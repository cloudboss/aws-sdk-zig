/// Contains information about a static policy.
///
/// This data type is used as a field that is part of the
/// [PolicyDefinitionDetail](https://docs.aws.amazon.com/verifiedpermissions/latest/apireference/API_PolicyDefinitionDetail.html) type.
pub const StaticPolicyDefinition = struct {
    /// The description of the static policy.
    description: ?[]const u8 = null,

    /// The policy content of the static policy, written in the Cedar policy
    /// language.
    statement: []const u8,

    pub const json_field_names = .{
        .description = "description",
        .statement = "statement",
    };
};
