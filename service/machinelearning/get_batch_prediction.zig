const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const EntityStatus = @import("entity_status.zig").EntityStatus;

pub const GetBatchPredictionInput = struct {
    /// An ID assigned to the `BatchPrediction` at creation.
    batch_prediction_id: []const u8,

    pub const json_field_names = .{
        .batch_prediction_id = "BatchPredictionId",
    };
};

pub const GetBatchPredictionOutput = struct {
    /// The ID of the `DataSource` that was used to create the `BatchPrediction`.
    batch_prediction_data_source_id: ?[]const u8 = null,

    /// An ID assigned to the `BatchPrediction` at creation. This value should be
    /// identical to the value of the `BatchPredictionID`
    /// in the request.
    batch_prediction_id: ?[]const u8 = null,

    /// The approximate CPU time in milliseconds that Amazon Machine Learning spent
    /// processing the `BatchPrediction`, normalized and scaled on computation
    /// resources. `ComputeTime` is only available if the `BatchPrediction` is in
    /// the `COMPLETED` state.
    compute_time: ?i64 = null,

    /// The time when the `BatchPrediction` was created. The time is expressed in
    /// epoch time.
    created_at: ?i64 = null,

    /// The AWS user account that invoked the `BatchPrediction`. The account type
    /// can be either an AWS root account or an AWS Identity and Access Management
    /// (IAM) user account.
    created_by_iam_user: ?[]const u8 = null,

    /// The epoch time when Amazon Machine Learning marked the `BatchPrediction` as
    /// `COMPLETED` or `FAILED`. `FinishedAt` is only available when the
    /// `BatchPrediction` is in the `COMPLETED` or `FAILED` state.
    finished_at: ?i64 = null,

    /// The location of the data file or directory in Amazon Simple Storage Service
    /// (Amazon S3).
    input_data_location_s3: ?[]const u8 = null,

    /// The number of invalid records that Amazon Machine Learning saw while
    /// processing the `BatchPrediction`.
    invalid_record_count: ?i64 = null,

    /// The time of the most recent edit to `BatchPrediction`. The time is expressed
    /// in epoch time.
    last_updated_at: ?i64 = null,

    /// A link to the file that contains logs of the `CreateBatchPrediction`
    /// operation.
    log_uri: ?[]const u8 = null,

    /// A description of the most recent details about processing the batch
    /// prediction request.
    message: ?[]const u8 = null,

    /// The ID of the `MLModel` that generated predictions for the `BatchPrediction`
    /// request.
    ml_model_id: ?[]const u8 = null,

    /// A user-supplied name or description of the `BatchPrediction`.
    name: ?[]const u8 = null,

    /// The location of an Amazon S3 bucket or directory to receive the operation
    /// results.
    output_uri: ?[]const u8 = null,

    /// The epoch time when Amazon Machine Learning marked the `BatchPrediction` as
    /// `INPROGRESS`. `StartedAt` isn't available if the `BatchPrediction` is in the
    /// `PENDING` state.
    started_at: ?i64 = null,

    /// The status of the `BatchPrediction`, which can be one of the following
    /// values:
    ///
    /// * `PENDING` - Amazon Machine Learning (Amazon ML) submitted a request to
    ///   generate batch predictions.
    ///
    /// * `INPROGRESS` - The batch predictions are in progress.
    ///
    /// * `FAILED` - The request to perform a batch prediction did not run to
    ///   completion. It is not usable.
    ///
    /// * `COMPLETED` - The batch prediction process completed successfully.
    ///
    /// * `DELETED` - The `BatchPrediction` is marked as deleted. It is not usable.
    status: ?EntityStatus = null,

    /// The number of total records that Amazon Machine Learning saw while
    /// processing the `BatchPrediction`.
    total_record_count: ?i64 = null,

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
        .log_uri = "LogUri",
        .message = "Message",
        .ml_model_id = "MLModelId",
        .name = "Name",
        .output_uri = "OutputUri",
        .started_at = "StartedAt",
        .status = "Status",
        .total_record_count = "TotalRecordCount",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetBatchPredictionInput, options: CallOptions) !GetBatchPredictionOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetBatchPredictionInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AmazonML_20141212.GetBatchPrediction");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetBatchPredictionOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetBatchPredictionOutput, body, allocator);
}
