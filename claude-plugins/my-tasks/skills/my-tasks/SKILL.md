---
name: my-tasks
description: This skill should be used when the user wants to "list my tasks", "show my tasks", "what are my tasks", "create a task", "add a task", "new task", "update a task", "mark a task as done", "mark as in progress", "complete a task", "change task status", "change task priority", "what tasks do I have", "show tasks in progress", or any other request to read, create, or update personal tasks in Notion.
version: 1.0.0
---

# My Tasks — Notion Database Skill

Provides direct, pre-configured access to Adam's personal "My Tasks" Notion database. All database IDs, schemas, and tool call patterns are hardcoded — do not search for or re-discover them.

## Database Config

| Property | Value |
|---|---|
| Data source ID | `3157f477-3326-80e9-855b-000be5c55882` |
| Collection URL | `collection://3157f477-3326-80e9-855b-000be5c55882` |
| Database URL | `https://www.notion.so/3157f4773326801cb9e8f67cfcd8257c` |

## Schema

| Property | Type | Valid values |
|---|---|---|
| Title | text (required) | any string |
| Status | select | `Not started`, `In progress`, `Done` |
| Priority | select | `High`, `Medium`, `Low` |
| Tags | multi_select | `document`, `investigation`, `research`, `feature`, `bug` |
| Description | text | any string |
| Due date | date | use expanded keys below |

**Date properties** must use expanded keys:
- `date:Due date:start` — ISO date string e.g. `"2026-03-15"`
- `date:Due date:end` — ISO date string or omit
- `date:Due date:is_datetime` — `0` for date, `1` for datetime

**Tags** must be passed as a plain string for one value (`"feature"`) or a JSON-encoded string for multiple (`'["feature","bug"]'`). Do NOT pass a native array.

---

## Listing Tasks

Use `mcp__claude_ai_Notion__notion-search` in parallel with multiple broad queries to maximise coverage (the tool does semantic matching so a single query may miss rows):

```
Query 1: "a"          data_source_url: "collection://3157f477-3326-80e9-855b-000be5c55882"
Query 2: "task"       data_source_url: "collection://3157f477-3326-80e9-855b-000be5c55882"
Query 3: "in progress not started done"   (same data_source_url)
```

Then:
1. Deduplicate results by page ID.
2. Call `mcp__claude_ai_Notion__notion-fetch` on each unique URL to retrieve full properties.
3. Apply any status/priority filter the user requested.
4. Present as a table: Title | Status | Priority | Tags | Due date.

---

## Creating a Task

Use `mcp__claude_ai_Notion__notion-create-pages`. The only valid top-level keys in each page object are `properties` and `content`. The parent must use `data_source_id`.

**Correct call shape:**
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
        "Description": "<optional description>"
      },
      "content": "<optional Notion-flavored markdown body>"
    }
  ]
}
```

**Defaults:** Status = `Not started`, Priority = `Medium`.

After creating, confirm with: title, status, priority, tags, and the Notion page URL.

---

## Updating a Task

Use `mcp__claude_ai_Notion__notion-update-page`.

1. If the user gives a title (not a URL), call `mcp__claude_ai_Notion__notion-search` with the title as query and `data_source_url: "collection://3157f477-3326-80e9-855b-000be5c55882"`. If multiple matches, show them and ask which one.
2. Call `mcp__claude_ai_Notion__notion-update-page` with:
   - `page_url`: the full Notion page URL
   - `properties`: only the fields being changed (same names and values as the schema above)

After updating, confirm the new values and link to the page.

---

## Common patterns

| User says | Action |
|---|---|
| "what are my tasks" / "list tasks" | List all, show table |
| "what's in progress" | List, filter Status = In progress |
| "add a task: Fix login bug, high priority" | Create with Priority = High |
| "mark [task] as done" | Update Status = Done |
| "set [task] to high priority" | Update Priority = High |
| "add a due date of Friday to [task]" | Update `date:Due date:start` |
