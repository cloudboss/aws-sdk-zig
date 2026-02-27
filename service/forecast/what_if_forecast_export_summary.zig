const DataDestination = @import("data_destination.zig").DataDestination;

/// Provides a summary of the what-if forecast export properties used in the
/// ListWhatIfForecastExports operation. To get the complete set of properties,
/// call the DescribeWhatIfForecastExport operation, and provide the
/// `WhatIfForecastExportArn` that is listed in the summary.
pub const WhatIfForecastExportSummary = struct {
    /// When the what-if forecast export was created.
    creation_time: ?i64,

    /// The path to the Amazon Simple Storage Service (Amazon S3) bucket where the
    /// forecast is exported.
    destination: ?DataDestination,

    /// The last time the resource was modified. The timestamp depends on the status
    /// of the job:
    ///
    /// * `CREATE_PENDING` - The `CreationTime`.
    ///
    /// * `CREATE_IN_PROGRESS` - The current timestamp.
    ///
    /// * `CREATE_STOPPING` - The current timestamp.
    ///
    /// * `CREATE_STOPPED` - When the job stopped.
    ///
    /// * `ACTIVE` or `CREATE_FAILED` - When the job finished or
    /// failed.
    last_modification_time: ?i64,

    /// If an error occurred, an informational message about the error.
    message: ?[]const u8,

    /// The status of the what-if forecast export. States include:
    ///
    /// * `ACTIVE`
    ///
    /// * `CREATE_PENDING`, `CREATE_IN_PROGRESS`,
    /// `CREATE_FAILED`
    ///
    /// * `CREATE_STOPPING`, `CREATE_STOPPED`
    ///
    /// * `DELETE_PENDING`, `DELETE_IN_PROGRESS`,
    /// `DELETE_FAILED`
    ///
    /// The `Status` of the what-if analysis must be `ACTIVE` before you can access
    /// the
    /// analysis.
    status: ?[]const u8,

    /// An array of Amazon Resource Names (ARNs) that define the what-if forecasts
    /// included in the export.
    what_if_forecast_arns: ?[]const []const u8,

    /// The Amazon Resource Name (ARN) of the what-if forecast export.
    what_if_forecast_export_arn: ?[]const u8,

    /// The what-if forecast export name.
    what_if_forecast_export_name: ?[]const u8,

    pub const json_field_names = .{
        .creation_time = "CreationTime",
        .destination = "Destination",
        .last_modification_time = "LastModificationTime",
        .message = "Message",
        .status = "Status",
        .what_if_forecast_arns = "WhatIfForecastArns",
        .what_if_forecast_export_arn = "WhatIfForecastExportArn",
        .what_if_forecast_export_name = "WhatIfForecastExportName",
    };
};
