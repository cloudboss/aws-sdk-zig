/// Provides a summary of the what-if forecast properties used in the
/// ListWhatIfForecasts operation. To get the complete set of properties, call
/// the DescribeWhatIfForecast operation, and provide the `WhatIfForecastArn`
/// that is listed in the summary.
pub const WhatIfForecastSummary = struct {
    /// When the what-if forecast was created.
    creation_time: ?i64,

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

    /// The status of the what-if forecast. States include:
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

    /// The Amazon Resource Name (ARN) of the what-if analysis that contains this
    /// what-if forecast.
    what_if_analysis_arn: ?[]const u8,

    /// The Amazon Resource Name (ARN) of the what-if forecast.
    what_if_forecast_arn: ?[]const u8,

    /// The name of the what-if forecast.
    what_if_forecast_name: ?[]const u8,

    pub const json_field_names = .{
        .creation_time = "CreationTime",
        .last_modification_time = "LastModificationTime",
        .message = "Message",
        .status = "Status",
        .what_if_analysis_arn = "WhatIfAnalysisArn",
        .what_if_forecast_arn = "WhatIfForecastArn",
        .what_if_forecast_name = "WhatIfForecastName",
    };
};
