const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const QueryComputeRequest = @import("query_compute_request.zig").QueryComputeRequest;
const QueryPricingModel = @import("query_pricing_model.zig").QueryPricingModel;
const QueryComputeResponse = @import("query_compute_response.zig").QueryComputeResponse;

pub const UpdateAccountSettingsInput = struct {
    /// The maximum number of compute units the service will use at any point in
    /// time to serve your queries. To run queries, you must set a minimum capacity
    /// of 4 TCU. You can set the maximum number of TCU in multiples of 4, for
    /// example, 4, 8, 16, 32, and so on. The maximum value supported for
    /// `MaxQueryTCU` is 1000. To request an increase to this soft limit, contact
    /// Amazon Web Services Support. For information about the default quota for
    /// maxQueryTCU, see Default quotas. This configuration is applicable only for
    /// on-demand usage of Timestream Compute Units (TCUs).
    ///
    /// The maximum value supported for `MaxQueryTCU` is 1000. To request an
    /// increase to this soft limit, contact Amazon Web Services Support. For
    /// information about the default quota for `maxQueryTCU`, see [Default
    /// quotas](https://docs.aws.amazon.com/timestream/latest/developerguide/ts-limits.html#limits.default).
    max_query_tcu: ?i32 = null,

    /// Modifies the query compute settings configured in your account, including
    /// the query pricing model and provisioned Timestream Compute Units (TCUs) in
    /// your account.
    ///
    /// This API is idempotent, meaning that making the same request multiple times
    /// will have the same effect as making the request once.
    query_compute: ?QueryComputeRequest = null,

    /// The pricing model for queries in an account.
    ///
    /// The `QueryPricingModel` parameter is used by several Timestream operations;
    /// however, the `UpdateAccountSettings` API operation doesn't recognize any
    /// values other than `COMPUTE_UNITS`.
    query_pricing_model: ?QueryPricingModel = null,

    pub const json_field_names = .{
        .max_query_tcu = "MaxQueryTCU",
        .query_compute = "QueryCompute",
        .query_pricing_model = "QueryPricingModel",
    };
};

pub const UpdateAccountSettingsOutput = struct {
    /// The configured maximum number of compute units the service will use at any
    /// point in time to serve your queries.
    max_query_tcu: ?i32 = null,

    /// Confirms the updated account settings for querying data in your account.
    query_compute: ?QueryComputeResponse = null,

    /// The pricing model for an account.
    query_pricing_model: ?QueryPricingModel = null,

    pub const json_field_names = .{
        .max_query_tcu = "MaxQueryTCU",
        .query_compute = "QueryCompute",
        .query_pricing_model = "QueryPricingModel",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateAccountSettingsInput, options: CallOptions) !UpdateAccountSettingsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "timestream");

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateAccountSettingsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("query.timestream", "Timestream Query", allocator);

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
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "Timestream_20181101.UpdateAccountSettings");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateAccountSettingsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(UpdateAccountSettingsOutput, body, allocator);
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

    if (std.mem.eql(u8, error_code, "AccessDeniedException")) {
        return .{ .arena = arena, .kind = .{ .access_denied_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ConflictException")) {
        return .{ .arena = arena, .kind = .{ .conflict_exception = .{
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
    if (std.mem.eql(u8, error_code, "InvalidEndpointException")) {
        return .{ .arena = arena, .kind = .{ .invalid_endpoint_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "QueryExecutionException")) {
        return .{ .arena = arena, .kind = .{ .query_execution_exception = .{
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
    if (std.mem.eql(u8, error_code, "ServiceQuotaExceededException")) {
        return .{ .arena = arena, .kind = .{ .service_quota_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ThrottlingException")) {
        return .{ .arena = arena, .kind = .{ .throttling_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ValidationException")) {
        return .{ .arena = arena, .kind = .{ .validation_exception = .{
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
