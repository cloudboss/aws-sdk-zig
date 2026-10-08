/// Contains summary information about a test template.
pub const TestTemplateSummary = struct {
    /// A description of the test template.
    description: []const u8,

    /// The name of the test template.
    name: []const u8,

    /// The ARN of the test template.
    test_template_arn: []const u8,

    pub const json_field_names = .{
        .description = "description",
        .name = "name",
        .test_template_arn = "testTemplateArn",
    };
};
