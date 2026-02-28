const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const RealtimeEndpointInfo = @import("realtime_endpoint_info.zig").RealtimeEndpointInfo;
const MLModelType = @import("ml_model_type.zig").MLModelType;
const EntityStatus = @import("entity_status.zig").EntityStatus;

pub const GetMLModelInput = struct {
    /// The ID assigned to the `MLModel` at creation.
    ml_model_id: []const u8,

    /// Specifies whether the `GetMLModel` operation should return `Recipe`.
    ///
    /// If true, `Recipe` is returned.
    ///
    /// If false, `Recipe` is not returned.
    verbose: ?bool = null,

    pub const json_field_names = .{
        .ml_model_id = "MLModelId",
        .verbose = "Verbose",
    };
};

pub const GetMLModelOutput = struct {
    /// The approximate CPU time in milliseconds that Amazon Machine Learning spent
    /// processing the `MLModel`, normalized and scaled on computation resources.
    /// `ComputeTime` is only available if the `MLModel` is in the `COMPLETED`
    /// state.
    compute_time: ?i64 = null,

    /// The time that the `MLModel` was created. The time is expressed in epoch
    /// time.
    created_at: ?i64 = null,

    /// The AWS user account from which the `MLModel` was created. The account type
    /// can be either an AWS root account or an AWS Identity and Access Management
    /// (IAM) user account.
    created_by_iam_user: ?[]const u8 = null,

    /// The current endpoint of the `MLModel`
    endpoint_info: ?RealtimeEndpointInfo = null,

    /// The epoch time when Amazon Machine Learning marked the `MLModel` as
    /// `COMPLETED` or `FAILED`. `FinishedAt` is only available when the `MLModel`
    /// is in the `COMPLETED` or `FAILED` state.
    finished_at: ?i64 = null,

    /// The location of the data file or directory in Amazon Simple Storage Service
    /// (Amazon S3).
    input_data_location_s3: ?[]const u8 = null,

    /// The time of the most recent edit to the `MLModel`. The time is expressed in
    /// epoch time.
    last_updated_at: ?i64 = null,

    /// A link to the file that contains logs of the `CreateMLModel` operation.
    log_uri: ?[]const u8 = null,

    /// A description of the most recent details about accessing the `MLModel`.
    message: ?[]const u8 = null,

    /// The MLModel ID,
    /// which is same as the `MLModelId` in the request.
    ml_model_id: ?[]const u8 = null,

    /// Identifies the `MLModel` category. The following are the available types:
    ///
    /// * REGRESSION -- Produces a numeric result. For example, "What price should a
    ///   house be listed at?"
    ///
    /// * BINARY -- Produces one of two possible results. For example, "Is this an
    ///   e-commerce website?"
    ///
    /// * MULTICLASS -- Produces one of several possible results. For example, "Is
    ///   this a HIGH, LOW or MEDIUM risk trade?"
    ml_model_type: ?MLModelType = null,

    /// A user-supplied name or description of the `MLModel`.
    name: ?[]const u8 = null,

    /// The recipe to use when training the `MLModel`. The `Recipe`
    /// provides detailed information about the observation data to use during
    /// training, and
    /// manipulations to perform on the observation data during training.
    ///
    /// **Note:** This parameter is provided as part of the verbose format.
    recipe: ?[]const u8 = null,

    /// The schema used by all of the data files referenced by the `DataSource`.
    ///
    /// **Note:** This parameter is provided as part of the verbose format.
    schema: ?[]const u8 = null,

    /// The scoring threshold is used in binary classification `MLModel`
    /// models. It marks the boundary between a positive prediction and a
    /// negative prediction.
    ///
    /// Output values greater than or equal to the threshold receive a positive
    /// result from the MLModel, such as
    /// `true`. Output values less than the threshold receive a negative response
    /// from the MLModel,
    /// such as `false`.
    score_threshold: ?f32 = null,

    /// The time of the most recent edit to the `ScoreThreshold`. The time is
    /// expressed in epoch time.
    score_threshold_last_updated_at: ?i64 = null,

    size_in_bytes: ?i64 = null,

    /// The epoch time when Amazon Machine Learning marked the `MLModel` as
    /// `INPROGRESS`. `StartedAt` isn't available if the `MLModel` is in the
    /// `PENDING` state.
    started_at: ?i64 = null,

    /// The current status of the `MLModel`. This element can have one of the
    /// following values:
    ///
    /// * `PENDING` - Amazon Machine Learning (Amazon ML) submitted a request to
    ///   describe a `MLModel`.
    ///
    /// * `INPROGRESS` - The request is processing.
    ///
    /// * `FAILED` - The request did not run to completion. The ML model isn't
    /// usable.
    ///
    /// * `COMPLETED` - The request completed successfully.
    ///
    /// * `DELETED` - The `MLModel` is marked as deleted. It isn't
    /// usable.
    status: ?EntityStatus = null,

    /// The ID of the training `DataSource`.
    training_data_source_id: ?[]const u8 = null,

    /// A list of the training parameters in the `MLModel`. The list is implemented
    /// as
    /// a map of key-value pairs.
    ///
    /// The following is the current set of training parameters:
    ///
    /// * `sgd.maxMLModelSizeInBytes` - The maximum allowed size of the model.
    ///   Depending on the
    /// input data, the size of the model might affect its performance.
    ///
    /// The value is an integer that ranges from `100000` to `2147483648`. The
    /// default value is `33554432`.
    ///
    /// * `sgd.maxPasses` - The number of times that the training process traverses
    ///   the
    /// observations to build the `MLModel`. The value is an integer that
    /// ranges from `1` to `10000`. The default value is
    /// `10`.
    ///
    /// * `sgd.shuffleType` - Whether Amazon ML shuffles the training data.
    ///   Shuffling data improves a
    /// model's ability to find the optimal solution for a variety of data types.
    /// The
    /// valid values are `auto` and `none`. The default value is
    /// `none`. We strongly recommend that you shuffle your data.
    ///
    /// * `sgd.l1RegularizationAmount` - The coefficient regularization L1 norm. It
    ///   controls
    /// overfitting the data by penalizing large coefficients. This tends to drive
    /// coefficients to zero, resulting in a sparse feature set. If you use this
    /// parameter, start by specifying a small value, such as `1.0E-08`.
    ///
    /// The value is a double that ranges from `0` to `MAX_DOUBLE`.
    /// The default is to not use L1 normalization. This parameter can't be used
    /// when
    /// `L2` is specified. Use this parameter sparingly.
    ///
    /// * `sgd.l2RegularizationAmount` - The coefficient regularization L2 norm. It
    ///   controls
    /// overfitting the data by penalizing large coefficients. This tends to drive
    /// coefficients to small, nonzero values. If you use this parameter, start by
    /// specifying a small value, such as `1.0E-08`.
    ///
    /// The value is a double that ranges from `0` to `MAX_DOUBLE`.
    /// The default is to not use L2 normalization. This parameter can't be used
    /// when
    /// `L1` is specified. Use this parameter sparingly.
    training_parameters: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .compute_time = "ComputeTime",
        .created_at = "CreatedAt",
        .created_by_iam_user = "CreatedByIamUser",
        .endpoint_info = "EndpointInfo",
        .finished_at = "FinishedAt",
        .input_data_location_s3 = "InputDataLocationS3",
        .last_updated_at = "LastUpdatedAt",
        .log_uri = "LogUri",
        .message = "Message",
        .ml_model_id = "MLModelId",
        .ml_model_type = "MLModelType",
        .name = "Name",
        .recipe = "Recipe",
        .schema = "Schema",
        .score_threshold = "ScoreThreshold",
        .score_threshold_last_updated_at = "ScoreThresholdLastUpdatedAt",
        .size_in_bytes = "SizeInBytes",
        .started_at = "StartedAt",
        .status = "Status",
        .training_data_source_id = "TrainingDataSourceId",
        .training_parameters = "TrainingParameters",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetMLModelInput, options: Options) !GetMLModelOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "machinelearning");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(response.body, response.status, client.allocator) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(response.body, response.status, response.headers, allocator);
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: GetMLModelInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("machinelearning", "Machine Learning", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const body = try aws.json.jsonStringify(input, alloc);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(alloc, "X-Amz-Target", "AmazonML_20141212.GetMLModel");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !GetMLModelOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetMLModelOutput, body, alloc);
}

fn parseErrorResponse(body: []const u8, status: u16, alloc: std.mem.Allocator) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(alloc);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "IdempotentParameterMismatchException")) {
        return .{ .arena = arena, .kind = .{ .idempotent_parameter_mismatch_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalServerException")) {
        return .{ .arena = arena, .kind = .{ .internal_server_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidInputException")) {
        return .{ .arena = arena, .kind = .{ .invalid_input_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidTagException")) {
        return .{ .arena = arena, .kind = .{ .invalid_tag_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "LimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "PredictorNotMountedException")) {
        return .{ .arena = arena, .kind = .{ .predictor_not_mounted_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TagLimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .tag_limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
