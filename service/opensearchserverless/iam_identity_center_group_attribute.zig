pub const IamIdentityCenterGroupAttribute = enum {
    /// Group ID
    group_id,
    /// Group Name
    group_name,

    pub const json_field_names = .{
        .group_id = "GroupId",
        .group_name = "GroupName",
    };
};
