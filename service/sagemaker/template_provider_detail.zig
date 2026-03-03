const CfnTemplateProviderDetail = @import("cfn_template_provider_detail.zig").CfnTemplateProviderDetail;

/// Details about a template provider configuration and associated provisioning
/// information.
pub const TemplateProviderDetail = struct {
    /// Details about a CloudFormation template provider configuration and
    /// associated provisioning information.
    cfn_template_provider_detail: ?CfnTemplateProviderDetail = null,

    pub const json_field_names = .{
        .cfn_template_provider_detail = "CfnTemplateProviderDetail",
    };
};
