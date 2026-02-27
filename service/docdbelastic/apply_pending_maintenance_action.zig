const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const OptInType = @import("opt_in_type.zig").OptInType;
const ResourcePendingMaintenanceAction = @import("resource_pending_maintenance_action.zig").ResourcePendingMaintenanceAction;

pub const ApplyPendingMaintenanceActionInput = struct {
    /// The pending maintenance action to apply to the resource.
    ///
    /// Valid actions are:
    ///
    /// * `ENGINE_UPDATE
    /// `
    ///
    /// * `ENGINE_UPGRADE`
    ///
    /// * `SECURITY_UPDATE`
    ///
    /// * `OS_UPDATE`
    ///
    /// * `MASTER_USER_PASSWORD_UPDATE`
    apply_action: []const u8,

    /// A specific date to apply the pending maintenance action. Required if
    /// opt-in-type is `APPLY_ON`. Format: `yyyy/MM/dd HH:mm-yyyy/MM/dd HH:mm`
    apply_on: ?[]const u8 = null,

    /// A value that specifies the type of opt-in request, or undoes an opt-in
    /// request. An opt-in request of type `IMMEDIATE` can't be undone.
    opt_in_type: OptInType,

    /// The Amazon DocumentDB Amazon Resource Name (ARN) of the resource to which
    /// the pending maintenance action applies.
    resource_arn: []const u8,

    pub const json_field_names = .{
        .apply_action = "applyAction",
        .apply_on = "applyOn",
        .opt_in_type = "optInType",
        .resource_arn = "resourceArn",
    };
};

pub const ApplyPendingMaintenanceActionOutput = struct {
    /// The output of the pending maintenance action being applied.
    resource_pending_maintenance_action: ?ResourcePendingMaintenanceAction = null,

    pub const json_field_names = .{
        .resource_pending_maintenance_action = "resourcePendingMaintenanceAction",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ApplyPendingMaintenanceActionInput, options: Options) !ApplyPendingMaintenanceActionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "docdbelastic");

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

fn serializeRequest(alloc: std.mem.Allocator, input: ApplyPendingMaintenanceActionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("docdbelastic", "DocDB Elastic", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const path = "/pending-action";

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(alloc, "{");

    if (has_prev) try body_buf.appendSlice(alloc, ",");
    try body_buf.appendSlice(alloc, "\"applyAction\":");
    try aws.json.writeValue(@TypeOf(input.apply_action), input.apply_action, alloc, &body_buf);
    has_prev = true;
    if (input.apply_on) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"applyOn\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(alloc, ",");
    try body_buf.appendSlice(alloc, "\"optInType\":");
    try aws.json.writeValue(@TypeOf(input.opt_in_type), input.opt_in_type, alloc, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(alloc, ",");
    try body_buf.appendSlice(alloc, "\"resourceArn\":");
    try aws.json.writeValue(@TypeOf(input.resource_arn), input.resource_arn, alloc, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(alloc, "}");
    const body = try body_buf.toOwnedSlice(alloc);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !ApplyPendingMaintenanceActionOutput {
    var result: ApplyPendingMaintenanceActionOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ApplyPendingMaintenanceActionOutput, body, alloc);
    }
    _ = status;
    _ = headers;

    return result;
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
