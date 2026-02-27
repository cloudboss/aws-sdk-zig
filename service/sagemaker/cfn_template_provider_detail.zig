const CfnStackParameter = @import("cfn_stack_parameter.zig").CfnStackParameter;
const CfnStackDetail = @import("cfn_stack_detail.zig").CfnStackDetail;

/// Details about a CloudFormation template provider configuration and
/// associated provisioning information.
pub const CfnTemplateProviderDetail = struct {
    /// An array of CloudFormation stack parameters.
    parameters: ?[]const CfnStackParameter,

    /// The IAM role used by CloudFormation to create the stack.
    role_arn: ?[]const u8,

    /// Information about the CloudFormation stack created by the template provider.
    stack_detail: ?CfnStackDetail,

    /// The unique identifier of the template within the project.
    template_name: []const u8,

    /// The Amazon S3 URL of the CloudFormation template.
    template_url: []const u8,

    pub const json_field_names = .{
        .parameters = "Parameters",
        .role_arn = "RoleARN",
        .stack_detail = "StackDetail",
        .template_name = "TemplateName",
        .template_url = "TemplateURL",
    };
};
