const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const CustomLineItemBillingPeriodRange = @import("custom_line_item_billing_period_range.zig").CustomLineItemBillingPeriodRange;
const UpdateCustomLineItemChargeDetails = @import("update_custom_line_item_charge_details.zig").UpdateCustomLineItemChargeDetails;
const ListCustomLineItemChargeDetails = @import("list_custom_line_item_charge_details.zig").ListCustomLineItemChargeDetails;

pub const UpdateCustomLineItemInput = struct {
    /// The ARN of the custom line item to be updated.
    arn: []const u8,

    billing_period_range: ?CustomLineItemBillingPeriodRange = null,

    /// A `ListCustomLineItemChargeDetails` containing the new charge details for
    /// the custom line item.
    charge_details: ?UpdateCustomLineItemChargeDetails = null,

    /// The new line item description of the custom line item.
    description: ?[]const u8 = null,

    /// The new name for the custom line item.
    name: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .billing_period_range = "BillingPeriodRange",
        .charge_details = "ChargeDetails",
        .description = "Description",
        .name = "Name",
    };
};

pub const UpdateCustomLineItemOutput = struct {
    /// The ARN of the successfully updated custom line item.
    arn: ?[]const u8 = null,

    /// The number of resources that are associated to the custom line item.
    association_size: i64 = 0,

    /// The ARN of the billing group that the custom line item is applied to.
    billing_group_arn: ?[]const u8 = null,

    /// A `ListCustomLineItemChargeDetails` containing the charge details of the
    /// successfully updated custom line item.
    charge_details: ?ListCustomLineItemChargeDetails = null,

    /// The description of the successfully updated custom line item.
    description: ?[]const u8 = null,

    /// The most recent time when the custom line item was modified.
    last_modified_time: i64 = 0,

    /// The name of the successfully updated custom line item.
    name: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .association_size = "AssociationSize",
        .billing_group_arn = "BillingGroupArn",
        .charge_details = "ChargeDetails",
        .description = "Description",
        .last_modified_time = "LastModifiedTime",
        .name = "Name",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateCustomLineItemInput, options: Options) !UpdateCustomLineItemOutput {
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
            d.* = parseErrorResponse(response.body, response.status, client.allocator) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(response.body, response.status, response.headers, allocator);
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: UpdateCustomLineItemInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("billingconductor", "billingconductor", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const path = "/update-custom-line-item";

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(alloc, "{");

    if (has_prev) try body_buf.appendSlice(alloc, ",");
    try body_buf.appendSlice(alloc, "\"Arn\":");
    try aws.json.writeValue(@TypeOf(input.arn), input.arn, alloc, &body_buf);
    has_prev = true;
    if (input.billing_period_range) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"BillingPeriodRange\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.charge_details) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"ChargeDetails\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"Description\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.name) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"Name\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }

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

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !UpdateCustomLineItemOutput {
    var result: UpdateCustomLineItemOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(UpdateCustomLineItemOutput, body, alloc);
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
