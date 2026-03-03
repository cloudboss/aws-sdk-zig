const AccessPreviewStatus = @import("access_preview_status.zig").AccessPreviewStatus;
const AccessPreviewStatusReason = @import("access_preview_status_reason.zig").AccessPreviewStatusReason;

/// Contains a summary of information about an access preview.
pub const AccessPreviewSummary = struct {
    /// The ARN of the analyzer used to generate the access preview.
    analyzer_arn: []const u8,

    /// The time at which the access preview was created.
    created_at: i64,

    /// The unique ID for the access preview.
    id: []const u8,

    /// The status of the access preview.
    ///
    /// * `Creating` - The access preview creation is in progress.
    /// * `Completed` - The access preview is complete and previews the findings for
    ///   external access to the resource.
    /// * `Failed` - The access preview creation has failed.
    status: AccessPreviewStatus,

    status_reason: ?AccessPreviewStatusReason = null,

    pub const json_field_names = .{
        .analyzer_arn = "analyzerArn",
        .created_at = "createdAt",
        .id = "id",
        .status = "status",
        .status_reason = "statusReason",
    };
};
