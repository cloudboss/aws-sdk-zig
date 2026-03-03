const aws = @import("aws");
const std = @import("std");

const add_tags = @import("add_tags.zig");
const create_batch_prediction = @import("create_batch_prediction.zig");
const create_data_source_from_rds = @import("create_data_source_from_rds.zig");
const create_data_source_from_redshift = @import("create_data_source_from_redshift.zig");
const create_data_source_from_s3 = @import("create_data_source_from_s3.zig");
const create_evaluation = @import("create_evaluation.zig");
const create_ml_model = @import("create_ml_model.zig");
const create_realtime_endpoint = @import("create_realtime_endpoint.zig");
const delete_batch_prediction = @import("delete_batch_prediction.zig");
const delete_data_source = @import("delete_data_source.zig");
const delete_evaluation = @import("delete_evaluation.zig");
const delete_ml_model = @import("delete_ml_model.zig");
const delete_realtime_endpoint = @import("delete_realtime_endpoint.zig");
const delete_tags = @import("delete_tags.zig");
const describe_batch_predictions = @import("describe_batch_predictions.zig");
const describe_data_sources = @import("describe_data_sources.zig");
const describe_evaluations = @import("describe_evaluations.zig");
const describe_ml_models = @import("describe_ml_models.zig");
const describe_tags = @import("describe_tags.zig");
const get_batch_prediction = @import("get_batch_prediction.zig");
const get_data_source = @import("get_data_source.zig");
const get_evaluation = @import("get_evaluation.zig");
const get_ml_model = @import("get_ml_model.zig");
const predict_ = @import("predict.zig");
const update_batch_prediction = @import("update_batch_prediction.zig");
const update_data_source = @import("update_data_source.zig");
const update_evaluation = @import("update_evaluation.zig");
const update_ml_model = @import("update_ml_model.zig");
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "Machine Learning";

    pub fn init(allocator: std.mem.Allocator, config: *aws.Config) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.init(allocator, .{ .retry_mode = config.retry_mode }),
        };
    }

    pub fn initWithOptions(allocator: std.mem.Allocator, config: *aws.Config, options: aws.http.RequestOptions) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.init(allocator, .{ .retry_mode = config.retry_mode, .request_options = options }),
        };
    }

    pub fn deinit(self: *Self) void {
        self.http_client.deinit();
    }

    /// Adds one or more tags to an object, up to a limit of 10. Each tag consists
    /// of a key
    /// and an optional value. If you add a tag using a key that is already
    /// associated with the ML object,
    /// `AddTags` updates the tag's value.
    pub fn addTags(self: *Self, allocator: std.mem.Allocator, input: add_tags.AddTagsInput, options: add_tags.Options) !add_tags.AddTagsOutput {
        return add_tags.execute(self, allocator, input, options);
    }

    /// Generates predictions for a group of observations. The observations to
    /// process exist in one or more data files referenced
    /// by a `DataSource`. This operation creates a new `BatchPrediction`, and uses
    /// an `MLModel` and the data
    /// files referenced by the `DataSource` as information sources.
    ///
    /// `CreateBatchPrediction` is an asynchronous operation. In response to
    /// `CreateBatchPrediction`,
    /// Amazon Machine Learning (Amazon ML) immediately returns and sets the
    /// `BatchPrediction` status to `PENDING`.
    /// After the `BatchPrediction` completes, Amazon ML sets the status to
    /// `COMPLETED`.
    ///
    /// You can poll for status updates by using the GetBatchPrediction operation
    /// and checking the `Status` parameter of the result. After the `COMPLETED`
    /// status appears,
    /// the results are available in the location specified by the `OutputUri`
    /// parameter.
    pub fn createBatchPrediction(self: *Self, allocator: std.mem.Allocator, input: create_batch_prediction.CreateBatchPredictionInput, options: create_batch_prediction.Options) !create_batch_prediction.CreateBatchPredictionOutput {
        return create_batch_prediction.execute(self, allocator, input, options);
    }

    /// Creates a `DataSource` object from an [ Amazon Relational Database
    /// Service](http://aws.amazon.com/rds/) (Amazon RDS). A `DataSource` references
    /// data that can be used to perform `CreateMLModel`, `CreateEvaluation`, or
    /// `CreateBatchPrediction` operations.
    ///
    /// `CreateDataSourceFromRDS` is an asynchronous operation. In response to
    /// `CreateDataSourceFromRDS`,
    /// Amazon Machine Learning (Amazon ML) immediately returns and sets the
    /// `DataSource` status to `PENDING`.
    /// After the `DataSource` is created and ready for use, Amazon ML sets the
    /// `Status` parameter to `COMPLETED`.
    /// `DataSource` in the `COMPLETED` or `PENDING` state can
    /// be used only to perform `>CreateMLModel`>, `CreateEvaluation`, or
    /// `CreateBatchPrediction` operations.
    ///
    /// If Amazon ML cannot accept the input source, it sets the `Status` parameter
    /// to `FAILED` and includes an error message in the `Message` attribute of the
    /// `GetDataSource` operation response.
    pub fn createDataSourceFromRds(self: *Self, allocator: std.mem.Allocator, input: create_data_source_from_rds.CreateDataSourceFromRDSInput, options: create_data_source_from_rds.Options) !create_data_source_from_rds.CreateDataSourceFromRDSOutput {
        return create_data_source_from_rds.execute(self, allocator, input, options);
    }

    /// Creates a `DataSource` from a database hosted on an Amazon Redshift cluster.
    /// A
    /// `DataSource` references data that can be used to perform either
    /// `CreateMLModel`, `CreateEvaluation`, or `CreateBatchPrediction`
    /// operations.
    ///
    /// `CreateDataSourceFromRedshift` is an asynchronous operation. In response to
    /// `CreateDataSourceFromRedshift`, Amazon Machine Learning (Amazon ML)
    /// immediately returns and sets the `DataSource` status to `PENDING`.
    /// After the `DataSource` is created and ready for use, Amazon ML sets the
    /// `Status` parameter to `COMPLETED`.
    /// `DataSource` in `COMPLETED` or `PENDING` states can be
    /// used to perform only `CreateMLModel`, `CreateEvaluation`, or
    /// `CreateBatchPrediction` operations.
    ///
    /// If Amazon ML can't accept the input source, it sets the `Status` parameter
    /// to `FAILED` and includes an error message in the `Message`
    /// attribute of the `GetDataSource` operation response.
    ///
    /// The observations should be contained in the database hosted on an Amazon
    /// Redshift cluster
    /// and should be specified by a `SelectSqlQuery` query. Amazon ML executes an
    /// `Unload` command in Amazon Redshift to transfer the result set of
    /// the `SelectSqlQuery` query to `S3StagingLocation`.
    ///
    /// After the `DataSource` has been created, it's ready for use in evaluations
    /// and
    /// batch predictions. If you plan to use the `DataSource` to train an
    /// `MLModel`, the `DataSource` also requires a recipe. A recipe
    /// describes how each input variable will be used in training an `MLModel`.
    /// Will
    /// the variable be included or excluded from training? Will the variable be
    /// manipulated;
    /// for example, will it be combined with another variable or will it be split
    /// apart into
    /// word combinations? The recipe provides answers to these questions.
    ///
    /// You can't change an existing datasource, but you can copy and modify the
    /// settings from an
    /// existing Amazon Redshift datasource to create a new datasource. To do so,
    /// call
    /// `GetDataSource` for an existing datasource and copy the values to a
    /// `CreateDataSource` call. Change the settings that you want to change and
    /// make sure that all required fields have the appropriate values.
    pub fn createDataSourceFromRedshift(self: *Self, allocator: std.mem.Allocator, input: create_data_source_from_redshift.CreateDataSourceFromRedshiftInput, options: create_data_source_from_redshift.Options) !create_data_source_from_redshift.CreateDataSourceFromRedshiftOutput {
        return create_data_source_from_redshift.execute(self, allocator, input, options);
    }

    /// Creates a `DataSource` object. A `DataSource` references data that
    /// can be used to perform `CreateMLModel`, `CreateEvaluation`, or
    /// `CreateBatchPrediction` operations.
    ///
    /// `CreateDataSourceFromS3` is an asynchronous operation. In response to
    /// `CreateDataSourceFromS3`, Amazon Machine Learning (Amazon ML) immediately
    /// returns and sets the `DataSource` status to `PENDING`. After the
    /// `DataSource` has been created and is ready for use, Amazon ML sets the
    /// `Status` parameter to `COMPLETED`. `DataSource` in
    /// the `COMPLETED` or `PENDING` state can be used to perform only
    /// `CreateMLModel`, `CreateEvaluation` or
    /// `CreateBatchPrediction` operations.
    ///
    /// If Amazon ML can't accept the input source, it sets the `Status` parameter
    /// to
    /// `FAILED` and includes an error message in the `Message`
    /// attribute of the `GetDataSource` operation response.
    ///
    /// The observation data used in a `DataSource` should be ready to use; that is,
    /// it should have a consistent structure, and missing data values should be
    /// kept to a
    /// minimum. The observation data must reside in one or more .csv files in an
    /// Amazon Simple
    /// Storage Service (Amazon S3) location, along with a schema that describes the
    /// data items
    /// by name and type. The same schema must be used for all of the data files
    /// referenced by
    /// the `DataSource`.
    ///
    /// After the `DataSource` has been created, it's ready to use in evaluations
    /// and
    /// batch predictions. If you plan to use the `DataSource` to train an
    /// `MLModel`, the `DataSource` also needs a recipe. A recipe
    /// describes how each input variable will be used in training an `MLModel`.
    /// Will
    /// the variable be included or excluded from training? Will the variable be
    /// manipulated;
    /// for example, will it be combined with another variable or will it be split
    /// apart into
    /// word combinations? The recipe provides answers to these questions.
    pub fn createDataSourceFromS3(self: *Self, allocator: std.mem.Allocator, input: create_data_source_from_s3.CreateDataSourceFromS3Input, options: create_data_source_from_s3.Options) !create_data_source_from_s3.CreateDataSourceFromS3Output {
        return create_data_source_from_s3.execute(self, allocator, input, options);
    }

    /// Creates a new `Evaluation` of an `MLModel`. An `MLModel` is evaluated on a
    /// set of observations associated to a `DataSource`. Like a `DataSource`
    /// for an `MLModel`, the `DataSource` for an `Evaluation` contains values for
    /// the `Target Variable`. The `Evaluation` compares the predicted result for
    /// each observation to the actual outcome and provides a
    /// summary so that you know how effective the `MLModel` functions on the test
    /// data. Evaluation generates a relevant performance metric, such as BinaryAUC,
    /// RegressionRMSE or MulticlassAvgFScore based on the corresponding
    /// `MLModelType`: `BINARY`, `REGRESSION` or `MULTICLASS`.
    ///
    /// `CreateEvaluation` is an asynchronous operation. In response to
    /// `CreateEvaluation`, Amazon Machine Learning (Amazon ML) immediately
    /// returns and sets the evaluation status to `PENDING`. After the `Evaluation`
    /// is created and ready for use,
    /// Amazon ML sets the status to `COMPLETED`.
    ///
    /// You can use the `GetEvaluation` operation to check progress of the
    /// evaluation during the creation operation.
    pub fn createEvaluation(self: *Self, allocator: std.mem.Allocator, input: create_evaluation.CreateEvaluationInput, options: create_evaluation.Options) !create_evaluation.CreateEvaluationOutput {
        return create_evaluation.execute(self, allocator, input, options);
    }

    /// Creates a new `MLModel` using the `DataSource` and the recipe as
    /// information sources.
    ///
    /// An `MLModel` is nearly immutable. Users can update only the
    /// `MLModelName` and the `ScoreThreshold` in an
    /// `MLModel` without creating a new `MLModel`.
    ///
    /// `CreateMLModel` is an asynchronous operation. In response to
    /// `CreateMLModel`, Amazon Machine Learning (Amazon ML) immediately returns
    /// and sets the `MLModel` status to `PENDING`. After the
    /// `MLModel` has been created and ready is for use, Amazon ML sets the
    /// status to `COMPLETED`.
    ///
    /// You can use the `GetMLModel` operation to check the progress of the
    /// `MLModel` during the creation operation.
    ///
    /// `CreateMLModel` requires a `DataSource` with computed statistics,
    /// which can be created by setting `ComputeStatistics` to `true` in
    /// `CreateDataSourceFromRDS`, `CreateDataSourceFromS3`, or
    /// `CreateDataSourceFromRedshift` operations.
    pub fn createMlModel(self: *Self, allocator: std.mem.Allocator, input: create_ml_model.CreateMLModelInput, options: create_ml_model.Options) !create_ml_model.CreateMLModelOutput {
        return create_ml_model.execute(self, allocator, input, options);
    }

    /// Creates a real-time endpoint for the `MLModel`. The endpoint contains the
    /// URI of the `MLModel`; that is, the location to send real-time prediction
    /// requests for the specified `MLModel`.
    pub fn createRealtimeEndpoint(self: *Self, allocator: std.mem.Allocator, input: create_realtime_endpoint.CreateRealtimeEndpointInput, options: create_realtime_endpoint.Options) !create_realtime_endpoint.CreateRealtimeEndpointOutput {
        return create_realtime_endpoint.execute(self, allocator, input, options);
    }

    /// Assigns the DELETED status to a `BatchPrediction`, rendering it unusable.
    ///
    /// After using the `DeleteBatchPrediction` operation, you can use the
    /// GetBatchPrediction
    /// operation to verify that the status of the `BatchPrediction` changed to
    /// DELETED.
    ///
    /// **Caution:** The result of the `DeleteBatchPrediction` operation is
    /// irreversible.
    pub fn deleteBatchPrediction(self: *Self, allocator: std.mem.Allocator, input: delete_batch_prediction.DeleteBatchPredictionInput, options: delete_batch_prediction.Options) !delete_batch_prediction.DeleteBatchPredictionOutput {
        return delete_batch_prediction.execute(self, allocator, input, options);
    }

    /// Assigns the DELETED status to a `DataSource`, rendering it unusable.
    ///
    /// After using the `DeleteDataSource` operation, you can use the GetDataSource
    /// operation to verify that the status of the `DataSource` changed to DELETED.
    ///
    /// **Caution:** The results of the `DeleteDataSource` operation are
    /// irreversible.
    pub fn deleteDataSource(self: *Self, allocator: std.mem.Allocator, input: delete_data_source.DeleteDataSourceInput, options: delete_data_source.Options) !delete_data_source.DeleteDataSourceOutput {
        return delete_data_source.execute(self, allocator, input, options);
    }

    /// Assigns the `DELETED` status to an `Evaluation`, rendering it unusable.
    ///
    /// After invoking the `DeleteEvaluation` operation, you can use the
    /// `GetEvaluation` operation to verify that the status of the `Evaluation`
    /// changed to `DELETED`.
    ///
    /// **Caution:** The results of the `DeleteEvaluation` operation are
    /// irreversible.
    pub fn deleteEvaluation(self: *Self, allocator: std.mem.Allocator, input: delete_evaluation.DeleteEvaluationInput, options: delete_evaluation.Options) !delete_evaluation.DeleteEvaluationOutput {
        return delete_evaluation.execute(self, allocator, input, options);
    }

    /// Assigns the `DELETED` status to an `MLModel`, rendering it unusable.
    ///
    /// After using the `DeleteMLModel` operation, you can use the
    /// `GetMLModel` operation to verify that the status of the `MLModel` changed to
    /// DELETED.
    ///
    /// **Caution:** The result of the `DeleteMLModel` operation is irreversible.
    pub fn deleteMlModel(self: *Self, allocator: std.mem.Allocator, input: delete_ml_model.DeleteMLModelInput, options: delete_ml_model.Options) !delete_ml_model.DeleteMLModelOutput {
        return delete_ml_model.execute(self, allocator, input, options);
    }

    /// Deletes a real time endpoint of an `MLModel`.
    pub fn deleteRealtimeEndpoint(self: *Self, allocator: std.mem.Allocator, input: delete_realtime_endpoint.DeleteRealtimeEndpointInput, options: delete_realtime_endpoint.Options) !delete_realtime_endpoint.DeleteRealtimeEndpointOutput {
        return delete_realtime_endpoint.execute(self, allocator, input, options);
    }

    /// Deletes the specified tags associated with an ML object. After this
    /// operation is complete, you can't recover deleted tags.
    ///
    /// If you specify a tag that doesn't exist, Amazon ML ignores it.
    pub fn deleteTags(self: *Self, allocator: std.mem.Allocator, input: delete_tags.DeleteTagsInput, options: delete_tags.Options) !delete_tags.DeleteTagsOutput {
        return delete_tags.execute(self, allocator, input, options);
    }

    /// Returns a list of `BatchPrediction` operations that match the search
    /// criteria in the request.
    pub fn describeBatchPredictions(self: *Self, allocator: std.mem.Allocator, input: describe_batch_predictions.DescribeBatchPredictionsInput, options: describe_batch_predictions.Options) !describe_batch_predictions.DescribeBatchPredictionsOutput {
        return describe_batch_predictions.execute(self, allocator, input, options);
    }

    /// Returns a list of `DataSource` that match the search criteria in the
    /// request.
    pub fn describeDataSources(self: *Self, allocator: std.mem.Allocator, input: describe_data_sources.DescribeDataSourcesInput, options: describe_data_sources.Options) !describe_data_sources.DescribeDataSourcesOutput {
        return describe_data_sources.execute(self, allocator, input, options);
    }

    /// Returns a list of `DescribeEvaluations` that match the search criteria in
    /// the request.
    pub fn describeEvaluations(self: *Self, allocator: std.mem.Allocator, input: describe_evaluations.DescribeEvaluationsInput, options: describe_evaluations.Options) !describe_evaluations.DescribeEvaluationsOutput {
        return describe_evaluations.execute(self, allocator, input, options);
    }

    /// Returns a list of `MLModel` that match the search criteria in the request.
    pub fn describeMlModels(self: *Self, allocator: std.mem.Allocator, input: describe_ml_models.DescribeMLModelsInput, options: describe_ml_models.Options) !describe_ml_models.DescribeMLModelsOutput {
        return describe_ml_models.execute(self, allocator, input, options);
    }

    /// Describes one or more of the tags for your Amazon ML object.
    pub fn describeTags(self: *Self, allocator: std.mem.Allocator, input: describe_tags.DescribeTagsInput, options: describe_tags.Options) !describe_tags.DescribeTagsOutput {
        return describe_tags.execute(self, allocator, input, options);
    }

    /// Returns a `BatchPrediction` that includes detailed metadata, status, and
    /// data file information for a
    /// `Batch Prediction` request.
    pub fn getBatchPrediction(self: *Self, allocator: std.mem.Allocator, input: get_batch_prediction.GetBatchPredictionInput, options: get_batch_prediction.Options) !get_batch_prediction.GetBatchPredictionOutput {
        return get_batch_prediction.execute(self, allocator, input, options);
    }

    /// Returns a `DataSource` that includes metadata and data file information, as
    /// well as the current status of the `DataSource`.
    ///
    /// `GetDataSource` provides results in normal or verbose format. The verbose
    /// format
    /// adds the schema description and the list of files pointed to by the
    /// DataSource to the normal format.
    pub fn getDataSource(self: *Self, allocator: std.mem.Allocator, input: get_data_source.GetDataSourceInput, options: get_data_source.Options) !get_data_source.GetDataSourceOutput {
        return get_data_source.execute(self, allocator, input, options);
    }

    /// Returns an `Evaluation` that includes metadata as well as the current status
    /// of the `Evaluation`.
    pub fn getEvaluation(self: *Self, allocator: std.mem.Allocator, input: get_evaluation.GetEvaluationInput, options: get_evaluation.Options) !get_evaluation.GetEvaluationOutput {
        return get_evaluation.execute(self, allocator, input, options);
    }

    /// Returns an `MLModel` that includes detailed metadata, data source
    /// information, and the current status of the `MLModel`.
    ///
    /// `GetMLModel` provides results in normal or verbose format.
    pub fn getMlModel(self: *Self, allocator: std.mem.Allocator, input: get_ml_model.GetMLModelInput, options: get_ml_model.Options) !get_ml_model.GetMLModelOutput {
        return get_ml_model.execute(self, allocator, input, options);
    }

    /// Generates a prediction for the observation using the specified `ML Model`.
    ///
    /// **Note:** Not all response parameters will be populated. Whether a
    /// response parameter is populated depends on the type of model requested.
    pub fn predict(self: *Self, allocator: std.mem.Allocator, input: predict_.PredictInput, options: predict_.Options) !predict_.PredictOutput {
        return predict_.execute(self, allocator, input, options);
    }

    /// Updates the `BatchPredictionName` of a `BatchPrediction`.
    ///
    /// You can use the `GetBatchPrediction` operation to view the contents of the
    /// updated data element.
    pub fn updateBatchPrediction(self: *Self, allocator: std.mem.Allocator, input: update_batch_prediction.UpdateBatchPredictionInput, options: update_batch_prediction.Options) !update_batch_prediction.UpdateBatchPredictionOutput {
        return update_batch_prediction.execute(self, allocator, input, options);
    }

    /// Updates the `DataSourceName` of a `DataSource`.
    ///
    /// You can use the `GetDataSource` operation to view the contents of the
    /// updated data element.
    pub fn updateDataSource(self: *Self, allocator: std.mem.Allocator, input: update_data_source.UpdateDataSourceInput, options: update_data_source.Options) !update_data_source.UpdateDataSourceOutput {
        return update_data_source.execute(self, allocator, input, options);
    }

    /// Updates the `EvaluationName` of an `Evaluation`.
    ///
    /// You can use the `GetEvaluation` operation to view the contents of the
    /// updated data element.
    pub fn updateEvaluation(self: *Self, allocator: std.mem.Allocator, input: update_evaluation.UpdateEvaluationInput, options: update_evaluation.Options) !update_evaluation.UpdateEvaluationOutput {
        return update_evaluation.execute(self, allocator, input, options);
    }

    /// Updates the `MLModelName` and the `ScoreThreshold` of an `MLModel`.
    ///
    /// You can use the `GetMLModel` operation to view the contents of the updated
    /// data element.
    pub fn updateMlModel(self: *Self, allocator: std.mem.Allocator, input: update_ml_model.UpdateMLModelInput, options: update_ml_model.Options) !update_ml_model.UpdateMLModelOutput {
        return update_ml_model.execute(self, allocator, input, options);
    }

    pub fn describeBatchPredictionsPaginator(self: *Self, params: describe_batch_predictions.DescribeBatchPredictionsInput) paginator.DescribeBatchPredictionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeDataSourcesPaginator(self: *Self, params: describe_data_sources.DescribeDataSourcesInput) paginator.DescribeDataSourcesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeEvaluationsPaginator(self: *Self, params: describe_evaluations.DescribeEvaluationsInput) paginator.DescribeEvaluationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeMlModelsPaginator(self: *Self, params: describe_ml_models.DescribeMLModelsInput) paginator.DescribeMLModelsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};
