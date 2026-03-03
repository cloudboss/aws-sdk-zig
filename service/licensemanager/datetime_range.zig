/// Describes a time range, in ISO8601-UTC format.
pub const DatetimeRange = struct {
    /// Start of the time range.
    begin: []const u8,

    /// End of the time range.
    end: ?[]const u8 = null,

    pub const json_field_names = .{
        .begin = "Begin",
        .end = "End",
    };
};
