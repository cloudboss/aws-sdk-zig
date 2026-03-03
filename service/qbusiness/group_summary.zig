/// Summary information for groups.
pub const GroupSummary = struct {
    /// The name of the group the summary information is for.
    group_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .group_name = "groupName",
    };
};
