const SummaryStatus = @import("summary_status.zig").SummaryStatus;

/// Provides a summary of the application-level health status for an instance.
pub const ApplicationStatusSummary = struct {
    /// The date and time when the application status became impaired.
    impaired_since: ?i64 = null,

    /// The current status.
    status: ?SummaryStatus = null,
};
