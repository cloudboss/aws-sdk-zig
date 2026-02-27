pub const ContactCenterActivity = struct {
    /// The unique identifier for the next activity to perform after the this
    /// activity.
    next_activity: ?[]const u8,

    pub const json_field_names = .{
        .next_activity = "NextActivity",
    };
};
