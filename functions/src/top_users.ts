import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

admin.initializeApp();
const db = admin.firestore();

export const getTopUsers = functions.https.onRequest(async (req, res) => {
  try {
    // Query the 'users' collection for documents where totalPoints > 0
    // Sort them by totalPoints in descending order and limit to the top 5
    const usersSnapshot = await db.collection("users")
      .where("totalPoints", ">", 0)
      .orderBy("totalPoints", "desc")
      .limit(5)
      .get();

    // Prepare the list of top users
    const topUsers = usersSnapshot.docs.map((doc) => {
      const data = doc.data();
      return {
        firstName: data.firstName,
        lastName: data.lastName,
        points: data.totalPoints,
      };
    });

    // Send the top users as a response
    res.status(200).json(topUsers);
  } catch (error) {
    console.error("Error fetching top users:", error);
    res.status(500).json({error: "Failed to fetch top users"});
  }
});
