const CfnCreateTemplateProvider = @import("cfn_create_template_provider.zig").CfnCreateTemplateProvider;

/// Contains configuration details for a template provider. Only one type of
/// template provider can be specified.
pub const CreateTemplateProvider = struct {
    /// The CloudFormation template provider configuration for creating
    /// infrastructure resources.
    cfn_template_provider: ?CfnCreateTemplateProvider = null,

    pub const json_field_names = .{
        .cfn_template_provider = "CfnTemplateProvider",
    };
};
