const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const DataConfig = @import("data_config.zig").DataConfig;
const EncryptionConfig = @import("encryption_config.zig").EncryptionConfig;
const MonitorConfig = @import("monitor_config.zig").MonitorConfig;
const OptimizationMetric = @import("optimization_metric.zig").OptimizationMetric;
const Tag = @import("tag.zig").Tag;
const TimeAlignmentBoundary = @import("time_alignment_boundary.zig").TimeAlignmentBoundary;

pub const CreateAutoPredictorInput = struct {
    /// The data configuration for your dataset group and any additional datasets.
    data_config: ?DataConfig = null,

    encryption_config: ?EncryptionConfig = null,

    /// Create an Explainability resource for the predictor.
    explain_predictor: ?bool = null,

    /// An array of dimension (field) names that specify how to group the generated
    /// forecast.
    ///
    /// For example, if you are generating forecasts for item sales across all your
    /// stores,
    /// and your dataset contains a `store_id` field, you would specify
    /// `store_id` as a dimension to group sales forecasts for each store.
    forecast_dimensions: ?[]const []const u8 = null,

    /// The frequency of predictions in a forecast.
    ///
    /// Valid intervals are an integer followed by Y (Year), M (Month), W (Week), D
    /// (Day), H (Hour), and min (Minute). For example,
    /// "1D" indicates every day and "15min" indicates every 15 minutes. You cannot
    /// specify a value that would overlap with the next larger frequency. That
    /// means, for example, you cannot specify a frequency of 60 minutes, because
    /// that is equivalent to 1 hour. The valid values for each frequency are the
    /// following:
    ///
    /// * Minute - 1-59
    ///
    /// * Hour - 1-23
    ///
    /// * Day - 1-6
    ///
    /// * Week - 1-4
    ///
    /// * Month - 1-11
    ///
    /// * Year - 1
    ///
    /// Thus, if you want every other week forecasts, specify "2W". Or, if you want
    /// quarterly forecasts, you specify "3M".
    ///
    /// The frequency must be greater than or equal to the TARGET_TIME_SERIES
    /// dataset
    /// frequency.
    ///
    /// When a RELATED_TIME_SERIES dataset is provided, the frequency must be equal
    /// to the
    /// RELATED_TIME_SERIES dataset frequency.
    forecast_frequency: ?[]const u8 = null,

    /// The number of time-steps that the model predicts. The forecast horizon is
    /// also called
    /// the prediction length.
    ///
    /// The maximum forecast horizon is the lesser of 500 time-steps or 1/4 of the
    /// TARGET_TIME_SERIES dataset length. If you are retraining an existing
    /// AutoPredictor, then
    /// the maximum forecast horizon is the lesser of 500 time-steps or 1/3 of the
    /// TARGET_TIME_SERIES dataset length.
    ///
    /// If you are upgrading to an AutoPredictor or retraining an existing
    /// AutoPredictor, you
    /// cannot update the forecast horizon parameter. You can meet this requirement
    /// by providing
    /// longer time-series in the dataset.
    forecast_horizon: ?i32 = null,

    /// The forecast types used to train a predictor. You can specify up to five
    /// forecast
    /// types. Forecast types can be quantiles from 0.01 to 0.99, by increments of
    /// 0.01 or
    /// higher. You can also specify the mean forecast with `mean`.
    forecast_types: ?[]const []const u8 = null,

    /// The configuration details for predictor monitoring. Provide a name for the
    /// monitor resource to enable predictor monitoring.
    ///
    /// Predictor monitoring allows you to see how your predictor's performance
    /// changes over time.
    /// For more information, see [Predictor
    /// Monitoring](https://docs.aws.amazon.com/forecast/latest/dg/predictor-monitoring.html).
    monitor_config: ?MonitorConfig = null,

    /// The accuracy metric used to optimize the predictor.
    optimization_metric: ?OptimizationMetric = null,

    /// A unique name for the predictor
    predictor_name: []const u8,

    /// The ARN of the predictor to retrain or upgrade. This parameter is only used
    /// when
    /// retraining or upgrading a predictor. When creating a new predictor, do not
    /// specify a
    /// value for this parameter.
    ///
    /// When upgrading or retraining a predictor, only specify values for the
    /// `ReferencePredictorArn` and `PredictorName`. The value for
    /// `PredictorName` must be a unique predictor name.
    reference_predictor_arn: ?[]const u8 = null,

    /// Optional metadata to help you categorize and organize your predictors. Each
    /// tag
    /// consists of a key and an optional value, both of which you define. Tag keys
    /// and values
    /// are case sensitive.
    ///
    /// The following restrictions apply to tags:
    ///
    /// * For each resource, each tag key must be unique and each tag key must have
    ///   one
    /// value.
    ///
    /// * Maximum number of tags per resource: 50.
    ///
    /// * Maximum key length: 128 Unicode characters in UTF-8.
    ///
    /// * Maximum value length: 256 Unicode characters in UTF-8.
    ///
    /// * Accepted characters: all letters and numbers, spaces representable in
    ///   UTF-8,
    /// and + - = . _ : / @. If your tagging schema is used across other services
    /// and
    /// resources, the character restrictions of those services also apply.
    ///
    /// * Key prefixes cannot include any upper or lowercase combination of
    /// `aws:` or `AWS:`. Values can have this prefix. If a
    /// tag value has `aws` as its prefix but the key does not, Forecast
    /// considers it to be a user tag and will count against the limit of 50 tags.
    /// Tags
    /// with only the key prefix of `aws` do not count against your tags per
    /// resource limit. You cannot edit or delete tag keys with this prefix.
    tags: ?[]const Tag = null,

    /// The time boundary Forecast uses to align and aggregate any data that doesn't
    /// align with your forecast frequency. Provide the unit of time and the time
    /// boundary as a key value pair.
    /// For more information on specifying a time boundary, see [Specifying a Time
    /// Boundary](https://docs.aws.amazon.com/forecast/latest/dg/data-aggregation.html#specifying-time-boundary).
    /// If you
    /// don't provide a time boundary, Forecast uses a set of [Default Time
    /// Boundaries](https://docs.aws.amazon.com/forecast/latest/dg/data-aggregation.html#default-time-boundaries).
    time_alignment_boundary: ?TimeAlignmentBoundary = null,

    pub const json_field_names = .{
        .data_config = "DataConfig",
        .encryption_config = "EncryptionConfig",
        .explain_predictor = "ExplainPredictor",
        .forecast_dimensions = "ForecastDimensions",
        .forecast_frequency = "ForecastFrequency",
        .forecast_horizon = "ForecastHorizon",
        .forecast_types = "ForecastTypes",
        .monitor_config = "MonitorConfig",
        .optimization_metric = "OptimizationMetric",
        .predictor_name = "PredictorName",
        .reference_predictor_arn = "ReferencePredictorArn",
        .tags = "Tags",
        .time_alignment_boundary = "TimeAlignmentBoundary",
    };
};

pub const CreateAutoPredictorOutput = struct {
    /// The Amazon Resource Name (ARN) of the predictor.
    predictor_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .predictor_arn = "PredictorArn",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateAutoPredictorInput, options: Options) !CreateAutoPredictorOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateAutoPredictorInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AmazonForecast.CreateAutoPredictor");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateAutoPredictorOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateAutoPredictorOutput, body, allocator);
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
