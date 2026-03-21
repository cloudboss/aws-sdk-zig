# Learnings - live-tests-fix

## Session ses_339ba36faffezyUUu2LXwCyMx9 (2026-03-07)

### CRITICAL: AWS_PROFILE Required
All live tests must be run as:
  `AWS_PROFILE=cloudboss-corp make test-integration-live SCENARIO=xxx`

The credentials file at ~/.aws/credentials has only the `cloudboss-corp` profile
(no `default`). Without setting AWS_PROFILE, all runs fail at credential preflight.

### Plan Overview
- 24 live integration test scenarios exist (plan says 22; misc and lambda are extras)
- Primary fix location is the Kotlin code generator (`codegen/`), but some bugs are
  in the SDK runtime (`src/`) and test files
- Must use `make` for all builds/tests (containerized environment)
- Each fixed scenario gets its own git commit
- Commit style: Linux kernel style, no subsystem prefix, lines <= 72 chars

### Key Make Targets
- `AWS_PROFILE=cloudboss-corp make test-integration-live SCENARIO=xxx`
- `make codegen` - regenerate all services from Kotlin (run after any codegen/ change)
- `make build` - build Zig code
- `make test` - unit tests (378 pass as of Wave 2)

---

## Wave 1 Complete: Triage Results

### Scenario Status After Triage (with correct AWS_PROFILE)

| Scenario      | Status       | Root Cause                                      |
|---------------|--------------|-------------------------------------------------|
| sts           | PASS         | Working                                         |
| ssm           | FIXED        | credentials use-after-free (see Wave 2)         |
| s3            | RUNTIME_FAIL | Same credentials use-after-free (not yet fixed) |
| sqs           | RUNTIME_FAIL | Same credentials use-after-free (not yet fixed) |
| sns           | RUNTIME_FAIL | Same credentials use-after-free (not yet fixed) |
| iam           | RUNTIME_FAIL | ConnectionFailed -- global service endpoint?    |
| secretsmanager| FALSE PASS   | beforeAll fails with ServiceError; all 5 tests  |
|               |              | skipped; runner reports PASS                    |
| dynamodb      | COMPILE_FAIL | operator >= on ?i32 (optional not unwrapped)    |
| ec2           | COMPILE_FAIL | std.time.sleep removed + missing enum values    |
| lambda        | COMPILE_FAIL | std.time.sleep removed (x2)                     |
| kinesis       | COMPILE_FAIL | std.base64.Decoder.calcSize removed in 0.15     |
| cloudwatch    | COMPILE_FAIL | codegen passes enum/f64 to url.appendUrlEncoded |
| route53       | COMPILE_FAIL | missing struct fields + optional mismatch       |
| elb           | COMPILE_FAIL | % operator on signed i64 not allowed            |
| compute et al | NOT_TESTED   | 10 smoke test scenarios not yet attempted       |

### Compile Error Details

**dynamodb** (`tests/integration/scenarios-live/dynamodb/test.zig:315`):
  `operator >= not allowed for type '?i32'`
  Fix: `result.count.? >= 2` or make count non-optional in codegen

**ec2** (3 errors):
  - `std.time.sleep` -> `std.Thread.sleep`
  - `enum 'VolumeType' has no member named 'gp3'` -- codegen missing enum value
  - `enum 'InstanceType' has no member named 't3_nano'` -- codegen missing enum value

**lambda** (2 errors):
  - `std.time.sleep` -> `std.Thread.sleep` (lines 76, 292)

**kinesis**:
  - `std.base64.standard.Decoder.calcSize` -- removed in Zig 0.15
  - Check Zig 0.15 std.base64 docs for replacement

**cloudwatch** (4 errors in generated service files):
  - `describe_alarms.zig:187`: passes `AlarmType` enum where `[]const u8` expected
  - `put_metric_alarm.zig:738`: passes `f64` where `[]const u8` expected
  - `put_metric_data.zig:141`: passes `f64` where `[]const u8` expected
  - Also: division by zero in array_list.zig (zero-sized type from generated code)
  - Fix: codegen must stringify enums and floats before calling url.appendUrlEncoded

**route53** (6 errors in generated service files):
  - `get_hosted_zone_count.zig:68`: missing struct field `hosted_zone_count`
  - `list_hosted_zones.zig:155`: missing fields `marker`, `max_items`
  - `list_hosted_zones_by_name.zig:162`: missing field `max_items`
  - `list_resource_record_sets.zig:196`: missing field `max_items`
  - `serde.zig:591`: `ChangeStatus` vs `?ChangeStatus` mismatch
  - `test.zig:61`: `std.time.sleep` -> `std.Thread.sleep`

**elb** (`tests/integration/scenarios-live/elb/test.zig:25`):
  `std.time.timestamp() % 100000` -- % not allowed for signed i64
  Fix: `@mod(std.time.timestamp(), 100000)`

### Known Codegen Bugs (from Metis review -- status UNKNOWN until those services compile)
- JSON error code `:url` suffix not stripped: `AwsJsonProtocol.kt:95`,
  `RestJsonProtocol.kt:618`
- Pagination identical-token termination: CloudWatch Logs `GetLogEvents`
- Union-valued map serialization TODO: `AwsQueryProtocol.kt:160` (IAM, EC2)

---

## Wave 2 Complete: Foundation Fixes

### Task 2: STS -- PASS (no changes needed)
`AWS_PROFILE=cloudboss-corp make test-integration-live SCENARIO=sts` passes.
Confirms credential loading, HTTP, signing, and AWS Query deserialization work.

### Task 3: SSM -- FIXED
**Root cause**: use-after-free of cached credential strings in `src/credentials.zig`.

`ChainProvider.cacheCredentials` stored the `Credentials` struct directly, but
the `access_key_id` and `secret_access_key` fields are slices into arena-allocated
memory (the arena passed by the caller to `getCredentials`). Each service call
creates a fresh arena and frees it at the end of `execute()`. After the first call
the cache holds dangling pointers. The second call returns cached credentials whose
string fields point to freed memory, causing a segfault in `deriveSigningKey` at
`@memcpy(k_secret[prefix.len..][0..secret_key.len], secret_key)`.

**Fix** (`src/credentials.zig`, `src/config.zig`):
- Added `allocator` field to `ChainProvider` (set from `Config.load` allocator)
- `cacheCredentials` now dupes all string fields with `self.allocator`
- `freeCachedCredentials()` frees owned strings; called by `clearCache` and `deinit`
- `CredentialsProvider.deinit()` added; `Config.deinit()` now calls it

**This fix also unblocks**: sqs, sns, s3 (same root cause, different service)

**Commit**: `f3b9e2c9d Fix use-after-free of cached credential strings`
**Evidence**: `.sisyphus/evidence/task-3-ssm-pass.txt` (7/7 tests pass)
**Unit tests**: 378 pass after fix

---

## Next Session: Wave 3 Starting Point

The credentials fix unblocks sqs, sns, s3. Those should be tried first -- they may
now pass without any further changes. The compile failures need separate fixes.

Suggested order for Wave 3:
1. Try sqs, sns, s3 -- may pass now that credentials work
2. Fix elb test (1-line fix: `@mod` instead of `%`)
3. Fix dynamodb test (unwrap optional: `.?`)
4. Fix lambda test (`std.Thread.sleep`)
5. Fix kinesis test (std.base64 API)
6. Fix cloudwatch codegen (url encoding of enums/floats)
7. Fix route53 codegen (missing struct fields)
8. Investigate iam ConnectionFailed
9. Investigate secretsmanager ServiceError

## 2026-03-07 Session task-6 SQS

- Live SQS failed in `purgeQueue clears all messages` with `error.ServiceError` when the test
  purged the shared queue shortly after another purge operation in a previous test.
- SQS enforces a 60 second cooldown for `PurgeQueue`; using a dedicated queue in the
  `sendMessageBatch sends multiple messages` test avoids cross-test purge conflicts.
- `listQueues` against all queues is eventually consistent for newly-created queues in this
  account. Filtering with `.queue_name_prefix = shared_queue_name` made lookup deterministic.

## 2026-03-07 Session task-4 DynamoDB

- Live DynamoDB compile fix required optional unwrapping in expectations: `result.count` is `?i32`,
  so comparisons and exact equality checks must unwrap with `.?`.
- Live DynamoDB `beforeAll` can fail with `ServiceError` on `tagResource` if called immediately
  after `createTable`; adding `waitUntilTableExists(.{ .table_name = shared_table })` makes setup
  deterministic.
- Second-level table-name suffixes can collide with prior runs in the same second; using
  `std.time.milliTimestamp()` for the live test table name avoids duplicate table name conflicts.
- Regression runs for STS and SSM are stable when invoked with
  `AWS_PROFILE=cloudboss-corp make test-integration-live SCENARIO=<name>`.

## 2026-03-06 Session task-5 SecretsManager

- Live SecretsManager beforeAll was failing with `InvalidRequestException` from AWS: createSecret now requires `client_request_token`; logging `ServiceError` diagnostic exposed the exact AWS message.
- Using a unique secret name (`milliTimestamp` + random suffix) avoids collisions with leftover resources across runs.
- `listSecrets` can lag on visibility right after create; filtering by name and retrying with a short sleep makes live checks deterministic without masking failures.

---

## Wave 3 Complete: Core JSON Services (2026-03-07 Session ses_33999f522ffe6usxakHl6YjsMv)

### Updated Scenario Status Table

| Scenario       | Status  | Commit / Notes                                    |
|----------------|---------|---------------------------------------------------|
| sts            | PASS    | No changes needed                                 |
| ssm            | PASS    | Wave 2: credentials use-after-free fix            |
| sqs            | PASS    | Wave 3: batch queue isolation + listQueues retry  |
| dynamodb       | PASS    | Wave 3: optional unwrap + waiter + ms timestamp   |
| secretsmanager | PASS    | Wave 3: ClientRequestToken + unique naming        |
| sns            | PENDING | Wave 4 -- credentials fix likely unblocks it      |
| kinesis        | PENDING | Wave 4 -- std.base64 API change (Zig 0.15)        |
| cloudwatch     | PENDING | Wave 4 -- codegen: enum/f64 to url encoding       |
| lambda         | PENDING | Wave 4 -- std.time.sleep -> std.Thread.sleep      |
| s3             | PENDING | credentials fix should unblock it                 |
| iam            | PENDING | ConnectionFailed on global endpoint               |
| ec2            | PENDING | compile errors + missing enum values in codegen   |
| route53        | PENDING | codegen: missing struct fields + optional mismatch|
| elb            | PENDING | 1-line fix: @mod() for signed i64 modulo          |
| smoke (10)     | PENDING | Not yet attempted                                 |

### Wave 3 Root Causes Fixed

**SQS** (commit `a2ae084`):
- PurgeQueue enforces a 60-second cooldown -- batch test must use its own
  queue and not purge the shared queue.
- listQueues is eventually consistent; filter by prefix + short retry loop.

**DynamoDB** (commit `2886c20`):
- `result.count` is `?i32`; ordering comparison needs `.?` unwrap.
- `tagResource` races `createTable`; add `waitUntilTableExists` before tag.
- Use `milliTimestamp()` (not `timestamp()`) for unique table name suffix.

**SecretsManager** (commit `eefb365`):
- AWS live API requires `client_request_token` on `createSecret` and
  `putSecretValue` -- Localstack does not enforce this.
- `listSecrets` is eventually consistent; filter by name + short retry.
- Use `milliTimestamp` + random suffix for unique secret name.

### CRITICAL: Commit Message Style (AGENTS.md correction)

AGENTS.md now explicitly says:
  "DO NOT add a kernel style 'subsystem' to the summary."

Correct format (no prefix):
  Fix SQS batch test queue isolation and listQueues retry

  Isolate sendMessageBatch to its own queue to avoid the
  PurgeQueue cooldown interference. Retry listQueues with
  a queue name prefix to handle eventual consistency.

Wrong format (subsystem prefix -- DO NOT USE):
  sqs: Fix batch test queue isolation and listQueues retry

Body lines must be <= 72 characters each. Do not write the body as a
single long run-on line.

### Wave 4 Starting Point

Tasks 7-10 per plan: SNS, Kinesis, CloudWatch, Lambda

Priority order based on likely effort:
1. SNS (Task 7) -- same credentials issue, should pass with no changes;
   try first before investigating further
2. Lambda (Task 10) -- COMPILE_FAIL: replace std.time.sleep with
   std.Thread.sleep at lines 76 and 292 in test.zig; may also need
   the IAM cross-service setup
3. Kinesis (Task 8) -- COMPILE_FAIL: std.base64.standard.Decoder.calcSize
   removed in Zig 0.15; check replacement API
4. CloudWatch (Task 9) -- COMPILE_FAIL: codegen bug (enum/f64 passed to
   url.appendUrlEncoded expecting []const u8); needs codegen fix in
   AwsQueryProtocol.kt

SNS and Lambda are test-file-only fixes; CloudWatch requires codegen
changes. Run make codegen then make build then make test after any
codegen change.

## 2026-03-07 Session task-7 SNS

- SNS live scenario now passes with no code changes after the Wave 2
  credentials ownership fix; run with
  `AWS_PROFILE=cloudboss-corp make test-integration-live SCENARIO=sns`.
- Current SNS live run reports 8/8 test cases passing in scenario output.
- Required regression checks passed unchanged:
  `make test` (378/378) and
  `AWS_PROFILE=cloudboss-corp make test-integration-live SCENARIO=sqs`.
- Live cleanup can report tagged resources that it cannot delete; this did
  not affect scenario pass/fail and appears to be expected best-effort
  cleanup behavior in current scripts.

## 2026-03-07 Session task-8 Kinesis

- Zig 0.15 base64 decode no longer uses `Decoder.calcSize`; use
  `Decoder.calcSizeForSlice(encoded)` and then call `Decoder.decode(dst, encoded)`.
- Live Kinesis `putRecord` accepted base64-encoded payload data in this scenario;
  sending raw bytes produced `SerializationException`.
- `putRecord` was intermittently `ResourceNotFoundException` immediately after
  stream activation when addressed by stream name; using `stream_arn` and a
  bounded retry made the live test deterministic.
- Final live verification command:
  `AWS_PROFILE=cloudboss-corp make test-integration-live SCENARIO=kinesis`.

## 2026-03-07 Session task-9 CloudWatch

- The AWS Query serializer had mixed scalar formatting paths. Some scalar writes
  used `ctx.scalarFormatExpr*`, which can emit non-string Zig expressions for
  enums and floats in generated request serializers.
- The robust path is `scalarToQueryExpr`, which normalizes enums via
  `.wireName()` and numeric scalars via `std.fmt.allocPrint` before
  `aws.url.appendUrlEncoded`.
- Fixing all scalar append call sites in `AwsQueryProtocol.kt` to route through
  `scalarToQueryExpr` removed CloudWatch compile failures for enum and f64
  fields and prevented similar regressions in nested struct/list/map serializers.
- After `make codegen`, verification passed with:
  `make build`, `make test` (379 passed), and
  `AWS_PROFILE=cloudboss-corp make test-integration-live SCENARIO=cloudwatch`.

## 2026-03-07 Session task-9 CloudWatch endpoint/signing follow-up

- CloudWatch endpoint/signing must not derive from `packageName`.
- Protocol endpoint resolution now uses `endpointPrefix` (for CloudWatch,
  `monitoring`) so generated clients call
  `monitoring.<region>.amazonaws.com` instead of
  `cloudwatch.<region>.amazonaws.com`.
- Request signing in `OperationGenerator` must use `signingName`
  (CloudWatch: `monitoring`) for SigV4 service scope.
- In AWS Query scalar serialization, optional scalar fields in nested
  list/struct paths must append key/value only when value exists; emitting
  an empty `&...=` for null optionals can trigger service-side validation
  errors (observed on CloudWatch `putMetricData`).

- Task 10: Lambda live failures were a chain: Zig 0.15 sleep API, IAM regional endpoint DNS failure in this environment, Lambda ZipFile needing base64 in request JSON, and optional enum parse brittleness on evolving API values.
- Live Lambda teardown exposed error-path header/body leaks in HTTP response handling; adding errdefer cleanup fixed integration test allocator failures while keeping unit tests clean.

## 2026-03-21 Session task-11 EC2

- EC2 live test updates for Zig 0.15 and generated enum naming must use
  `std.Thread.sleep`, `.gp_3`, and `.t_3_nano` in the test (generated enum
  symbols map dot wire values like `gp3` and `t3.nano` to underscored Zig names).
- This account can have no default subnets in the test VPC. Creating a subnet in
  the created VPC (`createSubnet`) before `runInstances` makes the scenario
  deterministic.
- `describeInstances` can intermittently return `error.ServiceError` immediately
  after launch; a bounded retry loop in the test keeps the assertion stable.
- ELB live test on Zig 0.15 requires @mod(std.time.timestamp(), 100000) because % is invalid for signed i64.
- In this account/region, ELB create was flaky with availability_zones/default-subnet assumptions; selecting an existing available subnet via EC2 DescribeSubnets and creating an internal ELB with that subnet stabilized the scenario.

## 2026-03-21 Session task-12 IAM

- IAM live scenario now passes with no code changes when run as
  `AWS_PROFILE=cloudboss-corp make test-integration-live SCENARIO=iam`.
- Existing global endpoint/signing handling for IAM is working as expected in
  this environment (`iam.amazonaws.com`).
- Regression checks remain green after IAM verification:
  `make test` (381/381) and `make build`.
