const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const MemberAccountDiscountVisibility = @import("member_account_discount_visibility.zig").MemberAccountDiscountVisibility;
const PreferredCommitment = @import("preferred_commitment.zig").PreferredCommitment;
const SavingsEstimationMode = @import("savings_estimation_mode.zig").SavingsEstimationMode;

pub const UpdatePreferencesInput = struct {
    /// Sets the "member account discount visibility" preference.
    member_account_discount_visibility: ?MemberAccountDiscountVisibility = null,

    /// Sets the preferences for how Reserved Instances and Savings Plans
    /// cost-saving opportunities are prioritized in terms of payment option and
    /// term length.
    preferred_commitment: ?PreferredCommitment = null,

    /// Sets the "savings estimation mode" preference.
    savings_estimation_mode: ?SavingsEstimationMode = null,

    pub const json_field_names = .{
        .member_account_discount_visibility = "memberAccountDiscountVisibility",
        .preferred_commitment = "preferredCommitment",
        .savings_estimation_mode = "savingsEstimationMode",
    };
};

pub const UpdatePreferencesOutput = struct {
    /// Shows the status of the "member account discount visibility" preference.
    member_account_discount_visibility: ?MemberAccountDiscountVisibility = null,

    /// Shows the updated preferences for how Reserved Instances and Savings Plans
    /// cost-saving opportunities are prioritized in terms of payment option and
    /// term length.
    preferred_commitment: ?PreferredCommitment = null,

    /// Shows the status of the "savings estimation mode" preference.
    savings_estimation_mode: ?SavingsEstimationMode = null,

    pub const json_field_names = .{
        .member_account_discount_visibility = "memberAccountDiscountVisibility",
        .preferred_commitment = "preferredCommitment",
        .savings_estimation_mode = "savingsEstimationMode",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdatePreferencesInput, options: CallOptions) !UpdatePreferencesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "costoptimizationhubservice");

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdatePreferencesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cost-optimization-hub", "Cost Optimization Hub", allocator);

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
    try request.headers.put(allocator, "X-Amz-Target", "CostOptimizationHubService.UpdatePreferences");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdatePreferencesOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(UpdatePreferencesOutput, body, allocator);
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
