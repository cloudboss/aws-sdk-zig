const ResourceStatus = @import("resource_status.zig").ResourceStatus;

/// The summary metadata that describes an analysis.
pub const AnalysisSummary = struct {
    /// The ID of the analysis. This ID displays in the URL.
    analysis_id: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) for the analysis.
    arn: ?[]const u8 = null,

    /// The time that the analysis was created.
    created_time: ?i64 = null,

    /// The time that the analysis was last updated.
    last_updated_time: ?i64 = null,

    /// The name of the analysis. This name is displayed in the Quick Sight console.
    name: ?[]const u8 = null,

    /// The last known status for the analysis.
    status: ?ResourceStatus = null,

    pub const json_field_names = .{
        .analysis_id = "AnalysisId",
        .arn = "Arn",
        .created_time = "CreatedTime",
        .last_updated_time = "LastUpdatedTime",
        .name = "Name",
        .status = "Status",
    };
};
