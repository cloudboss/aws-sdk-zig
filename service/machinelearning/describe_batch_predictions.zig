const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const BatchPredictionFilterVariable = @import("batch_prediction_filter_variable.zig").BatchPredictionFilterVariable;
const SortOrder = @import("sort_order.zig").SortOrder;
const BatchPrediction = @import("batch_prediction.zig").BatchPrediction;

pub const DescribeBatchPredictionsInput = struct {
    /// The equal to operator. The `BatchPrediction` results will have
    /// `FilterVariable` values that exactly match the value specified with `EQ`.
    eq: ?[]const u8 = null,

    /// Use one of the following variables to filter a list of `BatchPrediction`:
    ///
    /// * `CreatedAt` - Sets the search criteria to the `BatchPrediction` creation
    ///   date.
    ///
    /// * `Status` - Sets the search criteria to the `BatchPrediction` status.
    ///
    /// * `Name` - Sets the search criteria to the contents of the `BatchPrediction`
    /// ** **
    /// `Name`.
    ///
    /// * `IAMUser` - Sets the search criteria to the user account that invoked the
    ///   `BatchPrediction` creation.
    ///
    /// * `MLModelId` - Sets the search criteria to the `MLModel` used in the
    ///   `BatchPrediction`.
    ///
    /// * `DataSourceId` - Sets the search criteria to the `DataSource` used in the
    ///   `BatchPrediction`.
    ///
    /// * `DataURI` - Sets the search criteria to the data file(s) used in the
    ///   `BatchPrediction`. The URL can identify either a file or an Amazon Simple
    ///   Storage Solution (Amazon S3) bucket or directory.
    filter_variable: ?BatchPredictionFilterVariable = null,

    /// The greater than or equal to operator. The `BatchPrediction` results will
    /// have `FilterVariable` values that are greater than or equal to the value
    /// specified with `GE`.
    ge: ?[]const u8 = null,

    /// The greater than operator. The `BatchPrediction` results will
    /// have `FilterVariable` values that are greater than the value specified with
    /// `GT`.
    gt: ?[]const u8 = null,

    /// The less than or equal to operator. The `BatchPrediction` results will have
    /// `FilterVariable` values that are less than or equal to the value specified
    /// with `LE`.
    le: ?[]const u8 = null,

    /// The number of pages of information to include in the result. The range of
    /// acceptable values is `1` through `100`. The default value is `100`.
    limit: ?i32 = null,

    /// The less than operator. The `BatchPrediction` results will
    /// have `FilterVariable` values that are less than the value specified with
    /// `LT`.
    lt: ?[]const u8 = null,

    /// The not equal to operator. The `BatchPrediction` results will have
    /// `FilterVariable` values not equal to the value specified with `NE`.
    ne: ?[]const u8 = null,

    /// An ID of the page in the paginated results.
    next_token: ?[]const u8 = null,

    /// A string that is found at the beginning of a variable, such as `Name` or
    /// `Id`.
    ///
    /// For example, a `Batch Prediction` operation could have the `Name`
    /// `2014-09-09-HolidayGiftMailer`. To search for
    /// this `BatchPrediction`, select `Name` for the `FilterVariable` and any of
    /// the following strings for the
    /// `Prefix`:
    ///
    /// * 2014-09
    ///
    /// * 2014-09-09
    ///
    /// * 2014-09-09-Holiday
    prefix: ?[]const u8 = null,

    /// A two-value parameter that determines the sequence of the resulting list of
    /// `MLModel`s.
    ///
    /// * `asc` - Arranges the list in ascending order (A-Z, 0-9).
    ///
    /// * `dsc` - Arranges the list in descending order (Z-A, 9-0).
    ///
    /// Results are sorted by `FilterVariable`.
    sort_order: ?SortOrder = null,

    pub const json_field_names = .{
        .eq = "EQ",
        .filter_variable = "FilterVariable",
        .ge = "GE",
        .gt = "GT",
        .le = "LE",
        .limit = "Limit",
        .lt = "LT",
        .ne = "NE",
        .next_token = "NextToken",
        .prefix = "Prefix",
        .sort_order = "SortOrder",
    };
};

pub const DescribeBatchPredictionsOutput = struct {
    /// The ID of the next page in the paginated results that indicates at least one
    /// more page follows.
    next_token: ?[]const u8 = null,

    /// A list of `BatchPrediction` objects that meet the search criteria.
    results: ?[]const BatchPrediction = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .results = "Results",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeBatchPredictionsInput, options: CallOptions) !DescribeBatchPredictionsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "machinelearning");

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeBatchPredictionsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("machinelearning", "Machine Learning", allocator);

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
    try request.headers.put(allocator, "X-Amz-Target", "AmazonML_20141212.DescribeBatchPredictions");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeBatchPredictionsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeBatchPredictionsOutput, body, allocator);
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
