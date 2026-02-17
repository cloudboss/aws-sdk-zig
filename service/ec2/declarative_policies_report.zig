const ReportState = @import("report_state.zig").ReportState;
const Tag = @import("tag.zig").Tag;

/// Describes the metadata of the account status report.
pub const DeclarativePoliciesReport = struct {
    /// The time when the report generation ended.
    end_time: ?i64,

    /// The ID of the report.
    report_id: ?[]const u8,

    /// The name of the Amazon S3 bucket where the report is located.
    s3_bucket: ?[]const u8,

    /// The prefix for your S3 object.
    s3_prefix: ?[]const u8,

    /// The time when the report generation started.
    start_time: ?i64,

    /// The current status of the report.
    status: ?ReportState,

    /// Any tags assigned to the report.
    tags: ?[]const Tag,

    /// The root ID, organizational unit ID, or account ID.
    ///
    /// Format:
    ///
    /// * For root: `r-ab12`
    ///
    /// * For OU: `ou-ab12-cdef1234`
    ///
    /// * For account: `123456789012`
    target_id: ?[]const u8,
};
