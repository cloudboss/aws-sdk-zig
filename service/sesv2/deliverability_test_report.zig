const DeliverabilityTestStatus = @import("deliverability_test_status.zig").DeliverabilityTestStatus;

/// An object that contains metadata related to a predictive inbox placement
/// test.
pub const DeliverabilityTestReport = struct {
    /// The date and time when the predictive inbox placement test was created.
    create_date: ?i64,

    /// The status of the predictive inbox placement test. If the status is
    /// `IN_PROGRESS`, then the predictive inbox placement test
    /// is currently running. Predictive inbox placement tests are usually complete
    /// within 24 hours of creating the
    /// test. If the status is `COMPLETE`, then the test is finished, and you can
    /// use
    /// the `GetDeliverabilityTestReport` to view the results of the test.
    deliverability_test_status: ?DeliverabilityTestStatus,

    /// The sender address that you specified for the predictive inbox placement
    /// test.
    from_email_address: ?[]const u8,

    /// A unique string that identifies the predictive inbox placement test.
    report_id: ?[]const u8,

    /// A name that helps you identify a predictive inbox placement test report.
    report_name: ?[]const u8,

    /// The subject line for an email that you submitted in a predictive inbox
    /// placement test.
    subject: ?[]const u8,

    pub const json_field_names = .{
        .create_date = "CreateDate",
        .deliverability_test_status = "DeliverabilityTestStatus",
        .from_email_address = "FromEmailAddress",
        .report_id = "ReportId",
        .report_name = "ReportName",
        .subject = "Subject",
    };
};
