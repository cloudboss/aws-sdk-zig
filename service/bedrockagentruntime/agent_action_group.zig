const aws = @import("aws");

const ActionGroupExecutor = @import("action_group_executor.zig").ActionGroupExecutor;
const APISchema = @import("api_schema.zig").APISchema;
const FunctionSchema = @import("function_schema.zig").FunctionSchema;
const ActionGroupSignature = @import("action_group_signature.zig").ActionGroupSignature;

/// Contains details of the inline agent's action group.
pub const AgentActionGroup = struct {
    /// The Amazon Resource Name (ARN) of the Lambda function containing the
    /// business logic that is carried out upon invoking the action or the custom
    /// control method for handling the information elicited from the user.
    action_group_executor: ?ActionGroupExecutor = null,

    /// The name of the action group.
    action_group_name: []const u8,

    /// Contains either details about the S3 object containing the OpenAPI schema
    /// for the action group or the JSON or YAML-formatted payload defining the
    /// schema. For more information, see [Action group OpenAPI
    /// schemas](https://docs.aws.amazon.com/bedrock/latest/userguide/agents-api-schema.html).
    api_schema: ?APISchema = null,

    /// A description of the action group.
    description: ?[]const u8 = null,

    /// Contains details about the function schema for the action group or the JSON
    /// or YAML-formatted payload defining the schema.
    function_schema: ?FunctionSchema = null,

    /// Specify a built-in or computer use action for this action group. If you
    /// specify a value, you must leave the `description`, `apiSchema`, and
    /// `actionGroupExecutor` fields empty for this action group.
    ///
    /// * To allow your agent to request the user for additional information when
    ///   trying to complete a task, set this field to `AMAZON.UserInput`.
    /// * To allow your agent to generate, run, and troubleshoot code when trying to
    ///   complete a task, set this field to `AMAZON.CodeInterpreter`.
    /// * To allow your agent to use an Anthropic computer use tool, specify one of
    ///   the following values.
    ///
    /// Computer use is a new Anthropic Claude model capability (in beta) available
    /// with Anthropic Claude 3.7 Sonnet and Claude 3.5 Sonnet v2 only. When
    /// operating computer use functionality, we recommend taking additional
    /// security precautions, such as executing computer actions in virtual
    /// environments with restricted data access and limited internet connectivity.
    /// For more information, see [Configure an Amazon Bedrock Agent to complete
    /// tasks with computer use
    /// tools](https://docs.aws.amazon.com/bedrock/latest/userguide/agent-computer-use.html).
    ///
    /// * `ANTHROPIC.Computer` - Gives the agent permission to use the mouse and
    ///   keyboard and take screenshots.
    /// * `ANTHROPIC.TextEditor` - Gives the agent permission to view, create and
    ///   edit files.
    /// * `ANTHROPIC.Bash` - Gives the agent permission to run commands in a bash
    ///   shell.
    parent_action_group_signature: ?ActionGroupSignature = null,

    /// The configuration settings for a computer use action.
    ///
    /// Computer use is a new Anthropic Claude model capability (in beta) available
    /// with Claude 3.7 Sonnet and Claude 3.5 Sonnet v2 only. For more information,
    /// see [Configure an Amazon Bedrock Agent to complete tasks with computer use
    /// tools](https://docs.aws.amazon.com/bedrock/latest/userguide/agent-computer-use.html).
    parent_action_group_signature_params: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .action_group_executor = "actionGroupExecutor",
        .action_group_name = "actionGroupName",
        .api_schema = "apiSchema",
        .description = "description",
        .function_schema = "functionSchema",
        .parent_action_group_signature = "parentActionGroupSignature",
        .parent_action_group_signature_params = "parentActionGroupSignatureParams",
    };
};
