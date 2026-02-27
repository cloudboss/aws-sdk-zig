/// Information about contacts and times that an on-call override replaces.
pub const PreviewOverride = struct {
    /// Information about the time a rotation override would end.
    end_time: ?i64,

    /// Information about contacts to add to an on-call rotation override.
    new_members: ?[]const []const u8,

    /// Information about the time a rotation override would begin.
    start_time: ?i64,

    pub const json_field_names = .{
        .end_time = "EndTime",
        .new_members = "NewMembers",
        .start_time = "StartTime",
    };
};
