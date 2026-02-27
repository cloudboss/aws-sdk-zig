const CfnStackCreateParameter = @import("cfn_stack_create_parameter.zig").CfnStackCreateParameter;

/// The CloudFormation template provider configuration for creating
/// infrastructure resources.
pub const CfnCreateTemplateProvider = struct {
    /// An array of CloudFormation stack parameters.
    parameters: ?[]const CfnStackCreateParameter,

    /// The IAM role that CloudFormation assumes when creating the stack.
    role_arn: ?[]const u8,

    /// A unique identifier for the template within the project.
    template_name: []const u8,

    /// The Amazon S3 URL of the CloudFormation template.
    template_url: []const u8,

    pub const json_field_names = .{
        .parameters = "Parameters",
        .role_arn = "RoleARN",
        .template_name = "TemplateName",
        .template_url = "TemplateURL",
    };
};
