# Subagent model selection

Every time you launch a subagent with the Agent tool (forks excepted), set the
`model` parameter explicitly. This applies to built-in agent types (Explore,
Plan, general-purpose) too, since the explicit parameter overrides their
defaults. Forks always run on the parent model, so never pass `model` to them.

The main session is the orchestrator: it plans, decides, and reviews. Subagents
are workers with a scoped task and a clear definition of done. Route by how
hard the *delegated task* is, not by how hard the overall project is.

## `model: "sonnet"` (Sonnet 5.5) — the default for delegated work

Use Sonnet whenever the task is well specified and the approach is known:

- Implementing a feature, fix, or test where the prompt says which files to
  touch, what the change is, and how to verify it.
- Refactors and migrations that follow a stated pattern or an existing example.
- Writing tests for behaviour that is already understood.
- Exploration and research: locating files or symbols, tracing a call path,
  summarising how a subsystem works, answering "where/how does X happen".
- Routine code review: style, consistency with existing patterns, obvious bugs.
- Running builds, tests, or scripts and reporting results.

Give Sonnet a precise brief: the files, the pattern to follow, what "done"
looks like, and the check to run. Precision in the prompt is what makes Sonnet
sufficient; a vague brief is a reason to sharpen the brief, not to upgrade the
model.

## `model: "haiku"` (Haiku 4.5) — trivial, high-volume tasks

Use Haiku for tasks with essentially one step and no judgement:

- Run a single command and report the output.
- A single grep/glob to find whether something exists.
- Mechanical edits with an exact search-and-replace spec across many files.

If the task needs the agent to read and understand code before acting, it is
Sonnet work, not Haiku.

## `model: "opus"` (Opus 5.5) — genuinely hard problems

Use Opus only when the difficulty is in the reasoning, not the volume:

- Debugging where the cause is unknown: subtle, intermittent, or
  cross-cutting bugs, race conditions, and anything that needs a hypothesis
  and experiments rather than a known fix.
- Design and architecture decisions, or planning a change whose approach is
  not yet clear.
- Security review and adversarial code review of correctness-critical code
  (auth, payments, concurrency, data integrity, migrations that can lose data).
- Work in an unfamiliar domain or codebase where the right approach must be
  discovered.
- Retries: if a Sonnet agent had the full context, clearly tried, and still got
  it wrong, rerun that task on Opus rather than re-prompting Sonnet a third
  time.

## Deciding

Ask: "could a strong mid-level engineer do this correctly from my brief without
needing to make a judgement call?" If yes, Sonnet. If the task is a single
mechanical step, Haiku. If the answer depends on judgement, discovery, or the
cost of a subtle mistake is high, Opus. When genuinely unsure between Sonnet
and Opus, start with Sonnet and escalate on failure; the retry is cheaper than
defaulting everything to Opus.

# Cloudflare

When interacting with Cloudflare, use the cf CLI unless the project has a Wrangler configuration file.
