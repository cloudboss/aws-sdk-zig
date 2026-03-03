const CfnUpdateTemplateProvider = @import("cfn_update_template_provider.zig").CfnUpdateTemplateProvider;

/// Contains configuration details for updating an existing template provider in
/// the project.
pub const UpdateTemplateProvider = struct {
    /// The CloudFormation template provider configuration to update.
    cfn_template_provider: ?CfnUpdateTemplateProvider = null,

    pub const json_field_names = .{
        .cfn_template_provider = "CfnTemplateProvider",
    };
};
