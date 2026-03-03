const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const CurrencyCode = @import("currency_code.zig").CurrencyCode;
const WorkloadEstimateRateType = @import("workload_estimate_rate_type.zig").WorkloadEstimateRateType;
const WorkloadEstimateStatus = @import("workload_estimate_status.zig").WorkloadEstimateStatus;

pub const UpdateWorkloadEstimateInput = struct {
    /// The new expiration date for the workload estimate.
    expires_at: ?i64 = null,

    /// The unique identifier of the workload estimate to update.
    identifier: []const u8,

    /// The new name for the workload estimate.
    name: ?[]const u8 = null,

    pub const json_field_names = .{
        .expires_at = "expiresAt",
        .identifier = "identifier",
        .name = "name",
    };
};

pub const UpdateWorkloadEstimateOutput = struct {
    /// The currency of the updated estimated cost.
    cost_currency: ?CurrencyCode = null,

    /// The timestamp when the workload estimate was originally created.
    created_at: ?i64 = null,

    /// The updated expiration timestamp for the workload estimate.
    expires_at: ?i64 = null,

    /// An error message if the workload estimate update failed.
    failure_message: ?[]const u8 = null,

    /// The unique identifier of the updated workload estimate.
    id: []const u8,

    /// The updated name of the workload estimate.
    name: ?[]const u8 = null,

    /// The timestamp of the pricing rates used for the updated estimate.
    rate_timestamp: ?i64 = null,

    /// The type of pricing rates used for the updated estimate.
    rate_type: ?WorkloadEstimateRateType = null,

    /// The current status of the updated workload estimate.
    status: ?WorkloadEstimateStatus = null,

    /// The updated total estimated cost for the workload.
    total_cost: ?f64 = null,

    pub const json_field_names = .{
        .cost_currency = "costCurrency",
        .created_at = "createdAt",
        .expires_at = "expiresAt",
        .failure_message = "failureMessage",
        .id = "id",
        .name = "name",
        .rate_timestamp = "rateTimestamp",
        .rate_type = "rateType",
        .status = "status",
        .total_cost = "totalCost",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateWorkloadEstimateInput, options: Options) !UpdateWorkloadEstimateOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "bcmpricingcalculator");

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateWorkloadEstimateInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bcmpricingcalculator", "BCM Pricing Calculator", allocator);

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
    try request.headers.put(allocator, "X-Amz-Target", "AWSBCMPricingCalculator.UpdateWorkloadEstimate");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateWorkloadEstimateOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(UpdateWorkloadEstimateOutput, body, allocator);
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
    if (std.mem.eql(u8, error_code, "DataUnavailableException")) {
        return .{ .arena = arena, .kind = .{ .data_unavailable_exception = .{
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
