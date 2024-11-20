/**
 * Import function triggers from their respective submodules:
 *
 * import {onCall} from "firebase-functions/v2/https";
 * import {onDocumentWritten} from "firebase-functions/v2/firestore";
 *
 * See a full list of supported triggers at https://firebase.google.com/docs/functions
 */

// Start writing functions
// https://firebase.google.com/docs/functions/typescript

import {onRequest} from "firebase-functions/v2/https";
import * as logger from "firebase-functions/logger";
import {getTopUsers} from "./top_users";

// Export the function
exports.getTopUsers = getTopUsers;

export const helloWorld = onRequest((request, response) => {
  logger.info("Hello logs!", {structuredData: true});
  response.send("Hello from Firebase!");
});
