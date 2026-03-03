const aws = @import("aws");

const ParameterDetail = @import("parameter_detail.zig").ParameterDetail;
const RequireConfirmation = @import("require_confirmation.zig").RequireConfirmation;

/// Defines parameters that the agent needs to invoke from the user to complete
/// the function. Corresponds to an action in an action group.
pub const FunctionDefinition = struct {
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
