const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const OperationStatus = @import("operation_status.zig").OperationStatus;
const StatusFlag = @import("status_flag.zig").StatusFlag;
const OperationType = @import("operation_type.zig").OperationType;

pub const GetOperationDetailInput = struct {
    /// The identifier for the operation for which you want to get the status. Route
    /// 53
    /// returned the identifier in the response to the original request.
    operation_id: []const u8,

    pub const json_field_names = .{
        .operation_id = "OperationId",
    };
};

pub const GetOperationDetailOutput = struct {
    /// The name of a domain.
    domain_name: ?[]const u8 = null,

    /// The date when the operation was last updated.
    last_updated_date: ?i64 = null,

    /// Detailed information on the status including possible errors.
    message: ?[]const u8 = null,

    /// The identifier for the operation.
    operation_id: ?[]const u8 = null,

    /// The current status of the requested operation in the system.
    status: ?OperationStatus = null,

    /// Lists any outstanding operations that require customer action. Valid values
    /// are:
    ///
    /// * `PENDING_ACCEPTANCE`: The operation is waiting for acceptance from
    /// the account that is receiving the domain.
    ///
    /// * `PENDING_CUSTOMER_ACTION`: The operation is waiting for customer
    /// action, for example, returning an email.
    ///
    /// * `PENDING_AUTHORIZATION`: The operation is waiting for the form of
    /// authorization. For more information, see
    /// [ResendOperationAuthorization](https://docs.aws.amazon.com/Route53/latest/APIReference/API_domains_ResendOperationAuthorization.html).
    ///
    /// * `PENDING_PAYMENT_VERIFICATION`: The operation is waiting for the
    /// payment method to validate.
    ///
    /// * `PENDING_SUPPORT_CASE`: The operation includes a support case and
    /// is waiting for its resolution.
    status_flag: ?StatusFlag = null,

    /// The date when the request was submitted.
    submitted_date: ?i64 = null,

    /// The type of operation that was requested.
    type: ?OperationType = null,

    pub const json_field_names = .{
        .domain_name = "DomainName",
        .last_updated_date = "LastUpdatedDate",
        .message = "Message",
        .operation_id = "OperationId",
        .status = "Status",
        .status_flag = "StatusFlag",
        .submitted_date = "SubmittedDate",
        .type = "Type",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetOperationDetailInput, options: Options) !GetOperationDetailOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "route53domains");

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

fn serializeRequest(alloc: std.mem.Allocator, input: GetOperationDetailInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("route53domains", "Route 53 Domains", alloc);

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
    try request.headers.put(alloc, "X-Amz-Target", "Route53Domains_v20140515.GetOperationDetail");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !GetOperationDetailOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetOperationDetailOutput, body, alloc);
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

    if (std.mem.eql(u8, error_code, "DnssecLimitExceeded")) {
        return .{ .arena = arena, .kind = .{ .dnssec_limit_exceeded = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DomainLimitExceeded")) {
        return .{ .arena = arena, .kind = .{ .domain_limit_exceeded = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DuplicateRequest")) {
        return .{ .arena = arena, .kind = .{ .duplicate_request = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidInput")) {
        return .{ .arena = arena, .kind = .{ .invalid_input = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "OperationLimitExceeded")) {
        return .{ .arena = arena, .kind = .{ .operation_limit_exceeded = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TLDRulesViolation")) {
        return .{ .arena = arena, .kind = .{ .tld_rules_violation = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UnsupportedTLD")) {
        return .{ .arena = arena, .kind = .{ .unsupported_tld = .{
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
