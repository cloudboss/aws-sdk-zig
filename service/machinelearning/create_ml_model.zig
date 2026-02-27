const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const MLModelType = @import("ml_model_type.zig").MLModelType;

pub const CreateMLModelInput = struct {
    /// A user-supplied ID that uniquely identifies the `MLModel`.
    ml_model_id: []const u8,

    /// A user-supplied name or description of the `MLModel`.
    ml_model_name: ?[]const u8 = null,

    /// The category of supervised learning that this `MLModel` will address. Choose
    /// from the following types:
    ///
    /// * Choose `REGRESSION` if the `MLModel` will be used to predict a numeric
    ///   value.
    ///
    /// * Choose `BINARY` if the `MLModel` result has two possible values.
    ///
    /// * Choose `MULTICLASS` if the `MLModel` result has a limited number of
    ///   values.
    ///
    /// For more information, see the [Amazon Machine Learning Developer
    /// Guide](https://docs.aws.amazon.com/machine-learning/latest/dg).
    ml_model_type: MLModelType,

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
    ///   Shuffling
    /// the data improves a model's ability to find the optimal solution for a
    /// variety
    /// of data types. The valid values are `auto` and `none`. The
    /// default value is `none`. We strongly recommend that you shuffle your data.
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
    parameters: ?[]const aws.map.StringMapEntry = null,

    /// The data recipe for creating the `MLModel`. You must specify either the
    /// recipe
    /// or its URI. If you don't specify a recipe or its URI, Amazon ML creates a
    /// default.
    recipe: ?[]const u8 = null,

    /// The Amazon Simple Storage Service (Amazon S3) location and file name that
    /// contains the `MLModel` recipe. You must specify either the recipe or its
    /// URI. If you don't specify a recipe or its URI, Amazon ML creates a default.
    recipe_uri: ?[]const u8 = null,

    /// The `DataSource` that points to the training data.
    training_data_source_id: []const u8,

    pub const json_field_names = .{
        .ml_model_id = "MLModelId",
        .ml_model_name = "MLModelName",
        .ml_model_type = "MLModelType",
        .parameters = "Parameters",
        .recipe = "Recipe",
        .recipe_uri = "RecipeUri",
        .training_data_source_id = "TrainingDataSourceId",
    };
};

pub const CreateMLModelOutput = struct {
    /// A user-supplied ID that uniquely identifies the `MLModel`. This value should
    /// be identical to the value of the
    /// `MLModelId` in the request.
    ml_model_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .ml_model_id = "MLModelId",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateMLModelInput, options: Options) !CreateMLModelOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: CreateMLModelInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(alloc, "X-Amz-Target", "AmazonML_20141212.CreateMLModel");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !CreateMLModelOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateMLModelOutput, body, alloc);
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
