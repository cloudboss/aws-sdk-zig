const DetectorVersionStatus = @import("detector_version_status.zig").DetectorVersionStatus;

/// The summary of the detector version.
pub const DetectorVersionSummary = struct {
    /// The detector version description.
    description: ?[]const u8 = null,

    /// The detector version ID.
    detector_version_id: ?[]const u8 = null,

    /// Timestamp of when the detector version was last updated.
    last_updated_time: ?[]const u8 = null,

    /// The detector version status.
    status: ?DetectorVersionStatus = null,

    pub const json_field_names = .{
        .description = "description",
        .detector_version_id = "detectorVersionId",
        .last_updated_time = "lastUpdatedTime",
        .status = "status",
    };
};
