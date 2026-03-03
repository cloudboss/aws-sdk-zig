const ReferencePredictorSummary = @import("reference_predictor_summary.zig").ReferencePredictorSummary;

/// Provides a summary of the predictor properties that are used in the
/// ListPredictors operation. To get the complete set of properties, call the
/// DescribePredictor operation, and provide the listed
/// `PredictorArn`.
pub const PredictorSummary = struct {
    /// When the model training task was created.
    creation_time: ?i64 = null,

    /// The Amazon Resource Name (ARN) of the dataset group that contains the data
    /// used to train
    /// the predictor.
    dataset_group_arn: ?[]const u8 = null,

    /// Whether AutoPredictor was used to create the predictor.
    is_auto_predictor: ?bool = null,

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

    /// If an error occurred, an informational message about the error.
    message: ?[]const u8 = null,

    /// The ARN of the predictor.
    predictor_arn: ?[]const u8 = null,

    /// The name of the predictor.
    predictor_name: ?[]const u8 = null,

    /// A summary of the reference predictor used if the predictor was retrained or
    /// upgraded.
    reference_predictor_summary: ?ReferencePredictorSummary = null,

    /// The status of the predictor. States include:
    ///
    /// * `ACTIVE`
    ///
    /// * `CREATE_PENDING`, `CREATE_IN_PROGRESS`,
    /// `CREATE_FAILED`
    ///
    /// * `DELETE_PENDING`, `DELETE_IN_PROGRESS`,
    /// `DELETE_FAILED`
    ///
    /// * `CREATE_STOPPING`, `CREATE_STOPPED`
    ///
    /// The `Status` of the predictor must be `ACTIVE` before you can use
    /// the predictor to create a forecast.
    status: ?[]const u8 = null,

    pub const json_field_names = .{
        .creation_time = "CreationTime",
        .dataset_group_arn = "DatasetGroupArn",
        .is_auto_predictor = "IsAutoPredictor",
        .last_modification_time = "LastModificationTime",
        .message = "Message",
        .predictor_arn = "PredictorArn",
        .predictor_name = "PredictorName",
        .reference_predictor_summary = "ReferencePredictorSummary",
        .status = "Status",
    };
};
