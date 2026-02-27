/// The status of a predictive inbox placement test. If the status is
/// `IN_PROGRESS`, then the predictive inbox placement test is
/// currently running. Predictive inbox placement tests are usually complete
/// within 24 hours of creating the test.
/// If the status is `COMPLETE`, then the test is finished, and you can use the
/// `GetDeliverabilityTestReport` operation to view the results of the
/// test.
pub const DeliverabilityTestStatus = enum {
    in_progress,
    completed,

    pub const json_field_names = .{
        .in_progress = "IN_PROGRESS",
        .completed = "COMPLETED",
    };
};
