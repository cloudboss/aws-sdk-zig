const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const PerformanceMetrics = @import("performance_metrics.zig").PerformanceMetrics;
const EntityStatus = @import("entity_status.zig").EntityStatus;

pub const GetEvaluationInput = struct {
    /// The ID of the `Evaluation` to retrieve. The evaluation of each `MLModel` is
    /// recorded and cataloged. The ID provides the means to access the information.
    evaluation_id: []const u8,

    pub const json_field_names = .{
        .evaluation_id = "EvaluationId",
    };
};

pub const GetEvaluationOutput = struct {
    /// The approximate CPU time in milliseconds that Amazon Machine Learning spent
    /// processing the `Evaluation`, normalized and scaled on computation resources.
    /// `ComputeTime` is only available if the `Evaluation` is in the `COMPLETED`
    /// state.
    compute_time: ?i64 = null,

    /// The time that the `Evaluation` was created. The time is expressed in epoch
    /// time.
    created_at: ?i64 = null,

    /// The AWS user account that invoked the evaluation. The account type can be
    /// either an AWS root account or an AWS Identity and Access Management (IAM)
    /// user account.
    created_by_iam_user: ?[]const u8 = null,

    /// The `DataSource` used for this evaluation.
    evaluation_data_source_id: ?[]const u8 = null,

    /// The evaluation ID which is same as the `EvaluationId` in the request.
    evaluation_id: ?[]const u8 = null,

    /// The epoch time when Amazon Machine Learning marked the `Evaluation` as
    /// `COMPLETED` or `FAILED`. `FinishedAt` is only available when the
    /// `Evaluation` is in the `COMPLETED` or `FAILED` state.
    finished_at: ?i64 = null,

    /// The location of the data file or directory in Amazon Simple Storage Service
    /// (Amazon S3).
    input_data_location_s3: ?[]const u8 = null,

    /// The time of the most recent edit to the `Evaluation`. The time is expressed
    /// in epoch time.
    last_updated_at: ?i64 = null,

    /// A link to the file that contains logs of the `CreateEvaluation` operation.
    log_uri: ?[]const u8 = null,

    /// A description of the most recent details about evaluating the `MLModel`.
    message: ?[]const u8 = null,

    /// The ID of the `MLModel` that was the focus of the evaluation.
    ml_model_id: ?[]const u8 = null,

    /// A user-supplied name or description of the `Evaluation`.
    name: ?[]const u8 = null,

    /// Measurements of how well the `MLModel` performed using observations
    /// referenced by the `DataSource`. One of the following metric is returned
    /// based on the type of the `MLModel`:
    ///
    /// * BinaryAUC: A binary `MLModel` uses the Area Under the Curve (AUC)
    ///   technique to measure performance.
    ///
    /// * RegressionRMSE: A regression `MLModel` uses the Root Mean Square Error
    ///   (RMSE) technique to measure performance. RMSE measures the difference
    ///   between predicted and actual values for a single variable.
    ///
    /// * MulticlassAvgFScore: A multiclass `MLModel` uses the F1 score technique to
    ///   measure performance.
    ///
    /// For more information about performance metrics, please see the [Amazon
    /// Machine Learning Developer
    /// Guide](https://docs.aws.amazon.com/machine-learning/latest/dg).
    performance_metrics: ?PerformanceMetrics = null,

    /// The epoch time when Amazon Machine Learning marked the `Evaluation` as
    /// `INPROGRESS`. `StartedAt` isn't available if the `Evaluation` is in the
    /// `PENDING` state.
    started_at: ?i64 = null,

    /// The status of the evaluation. This element can have one of the following
    /// values:
    ///
    /// * `PENDING` - Amazon Machine Language (Amazon ML) submitted a request to
    ///   evaluate an `MLModel`.
    ///
    /// * `INPROGRESS` - The evaluation is underway.
    ///
    /// * `FAILED` - The request to evaluate an `MLModel` did not run to completion.
    ///   It is not usable.
    ///
    /// * `COMPLETED` - The evaluation process completed successfully.
    ///
    /// * `DELETED` - The `Evaluation` is marked as deleted. It is not usable.
    status: ?EntityStatus = null,

    pub const json_field_names = .{
        .compute_time = "ComputeTime",
        .created_at = "CreatedAt",
        .created_by_iam_user = "CreatedByIamUser",
        .evaluation_data_source_id = "EvaluationDataSourceId",
        .evaluation_id = "EvaluationId",
        .finished_at = "FinishedAt",
        .input_data_location_s3 = "InputDataLocationS3",
        .last_updated_at = "LastUpdatedAt",
        .log_uri = "LogUri",
        .message = "Message",
        .ml_model_id = "MLModelId",
        .name = "Name",
        .performance_metrics = "PerformanceMetrics",
        .started_at = "StartedAt",
        .status = "Status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetEvaluationInput, options: CallOptions) !GetEvaluationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "machinelearning", client.config.http_client.clock_skew_offset);

    var response = try client.config.http_client.sendRequestWithOptions(&request, client.options);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = try parseErrorResponse(client.allocator, response.body, response.status);
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: GetEvaluationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("machinelearning", "Machine Learning", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AmazonML_20141212.GetEvaluation");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetEvaluationOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetEvaluationOutput, body, allocator);
}
