/// A suggested action that creates a calendar event on the recipient's device.
pub const RcsCreateCalendarEventAction = struct {
    /// An optional description for the calendar event. Maximum 500 characters.
    description: ?[]const u8 = null,

    /// The end time of the calendar event in ISO 8601 format.
    end_time: i64,

    /// The postback data sent to your webhook when the user taps this action.
    /// Maximum 2048 characters.
    postback_data: []const u8,

    /// The start time of the calendar event in ISO 8601 format.
    start_time: i64,

    /// The display text of the action. Maximum 25 characters.
    text: []const u8,

    /// The title of the calendar event. Maximum 100 characters.
    title: []const u8,

    pub const json_field_names = .{
        .description = "Description",
        .end_time = "EndTime",
        .postback_data = "PostbackData",
        .start_time = "StartTime",
        .text = "Text",
        .title = "Title",
    };
};
