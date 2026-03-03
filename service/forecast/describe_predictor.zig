const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const AutoMLOverrideStrategy = @import("auto_ml_override_strategy.zig").AutoMLOverrideStrategy;
const EncryptionConfig = @import("encryption_config.zig").EncryptionConfig;
const EvaluationParameters = @import("evaluation_parameters.zig").EvaluationParameters;
const FeaturizationConfig = @import("featurization_config.zig").FeaturizationConfig;
const HyperParameterTuningJobConfig = @import("hyper_parameter_tuning_job_config.zig").HyperParameterTuningJobConfig;
const InputDataConfig = @import("input_data_config.zig").InputDataConfig;
const OptimizationMetric = @import("optimization_metric.zig").OptimizationMetric;
const PredictorExecutionDetails = @import("predictor_execution_details.zig").PredictorExecutionDetails;

pub const DescribePredictorInput = struct {
    /// The Amazon Resource Name (ARN) of the predictor that you want information
    /// about.
    predictor_arn: []const u8,

    pub const json_field_names = .{
        .predictor_arn = "PredictorArn",
    };
};

pub const DescribePredictorOutput = struct {
    /// The Amazon Resource Name (ARN) of the algorithm used for model training.
    algorithm_arn: ?[]const u8 = null,

    /// When `PerformAutoML` is specified, the ARN of the chosen algorithm.
    auto_ml_algorithm_arns: ?[]const []const u8 = null,

    /// The `LatencyOptimized` AutoML override strategy is only available in private
    /// beta.
    /// Contact Amazon Web Services Support or your account manager to learn more
    /// about access privileges.
    ///
    /// The AutoML strategy used to train the predictor. Unless `LatencyOptimized`
    /// is specified, the AutoML strategy optimizes predictor accuracy.
    ///
    /// This parameter is only valid for predictors trained using AutoML.
    auto_ml_override_strategy: ?AutoMLOverrideStrategy = null,

    /// When the model training task was created.
    creation_time: ?i64 = null,

    /// An array of the ARNs of the dataset import jobs used to import training data
    /// for the
    /// predictor.
    dataset_import_job_arns: ?[]const []const u8 = null,

    /// An Key Management Service (KMS) key and the Identity and Access Management
    /// (IAM) role that Amazon Forecast can assume to access
    /// the key.
    encryption_config: ?EncryptionConfig = null,

    /// The estimated time remaining in minutes for the predictor training job to
    /// complete.
    estimated_time_remaining_in_minutes: ?i64 = null,

    /// Used to override the default evaluation parameters of the specified
    /// algorithm. Amazon Forecast
    /// evaluates a predictor by splitting a dataset into training data and testing
    /// data. The
    /// evaluation parameters define how to perform the split and the number of
    /// iterations.
    evaluation_parameters: ?EvaluationParameters = null,

    /// The featurization configuration.
    featurization_config: ?FeaturizationConfig = null,

    /// The number of time-steps of the forecast. The forecast horizon is also
    /// called the
    /// prediction length.
    forecast_horizon: ?i32 = null,

    /// The forecast types used during predictor training. Default value is
    /// `["0.1","0.5","0.9"]`
    forecast_types: ?[]const []const u8 = null,

    /// The hyperparameter override values for the algorithm.
    hpo_config: ?HyperParameterTuningJobConfig = null,

    /// Describes the dataset group that contains the data to use to train the
    /// predictor.
    input_data_config: ?InputDataConfig = null,

    /// Whether the predictor was created with CreateAutoPredictor.
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

    /// The accuracy metric used to optimize the predictor.
    optimization_metric: ?OptimizationMetric = null,

    /// Whether the predictor is set to perform AutoML.
    perform_auto_ml: ?bool = null,

    /// Whether the predictor is set to perform hyperparameter optimization (HPO).
    perform_hpo: ?bool = null,

    /// The ARN of the predictor.
    predictor_arn: ?[]const u8 = null,

    /// Details on the the status and results of the backtests performed to evaluate
    /// the accuracy
    /// of the predictor. You specify the number of backtests to perform when you
    /// call the operation.
    predictor_execution_details: ?PredictorExecutionDetails = null,

    /// The name of the predictor.
    predictor_name: ?[]const u8 = null,

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

    /// The default training parameters or overrides selected during model training.
    /// When running
    /// AutoML or choosing HPO with CNN-QR or DeepAR+, the optimized values for the
    /// chosen
    /// hyperparameters are returned. For more information, see
    /// aws-forecast-choosing-recipes.
    training_parameters: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .algorithm_arn = "AlgorithmArn",
        .auto_ml_algorithm_arns = "AutoMLAlgorithmArns",
        .auto_ml_override_strategy = "AutoMLOverrideStrategy",
        .creation_time = "CreationTime",
        .dataset_import_job_arns = "DatasetImportJobArns",
        .encryption_config = "EncryptionConfig",
        .estimated_time_remaining_in_minutes = "EstimatedTimeRemainingInMinutes",
        .evaluation_parameters = "EvaluationParameters",
        .featurization_config = "FeaturizationConfig",
        .forecast_horizon = "ForecastHorizon",
        .forecast_types = "ForecastTypes",
        .hpo_config = "HPOConfig",
        .input_data_config = "InputDataConfig",
        .is_auto_predictor = "IsAutoPredictor",
        .last_modification_time = "LastModificationTime",
        .message = "Message",
        .optimization_metric = "OptimizationMetric",
        .perform_auto_ml = "PerformAutoML",
        .perform_hpo = "PerformHPO",
        .predictor_arn = "PredictorArn",
        .predictor_execution_details = "PredictorExecutionDetails",
        .predictor_name = "PredictorName",
        .status = "Status",
        .training_parameters = "TrainingParameters",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribePredictorInput, options: Options) !DescribePredictorOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribePredictorInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AmazonForecast.DescribePredictor");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribePredictorOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribePredictorOutput, body, allocator);
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
