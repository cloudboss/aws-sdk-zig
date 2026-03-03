const aws = @import("aws");

const ParameterDetail = @import("parameter_detail.zig").ParameterDetail;
const RequireConfirmation = @import("require_confirmation.zig").RequireConfirmation;

/// Defines parameters that the agent needs to invoke from the user to complete
/// the function. Corresponds to an action in an action group.
///
/// This data type is used in the following API operations:
///
/// * [CreateAgentActionGroup
///   request](https://docs.aws.amazon.com/bedrock/latest/APIReference/API_agent_CreateAgentActionGroup.html#API_agent_CreateAgentActionGroup_RequestSyntax)
/// * [CreateAgentActionGroup
///   response](https://docs.aws.amazon.com/bedrock/latest/APIReference/API_agent_CreateAgentActionGroup.html#API_agent_CreateAgentActionGroup_ResponseSyntax)
/// * [UpdateAgentActionGroup
///   request](https://docs.aws.amazon.com/bedrock/latest/APIReference/API_agent_UpdateAgentActionGroup.html#API_agent_UpdateAgentActionGroup_RequestSyntax)
/// * [UpdateAgentActionGroup
///   response](https://docs.aws.amazon.com/bedrock/latest/APIReference/API_agent_UpdateAgentActionGroup.html#API_agent_UpdateAgentActionGroup_ResponseSyntax)
/// * [GetAgentActionGroup
///   response](https://docs.aws.amazon.com/bedrock/latest/APIReference/API_agent_GetAgentActionGroup.html#API_agent_GetAgentActionGroup_ResponseSyntax)
pub const Function = struct {
    /// A description of the function and its purpose.
    description: ?[]const u8 = null,

    /// A name for the function.
    name: []const u8,

    /// The parameters that the agent elicits from the user to fulfill the function.
    parameters: ?[]const aws.map.MapEntry(ParameterDetail) = null,

    /// Contains information if user confirmation is required to invoke the
    /// function.
    require_confirmation: ?RequireConfirmation = null,

    pub const json_field_names = .{
        .description = "description",
        .name = "name",
        .parameters = "parameters",
        .require_confirmation = "requireConfirmation",
    };
};
