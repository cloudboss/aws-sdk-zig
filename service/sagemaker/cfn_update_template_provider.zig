const CfnStackUpdateParameter = @import("cfn_stack_update_parameter.zig").CfnStackUpdateParameter;

/// Contains configuration details for updating an existing CloudFormation
/// template provider in the project.
pub const CfnUpdateTemplateProvider = struct {
    /// An array of CloudFormation stack parameters.
    parameters: ?[]const CfnStackUpdateParameter,

    /// The unique identifier of the template to update within the project.
    template_name: []const u8,

    /// The Amazon S3 URL of the CloudFormation template.
    template_url: []const u8,

    pub const json_field_names = .{
        .parameters = "Parameters",
        .template_name = "TemplateName",
        .template_url = "TemplateURL",
    };
};
