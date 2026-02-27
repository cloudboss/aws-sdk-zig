const DashboardError = @import("dashboard_error.zig").DashboardError;
const Sheet = @import("sheet.zig").Sheet;
const ResourceStatus = @import("resource_status.zig").ResourceStatus;

/// Dashboard version.
pub const DashboardVersion = struct {
    /// The Amazon Resource Name (ARN) of the resource.
    arn: ?[]const u8,

    /// The time that this dashboard version was created.
    created_time: ?i64,

    /// The Amazon Resource Numbers (ARNs) for the datasets that are associated with
    /// this
    /// version of the dashboard.
    data_set_arns: ?[]const []const u8,

    /// Description.
    description: ?[]const u8,

    /// Errors associated with this dashboard version.
    errors: ?[]const DashboardError,

    /// A list of the associated sheets with the unique identifier and name of each
    /// sheet.
    sheets: ?[]const Sheet,

    /// Source entity ARN.
    source_entity_arn: ?[]const u8,

    /// The HTTP status of the request.
    status: ?ResourceStatus,

    /// The ARN of the theme associated with a version of the dashboard.
    theme_arn: ?[]const u8,

    /// Version number for this version of the dashboard.
    version_number: ?i64,

    pub const json_field_names = .{
        .arn = "Arn",
        .created_time = "CreatedTime",
        .data_set_arns = "DataSetArns",
        .description = "Description",
        .errors = "Errors",
        .sheets = "Sheets",
        .source_entity_arn = "SourceEntityArn",
        .status = "Status",
        .theme_arn = "ThemeArn",
        .version_number = "VersionNumber",
    };
};
