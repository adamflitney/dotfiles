---
name: rfc
description: Walk the user through creating an RFC in Notion. Asks questions about the topic, drafts the RFC, and creates it in the RFC proposals database.
argument-hint: [optional topic]
---

# RFC Creation Skill

You are helping the user create an RFC (Request For Comments) in the Yoto Notion workspace. Walk them through the process interactively.

## Step 1: Gather Context

If $ARGUMENTS is provided, use it as the starting topic. Otherwise, ask the user what their RFC is about.

Before drafting, you MUST ask the user targeted questions to understand their proposal. Ask these one round at a time (don't dump all questions at once). Adapt based on the topic:

**Round 1 — The basics:**
- What problem are you trying to solve? Why does it matter now?
- Who is affected (which teams, services, consumers)?

**Round 2 — The proposal:**
- What is your proposed solution? (Get specifics: patterns, naming, architecture choices, etc.)
- Are there any constraints or dependencies?
- What are the trade-offs or drawbacks you're aware of?

**Round 3 — Alternatives and open questions:**
- What alternatives have you considered, and why did you reject them?
- Are there specific areas you want feedback on from reviewers?
- Any related prior art (existing RFCs, ADRs, docs) you know of?

You don't need to ask every question — use judgement based on the topic. Some RFCs are simple and need fewer questions. The goal is to have enough to write a clear, concise draft.

## Step 2: Research

Before drafting, search Notion for relevant prior art:
- Search for related RFCs, ADRs, and guidelines that should be referenced
- Fetch any directly relevant documents to understand existing decisions
- Look for the Public API Design Guidelines, scope definitions (ADR-6), or other foundational docs if relevant to the topic

## Step 3: Draft the RFC

Present the full draft to the user in the conversation for review BEFORE creating it in Notion. Follow this structure:

### RFC Template Structure

```
Callout (blue_bg, 🗣 icon): 1-2 sentence summary of the proposal

## 1. Overview
Short paragraph or bullet list explaining what you're proposing.

## 2. Problem
Why does this matter? What's the current pain? Keep it concise.

## 3. Proposed Solution (or "Proposed Solutions" if multiple options)
The core of the proposal. Use sub-sections (3.1, 3.2, etc.) for distinct parts.
- Include code examples, patterns, or diagrams where helpful
- Highlight trade-offs and drawbacks
- Link to relevant prior art

## 4. Questions / Areas for Feedback
Specific questions for reviewers. Tag domain experts if relevant.

## 5. Alternative Solutions Considered
What else was considered and why it was rejected.

## 6. Conclusion
Leave as: "Once a decision has been agreed, document the outcome here, and the reasoning for the conclusion."

## Related
Links to related RFCs, ADRs, and external resources.
```

### Style Guidelines
- **Keep it brief.** Shorter RFCs are more likely to be read.
- Use Notion-flavored markdown (callouts, mention-pages for links to other Notion pages, etc.)
- Link to prior art using `<mention-page url="https://www.notion.so/{page-id}"/>` syntax
- Be opinionated — the RFC author owns the decision. Present a clear recommendation, not just a list of options.
- Call out specific areas where feedback is wanted.

## Step 4: Create in Notion

Once the user approves the draft (they may ask for changes first — iterate until they're happy), create the page in the RFC proposals database.

**Database details:**
- Data source ID: `1c8bb530-77c4-4cbe-9772-0609a5113b55`
- Properties to set:
  - `Name`: The RFC title
  - `Status`: `"Draft"`
  - `Tags`: JSON array of applicable tags from `["newbie", "identity", "security", "firmware"]` (or omit if none fit)
  - `Affected Teams`: Comma-separated team names
  - `date:Creation Date:start`: Today's date (YYYY-MM-DD)
  - `date:Creation Date:is_datetime`: `0`
- Do NOT set Authors or Reviewers (these are person fields that need user IDs)

After creation, remind the user of the next steps from the RFC checklist:
1. Add themselves as Author in Notion
2. Share as WIP with trusted colleagues
3. Post to #tech-rfcs in Slack when ready, and change status to Proposing
4. Assign reviewers
5. Drive it through to Accepted or Dropped
