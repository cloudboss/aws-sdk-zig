/// An action taken by a TestGridSession browser instance.
pub const TestGridSessionAction = struct {
    /// The action taken by the session.
    action: ?[]const u8,

    /// The time, in milliseconds, that the action took to complete in the browser.
    duration: ?i64,

    /// HTTP method that the browser used to make the request.
    request_method: ?[]const u8,

    /// The time that the session invoked the action.
    started: ?i64,

    /// HTTP status code returned to the browser when the action was taken.
    status_code: ?[]const u8,

    pub const json_field_names = .{
        .action = "action",
        .duration = "duration",
        .request_method = "requestMethod",
        .started = "started",
        .status_code = "statusCode",
    };
};
