/// An aggregate of step execution statuses displayed in the Amazon Web Services
/// Systems Manager console for a
/// multi-Region and multi-account Automation execution.
pub const ProgressCounters = struct {
    /// The total number of steps that the system cancelled in all specified Amazon
    /// Web Services Regions and
    /// Amazon Web Services accounts for the current Automation execution.
    cancelled_steps: i32 = 0,

    /// The total number of steps that failed to run in all specified Amazon Web
    /// Services Regions and
    /// Amazon Web Services accounts for the current Automation execution.
    failed_steps: i32 = 0,

    /// The total number of steps that successfully completed in all specified
    /// Amazon Web Services Regions and
    /// Amazon Web Services accounts for the current Automation execution.
    success_steps: i32 = 0,

    /// The total number of steps that timed out in all specified Amazon Web
    /// Services Regions and Amazon Web Services accounts
    /// for the current Automation execution.
    timed_out_steps: i32 = 0,

    /// The total number of steps run in all specified Amazon Web Services Regions
    /// and Amazon Web Services accounts for the
    /// current Automation execution.
    total_steps: i32 = 0,

    pub const json_field_names = .{
        .cancelled_steps = "CancelledSteps",
        .failed_steps = "FailedSteps",
        .success_steps = "SuccessSteps",
        .timed_out_steps = "TimedOutSteps",
        .total_steps = "TotalSteps",
    };
};
