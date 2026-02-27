const aws = @import("aws");

const Configuration = @import("configuration.zig").Configuration;
const AccessPreviewStatus = @import("access_preview_status.zig").AccessPreviewStatus;
const AccessPreviewStatusReason = @import("access_preview_status_reason.zig").AccessPreviewStatusReason;

/// Contains information about an access preview.
pub const AccessPreview = struct {
    /// The ARN of the analyzer used to generate the access preview.
    analyzer_arn: []const u8,

    /// A map of resource ARNs for the proposed resource configuration.
    configurations: []const aws.map.MapEntry(Configuration),

    /// The time at which the access preview was created.
    created_at: i64,

    /// The unique ID for the access preview.
    id: []const u8,

    /// The status of the access preview.
    ///
    /// * `Creating` - The access preview creation is in progress.
    /// * `Completed` - The access preview is complete. You can preview findings for
    ///   external access to the resource.
    /// * `Failed` - The access preview creation has failed.
    status: AccessPreviewStatus,

    /// Provides more details about the current status of the access preview.
    ///
    /// For example, if the creation of the access preview fails, a `Failed` status
    /// is returned. This failure can be due to an internal issue with the analysis
    /// or due to an invalid resource configuration.
    status_reason: ?AccessPreviewStatusReason,

    pub const json_field_names = .{
        .analyzer_arn = "analyzerArn",
        .configurations = "configurations",
        .created_at = "createdAt",
        .id = "id",
        .status = "status",
        .status_reason = "statusReason",
    };
};
