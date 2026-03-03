const aws = @import("aws");

const ActionGroupExecutor = @import("action_group_executor.zig").ActionGroupExecutor;
const ActionGroupState = @import("action_group_state.zig").ActionGroupState;
const APISchema = @import("api_schema.zig").APISchema;
const FunctionSchema = @import("function_schema.zig").FunctionSchema;
const ActionGroupSignature = @import("action_group_signature.zig").ActionGroupSignature;

/// Contains details about an action group.
pub const AgentActionGroup = struct {
    /// The Amazon Resource Name (ARN) of the Lambda function containing the
    /// business logic that is carried out upon invoking the action or the custom
    /// control method for handling the information elicited from the user.
    action_group_executor: ?ActionGroupExecutor = null,

    /// The unique identifier of the action group.
    action_group_id: []const u8,

    /// The name of the action group.
    action_group_name: []const u8,

    /// Specifies whether the action group is available for the agent to invoke or
    /// not when sending an
    /// [InvokeAgent](https://docs.aws.amazon.com/bedrock/latest/APIReference/API_agent-runtime_InvokeAgent.html) request.
    action_group_state: ActionGroupState,

    /// The unique identifier of the agent to which the action group belongs.
    agent_id: []const u8,

    /// The version of the agent to which the action group belongs.
    agent_version: []const u8,

    /// Contains either details about the S3 object containing the OpenAPI schema
    /// for the action group or the JSON or YAML-formatted payload defining the
    /// schema. For more information, see [Action group OpenAPI
    /// schemas](https://docs.aws.amazon.com/bedrock/latest/userguide/agents-api-schema.html).
    api_schema: ?APISchema = null,

    /// A unique, case-sensitive identifier to ensure that the API request completes
    /// no more than one time. If this token matches a previous request, Amazon
    /// Bedrock ignores the request, but does not return an error. For more
    /// information, see [Ensuring
    /// idempotency](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/Run_Instance_Idempotency.html).
    client_token: ?[]const u8 = null,

    /// The time at which the action group was created.
    created_at: i64,

    /// The description of the action group.
    description: ?[]const u8 = null,

    /// Defines functions that each define parameters that the agent needs to invoke
    /// from the user. Each function represents an action in an action group.
    function_schema: ?FunctionSchema = null,

    /// The configuration settings for a computer use action.
    ///
    /// Computer use is a new Anthropic Claude model capability (in beta) available
    /// with Claude 3.7 Sonnet and Claude 3.5 Sonnet v2 only. For more information,
    /// see [Configure an Amazon Bedrock Agent to complete tasks with computer use
    /// tools](https://docs.aws.amazon.com/bedrock/latest/userguide/agents-computer-use.html).
    parent_action_group_signature_params: ?[]const aws.map.StringMapEntry = null,

    /// If this field is set as `AMAZON.UserInput`, the agent can request the user
    /// for additional information when trying to complete a task. The
    /// `description`, `apiSchema`, and `actionGroupExecutor` fields must be blank
    /// for this action group.
    ///
    /// During orchestration, if the agent determines that it needs to invoke an API
    /// in an action group, but doesn't have enough information to complete the API
    /// request, it will invoke this action group instead and return an
    /// [Observation](https://docs.aws.amazon.com/bedrock/latest/APIReference/API_agent-runtime_Observation.html) reprompting the user for more information.
    parent_action_signature: ?ActionGroupSignature = null,

    /// The time at which the action group was last updated.
    updated_at: i64,

    pub const json_field_names = .{
        .action_group_executor = "actionGroupExecutor",
        .action_group_id = "actionGroupId",
        .action_group_name = "actionGroupName",
        .action_group_state = "actionGroupState",
        .agent_id = "agentId",
        .agent_version = "agentVersion",
        .api_schema = "apiSchema",
        .client_token = "clientToken",
        .created_at = "createdAt",
        .description = "description",
        .function_schema = "functionSchema",
        .parent_action_group_signature_params = "parentActionGroupSignatureParams",
        .parent_action_signature = "parentActionSignature",
        .updated_at = "updatedAt",
    };
};
