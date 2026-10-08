const TestAction = @import("test_action.zig").TestAction;
const TestTemplateParameter = @import("test_template_parameter.zig").TestTemplateParameter;

/// A pre-configured, AWS recommended test that defines which resilience
/// capability to validate, the fault actions it runs, and the parameters it
/// accepts.
pub const TestTemplate = struct {
    /// The fault actions the test template runs.
    actions: ?[]const TestAction = null,

    /// A description of the test template.
    description: ?[]const u8 = null,

    /// The name of the test template.
    name: []const u8,

    /// The parameters the test template accepts.
    parameters: ?[]const TestTemplateParameter = null,

    /// The ARN of the test template.
    test_template_arn: []const u8,

    pub const json_field_names = .{
        .actions = "actions",
        .description = "description",
        .name = "name",
        .parameters = "parameters",
        .test_template_arn = "testTemplateArn",
    };
};
