/// Specifies the rule settings for when messages can't be sent.
pub const ClosedDaysRule = struct {
    /// End DateTime ISO 8601 format
    end_date_time: ?[]const u8 = null,

    /// The name of the closed day rule.
    name: ?[]const u8 = null,

    /// Start DateTime ISO 8601 format
    start_date_time: ?[]const u8 = null,

    pub const json_field_names = .{
        .end_date_time = "EndDateTime",
        .name = "Name",
        .start_date_time = "StartDateTime",
    };
};
