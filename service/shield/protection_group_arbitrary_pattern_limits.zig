/// Limits settings on protection groups with arbitrary pattern type.
pub const ProtectionGroupArbitraryPatternLimits = struct {
    /// The maximum number of resources you can specify for a single arbitrary
    /// pattern in a protection group.
    max_members: i64 = 0,

    pub const json_field_names = .{
        .max_members = "MaxMembers",
    };
};
