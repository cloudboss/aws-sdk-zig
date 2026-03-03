const EbsStatusDetails = @import("ebs_status_details.zig").EbsStatusDetails;
const SummaryStatus = @import("summary_status.zig").SummaryStatus;

/// Provides a summary of the attached EBS volume status for an instance.
pub const EbsStatusSummary = struct {
    /// Details about the attached EBS status check for an instance.
    details: ?[]const EbsStatusDetails = null,

    /// The current status.
    status: ?SummaryStatus = null,
};
