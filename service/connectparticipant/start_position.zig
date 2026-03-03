/// A filtering option for where to start. For example, if you sent 100
/// messages, start
/// with message 50.
pub const StartPosition = struct {
    /// The time in ISO format where to start.
    ///
    /// It's specified in ISO 8601 format: yyyy-MM-ddThh:mm:ss.SSSZ. For example,
    /// 2019-11-08T02:41:28.172Z.
    absolute_time: ?[]const u8 = null,

    /// The ID of the message or event where to start.
    id: ?[]const u8 = null,

    /// The start position of the most recent message where you want to start.
    most_recent: i32 = 0,

    pub const json_field_names = .{
        .absolute_time = "AbsoluteTime",
        .id = "Id",
        .most_recent = "MostRecent",
    };
};
