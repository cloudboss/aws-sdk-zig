const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const UpdateBillingGroupAccountGrouping = @import("update_billing_group_account_grouping.zig").UpdateBillingGroupAccountGrouping;
const ComputationPreference = @import("computation_preference.zig").ComputationPreference;
const BillingGroupStatus = @import("billing_group_status.zig").BillingGroupStatus;

pub const UpdateBillingGroupInput = struct {
    /// Specifies if the billing group has automatic account association
    /// (`AutoAssociate`) enabled.
    account_grouping: ?UpdateBillingGroupAccountGrouping = null,

    /// The Amazon Resource Name (ARN) of the billing group being updated.
    arn: []const u8,

    /// The preferences and settings that will be used to compute the Amazon Web
    /// Services charges for a billing group.
    computation_preference: ?ComputationPreference = null,

    /// A description of the billing group.
    description: ?[]const u8 = null,

    /// The name of the billing group. The names must be unique to each billing
    /// group.
    name: ?[]const u8 = null,

    /// The status of the billing group. Only one of the valid values can be used.
    status: ?BillingGroupStatus = null,

    pub const json_field_names = .{
        .account_grouping = "AccountGrouping",
        .arn = "Arn",
        .computation_preference = "ComputationPreference",
        .description = "Description",
        .name = "Name",
        .status = "Status",
    };
};

pub const UpdateBillingGroupOutput = struct {
    /// Specifies if the billing group has automatic account association
    /// (`AutoAssociate`) enabled.
    account_grouping: ?UpdateBillingGroupAccountGrouping = null,

    /// The Amazon Resource Name (ARN) of the billing group that was updated.
    arn: ?[]const u8 = null,

    /// A description of the billing group.
    description: ?[]const u8 = null,

    /// The most recent time when the billing group was modified.
    last_modified_time: ?i64 = null,

    /// The name of the billing group. The names must be unique to each billing
    /// group.
    name: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the pricing plan to compute Amazon Web
    /// Services charges for the billing group.
    pricing_plan_arn: ?[]const u8 = null,

    /// The account ID that serves as the main account in a billing group.
    primary_account_id: ?[]const u8 = null,

    /// The number of accounts in the particular billing group.
    size: ?i64 = null,

    /// The status of the billing group. Only one of the valid values can be used.
    status: ?BillingGroupStatus = null,

    /// The reason why the billing group is in its current status.
    status_reason: ?[]const u8 = null,

    pub const json_field_names = .{
        .account_grouping = "AccountGrouping",
        .arn = "Arn",
        .description = "Description",
        .last_modified_time = "LastModifiedTime",
        .name = "Name",
        .pricing_plan_arn = "PricingPlanArn",
        .primary_account_id = "PrimaryAccountId",
        .size = "Size",
        .status = "Status",
        .status_reason = "StatusReason",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateBillingGroupInput, options: CallOptions) !UpdateBillingGroupOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "billingconductor");

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateBillingGroupInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("billingconductor", "billingconductor", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const path = "/update-billing-group";

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.account_grouping) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"AccountGrouping\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Arn\":");
    try aws.json.writeValue(@TypeOf(input.arn), input.arn, allocator, &body_buf);
    has_prev = true;
    if (input.computation_preference) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ComputationPreference\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Name\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.status) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Status\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateBillingGroupOutput {
    var result: UpdateBillingGroupOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(UpdateBillingGroupOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
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
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServiceLimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .service_limit_exceeded_exception = .{
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
