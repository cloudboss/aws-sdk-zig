const DataDestination = @import("data_destination.zig").DataDestination;

/// Provides a summary of the predictor backtest export job properties used in
/// the ListPredictorBacktestExportJobs operation. To get a complete set of
/// properties, call the DescribePredictorBacktestExportJob operation, and
/// provide the listed `PredictorBacktestExportJobArn`.
pub const PredictorBacktestExportJobSummary = struct {
    /// When the predictor backtest export job was created.
    creation_time: ?i64 = null,

    destination: ?DataDestination = null,

    /// The last time the resource was modified. The timestamp depends on the status
    /// of the
    /// job:
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
    last_modification_time: ?i64 = null,

    /// Information about any errors that may have occurred during the backtest
    /// export.
    message: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the predictor backtest export job.
    predictor_backtest_export_job_arn: ?[]const u8 = null,

    /// The name of the predictor backtest export job.
    predictor_backtest_export_job_name: ?[]const u8 = null,

    /// The status of the predictor backtest export job. States include:
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
    status: ?[]const u8 = null,

    pub const json_field_names = .{
        .creation_time = "CreationTime",
        .destination = "Destination",
        .last_modification_time = "LastModificationTime",
        .message = "Message",
        .predictor_backtest_export_job_arn = "PredictorBacktestExportJobArn",
        .predictor_backtest_export_job_name = "PredictorBacktestExportJobName",
        .status = "Status",
    };
};
