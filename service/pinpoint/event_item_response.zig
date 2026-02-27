/// Provides the status code and message that result from processing an event.
pub const EventItemResponse = struct {
    /// A custom message that's returned in the response as a result of processing
    /// the event.
    message: ?[]const u8,

    /// The status code that's returned in the response as a result of processing
    /// the event. Possible values are: 202, for events that were accepted; and,
    /// 400, for events that weren't valid.
    status_code: ?i32,

    pub const json_field_names = .{
        .message = "Message",
        .status_code = "StatusCode",
    };
};
