/// Provides a summary of the forecast properties used in the ListForecasts
/// operation. To get the complete set of properties, call the DescribeForecast
/// operation, and provide the `ForecastArn` that is listed in the summary.
pub const ForecastSummary = struct {
    /// Whether the Forecast was created from an AutoPredictor.
    created_using_auto_predictor: ?bool = null,

    /// When the forecast creation task was created.
    creation_time: ?i64 = null,

    /// The Amazon Resource Name (ARN) of the dataset group that provided the data
    /// used to train
    /// the predictor.
    dataset_group_arn: ?[]const u8 = null,

    /// The ARN of the forecast.
    forecast_arn: ?[]const u8 = null,

    /// The name of the forecast.
    forecast_name: ?[]const u8 = null,

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
    last_modification_time: ?i64 = null,

    /// If an error occurred, an informational message about the error.
    message: ?[]const u8 = null,

    /// The ARN of the predictor used to generate the forecast.
    predictor_arn: ?[]const u8 = null,

    /// The status of the forecast. States include:
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
    /// The `Status` of the forecast must be `ACTIVE` before you can query
    /// or export the forecast.
    status: ?[]const u8 = null,

    pub const json_field_names = .{
        .created_using_auto_predictor = "CreatedUsingAutoPredictor",
        .creation_time = "CreationTime",
        .dataset_group_arn = "DatasetGroupArn",
        .forecast_arn = "ForecastArn",
        .forecast_name = "ForecastName",
        .last_modification_time = "LastModificationTime",
        .message = "Message",
        .predictor_arn = "PredictorArn",
        .status = "Status",
    };
};
