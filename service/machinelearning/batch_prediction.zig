const EntityStatus = @import("entity_status.zig").EntityStatus;

/// Represents the output of a `GetBatchPrediction` operation.
///
/// The content consists of the detailed metadata, the status, and the data file
/// information of a
/// `Batch Prediction`.
pub const BatchPrediction = struct {
    /// The ID of the `DataSource` that points to the group of observations to
    /// predict.
    batch_prediction_data_source_id: ?[]const u8,

    /// The ID assigned to the `BatchPrediction` at creation. This value should be
    /// identical to the value of the `BatchPredictionID`
    /// in the request.
    batch_prediction_id: ?[]const u8,

    compute_time: ?i64,

    /// The time that the `BatchPrediction` was created. The time is expressed in
    /// epoch time.
    created_at: ?i64,

    /// The AWS user account that invoked the `BatchPrediction`. The account type
    /// can be either an AWS root account or an AWS Identity and Access Management
    /// (IAM) user account.
    created_by_iam_user: ?[]const u8,

    finished_at: ?i64,

    /// The location of the data file or directory in Amazon Simple Storage Service
    /// (Amazon S3).
    input_data_location_s3: ?[]const u8,

    invalid_record_count: ?i64,

    /// The time of the most recent edit to the `BatchPrediction`. The time is
    /// expressed in epoch time.
    last_updated_at: ?i64,

    /// A description of the most recent details about processing the batch
    /// prediction request.
    message: ?[]const u8,

    /// The ID of the `MLModel` that generated predictions for the `BatchPrediction`
    /// request.
    ml_model_id: ?[]const u8,

    /// A user-supplied name or description of the `BatchPrediction`.
    name: ?[]const u8,

    /// The location of an Amazon S3 bucket or directory to receive the operation
    /// results. The following substrings are not allowed in the `s3 key` portion of
    /// the `outputURI` field: ':', '//', '/./', '/../'.
    output_uri: ?[]const u8,

    started_at: ?i64,

    /// The status of the `BatchPrediction`. This element can have one of the
    /// following values:
    ///
    /// * `PENDING` - Amazon Machine Learning (Amazon ML) submitted a request to
    ///   generate predictions for a batch of observations.
    ///
    /// * `INPROGRESS` - The process is underway.
    ///
    /// * `FAILED` - The request to perform a batch prediction did not run to
    ///   completion. It is not usable.
    ///
    /// * `COMPLETED` - The batch prediction process completed successfully.
    ///
    /// * `DELETED` - The `BatchPrediction` is marked as deleted. It is not usable.
    status: ?EntityStatus,

    total_record_count: ?i64,

    pub const json_field_names = .{
        .batch_prediction_data_source_id = "BatchPredictionDataSourceId",
        .batch_prediction_id = "BatchPredictionId",
        .compute_time = "ComputeTime",
        .created_at = "CreatedAt",
        .created_by_iam_user = "CreatedByIamUser",
        .finished_at = "FinishedAt",
        .input_data_location_s3 = "InputDataLocationS3",
        .invalid_record_count = "InvalidRecordCount",
        .last_updated_at = "LastUpdatedAt",
        .message = "Message",
        .ml_model_id = "MLModelId",
        .name = "Name",
        .output_uri = "OutputUri",
        .started_at = "StartedAt",
        .status = "Status",
        .total_record_count = "TotalRecordCount",
    };
};
