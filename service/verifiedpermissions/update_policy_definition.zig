const UpdateStaticPolicyDefinition = @import("update_static_policy_definition.zig").UpdateStaticPolicyDefinition;

/// Contains information about updates to be applied to a policy.
///
/// This data type is used as a request parameter in the
/// [UpdatePolicy](https://docs.aws.amazon.com/verifiedpermissions/latest/apireference/API_UpdatePolicy.html) operation.
pub const UpdatePolicyDefinition = union(enum) {
    /// Contains details about the updates to be applied to a static policy.
    static: ?UpdateStaticPolicyDefinition,

    pub const json_field_names = .{
        .static = "static",
    };
};
