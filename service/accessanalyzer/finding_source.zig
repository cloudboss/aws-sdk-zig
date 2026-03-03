const FindingSourceDetail = @import("finding_source_detail.zig").FindingSourceDetail;
const FindingSourceType = @import("finding_source_type.zig").FindingSourceType;

/// The source of the finding. This indicates how the access that generated the
/// finding is granted. It is populated for Amazon S3 bucket findings.
pub const FindingSource = struct {
    /// Includes details about how the access that generated the finding is granted.
    /// This is populated for Amazon S3 bucket findings.
    detail: ?FindingSourceDetail = null,

    /// Indicates the type of access that generated the finding.
    @"type": FindingSourceType,

    pub const json_field_names = .{
        .detail = "detail",
        .@"type" = "type",
    };
};
