const AnalysisError = @import("analysis_error.zig").AnalysisError;
const Sheet = @import("sheet.zig").Sheet;
const ResourceStatus = @import("resource_status.zig").ResourceStatus;

/// Metadata structure for an analysis in Quick Sight
pub const Analysis = struct {
    /// The ID of the analysis.
    analysis_id: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the analysis.
    arn: ?[]const u8 = null,

    /// The time that the analysis was created.
    created_time: ?i64 = null,

    /// The ARNs of the datasets of the analysis.
    data_set_arns: ?[]const []const u8 = null,

    /// Errors associated with the analysis.
    errors: ?[]const AnalysisError = null,

    /// The time that the analysis was last updated.
    last_updated_time: ?i64 = null,

    /// The descriptive name of the analysis.
    name: ?[]const u8 = null,

    /// A list of the associated sheets with the unique identifier and name of each
    /// sheet.
    sheets: ?[]const Sheet = null,

    /// Status associated with the analysis.
    status: ?ResourceStatus = null,

    /// The ARN of the theme of the analysis.
    theme_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .analysis_id = "AnalysisId",
        .arn = "Arn",
        .created_time = "CreatedTime",
        .data_set_arns = "DataSetArns",
        .errors = "Errors",
        .last_updated_time = "LastUpdatedTime",
        .name = "Name",
        .sheets = "Sheets",
        .status = "Status",
        .theme_arn = "ThemeArn",
    };
};
