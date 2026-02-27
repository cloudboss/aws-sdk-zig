/// The group principal to whom the policy is granted.
pub const GroupPolicyGrantPrincipal = union(enum) {
    /// The ID Of the group of the group principal.
    group_identifier: ?[]const u8,

    pub const json_field_names = .{
        .group_identifier = "groupIdentifier",
    };
};
