const TestGridSessionStatus = @import("test_grid_session_status.zig").TestGridSessionStatus;

/// A TestGridSession is a single instance of a browser launched from the URL
/// provided by a
/// call to CreateTestGridUrl.
pub const TestGridSession = struct {
    /// The ARN of the session.
    arn: ?[]const u8 = null,

    /// The number of billed minutes that were used for this session.
    billing_minutes: ?f64 = null,

    /// The time that the session was started.
    created: ?i64 = null,

    /// The time the session ended.
    ended: ?i64 = null,

    /// A JSON object of options and parameters passed to the Selenium WebDriver.
    selenium_properties: ?[]const u8 = null,

    /// The state of the session.
    status: ?TestGridSessionStatus = null,

    pub const json_field_names = .{
        .arn = "arn",
        .billing_minutes = "billingMinutes",
        .created = "created",
        .ended = "ended",
        .selenium_properties = "seleniumProperties",
        .status = "status",
    };
};
