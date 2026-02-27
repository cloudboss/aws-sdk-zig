/// Provides a summary of the what-if analysis properties used in the
/// ListWhatIfAnalyses operation. To get the complete set of properties, call
/// the DescribeWhatIfAnalysis operation, and provide the `WhatIfAnalysisArn`
/// that is listed in the summary.
pub const WhatIfAnalysisSummary = struct {
    /// When the what-if analysis was created.
    creation_time: ?i64,

    /// The Amazon Resource Name (ARN) of the baseline forecast that is being used
    /// in this what-if analysis.
    forecast_arn: ?[]const u8,

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

    /// The status of the what-if analysis. States include:
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

    /// The Amazon Resource Name (ARN) of the what-if analysis.
    what_if_analysis_arn: ?[]const u8,

    /// The name of the what-if analysis.
    what_if_analysis_name: ?[]const u8,

    pub const json_field_names = .{
        .creation_time = "CreationTime",
        .forecast_arn = "ForecastArn",
        .last_modification_time = "LastModificationTime",
        .message = "Message",
        .status = "Status",
        .what_if_analysis_arn = "WhatIfAnalysisArn",
        .what_if_analysis_name = "WhatIfAnalysisName",
    };
};
