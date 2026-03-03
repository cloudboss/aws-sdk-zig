/// The status, start time, and end time of a backtest, as well as a failure
/// reason if
/// applicable.
pub const TestWindowSummary = struct {
    /// If the test failed, the reason why it failed.
    message: ?[]const u8 = null,

    /// The status of the test. Possible status values are:
    ///
    /// * `ACTIVE`
    ///
    /// * `CREATE_IN_PROGRESS`
    ///
    /// * `CREATE_FAILED`
    status: ?[]const u8 = null,

    /// The time at which the test ended.
    test_window_end: ?i64 = null,

    /// The time at which the test began.
    test_window_start: ?i64 = null,

    pub const json_field_names = .{
        .message = "Message",
        .status = "Status",
        .test_window_end = "TestWindowEnd",
        .test_window_start = "TestWindowStart",
    };
};
