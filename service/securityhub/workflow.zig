const WorkflowStatus = @import("workflow_status.zig").WorkflowStatus;

/// Provides details about the status of the investigation into a finding.
pub const Workflow = struct {
    /// The status of the investigation into the finding. The workflow status is
    /// specific to an individual finding. It does not affect the generation of new
    /// findings. For example, setting the workflow status to `SUPPRESSED` or
    /// `RESOLVED` does not prevent a new finding for the same issue.
    ///
    /// The allowed values are the following.
    ///
    /// * `NEW` - The initial state of a finding, before it is reviewed.
    ///
    /// Security Hub also resets the workflow status from `NOTIFIED` or
    /// `RESOLVED` to `NEW` in the following cases:
    ///
    /// * `RecordState` changes from `ARCHIVED` to
    /// `ACTIVE`.
    ///
    /// * `ComplianceStatus` changes from `PASSED` to either
    /// `WARNING`, `FAILED`, or
    /// `NOT_AVAILABLE`.
    ///
    /// * `NOTIFIED` - Indicates that you notified the resource owner about the
    /// security issue. Used when the initial reviewer is not the resource owner,
    /// and needs
    /// intervention from the resource owner.
    ///
    /// * `SUPPRESSED` - Indicates that you reviewed the finding and don't believe
    ///   that any action is needed. The finding is no longer updated.
    ///
    /// * `RESOLVED` - The finding was reviewed and remediated and is now
    /// considered resolved.
    status: ?WorkflowStatus,

    pub const json_field_names = .{
        .status = "Status",
    };
};
