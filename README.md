# SOFetch

Main objective
----------------
Fetches questions from Stack Overflow server. Questions must meet following criteria:
1. Have at least 1 answer
2. Have an accepted answer


Features
----------
A request using, https://api.stackexchange.com/docs/advanced-search#order=desc&sort=activity&accepted=True&filter=default&site=stackoverflow
url is being sent to the Stack Overflow server asking for a list of questions that have an accepted answer AND contain more than one answer.

After parsing the response, which is in JSON format, the main view uses diffable table view to display data. The table is populated using data source where each element contains:
1. Question title
2. Question tags
3. Link to question
4. Avatar of question poster

The "refresh" button sends another request to retrieve a new set of questions. The button is disabled for 2 minutes In order to prevent abuse forcing the API implement a number of throttles.
