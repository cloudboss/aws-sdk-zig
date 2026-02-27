const StaticPolicyDefinitionItem = @import("static_policy_definition_item.zig").StaticPolicyDefinitionItem;
const TemplateLinkedPolicyDefinitionItem = @import("template_linked_policy_definition_item.zig").TemplateLinkedPolicyDefinitionItem;

/// A structure that describes a
/// [PolicyDefinintion](https://docs.aws.amazon.com/verifiedpermissions/latest/apireference/API_PolicyDefinintion.html). It will always have either an `StaticPolicy` or a `TemplateLinkedPolicy` element.
///
/// This data type is used as a response parameter for the
/// [CreatePolicy](https://docs.aws.amazon.com/verifiedpermissions/latest/apireference/API_CreatePolicy.html) and [ListPolicies](https://docs.aws.amazon.com/verifiedpermissions/latest/apireference/API_ListPolicies.html) operations.
pub const PolicyDefinitionItem = union(enum) {
    /// Information about a static policy that wasn't created with a policy
    /// template.
    static: ?StaticPolicyDefinitionItem,
    /// Information about a template-linked policy that was created by instantiating
    /// a policy template.
    template_linked: ?TemplateLinkedPolicyDefinitionItem,

    pub const json_field_names = .{
        .static = "static",
        .template_linked = "templateLinked",
    };
};
