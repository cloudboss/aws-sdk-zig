/// Gathers information about when a particular result was clicked by a user.
/// Your
/// application uses the `SubmitFeedback` API to provide click
/// information.
pub const ClickFeedback = struct {
    /// The Unix timestamp when the result was clicked.
    click_time: i64,

    /// The identifier of the search result that was clicked.
    result_id: []const u8,

    pub const json_field_names = .{
        .click_time = "ClickTime",
        .result_id = "ResultId",
    };
};
