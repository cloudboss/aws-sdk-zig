const RemediationGuidance = @import("remediation_guidance.zig").RemediationGuidance;
const RemediationOutcome = @import("remediation_outcome.zig").RemediationOutcome;
const RemediationPriority = @import("remediation_priority.zig").RemediationPriority;
const RemediationSummaryDetail = @import("remediation_summary_detail.zig").RemediationSummaryDetail;
const RemediationResource = @import("remediation_resource.zig").RemediationResource;
const RemediationStatus = @import("remediation_status.zig").RemediationStatus;
const RemediationTrait = @import("remediation_trait.zig").RemediationTrait;

/// A remediation target.
pub const RemediationV2Item = struct {
    /// The remediation target's guidance. Returned only when `ShowGuidance` is
    /// `true` in the request.
    guidance: ?RemediationGuidance = null,

    /// The outcome of the remediation target's resolution.
    outcome: RemediationOutcome,

    /// The remediation target's priority. Valid values are `Critical`, `High`,
    /// `Medium`, and `Low`.
    priority: RemediationPriority,

    /// A summary of the remediation target.
    remediation_summary: RemediationSummaryDetail,

    /// The remediation target's associated resource.
    resource: RemediationResource,

    /// The current status of the remediation target.
    ///
    /// * `New` specifies that the remediation target was newly identified.
    ///
    /// * `Updated` specifies that the remediation target changed after it was
    ///   identified.
    ///
    /// * `Resolved` specifies that the remediation target is no longer present.
    status: RemediationStatus,

    /// The unique identifier (ID) of the remediation target.
    target_uid: []const u8,

    /// The trait associated with the remediation target.
    trait: RemediationTrait,

    /// The remediation target's last updated timestamp.
    ///
    /// For more information about the validation and formatting of timestamp fields
    /// in Security Hub CSPM, see
    /// [Timestamps](https://docs.aws.amazon.com/securityhub/1.0/APIReference/Welcome.html#timestamps).
    updated_at: ?i64 = null,

    pub const json_field_names = .{
        .guidance = "Guidance",
        .outcome = "Outcome",
        .priority = "Priority",
        .remediation_summary = "RemediationSummary",
        .resource = "Resource",
        .status = "Status",
        .target_uid = "TargetUid",
        .trait = "Trait",
        .updated_at = "UpdatedAt",
    };
};
