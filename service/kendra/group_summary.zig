/// Summary information for groups.
pub const GroupSummary = struct {
    /// The identifier of the group you want group summary information on.
    group_id: ?[]const u8 = null,

    /// The timestamp identifier used for the latest `PUT` or `DELETE`
    /// action.
    ordering_id: ?i64 = null,

    pub const json_field_names = .{
        .group_id = "GroupId",
        .ordering_id = "OrderingId",
    };
};
