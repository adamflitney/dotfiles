---
description: Update a task in My Tasks Notion database (status, priority, tags, due date)
argument-hint: '<title or page URL> [status] [priority] [tags] [due date]'
---

Update an existing task in the My Tasks Notion database.

## Database details (hardcoded — do not search for this)
- Data source ID: `3157f477-3326-80e9-855b-000be5c55882`
- Collection URL: `collection://3157f477-3326-80e9-855b-000be5c55882`

## Schema & valid values
- **Status** — one of: `Not started`, `In progress`, `Done`
- **Priority** — one of: `High`, `Medium`, `Low`
- **Tags** — plain string for one tag, or JSON string e.g. `'["feature","bug"]'`
  - Valid values: `document`, `investigation`, `research`, `feature`, `bug`
- **Due date** — use `date:Due date:start` (ISO date string) and `date:Due date:is_datetime` (0)
- **Description** — plain text

## Instructions

1. Parse `$ARGUMENTS` for a task title (or direct page URL) and the properties to change.

2. If given a title (not a URL):
   - Search for it using `mcp__claude_ai_Notion__notion-search` with `data_source_url: "collection://3157f477-3326-80e9-855b-000be5c55882"` and the title as the query.
   - If multiple matches, list them and ask the user to confirm which one.
   - If no match, tell the user and suggest running `/list` to find the correct task.

3. Call `mcp__claude_ai_Notion__notion-update-page` with:
   - `page_url`: the full Notion page URL (e.g. `https://www.notion.so/...`)
   - `properties`: only the fields being changed

4. Confirm the update by displaying the updated property values and a link to the page.

## Example updates
- Mark done: `Status: "Done"`
- Raise priority: `Priority: "High"`
- Set due date: `date:Due date:start: "2026-03-15"`, `date:Due date:is_datetime: 0`
