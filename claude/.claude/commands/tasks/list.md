---
description: List tasks from My Tasks Notion database, optionally filtered by status or priority
argument-hint: '[status: "Not started"|"In progress"|"Done"] [priority: High|Medium|Low]'
---

List tasks from the My Tasks Notion database using the `mcp__claude_ai_Notion__notion-search` tool.

## Database details (hardcoded — do not search for this)
- Data source ID: `3157f477-3326-80e9-855b-000be5c55882`
- Collection URL: `collection://3157f477-3326-80e9-855b-000be5c55882`
- Database URL: `https://www.notion.so/3157f4773326801cb9e8f67cfcd8257c`

## Schema
- **Title** (text) — task name
- **Status** — one of: `Not started`, `In progress`, `Done`
- **Priority** — one of: `High`, `Medium`, `Low`
- **Tags** — one or more of: `document`, `investigation`, `research`, `feature`, `bug`
- **Due date** — optional date
- **Description** — optional text

## Instructions

1. Run multiple `mcp__claude_ai_Notion__notion-search` calls in parallel using broad queries to maximise coverage, since the tool returns semantic matches only and a single query may miss tasks:
   - Query `"a"` with `data_source_url: "collection://3157f477-3326-80e9-855b-000be5c55882"`
   - Query `"in progress not started done"` with the same `data_source_url`
   - Query `"task"` with the same `data_source_url`

2. Deduplicate results by page ID.

3. For each unique page, call `mcp__claude_ai_Notion__notion-fetch` with its URL to get full properties (Status, Priority, Tags, Due date).

4. If `$ARGUMENTS` contains a status or priority filter, apply it after fetching.

5. Display results in a compact table:

| Title | Status | Priority | Tags | Due |
|-------|--------|----------|------|-----|
| ...   | ...    | ...      | ...  | ... |

6. Show total count. If no tasks found, say so clearly.
