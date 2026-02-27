const StaticPolicyDefinitionDetail = @import("static_policy_definition_detail.zig").StaticPolicyDefinitionDetail;
const TemplateLinkedPolicyDefinitionDetail = @import("template_linked_policy_definition_detail.zig").TemplateLinkedPolicyDefinitionDetail;

/// A structure that describes a policy definition. It must always have either
/// an `static` or a `templateLinked` element.
///
/// This data type is used as a response parameter for the
/// [GetPolicy](https://docs.aws.amazon.com/verifiedpermissions/latest/apireference/API_GetPolicy.html) operation.
pub const PolicyDefinitionDetail = union(enum) {
    /// Information about a static policy that wasn't created with a policy
    /// template.
    static: ?StaticPolicyDefinitionDetail,
    /// Information about a template-linked policy that was created by instantiating
    /// a policy template.
    template_linked: ?TemplateLinkedPolicyDefinitionDetail,

    pub const json_field_names = .{
        .static = "static",
        .template_linked = "templateLinked",
    };
};
