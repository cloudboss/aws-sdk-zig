const DeploymentConditionalField = @import("deployment_conditional_field.zig").DeploymentConditionalField;

/// A field that details a specification of a deployment pattern.
pub const DeploymentSpecificationsField = struct {
    /// The allowed values of the deployment specification.
    allowed_values: ?[]const []const u8 = null,

    /// The conditionals used for the deployment specification.
    conditionals: ?[]const DeploymentConditionalField = null,

    /// The description of the deployment specification.
    description: ?[]const u8 = null,

    /// The name of the deployment specification.
    name: ?[]const u8 = null,

    /// Indicates if the deployment specification is required.
    required: ?[]const u8 = null,

    pub const json_field_names = .{
        .allowed_values = "allowedValues",
        .conditionals = "conditionals",
        .description = "description",
        .name = "name",
        .required = "required",
    };
};
