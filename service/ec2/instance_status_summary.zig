const InstanceStatusDetails = @import("instance_status_details.zig").InstanceStatusDetails;
const SummaryStatus = @import("summary_status.zig").SummaryStatus;

/// Describes the status of an instance.
pub const InstanceStatusSummary = struct {
    /// The system instance health or application instance health.
    details: ?[]const InstanceStatusDetails = null,

    /// The status.
    status: ?SummaryStatus = null,
};
