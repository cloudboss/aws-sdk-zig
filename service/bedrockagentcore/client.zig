const aws = @import("aws");
const std = @import("std");

const batch_create_memory_records = @import("batch_create_memory_records.zig");
const batch_delete_memory_records = @import("batch_delete_memory_records.zig");
const batch_update_memory_records = @import("batch_update_memory_records.zig");
const complete_resource_token_auth = @import("complete_resource_token_auth.zig");
const create_event = @import("create_event.zig");
const delete_event = @import("delete_event.zig");
const delete_memory_record = @import("delete_memory_record.zig");
const evaluate_ = @import("evaluate.zig");
const get_agent_card = @import("get_agent_card.zig");
const get_browser_session = @import("get_browser_session.zig");
const get_code_interpreter_session = @import("get_code_interpreter_session.zig");
const get_event = @import("get_event.zig");
const get_memory_record = @import("get_memory_record.zig");
const get_resource_api_key = @import("get_resource_api_key.zig");
const get_resource_oauth_2_token = @import("get_resource_oauth_2_token.zig");
const get_workload_access_token = @import("get_workload_access_token.zig");
const get_workload_access_token_for_jwt = @import("get_workload_access_token_for_jwt.zig");
const get_workload_access_token_for_user_id = @import("get_workload_access_token_for_user_id.zig");
const invoke_agent_runtime = @import("invoke_agent_runtime.zig");
const invoke_agent_runtime_command = @import("invoke_agent_runtime_command.zig");
const invoke_browser = @import("invoke_browser.zig");
const invoke_code_interpreter = @import("invoke_code_interpreter.zig");
const invoke_harness = @import("invoke_harness.zig");
const list_actors = @import("list_actors.zig");
const list_browser_sessions = @import("list_browser_sessions.zig");
const list_code_interpreter_sessions = @import("list_code_interpreter_sessions.zig");
const list_events = @import("list_events.zig");
const list_memory_extraction_jobs = @import("list_memory_extraction_jobs.zig");
const list_memory_records = @import("list_memory_records.zig");
const list_sessions = @import("list_sessions.zig");
const retrieve_memory_records = @import("retrieve_memory_records.zig");
const save_browser_session_profile = @import("save_browser_session_profile.zig");
const search_registry_records = @import("search_registry_records.zig");
const start_browser_session = @import("start_browser_session.zig");
const start_code_interpreter_session = @import("start_code_interpreter_session.zig");
const start_memory_extraction_job = @import("start_memory_extraction_job.zig");
const stop_browser_session = @import("stop_browser_session.zig");
const stop_code_interpreter_session = @import("stop_code_interpreter_session.zig");
const stop_runtime_session = @import("stop_runtime_session.zig");
const update_browser_stream = @import("update_browser_stream.zig");
const CallOptions = @import("call_options.zig").CallOptions;
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "Bedrock AgentCore";

    pub fn init(allocator: std.mem.Allocator, config: *aws.Config) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.init(allocator, .{ .retry_mode = config.retry_mode }),
        };
    }

    pub fn initWithOptions(allocator: std.mem.Allocator, config: *aws.Config, options: aws.http.RequestOptions) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.init(allocator, .{ .retry_mode = config.retry_mode, .request_options = options }),
        };
    }

    pub fn deinit(self: *Self) void {
        self.http_client.deinit();
    }

    /// Creates multiple memory records in a single batch operation for the
    /// specified memory with custom content.
    pub fn batchCreateMemoryRecords(self: *Self, allocator: std.mem.Allocator, input: batch_create_memory_records.BatchCreateMemoryRecordsInput, options: CallOptions) !batch_create_memory_records.BatchCreateMemoryRecordsOutput {
        return batch_create_memory_records.execute(self, allocator, input, options);
    }

    /// Deletes multiple memory records in a single batch operation from the
    /// specified memory.
    pub fn batchDeleteMemoryRecords(self: *Self, allocator: std.mem.Allocator, input: batch_delete_memory_records.BatchDeleteMemoryRecordsInput, options: CallOptions) !batch_delete_memory_records.BatchDeleteMemoryRecordsOutput {
        return batch_delete_memory_records.execute(self, allocator, input, options);
    }

    /// Updates multiple memory records with custom content in a single batch
    /// operation within the specified memory.
    pub fn batchUpdateMemoryRecords(self: *Self, allocator: std.mem.Allocator, input: batch_update_memory_records.BatchUpdateMemoryRecordsInput, options: CallOptions) !batch_update_memory_records.BatchUpdateMemoryRecordsOutput {
        return batch_update_memory_records.execute(self, allocator, input, options);
    }

    /// Confirms the user authentication session for obtaining OAuth2.0 tokens for a
    /// resource.
    pub fn completeResourceTokenAuth(self: *Self, allocator: std.mem.Allocator, input: complete_resource_token_auth.CompleteResourceTokenAuthInput, options: CallOptions) !complete_resource_token_auth.CompleteResourceTokenAuthOutput {
        return complete_resource_token_auth.execute(self, allocator, input, options);
    }

    /// Creates an event in an AgentCore Memory resource. Events represent
    /// interactions or activities that occur within a session and are associated
    /// with specific actors.
    ///
    /// To use this operation, you must have the `bedrock-agentcore:CreateEvent`
    /// permission.
    ///
    /// This operation is subject to request rate limiting.
    pub fn createEvent(self: *Self, allocator: std.mem.Allocator, input: create_event.CreateEventInput, options: CallOptions) !create_event.CreateEventOutput {
        return create_event.execute(self, allocator, input, options);
    }

    /// Deletes an event from an AgentCore Memory resource. When you delete an
    /// event, it is permanently removed.
    ///
    /// To use this operation, you must have the `bedrock-agentcore:DeleteEvent`
    /// permission.
    pub fn deleteEvent(self: *Self, allocator: std.mem.Allocator, input: delete_event.DeleteEventInput, options: CallOptions) !delete_event.DeleteEventOutput {
        return delete_event.execute(self, allocator, input, options);
    }

    /// Deletes a memory record from an AgentCore Memory resource. When you delete a
    /// memory record, it is permanently removed.
    ///
    /// To use this operation, you must have the
    /// `bedrock-agentcore:DeleteMemoryRecord` permission.
    pub fn deleteMemoryRecord(self: *Self, allocator: std.mem.Allocator, input: delete_memory_record.DeleteMemoryRecordInput, options: CallOptions) !delete_memory_record.DeleteMemoryRecordOutput {
        return delete_memory_record.execute(self, allocator, input, options);
    }

    /// Performs on-demand evaluation of agent traces using a specified evaluator.
    /// This synchronous API accepts traces in OpenTelemetry format and returns
    /// immediate scoring results with detailed explanations.
    pub fn evaluate(self: *Self, allocator: std.mem.Allocator, input: evaluate_.EvaluateInput, options: CallOptions) !evaluate_.EvaluateOutput {
        return evaluate_.execute(self, allocator, input, options);
    }

    /// Retrieves the A2A agent card associated with an AgentCore Runtime agent.
    pub fn getAgentCard(self: *Self, allocator: std.mem.Allocator, input: get_agent_card.GetAgentCardInput, options: CallOptions) !get_agent_card.GetAgentCardOutput {
        return get_agent_card.execute(self, allocator, input, options);
    }

    /// Retrieves detailed information about a specific browser session in Amazon
    /// Bedrock AgentCore. This operation returns the session's configuration,
    /// current status, associated streams, and metadata.
    ///
    /// To get a browser session, you must specify both the browser identifier and
    /// the session ID. The response includes information about the session's
    /// viewport configuration, timeout settings, and stream endpoints.
    ///
    /// The following operations are related to `GetBrowserSession`:
    ///
    /// *
    ///   [StartBrowserSession](https://docs.aws.amazon.com/bedrock-agentcore/latest/APIReference/API_StartBrowserSession.html)
    /// *
    ///   [ListBrowserSessions](https://docs.aws.amazon.com/bedrock-agentcore/latest/APIReference/API_ListBrowserSessions.html)
    /// *
    ///   [StopBrowserSession](https://docs.aws.amazon.com/bedrock-agentcore/latest/APIReference/API_StopBrowserSession.html)
    pub fn getBrowserSession(self: *Self, allocator: std.mem.Allocator, input: get_browser_session.GetBrowserSessionInput, options: CallOptions) !get_browser_session.GetBrowserSessionOutput {
        return get_browser_session.execute(self, allocator, input, options);
    }

    /// Retrieves detailed information about a specific code interpreter session in
    /// Amazon Bedrock AgentCore. This operation returns the session's
    /// configuration, current status, and metadata.
    ///
    /// To get a code interpreter session, you must specify both the code
    /// interpreter identifier and the session ID. The response includes information
    /// about the session's timeout settings and current status.
    ///
    /// The following operations are related to `GetCodeInterpreterSession`:
    ///
    /// *
    ///   [StartCodeInterpreterSession](https://docs.aws.amazon.com/bedrock-agentcore/latest/APIReference/API_StartCodeInterpreterSession.html)
    /// *
    ///   [ListCodeInterpreterSessions](https://docs.aws.amazon.com/bedrock-agentcore/latest/APIReference/API_ListCodeInterpreterSessions.html)
    /// *
    ///   [StopCodeInterpreterSession](https://docs.aws.amazon.com/bedrock-agentcore/latest/APIReference/API_StopCodeInterpreterSession.html)
    pub fn getCodeInterpreterSession(self: *Self, allocator: std.mem.Allocator, input: get_code_interpreter_session.GetCodeInterpreterSessionInput, options: CallOptions) !get_code_interpreter_session.GetCodeInterpreterSessionOutput {
        return get_code_interpreter_session.execute(self, allocator, input, options);
    }

    /// Retrieves information about a specific event in an AgentCore Memory
    /// resource.
    ///
    /// To use this operation, you must have the `bedrock-agentcore:GetEvent`
    /// permission.
    pub fn getEvent(self: *Self, allocator: std.mem.Allocator, input: get_event.GetEventInput, options: CallOptions) !get_event.GetEventOutput {
        return get_event.execute(self, allocator, input, options);
    }

    /// Retrieves a specific memory record from an AgentCore Memory resource.
    ///
    /// To use this operation, you must have the `bedrock-agentcore:GetMemoryRecord`
    /// permission.
    pub fn getMemoryRecord(self: *Self, allocator: std.mem.Allocator, input: get_memory_record.GetMemoryRecordInput, options: CallOptions) !get_memory_record.GetMemoryRecordOutput {
        return get_memory_record.execute(self, allocator, input, options);
    }

    /// Retrieves the API key associated with an API key credential provider.
    pub fn getResourceApiKey(self: *Self, allocator: std.mem.Allocator, input: get_resource_api_key.GetResourceApiKeyInput, options: CallOptions) !get_resource_api_key.GetResourceApiKeyOutput {
        return get_resource_api_key.execute(self, allocator, input, options);
    }

    /// Returns the OAuth 2.0 token of the provided resource.
    pub fn getResourceOauth2Token(self: *Self, allocator: std.mem.Allocator, input: get_resource_oauth_2_token.GetResourceOauth2TokenInput, options: CallOptions) !get_resource_oauth_2_token.GetResourceOauth2TokenOutput {
        return get_resource_oauth_2_token.execute(self, allocator, input, options);
    }

    /// Obtains a workload access token for agentic workloads not acting on behalf
    /// of a user.
    pub fn getWorkloadAccessToken(self: *Self, allocator: std.mem.Allocator, input: get_workload_access_token.GetWorkloadAccessTokenInput, options: CallOptions) !get_workload_access_token.GetWorkloadAccessTokenOutput {
        return get_workload_access_token.execute(self, allocator, input, options);
    }

    /// Obtains a workload access token for agentic workloads acting on behalf of a
    /// user, using a JWT token.
    pub fn getWorkloadAccessTokenForJwt(self: *Self, allocator: std.mem.Allocator, input: get_workload_access_token_for_jwt.GetWorkloadAccessTokenForJWTInput, options: CallOptions) !get_workload_access_token_for_jwt.GetWorkloadAccessTokenForJWTOutput {
        return get_workload_access_token_for_jwt.execute(self, allocator, input, options);
    }

    /// Obtains a workload access token for agentic workloads acting on behalf of a
    /// user, using the user's ID.
    pub fn getWorkloadAccessTokenForUserId(self: *Self, allocator: std.mem.Allocator, input: get_workload_access_token_for_user_id.GetWorkloadAccessTokenForUserIdInput, options: CallOptions) !get_workload_access_token_for_user_id.GetWorkloadAccessTokenForUserIdOutput {
        return get_workload_access_token_for_user_id.execute(self, allocator, input, options);
    }

    /// Sends a request to an agent or tool hosted in an Amazon Bedrock AgentCore
    /// Runtime and receives responses in real-time.
    ///
    /// To invoke an agent, you can specify either the AgentCore Runtime ARN or the
    /// agent ID with an account ID, and provide a payload containing your request.
    /// When you use the agent ID instead of the full ARN, you don't need to
    /// URL-encode the identifier. You can optionally specify a qualifier to target
    /// a specific endpoint of the agent.
    ///
    /// This operation supports streaming responses, allowing you to receive partial
    /// responses as they become available. We recommend using pagination to ensure
    /// that the operation returns quickly and successfully when processing large
    /// responses.
    ///
    /// For example code, see [Invoke an AgentCore Runtime
    /// agent](https://docs.aws.amazon.com/bedrock-agentcore/latest/devguide/runtime-invoke-agent.html).
    ///
    /// If you're integrating your agent with OAuth, you can't use the Amazon Web
    /// Services SDK to call `InvokeAgentRuntime`. Instead, make a HTTPS request to
    /// `InvokeAgentRuntime`. For an example, see [Authenticate and authorize with
    /// Inbound Auth and Outbound
    /// Auth](https://docs.aws.amazon.com/bedrock-agentcore/latest/devguide/runtime-oauth.html).
    ///
    /// To use this operation, you must have the
    /// `bedrock-agentcore:InvokeAgentRuntime` permission. If you are making a call
    /// to `InvokeAgentRuntime` on behalf of a user ID with the
    /// `X-Amzn-Bedrock-AgentCore-Runtime-User-Id` header, You require permissions
    /// to both actions (`bedrock-agentcore:InvokeAgentRuntime` and
    /// `bedrock-agentcore:InvokeAgentRuntimeForUser`).
    pub fn invokeAgentRuntime(self: *Self, allocator: std.mem.Allocator, input: invoke_agent_runtime.InvokeAgentRuntimeInput, options: CallOptions) !invoke_agent_runtime.InvokeAgentRuntimeOutput {
        return invoke_agent_runtime.execute(self, allocator, input, options);
    }

    /// Executes a command in a runtime session container and streams the output
    /// back to the caller. This operation allows you to run shell commands within
    /// the agent runtime environment and receive real-time streaming responses
    /// including standard output and standard error.
    ///
    /// To invoke a command, you must specify the agent runtime ARN and a runtime
    /// session ID. The command execution supports streaming responses, allowing you
    /// to receive output as it becomes available through `contentStart`,
    /// `contentDelta`, and `contentStop` events.
    ///
    /// To use this operation, you must have the
    /// `bedrock-agentcore:InvokeAgentRuntimeCommand` permission.
    pub fn invokeAgentRuntimeCommand(self: *Self, allocator: std.mem.Allocator, input: invoke_agent_runtime_command.InvokeAgentRuntimeCommandInput, options: CallOptions) !invoke_agent_runtime_command.InvokeAgentRuntimeCommandOutput {
        return invoke_agent_runtime_command.execute(self, allocator, input, options);
    }

    /// Invokes an operating system-level action on a browser session in Amazon
    /// Bedrock AgentCore. This operation provides direct OS-level control over
    /// browser sessions, enabling mouse actions, keyboard input, and screenshots
    /// that the WebSocket-based Chrome DevTools Protocol (CDP) cannot handle — such
    /// as interacting with print dialogs, context menus, and JavaScript alerts.
    ///
    /// You send a request with exactly one action in the `BrowserAction` union, and
    /// receive a corresponding result in the `BrowserActionResult` union.
    ///
    /// The following operations are related to `InvokeBrowser`:
    ///
    /// *
    ///   [StartBrowserSession](https://docs.aws.amazon.com/bedrock-agentcore/latest/APIReference/API_StartBrowserSession.html)
    /// *
    ///   [GetBrowserSession](https://docs.aws.amazon.com/bedrock-agentcore/latest/APIReference/API_GetBrowserSession.html)
    /// *
    ///   [StopBrowserSession](https://docs.aws.amazon.com/bedrock-agentcore/latest/APIReference/API_StopBrowserSession.html)
    pub fn invokeBrowser(self: *Self, allocator: std.mem.Allocator, input: invoke_browser.InvokeBrowserInput, options: CallOptions) !invoke_browser.InvokeBrowserOutput {
        return invoke_browser.execute(self, allocator, input, options);
    }

    /// Executes code within an active code interpreter session in Amazon Bedrock
    /// AgentCore. This operation processes the provided code, runs it in a secure
    /// environment, and returns the execution results including output, errors, and
    /// generated visualizations.
    ///
    /// To execute code, you must specify the code interpreter identifier, session
    /// ID, and the code to run in the arguments parameter. The operation returns a
    /// stream containing the execution results, which can include text output,
    /// error messages, and data visualizations.
    ///
    /// This operation is subject to request rate limiting based on your account's
    /// service quotas.
    ///
    /// The following operations are related to `InvokeCodeInterpreter`:
    ///
    /// *
    ///   [StartCodeInterpreterSession](https://docs.aws.amazon.com/bedrock-agentcore/latest/APIReference/API_StartCodeInterpreterSession.html)
    /// *
    ///   [GetCodeInterpreterSession](https://docs.aws.amazon.com/bedrock-agentcore/latest/APIReference/API_GetCodeInterpreterSession.html)
    pub fn invokeCodeInterpreter(self: *Self, allocator: std.mem.Allocator, input: invoke_code_interpreter.InvokeCodeInterpreterInput, options: CallOptions) !invoke_code_interpreter.InvokeCodeInterpreterOutput {
        return invoke_code_interpreter.execute(self, allocator, input, options);
    }

    /// Operation to invoke a Harness.
    pub fn invokeHarness(self: *Self, allocator: std.mem.Allocator, input: invoke_harness.InvokeHarnessInput, options: CallOptions) !invoke_harness.InvokeHarnessOutput {
        return invoke_harness.execute(self, allocator, input, options);
    }

    /// Lists all actors in an AgentCore Memory resource. We recommend using
    /// pagination to ensure that the operation returns quickly and successfully.
    ///
    /// To use this operation, you must have the `bedrock-agentcore:ListActors`
    /// permission.
    pub fn listActors(self: *Self, allocator: std.mem.Allocator, input: list_actors.ListActorsInput, options: CallOptions) !list_actors.ListActorsOutput {
        return list_actors.execute(self, allocator, input, options);
    }

    /// Retrieves a list of browser sessions in Amazon Bedrock AgentCore that match
    /// the specified criteria. This operation returns summary information about
    /// each session, including identifiers, status, and timestamps.
    ///
    /// You can filter the results by browser identifier and session status. The
    /// operation supports pagination to handle large result sets efficiently.
    ///
    /// We recommend using pagination to ensure that the operation returns quickly
    /// and successfully when retrieving large numbers of sessions.
    ///
    /// The following operations are related to `ListBrowserSessions`:
    ///
    /// *
    ///   [StartBrowserSession](https://docs.aws.amazon.com/bedrock-agentcore/latest/APIReference/API_StartBrowserSession.html)
    /// *
    ///   [GetBrowserSession](https://docs.aws.amazon.com/bedrock-agentcore/latest/APIReference/API_GetBrowserSession.html)
    pub fn listBrowserSessions(self: *Self, allocator: std.mem.Allocator, input: list_browser_sessions.ListBrowserSessionsInput, options: CallOptions) !list_browser_sessions.ListBrowserSessionsOutput {
        return list_browser_sessions.execute(self, allocator, input, options);
    }

    /// Retrieves a list of code interpreter sessions in Amazon Bedrock AgentCore
    /// that match the specified criteria. This operation returns summary
    /// information about each session, including identifiers, status, and
    /// timestamps.
    ///
    /// You can filter the results by code interpreter identifier and session
    /// status. The operation supports pagination to handle large result sets
    /// efficiently.
    ///
    /// We recommend using pagination to ensure that the operation returns quickly
    /// and successfully when retrieving large numbers of sessions.
    ///
    /// The following operations are related to `ListCodeInterpreterSessions`:
    ///
    /// *
    ///   [StartCodeInterpreterSession](https://docs.aws.amazon.com/bedrock-agentcore/latest/APIReference/API_StartCodeInterpreterSession.html)
    /// *
    ///   [GetCodeInterpreterSession](https://docs.aws.amazon.com/bedrock-agentcore/latest/APIReference/API_GetCodeInterpreterSession.html)
    pub fn listCodeInterpreterSessions(self: *Self, allocator: std.mem.Allocator, input: list_code_interpreter_sessions.ListCodeInterpreterSessionsInput, options: CallOptions) !list_code_interpreter_sessions.ListCodeInterpreterSessionsOutput {
        return list_code_interpreter_sessions.execute(self, allocator, input, options);
    }

    /// Lists events in an AgentCore Memory resource based on specified criteria. We
    /// recommend using pagination to ensure that the operation returns quickly and
    /// successfully.
    ///
    /// To use this operation, you must have the `bedrock-agentcore:ListEvents`
    /// permission.
    pub fn listEvents(self: *Self, allocator: std.mem.Allocator, input: list_events.ListEventsInput, options: CallOptions) !list_events.ListEventsOutput {
        return list_events.execute(self, allocator, input, options);
    }

    /// Lists all long-term memory extraction jobs that are eligible to be started
    /// with optional filtering.
    ///
    /// To use this operation, you must have the
    /// `bedrock-agentcore:ListMemoryExtractionJobs` permission.
    pub fn listMemoryExtractionJobs(self: *Self, allocator: std.mem.Allocator, input: list_memory_extraction_jobs.ListMemoryExtractionJobsInput, options: CallOptions) !list_memory_extraction_jobs.ListMemoryExtractionJobsOutput {
        return list_memory_extraction_jobs.execute(self, allocator, input, options);
    }

    /// Lists memory records in an AgentCore Memory resource based on specified
    /// criteria. We recommend using pagination to ensure that the operation returns
    /// quickly and successfully.
    ///
    /// To use this operation, you must have the
    /// `bedrock-agentcore:ListMemoryRecords` permission.
    pub fn listMemoryRecords(self: *Self, allocator: std.mem.Allocator, input: list_memory_records.ListMemoryRecordsInput, options: CallOptions) !list_memory_records.ListMemoryRecordsOutput {
        return list_memory_records.execute(self, allocator, input, options);
    }

    /// Lists sessions in an AgentCore Memory resource based on specified criteria.
    /// We recommend using pagination to ensure that the operation returns quickly
    /// and successfully.
    ///
    /// Empty sessions are automatically deleted after one day.
    ///
    /// To use this operation, you must have the `bedrock-agentcore:ListSessions`
    /// permission.
    pub fn listSessions(self: *Self, allocator: std.mem.Allocator, input: list_sessions.ListSessionsInput, options: CallOptions) !list_sessions.ListSessionsOutput {
        return list_sessions.execute(self, allocator, input, options);
    }

    /// Searches for and retrieves memory records from an AgentCore Memory resource
    /// based on specified search criteria. We recommend using pagination to ensure
    /// that the operation returns quickly and successfully.
    ///
    /// To use this operation, you must have the
    /// `bedrock-agentcore:RetrieveMemoryRecords` permission.
    pub fn retrieveMemoryRecords(self: *Self, allocator: std.mem.Allocator, input: retrieve_memory_records.RetrieveMemoryRecordsInput, options: CallOptions) !retrieve_memory_records.RetrieveMemoryRecordsOutput {
        return retrieve_memory_records.execute(self, allocator, input, options);
    }

    /// Saves the current state of a browser session as a reusable profile in Amazon
    /// Bedrock AgentCore. A browser profile captures persistent browser data such
    /// as cookies and local storage from an active session, enabling you to reuse
    /// this data in future browser sessions.
    ///
    /// To save a browser session profile, you must specify the profile identifier,
    /// browser identifier, and session ID. The session must be active when saving
    /// the profile. Once saved, the profile can be used with the
    /// `StartBrowserSession` operation to initialize new sessions with the stored
    /// browser state.
    ///
    /// Browser profiles are useful for scenarios that require persistent
    /// authentication, maintaining user preferences across sessions, or continuing
    /// tasks that depend on previously stored browser data.
    ///
    /// The following operations are related to `SaveBrowserSessionProfile`:
    ///
    /// *
    ///   [StartBrowserSession](https://docs.aws.amazon.com/bedrock-agentcore/latest/APIReference/API_StartBrowserSession.html)
    /// *
    ///   [GetBrowserSession](https://docs.aws.amazon.com/bedrock-agentcore/latest/APIReference/API_GetBrowserSession.html)
    pub fn saveBrowserSessionProfile(self: *Self, allocator: std.mem.Allocator, input: save_browser_session_profile.SaveBrowserSessionProfileInput, options: CallOptions) !save_browser_session_profile.SaveBrowserSessionProfileOutput {
        return save_browser_session_profile.execute(self, allocator, input, options);
    }

    /// Searches for registry records using semantic, lexical, or hybrid queries.
    /// Returns metadata for matching records ordered by relevance within the
    /// specified registry.
    pub fn searchRegistryRecords(self: *Self, allocator: std.mem.Allocator, input: search_registry_records.SearchRegistryRecordsInput, options: CallOptions) !search_registry_records.SearchRegistryRecordsOutput {
        return search_registry_records.execute(self, allocator, input, options);
    }

    /// Creates and initializes a browser session in Amazon Bedrock AgentCore. The
    /// session enables agents to navigate and interact with web content, extract
    /// information from websites, and perform web-based tasks as part of their
    /// response generation.
    ///
    /// To create a session, you must specify a browser identifier and a name. You
    /// can also configure the viewport dimensions to control the visible area of
    /// web content. The session remains active until it times out or you explicitly
    /// stop it using the `StopBrowserSession` operation.
    ///
    /// The following operations are related to `StartBrowserSession`:
    ///
    /// *
    ///   [GetBrowserSession](https://docs.aws.amazon.com/bedrock-agentcore/latest/APIReference/API_GetBrowserSession.html)
    /// *
    ///   [UpdateBrowserStream](https://docs.aws.amazon.com/bedrock-agentcore/latest/APIReference/API_UpdateBrowserStream.html)
    /// *
    ///   [SaveBrowserSessionProfile](https://docs.aws.amazon.com/bedrock-agentcore/latest/APIReference/API_SaveBrowserSessionProfile.html)
    /// *
    ///   [StopBrowserSession](https://docs.aws.amazon.com/bedrock-agentcore/latest/APIReference/API_StopBrowserSession.html)
    /// *
    ///   [InvokeBrowser](https://docs.aws.amazon.com/bedrock-agentcore/latest/APIReference/API_InvokeBrowser.html)
    pub fn startBrowserSession(self: *Self, allocator: std.mem.Allocator, input: start_browser_session.StartBrowserSessionInput, options: CallOptions) !start_browser_session.StartBrowserSessionOutput {
        return start_browser_session.execute(self, allocator, input, options);
    }

    /// Creates and initializes a code interpreter session in Amazon Bedrock
    /// AgentCore. The session enables agents to execute code as part of their
    /// response generation, supporting programming languages such as Python for
    /// data analysis, visualization, and computation tasks.
    ///
    /// To create a session, you must specify a code interpreter identifier and a
    /// name. The session remains active until it times out or you explicitly stop
    /// it using the `StopCodeInterpreterSession` operation.
    ///
    /// The following operations are related to `StartCodeInterpreterSession`:
    ///
    /// *
    ///   [InvokeCodeInterpreter](https://docs.aws.amazon.com/bedrock-agentcore/latest/APIReference/API_InvokeCodeInterpreter.html)
    /// *
    ///   [GetCodeInterpreterSession](https://docs.aws.amazon.com/bedrock-agentcore/latest/APIReference/API_GetCodeInterpreterSession.html)
    /// *
    ///   [StopCodeInterpreterSession](https://docs.aws.amazon.com/bedrock-agentcore/latest/APIReference/API_StopCodeInterpreterSession.html)
    pub fn startCodeInterpreterSession(self: *Self, allocator: std.mem.Allocator, input: start_code_interpreter_session.StartCodeInterpreterSessionInput, options: CallOptions) !start_code_interpreter_session.StartCodeInterpreterSessionOutput {
        return start_code_interpreter_session.execute(self, allocator, input, options);
    }

    /// Starts a memory extraction job that processes events that failed extraction
    /// previously in an AgentCore Memory resource and produces structured memory
    /// records. When earlier extraction attempts have left events unprocessed, this
    /// job will pick up and extract those as well.
    ///
    /// To use this operation, you must have the
    /// `bedrock-agentcore:StartMemoryExtractionJob` permission.
    pub fn startMemoryExtractionJob(self: *Self, allocator: std.mem.Allocator, input: start_memory_extraction_job.StartMemoryExtractionJobInput, options: CallOptions) !start_memory_extraction_job.StartMemoryExtractionJobOutput {
        return start_memory_extraction_job.execute(self, allocator, input, options);
    }

    /// Terminates an active browser session in Amazon Bedrock AgentCore. This
    /// operation stops the session, releases associated resources, and makes the
    /// session unavailable for further use.
    ///
    /// To stop a browser session, you must specify both the browser identifier and
    /// the session ID. Once stopped, a session cannot be restarted; you must create
    /// a new session using `StartBrowserSession`.
    ///
    /// The following operations are related to `StopBrowserSession`:
    ///
    /// *
    ///   [StartBrowserSession](https://docs.aws.amazon.com/bedrock-agentcore/latest/APIReference/API_StartBrowserSession.html)
    /// *
    ///   [GetBrowserSession](https://docs.aws.amazon.com/bedrock-agentcore/latest/APIReference/API_GetBrowserSession.html)
    pub fn stopBrowserSession(self: *Self, allocator: std.mem.Allocator, input: stop_browser_session.StopBrowserSessionInput, options: CallOptions) !stop_browser_session.StopBrowserSessionOutput {
        return stop_browser_session.execute(self, allocator, input, options);
    }

    /// Terminates an active code interpreter session in Amazon Bedrock AgentCore.
    /// This operation stops the session, releases associated resources, and makes
    /// the session unavailable for further use.
    ///
    /// To stop a code interpreter session, you must specify both the code
    /// interpreter identifier and the session ID. Once stopped, a session cannot be
    /// restarted; you must create a new session using
    /// `StartCodeInterpreterSession`.
    ///
    /// The following operations are related to `StopCodeInterpreterSession`:
    ///
    /// *
    ///   [StartCodeInterpreterSession](https://docs.aws.amazon.com/bedrock-agentcore/latest/APIReference/API_StartCodeInterpreterSession.html)
    /// *
    ///   [GetCodeInterpreterSession](https://docs.aws.amazon.com/bedrock-agentcore/latest/APIReference/API_GetCodeInterpreterSession.html)
    pub fn stopCodeInterpreterSession(self: *Self, allocator: std.mem.Allocator, input: stop_code_interpreter_session.StopCodeInterpreterSessionInput, options: CallOptions) !stop_code_interpreter_session.StopCodeInterpreterSessionOutput {
        return stop_code_interpreter_session.execute(self, allocator, input, options);
    }

    /// Stops a session that is running in an running AgentCore Runtime agent.
    pub fn stopRuntimeSession(self: *Self, allocator: std.mem.Allocator, input: stop_runtime_session.StopRuntimeSessionInput, options: CallOptions) !stop_runtime_session.StopRuntimeSessionOutput {
        return stop_runtime_session.execute(self, allocator, input, options);
    }

    /// Updates a browser stream. To use this operation, you must have permissions
    /// to perform the bedrock:UpdateBrowserStream action.
    pub fn updateBrowserStream(self: *Self, allocator: std.mem.Allocator, input: update_browser_stream.UpdateBrowserStreamInput, options: CallOptions) !update_browser_stream.UpdateBrowserStreamOutput {
        return update_browser_stream.execute(self, allocator, input, options);
    }

    pub fn listActorsPaginator(self: *Self, params: list_actors.ListActorsInput) paginator.ListActorsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listEventsPaginator(self: *Self, params: list_events.ListEventsInput) paginator.ListEventsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listMemoryExtractionJobsPaginator(self: *Self, params: list_memory_extraction_jobs.ListMemoryExtractionJobsInput) paginator.ListMemoryExtractionJobsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listMemoryRecordsPaginator(self: *Self, params: list_memory_records.ListMemoryRecordsInput) paginator.ListMemoryRecordsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listSessionsPaginator(self: *Self, params: list_sessions.ListSessionsInput) paginator.ListSessionsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn retrieveMemoryRecordsPaginator(self: *Self, params: retrieve_memory_records.RetrieveMemoryRecordsInput) paginator.RetrieveMemoryRecordsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }
};
