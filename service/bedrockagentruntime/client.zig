const aws = @import("aws");
const std = @import("std");

const create_invocation = @import("create_invocation.zig");
const create_session = @import("create_session.zig");
const delete_agent_memory = @import("delete_agent_memory.zig");
const delete_session = @import("delete_session.zig");
const end_session = @import("end_session.zig");
const generate_query = @import("generate_query.zig");
const get_agent_memory = @import("get_agent_memory.zig");
const get_execution_flow_snapshot = @import("get_execution_flow_snapshot.zig");
const get_flow_execution = @import("get_flow_execution.zig");
const get_invocation_step = @import("get_invocation_step.zig");
const get_session = @import("get_session.zig");
const invoke_agent = @import("invoke_agent.zig");
const invoke_flow = @import("invoke_flow.zig");
const invoke_inline_agent = @import("invoke_inline_agent.zig");
const list_flow_execution_events = @import("list_flow_execution_events.zig");
const list_flow_executions = @import("list_flow_executions.zig");
const list_invocation_steps = @import("list_invocation_steps.zig");
const list_invocations = @import("list_invocations.zig");
const list_sessions = @import("list_sessions.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const optimize_prompt = @import("optimize_prompt.zig");
const put_invocation_step = @import("put_invocation_step.zig");
const rerank_ = @import("rerank.zig");
const retrieve_ = @import("retrieve.zig");
const retrieve_and_generate = @import("retrieve_and_generate.zig");
const retrieve_and_generate_stream = @import("retrieve_and_generate_stream.zig");
const start_flow_execution = @import("start_flow_execution.zig");
const stop_flow_execution = @import("stop_flow_execution.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_session = @import("update_session.zig");
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "Bedrock Agent Runtime";

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

    /// Creates a new invocation within a session. An invocation groups the related
    /// invocation steps that store the content from a conversation. For more
    /// information about sessions, see [Store and retrieve conversation history and
    /// context with Amazon Bedrock
    /// sessions](https://docs.aws.amazon.com/bedrock/latest/userguide/sessions.html).
    ///
    /// Related APIs
    ///
    /// *
    ///   [ListInvocations](https://docs.aws.amazon.com/bedrock/latest/APIReference/API_agent-runtime_ListInvocations.html)
    /// *
    ///   [ListSessions](https://docs.aws.amazon.com/bedrock/latest/APIReference/API_agent-runtime_ListSessions.html)
    /// *
    ///   [GetSession](https://docs.aws.amazon.com/bedrock/latest/APIReference/API_agent-runtime_GetSession.html)
    pub fn createInvocation(self: *Self, allocator: std.mem.Allocator, input: create_invocation.CreateInvocationInput, options: create_invocation.Options) !create_invocation.CreateInvocationOutput {
        return create_invocation.execute(self, allocator, input, options);
    }

    /// Creates a session to temporarily store conversations for generative AI
    /// (GenAI) applications built with open-source frameworks such as LangGraph and
    /// LlamaIndex. Sessions enable you to save the state of conversations at
    /// checkpoints, with the added security and infrastructure of Amazon Web
    /// Services. For more information, see [Store and retrieve conversation history
    /// and context with Amazon Bedrock
    /// sessions](https://docs.aws.amazon.com/bedrock/latest/userguide/sessions.html).
    ///
    /// By default, Amazon Bedrock uses Amazon Web Services-managed keys for session
    /// encryption, including session metadata, or you can use your own KMS key. For
    /// more information, see [Amazon Bedrock session
    /// encryption](https://docs.aws.amazon.com/bedrock/latest/userguide/session-encryption.html).
    ///
    /// You use a session to store state and conversation history for generative AI
    /// applications built with open-source frameworks. For Amazon Bedrock Agents,
    /// the service automatically manages conversation context and associates them
    /// with the agent-specific sessionId you specify in the
    /// [InvokeAgent](https://docs.aws.amazon.com/bedrock/latest/APIReference/API_agent-runtime_InvokeAgent.html) API operation.
    ///
    /// Related APIs:
    ///
    /// *
    ///   [ListSessions](https://docs.aws.amazon.com/bedrock/latest/APIReference/API_agent-runtime_ListSessions.html)
    /// *
    ///   [GetSession](https://docs.aws.amazon.com/bedrock/latest/APIReference/API_agent-runtime_GetSession.html)
    /// *
    ///   [EndSession](https://docs.aws.amazon.com/bedrock/latest/APIReference/API_agent-runtime_EndSession.html)
    /// *
    ///   [DeleteSession](https://docs.aws.amazon.com/bedrock/latest/APIReference/API_agent-runtime_DeleteSession.html)
    pub fn createSession(self: *Self, allocator: std.mem.Allocator, input: create_session.CreateSessionInput, options: create_session.Options) !create_session.CreateSessionOutput {
        return create_session.execute(self, allocator, input, options);
    }

    /// Deletes memory from the specified memory identifier.
    pub fn deleteAgentMemory(self: *Self, allocator: std.mem.Allocator, input: delete_agent_memory.DeleteAgentMemoryInput, options: delete_agent_memory.Options) !delete_agent_memory.DeleteAgentMemoryOutput {
        return delete_agent_memory.execute(self, allocator, input, options);
    }

    /// Deletes a session that you ended. You can't delete a session with an
    /// `ACTIVE` status. To delete an active session, you must first end it with the
    /// [EndSession](https://docs.aws.amazon.com/bedrock/latest/APIReference/API_agent-runtime_EndSession.html) API operation. For more information about sessions, see [Store and retrieve conversation history and context with Amazon Bedrock sessions](https://docs.aws.amazon.com/bedrock/latest/userguide/sessions.html).
    pub fn deleteSession(self: *Self, allocator: std.mem.Allocator, input: delete_session.DeleteSessionInput, options: delete_session.Options) !delete_session.DeleteSessionOutput {
        return delete_session.execute(self, allocator, input, options);
    }

    /// Ends the session. After you end a session, you can still access its content
    /// but you can’t add to it. To delete the session and it's content, you use the
    /// DeleteSession API operation. For more information about sessions, see [Store
    /// and retrieve conversation history and context with Amazon Bedrock
    /// sessions](https://docs.aws.amazon.com/bedrock/latest/userguide/sessions.html).
    pub fn endSession(self: *Self, allocator: std.mem.Allocator, input: end_session.EndSessionInput, options: end_session.Options) !end_session.EndSessionOutput {
        return end_session.execute(self, allocator, input, options);
    }

    /// Generates an SQL query from a natural language query. For more information,
    /// see [Generate a query for structured
    /// data](https://docs.aws.amazon.com/bedrock/latest/userguide/knowledge-base-generate-query.html) in the Amazon Bedrock User Guide.
    pub fn generateQuery(self: *Self, allocator: std.mem.Allocator, input: generate_query.GenerateQueryInput, options: generate_query.Options) !generate_query.GenerateQueryOutput {
        return generate_query.execute(self, allocator, input, options);
    }

    /// Gets the sessions stored in the memory of the agent.
    pub fn getAgentMemory(self: *Self, allocator: std.mem.Allocator, input: get_agent_memory.GetAgentMemoryInput, options: get_agent_memory.Options) !get_agent_memory.GetAgentMemoryOutput {
        return get_agent_memory.execute(self, allocator, input, options);
    }

    /// Retrieves the flow definition snapshot used for a flow execution. The
    /// snapshot represents the flow metadata and definition as it existed at the
    /// time the execution was started. Note that even if the flow is edited after
    /// an execution starts, the snapshot connected to the execution remains
    /// unchanged.
    ///
    /// Flow executions is in preview release for Amazon Bedrock and is subject to
    /// change.
    pub fn getExecutionFlowSnapshot(self: *Self, allocator: std.mem.Allocator, input: get_execution_flow_snapshot.GetExecutionFlowSnapshotInput, options: get_execution_flow_snapshot.Options) !get_execution_flow_snapshot.GetExecutionFlowSnapshotOutput {
        return get_execution_flow_snapshot.execute(self, allocator, input, options);
    }

    /// Retrieves details about a specific flow execution, including its status,
    /// start and end times, and any errors that occurred during execution.
    pub fn getFlowExecution(self: *Self, allocator: std.mem.Allocator, input: get_flow_execution.GetFlowExecutionInput, options: get_flow_execution.Options) !get_flow_execution.GetFlowExecutionOutput {
        return get_flow_execution.execute(self, allocator, input, options);
    }

    /// Retrieves the details of a specific invocation step within an invocation in
    /// a session. For more information about sessions, see [Store and retrieve
    /// conversation history and context with Amazon Bedrock
    /// sessions](https://docs.aws.amazon.com/bedrock/latest/userguide/sessions.html).
    pub fn getInvocationStep(self: *Self, allocator: std.mem.Allocator, input: get_invocation_step.GetInvocationStepInput, options: get_invocation_step.Options) !get_invocation_step.GetInvocationStepOutput {
        return get_invocation_step.execute(self, allocator, input, options);
    }

    /// Retrieves details about a specific session. For more information about
    /// sessions, see [Store and retrieve conversation history and context with
    /// Amazon Bedrock
    /// sessions](https://docs.aws.amazon.com/bedrock/latest/userguide/sessions.html).
    pub fn getSession(self: *Self, allocator: std.mem.Allocator, input: get_session.GetSessionInput, options: get_session.Options) !get_session.GetSessionOutput {
        return get_session.execute(self, allocator, input, options);
    }

    /// Sends a prompt for the agent to process and respond to. Note the following
    /// fields for the request:
    ///
    /// * To continue the same conversation with an agent, use the same `sessionId`
    ///   value in the request.
    /// * To activate trace enablement, turn `enableTrace` to `true`. Trace
    ///   enablement helps you follow the agent's reasoning process that led it to
    ///   the information it processed, the actions it took, and the final result it
    ///   yielded. For more information, see [Trace
    ///   enablement](https://docs.aws.amazon.com/bedrock/latest/userguide/agents-test.html#trace-events).
    /// * End a conversation by setting `endSession` to `true`.
    /// * In the `sessionState` object, you can include attributes for the session
    ///   or prompt or, if you configured an action group to return control, results
    ///   from invocation of the action group.
    ///
    /// The response contains both **chunk** and **trace** attributes.
    ///
    /// The final response is returned in the `bytes` field of the `chunk` object.
    /// The `InvokeAgent` returns one chunk for the entire interaction.
    ///
    /// * The `attribution` object contains citations for parts of the response.
    /// * If you set `enableTrace` to `true` in the request, you can trace the
    ///   agent's steps and reasoning process that led it to the response.
    /// * If the action predicted was configured to return control, the response
    ///   returns parameters for the action, elicited from the user, in the
    ///   `returnControl` field.
    /// * Errors are also surfaced in the response.
    pub fn invokeAgent(self: *Self, allocator: std.mem.Allocator, input: invoke_agent.InvokeAgentInput, options: invoke_agent.Options) !invoke_agent.InvokeAgentOutput {
        return invoke_agent.execute(self, allocator, input, options);
    }

    /// Invokes an alias of a flow to run the inputs that you specify and return the
    /// output of each node as a stream. If there's an error, the error is returned.
    /// For more information, see [Test a flow in Amazon
    /// Bedrock](https://docs.aws.amazon.com/bedrock/latest/userguide/flows-test.html) in the [Amazon Bedrock User Guide](https://docs.aws.amazon.com/bedrock/latest/userguide/what-is-service.html).
    ///
    /// The CLI doesn't support streaming operations in Amazon Bedrock, including
    /// `InvokeFlow`.
    pub fn invokeFlow(self: *Self, allocator: std.mem.Allocator, input: invoke_flow.InvokeFlowInput, options: invoke_flow.Options) !invoke_flow.InvokeFlowOutput {
        return invoke_flow.execute(self, allocator, input, options);
    }

    /// Invokes an inline Amazon Bedrock agent using the configurations you provide
    /// with the request.
    ///
    /// * Specify the following fields for security purposes.
    ///
    /// * (Optional) `customerEncryptionKeyArn` – The Amazon Resource Name (ARN) of
    ///   a KMS key to encrypt the creation of the agent.
    /// * (Optional) `idleSessionTTLinSeconds` – Specify the number of seconds for
    ///   which the agent should maintain session information. After this time
    ///   expires, the subsequent `InvokeInlineAgent` request begins a new session.
    ///
    /// * To override the default prompt behavior for agent orchestration and to use
    ///   advanced prompts, include a `promptOverrideConfiguration` object. For more
    ///   information, see [Advanced
    ///   prompts](https://docs.aws.amazon.com/bedrock/latest/userguide/advanced-prompts.html).
    /// * The agent instructions will not be honored if your agent has only one
    ///   knowledge base, uses default prompts, has no action group, and user input
    ///   is disabled.
    pub fn invokeInlineAgent(self: *Self, allocator: std.mem.Allocator, input: invoke_inline_agent.InvokeInlineAgentInput, options: invoke_inline_agent.Options) !invoke_inline_agent.InvokeInlineAgentOutput {
        return invoke_inline_agent.execute(self, allocator, input, options);
    }

    /// Lists events that occurred during a flow execution. Events provide detailed
    /// information about the execution progress, including node inputs and outputs,
    /// flow inputs and outputs, condition results, and failure events.
    ///
    /// Flow executions is in preview release for Amazon Bedrock and is subject to
    /// change.
    pub fn listFlowExecutionEvents(self: *Self, allocator: std.mem.Allocator, input: list_flow_execution_events.ListFlowExecutionEventsInput, options: list_flow_execution_events.Options) !list_flow_execution_events.ListFlowExecutionEventsOutput {
        return list_flow_execution_events.execute(self, allocator, input, options);
    }

    /// Lists all executions of a flow. Results can be paginated and include summary
    /// information about each execution, such as status, start and end times, and
    /// the execution's Amazon Resource Name (ARN).
    ///
    /// Flow executions is in preview release for Amazon Bedrock and is subject to
    /// change.
    pub fn listFlowExecutions(self: *Self, allocator: std.mem.Allocator, input: list_flow_executions.ListFlowExecutionsInput, options: list_flow_executions.Options) !list_flow_executions.ListFlowExecutionsOutput {
        return list_flow_executions.execute(self, allocator, input, options);
    }

    /// Lists all invocation steps associated with a session and optionally, an
    /// invocation within the session. For more information about sessions, see
    /// [Store and retrieve conversation history and context with Amazon Bedrock
    /// sessions](https://docs.aws.amazon.com/bedrock/latest/userguide/sessions.html).
    pub fn listInvocationSteps(self: *Self, allocator: std.mem.Allocator, input: list_invocation_steps.ListInvocationStepsInput, options: list_invocation_steps.Options) !list_invocation_steps.ListInvocationStepsOutput {
        return list_invocation_steps.execute(self, allocator, input, options);
    }

    /// Lists all invocations associated with a specific session. For more
    /// information about sessions, see [Store and retrieve conversation history and
    /// context with Amazon Bedrock
    /// sessions](https://docs.aws.amazon.com/bedrock/latest/userguide/sessions.html).
    pub fn listInvocations(self: *Self, allocator: std.mem.Allocator, input: list_invocations.ListInvocationsInput, options: list_invocations.Options) !list_invocations.ListInvocationsOutput {
        return list_invocations.execute(self, allocator, input, options);
    }

    /// Lists all sessions in your Amazon Web Services account. For more information
    /// about sessions, see [Store and retrieve conversation history and context
    /// with Amazon Bedrock
    /// sessions](https://docs.aws.amazon.com/bedrock/latest/userguide/sessions.html).
    pub fn listSessions(self: *Self, allocator: std.mem.Allocator, input: list_sessions.ListSessionsInput, options: list_sessions.Options) !list_sessions.ListSessionsOutput {
        return list_sessions.execute(self, allocator, input, options);
    }

    /// List all the tags for the resource you specify.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: list_tags_for_resource.Options) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Optimizes a prompt for the task that you specify. For more information, see
    /// [Optimize a
    /// prompt](https://docs.aws.amazon.com/bedrock/latest/userguide/prompt-management-optimize.html) in the [Amazon Bedrock User Guide](https://docs.aws.amazon.com/bedrock/latest/userguide/what-is-service.html).
    pub fn optimizePrompt(self: *Self, allocator: std.mem.Allocator, input: optimize_prompt.OptimizePromptInput, options: optimize_prompt.Options) !optimize_prompt.OptimizePromptOutput {
        return optimize_prompt.execute(self, allocator, input, options);
    }

    /// Add an invocation step to an invocation in a session. An invocation step
    /// stores fine-grained state checkpoints, including text and images, for each
    /// interaction. For more information about sessions, see [Store and retrieve
    /// conversation history and context with Amazon Bedrock
    /// sessions](https://docs.aws.amazon.com/bedrock/latest/userguide/sessions.html).
    ///
    /// Related APIs:
    ///
    /// *
    ///   [GetInvocationStep](https://docs.aws.amazon.com/bedrock/latest/APIReference/API_agent-runtime_GetInvocationStep.html)
    /// *
    ///   [ListInvocationSteps](https://docs.aws.amazon.com/bedrock/latest/APIReference/API_agent-runtime_ListInvocationSteps.html)
    /// *
    ///   [ListInvocations](https://docs.aws.amazon.com/bedrock/latest/APIReference/API_agent-runtime_ListInvocations.html)
    /// *
    ///   [ListSessions](https://docs.aws.amazon.com/bedrock/latest/APIReference/API_agent-runtime_ListInvocations.html)
    pub fn putInvocationStep(self: *Self, allocator: std.mem.Allocator, input: put_invocation_step.PutInvocationStepInput, options: put_invocation_step.Options) !put_invocation_step.PutInvocationStepOutput {
        return put_invocation_step.execute(self, allocator, input, options);
    }

    /// Reranks the relevance of sources based on queries. For more information, see
    /// [Improve the relevance of query responses with a reranker
    /// model](https://docs.aws.amazon.com/bedrock/latest/userguide/rerank.html).
    pub fn rerank(self: *Self, allocator: std.mem.Allocator, input: rerank_.RerankInput, options: rerank_.Options) !rerank_.RerankOutput {
        return rerank_.execute(self, allocator, input, options);
    }

    /// Queries a knowledge base and retrieves information from it.
    pub fn retrieve(self: *Self, allocator: std.mem.Allocator, input: retrieve_.RetrieveInput, options: retrieve_.Options) !retrieve_.RetrieveOutput {
        return retrieve_.execute(self, allocator, input, options);
    }

    /// Queries a knowledge base and generates responses based on the retrieved
    /// results and using the specified foundation model or [inference
    /// profile](https://docs.aws.amazon.com/bedrock/latest/userguide/cross-region-inference.html). The response only cites sources that are relevant to the query.
    pub fn retrieveAndGenerate(self: *Self, allocator: std.mem.Allocator, input: retrieve_and_generate.RetrieveAndGenerateInput, options: retrieve_and_generate.Options) !retrieve_and_generate.RetrieveAndGenerateOutput {
        return retrieve_and_generate.execute(self, allocator, input, options);
    }

    /// Queries a knowledge base and generates responses based on the retrieved
    /// results, with output in streaming format.
    ///
    /// The CLI doesn't support streaming operations in Amazon Bedrock, including
    /// `InvokeModelWithResponseStream`.
    ///
    /// This operation requires permission for the ` bedrock:RetrieveAndGenerate`
    /// action.
    pub fn retrieveAndGenerateStream(self: *Self, allocator: std.mem.Allocator, input: retrieve_and_generate_stream.RetrieveAndGenerateStreamInput, options: retrieve_and_generate_stream.Options) !retrieve_and_generate_stream.RetrieveAndGenerateStreamOutput {
        return retrieve_and_generate_stream.execute(self, allocator, input, options);
    }

    /// Starts an execution of an Amazon Bedrock flow. Unlike flows that run until
    /// completion or time out after five minutes, flow executions let you run flows
    /// asynchronously for longer durations. Flow executions also yield control so
    /// that your application can perform other tasks.
    ///
    /// This operation returns an Amazon Resource Name (ARN) that you can use to
    /// track and manage your flow execution.
    ///
    /// Flow executions is in preview release for Amazon Bedrock and is subject to
    /// change.
    pub fn startFlowExecution(self: *Self, allocator: std.mem.Allocator, input: start_flow_execution.StartFlowExecutionInput, options: start_flow_execution.Options) !start_flow_execution.StartFlowExecutionOutput {
        return start_flow_execution.execute(self, allocator, input, options);
    }

    /// Stops an Amazon Bedrock flow's execution. This operation prevents further
    /// processing of the flow and changes the execution status to `Aborted`.
    pub fn stopFlowExecution(self: *Self, allocator: std.mem.Allocator, input: stop_flow_execution.StopFlowExecutionInput, options: stop_flow_execution.Options) !stop_flow_execution.StopFlowExecutionOutput {
        return stop_flow_execution.execute(self, allocator, input, options);
    }

    /// Associate tags with a resource. For more information, see [Tagging
    /// resources](https://docs.aws.amazon.com/bedrock/latest/userguide/what-is-service.html) in the Amazon Bedrock User Guide.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: tag_resource.Options) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Remove tags from a resource.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: untag_resource.Options) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Updates the metadata or encryption settings of a session. For more
    /// information about sessions, see [Store and retrieve conversation history and
    /// context with Amazon Bedrock
    /// sessions](https://docs.aws.amazon.com/bedrock/latest/userguide/sessions.html).
    pub fn updateSession(self: *Self, allocator: std.mem.Allocator, input: update_session.UpdateSessionInput, options: update_session.Options) !update_session.UpdateSessionOutput {
        return update_session.execute(self, allocator, input, options);
    }

    pub fn getAgentMemoryPaginator(self: *Self, params: get_agent_memory.GetAgentMemoryInput) paginator.GetAgentMemoryPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listFlowExecutionEventsPaginator(self: *Self, params: list_flow_execution_events.ListFlowExecutionEventsInput) paginator.ListFlowExecutionEventsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listFlowExecutionsPaginator(self: *Self, params: list_flow_executions.ListFlowExecutionsInput) paginator.ListFlowExecutionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listInvocationStepsPaginator(self: *Self, params: list_invocation_steps.ListInvocationStepsInput) paginator.ListInvocationStepsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listInvocationsPaginator(self: *Self, params: list_invocations.ListInvocationsInput) paginator.ListInvocationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listSessionsPaginator(self: *Self, params: list_sessions.ListSessionsInput) paginator.ListSessionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn rerankPaginator(self: *Self, params: rerank_.RerankInput) paginator.RerankPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn retrievePaginator(self: *Self, params: retrieve_.RetrieveInput) paginator.RetrievePaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};
