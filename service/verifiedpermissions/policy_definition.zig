const StaticPolicyDefinition = @import("static_policy_definition.zig").StaticPolicyDefinition;
const TemplateLinkedPolicyDefinition = @import("template_linked_policy_definition.zig").TemplateLinkedPolicyDefinition;

/// A structure that contains the details for a Cedar policy definition. It
/// includes the policy type, a description, and a policy body. This is a top
/// level data type used to create a policy.
///
/// This data type is used as a request parameter for the
/// [CreatePolicy](https://docs.aws.amazon.com/verifiedpermissions/latest/apireference/API_CreatePolicy.html) operation. This structure must always have either an `static` or a `templateLinked` element.
pub const PolicyDefinition = union(enum) {
    /// A structure that describes a static policy. An static policy doesn't use a
    /// template or allow placeholders for entities.
    static: ?StaticPolicyDefinition,
    /// A structure that describes a policy that was instantiated from a template.
    /// The template can specify placeholders for `principal` and `resource`. When
    /// you use
    /// [CreatePolicy](https://docs.aws.amazon.com/verifiedpermissions/latest/apireference/API_CreatePolicy.html) to create a policy from a template, you specify the exact principal and resource to use for the instantiated policy.
    template_linked: ?TemplateLinkedPolicyDefinition,

    pub const json_field_names = .{
        .static = "static",
        .template_linked = "templateLinked",
    };
};
