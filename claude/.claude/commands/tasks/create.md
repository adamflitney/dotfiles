---
description: Create a new task in My Tasks Notion database
argument-hint: '<title> [status] [priority] [tags] [due date]'
---

Create a new task in the My Tasks Notion database using `mcp__claude_ai_Notion__notion-create-pages`.

## Database details (hardcoded — do not search for this)
- Data source ID: `3157f477-3326-80e9-855b-000be5c55882`
- Parent format: `{"data_source_id": "3157f477-3326-80e9-855b-000be5c55882"}`

## Schema & valid values
- **Title** (required) — task name string
- **Status** — one of: `Not started` (default), `In progress`, `Done`
- **Priority** — one of: `High`, `Medium`, `Low` (default: `Medium`)
- **Tags** — pass as a plain string for one tag, or a JSON string for multiple e.g. `'["feature","bug"]'`
  - Valid values: `document`, `investigation`, `research`, `feature`, `bug`
- **Description** — plain text string
- **Due date** — use expanded properties: `date:Due date:start` (ISO date), `date:Due date:is_datetime` (0)

## CRITICAL tool call format

Use this exact structure — `title` and `data_source_url` are NOT valid keys at the page level:

```json
{
  "parent": { "data_source_id": "3157f477-3326-80e9-855b-000be5c55882" },
  "pages": [
    {
      "properties": {
        "Title": "<title>",
        "Status": "Not started",
        "Priority": "Medium",
        "Tags": "feature",
        "Description": "<description>"
      },
      "content": "<optional markdown body>"
    }
  ]
}
```

## Instructions

1. Parse `$ARGUMENTS` for: title (required), status, priority, tags, due date, description.
   - If no title provided, ask the user for one before proceeding.
2. Apply sensible defaults: Status = `Not started`, Priority = `Medium`.
3. Call `mcp__claude_ai_Notion__notion-create-pages` with the exact format above.
4. Confirm success by displaying:
   - Task title
   - Status, Priority, Tags
   - Link to the created page
