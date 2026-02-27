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
const Tag = @import("tag.zig").Tag;

pub const CreatePredictorInput = struct {
    /// The Amazon Resource Name (ARN) of the algorithm to use for model training.
    /// Required if
    /// `PerformAutoML` is not set to `true`.
    ///
    /// **Supported algorithms:**
    ///
    /// * `arn:aws:forecast:::algorithm/ARIMA`
    ///
    /// * `arn:aws:forecast:::algorithm/CNN-QR`
    ///
    /// * `arn:aws:forecast:::algorithm/Deep_AR_Plus`
    ///
    /// * `arn:aws:forecast:::algorithm/ETS`
    ///
    /// * `arn:aws:forecast:::algorithm/NPTS`
    ///
    /// * `arn:aws:forecast:::algorithm/Prophet`
    algorithm_arn: ?[]const u8 = null,

    /// The `LatencyOptimized` AutoML override strategy is only available in private
    /// beta.
    /// Contact Amazon Web Services Support or your account manager to learn more
    /// about access privileges.
    ///
    /// Used to overide the default AutoML strategy, which is to optimize predictor
    /// accuracy.
    /// To apply an AutoML strategy that minimizes training time, use
    /// `LatencyOptimized`.
    ///
    /// This parameter is only valid for predictors trained using AutoML.
    auto_ml_override_strategy: ?AutoMLOverrideStrategy = null,

    /// An Key Management Service (KMS) key and the Identity and Access Management
    /// (IAM) role that Amazon Forecast can assume to access
    /// the key.
    encryption_config: ?EncryptionConfig = null,

    /// Used to override the default evaluation parameters of the specified
    /// algorithm. Amazon Forecast
    /// evaluates a predictor by splitting a dataset into training data and testing
    /// data. The
    /// evaluation parameters define how to perform the split and the number of
    /// iterations.
    evaluation_parameters: ?EvaluationParameters = null,

    /// The featurization configuration.
    featurization_config: FeaturizationConfig,

    /// Specifies the number of time-steps that the model is trained to predict. The
    /// forecast
    /// horizon is also called the prediction length.
    ///
    /// For example, if you configure a dataset for daily data collection (using the
    /// `DataFrequency` parameter of the CreateDataset operation) and
    /// set the forecast horizon to 10, the model returns predictions for 10 days.
    ///
    /// The maximum forecast horizon is the lesser of 500 time-steps or 1/3 of the
    /// TARGET_TIME_SERIES dataset length.
    forecast_horizon: i32,

    /// Specifies the forecast types used to train a predictor. You can specify up
    /// to five
    /// forecast types. Forecast types can be quantiles from 0.01 to 0.99, by
    /// increments of 0.01 or
    /// higher. You can also specify the mean forecast with `mean`.
    ///
    /// The default value is `["0.10", "0.50", "0.9"]`.
    forecast_types: ?[]const []const u8 = null,

    /// Provides hyperparameter override values for the algorithm. If you don't
    /// provide this
    /// parameter, Amazon Forecast uses default values. The individual algorithms
    /// specify which
    /// hyperparameters support hyperparameter optimization (HPO). For more
    /// information, see aws-forecast-choosing-recipes.
    ///
    /// If you included the `HPOConfig` object, you must set `PerformHPO` to
    /// true.
    hpo_config: ?HyperParameterTuningJobConfig = null,

    /// Describes the dataset group that contains the data to use to train the
    /// predictor.
    input_data_config: InputDataConfig,

    /// The accuracy metric used to optimize the predictor.
    optimization_metric: ?OptimizationMetric = null,

    /// Whether to perform AutoML. When Amazon Forecast performs AutoML, it
    /// evaluates the algorithms it
    /// provides and chooses the best algorithm and configuration for your training
    /// dataset.
    ///
    /// The default value is `false`. In this case, you are required to specify an
    /// algorithm.
    ///
    /// Set `PerformAutoML` to `true` to have Amazon Forecast perform AutoML. This
    /// is a good option if you aren't sure which algorithm is suitable for your
    /// training data. In
    /// this case, `PerformHPO` must be false.
    perform_auto_ml: ?bool = null,

    /// Whether to perform hyperparameter optimization (HPO). HPO finds optimal
    /// hyperparameter
    /// values for your training data. The process of performing HPO is known as
    /// running a
    /// hyperparameter tuning job.
    ///
    /// The default value is `false`. In this case, Amazon Forecast uses default
    /// hyperparameter values from the chosen algorithm.
    ///
    /// To override the default values, set `PerformHPO` to `true` and,
    /// optionally, supply the HyperParameterTuningJobConfig object. The tuning job
    /// specifies a metric to optimize, which hyperparameters participate in tuning,
    /// and the valid
    /// range for each tunable hyperparameter. In this case, you are required to
    /// specify an algorithm
    /// and `PerformAutoML` must be false.
    ///
    /// The following algorithms support HPO:
    ///
    /// * DeepAR+
    ///
    /// * CNN-QR
    perform_hpo: ?bool = null,

    /// A name for the predictor.
    predictor_name: []const u8,

    /// The optional metadata that you apply to the predictor to help you categorize
    /// and organize
    /// them. Each tag consists of a key and an optional value, both of which you
    /// define.
    ///
    /// The following basic restrictions apply to tags:
    ///
    /// * Maximum number of tags per resource - 50.
    ///
    /// * For each resource, each tag key must be unique, and each tag key can have
    ///   only one
    /// value.
    ///
    /// * Maximum key length - 128 Unicode characters in UTF-8.
    ///
    /// * Maximum value length - 256 Unicode characters in UTF-8.
    ///
    /// * If your tagging schema is used across multiple services and resources,
    ///   remember that
    /// other services may have restrictions on allowed characters. Generally
    /// allowed characters
    /// are: letters, numbers, and spaces representable in UTF-8, and the following
    /// characters: +
    /// - = . _ : / @.
    ///
    /// * Tag keys and values are case sensitive.
    ///
    /// * Do not use `aws:`, `AWS:`, or any upper or lowercase combination
    /// of such as a prefix for keys as it is reserved for Amazon Web Services use.
    /// You cannot edit or delete tag
    /// keys with this prefix. Values can have this prefix. If a tag value has `aws`
    /// as
    /// its prefix but the key does not, then Forecast considers it to be a user tag
    /// and will
    /// count against the limit of 50 tags. Tags with only the key prefix of `aws`
    /// do
    /// not count against your tags per resource limit.
    tags: ?[]const Tag = null,

    /// The hyperparameters to override for model training. The hyperparameters that
    /// you can
    /// override are listed in the individual algorithms. For the list of supported
    /// algorithms, see
    /// aws-forecast-choosing-recipes.
    training_parameters: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .algorithm_arn = "AlgorithmArn",
        .auto_ml_override_strategy = "AutoMLOverrideStrategy",
        .encryption_config = "EncryptionConfig",
        .evaluation_parameters = "EvaluationParameters",
        .featurization_config = "FeaturizationConfig",
        .forecast_horizon = "ForecastHorizon",
        .forecast_types = "ForecastTypes",
        .hpo_config = "HPOConfig",
        .input_data_config = "InputDataConfig",
        .optimization_metric = "OptimizationMetric",
        .perform_auto_ml = "PerformAutoML",
        .perform_hpo = "PerformHPO",
        .predictor_name = "PredictorName",
        .tags = "Tags",
        .training_parameters = "TrainingParameters",
    };
};

pub const CreatePredictorOutput = struct {
    /// The Amazon Resource Name (ARN) of the predictor.
    predictor_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .predictor_arn = "PredictorArn",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreatePredictorInput, options: Options) !CreatePredictorOutput {
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
            d.* = parseErrorResponse(response.body, response.status, client.allocator) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(response.body, response.status, response.headers, allocator);
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: CreatePredictorInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("forecast", "forecast", alloc);

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
    try request.headers.put(alloc, "X-Amz-Target", "AmazonForecast.CreatePredictor");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !CreatePredictorOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreatePredictorOutput, body, alloc);
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
