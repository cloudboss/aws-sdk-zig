/// The source of the data the monitor used during the evaluation.
pub const MonitorDataSource = struct {
    /// The Amazon Resource Name (ARN) of the dataset import job used to import the
    /// data that initiated the monitor evaluation.
    dataset_import_job_arn: ?[]const u8,

    /// The Amazon Resource Name (ARN) of the forecast the monitor used during the
    /// evaluation.
    forecast_arn: ?[]const u8,

    /// The Amazon Resource Name (ARN) of the predictor resource you are monitoring.
    predictor_arn: ?[]const u8,

    pub const json_field_names = .{
        .dataset_import_job_arn = "DatasetImportJobArn",
        .forecast_arn = "ForecastArn",
        .predictor_arn = "PredictorArn",
    };
};
