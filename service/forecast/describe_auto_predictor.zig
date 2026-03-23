const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const DataConfig = @import("data_config.zig").DataConfig;
const EncryptionConfig = @import("encryption_config.zig").EncryptionConfig;
const ExplainabilityInfo = @import("explainability_info.zig").ExplainabilityInfo;
const MonitorInfo = @import("monitor_info.zig").MonitorInfo;
const OptimizationMetric = @import("optimization_metric.zig").OptimizationMetric;
const ReferencePredictorSummary = @import("reference_predictor_summary.zig").ReferencePredictorSummary;
const TimeAlignmentBoundary = @import("time_alignment_boundary.zig").TimeAlignmentBoundary;

pub const DescribeAutoPredictorInput = struct {
    /// The Amazon Resource Name (ARN) of the predictor.
    predictor_arn: []const u8,

    pub const json_field_names = .{
        .predictor_arn = "PredictorArn",
    };
};

pub const DescribeAutoPredictorOutput = struct {
    /// The timestamp of the CreateAutoPredictor request.
    creation_time: ?i64 = null,

    /// The data configuration for your dataset group and any additional datasets.
    data_config: ?DataConfig = null,

    /// An array of the ARNs of the dataset import jobs used to import training data
    /// for the
    /// predictor.
    dataset_import_job_arns: ?[]const []const u8 = null,

    encryption_config: ?EncryptionConfig = null,

    /// The estimated time remaining in minutes for the predictor training job to
    /// complete.
    estimated_time_remaining_in_minutes: ?i64 = null,

    /// Provides the status and ARN of the Predictor Explainability.
    explainability_info: ?ExplainabilityInfo = null,

    /// An array of dimension (field) names that specify the attributes used to
    /// group your
    /// time series.
    forecast_dimensions: ?[]const []const u8 = null,

    /// The frequency of predictions in a forecast.
    ///
    /// Valid intervals are Y (Year), M (Month), W (Week), D (Day), H (Hour), 30min
    /// (30
    /// minutes), 15min (15 minutes), 10min (10 minutes), 5min (5 minutes), and 1min
    /// (1 minute).
    /// For example, "Y" indicates every year and "5min" indicates every five
    /// minutes.
    forecast_frequency: ?[]const u8 = null,

    /// The number of time-steps that the model predicts. The forecast horizon is
    /// also called
    /// the prediction length.
    forecast_horizon: ?i32 = null,

    /// The forecast types used during predictor training. Default value is
    /// ["0.1","0.5","0.9"].
    forecast_types: ?[]const []const u8 = null,

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

    /// In the event of an error, a message detailing the cause of the error.
    message: ?[]const u8 = null,

    /// A object with the Amazon Resource Name (ARN) and status of the monitor
    /// resource.
    monitor_info: ?MonitorInfo = null,

    /// The accuracy metric used to optimize the predictor.
    optimization_metric: ?OptimizationMetric = null,

    /// The Amazon Resource Name (ARN) of the predictor
    predictor_arn: ?[]const u8 = null,

    /// The name of the predictor.
    predictor_name: ?[]const u8 = null,

    /// The ARN and state of the reference predictor. This parameter is only valid
    /// for
    /// retrained or upgraded predictors.
    reference_predictor_summary: ?ReferencePredictorSummary = null,

    /// The status of the predictor. States include:
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

    /// The time boundary Forecast uses when aggregating data.
    time_alignment_boundary: ?TimeAlignmentBoundary = null,

    pub const json_field_names = .{
        .creation_time = "CreationTime",
        .data_config = "DataConfig",
        .dataset_import_job_arns = "DatasetImportJobArns",
        .encryption_config = "EncryptionConfig",
        .estimated_time_remaining_in_minutes = "EstimatedTimeRemainingInMinutes",
        .explainability_info = "ExplainabilityInfo",
        .forecast_dimensions = "ForecastDimensions",
        .forecast_frequency = "ForecastFrequency",
        .forecast_horizon = "ForecastHorizon",
        .forecast_types = "ForecastTypes",
        .last_modification_time = "LastModificationTime",
        .message = "Message",
        .monitor_info = "MonitorInfo",
        .optimization_metric = "OptimizationMetric",
        .predictor_arn = "PredictorArn",
        .predictor_name = "PredictorName",
        .reference_predictor_summary = "ReferencePredictorSummary",
        .status = "Status",
        .time_alignment_boundary = "TimeAlignmentBoundary",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeAutoPredictorInput, options: CallOptions) !DescribeAutoPredictorOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "forecast");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeAutoPredictorInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("forecast", "forecast", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AmazonForecast.DescribeAutoPredictor");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeAutoPredictorOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeAutoPredictorOutput, body, allocator);
}

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "InvalidInputException")) {
        return .{ .arena = arena, .kind = .{ .invalid_input_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidNextTokenException")) {
        return .{ .arena = arena, .kind = .{ .invalid_next_token_exception = .{
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
    if (std.mem.eql(u8, error_code, "ResourceAlreadyExistsException")) {
        return .{ .arena = arena, .kind = .{ .resource_already_exists_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceInUseException")) {
        return .{ .arena = arena, .kind = .{ .resource_in_use_exception = .{
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

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
