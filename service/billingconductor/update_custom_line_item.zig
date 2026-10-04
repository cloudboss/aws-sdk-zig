const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
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
    association_size: ?i64 = null,

    /// The ARN of the billing group that the custom line item is applied to.
    billing_group_arn: ?[]const u8 = null,

    /// A `ListCustomLineItemChargeDetails` containing the charge details of the
    /// successfully updated custom line item.
    charge_details: ?ListCustomLineItemChargeDetails = null,

    /// The description of the successfully updated custom line item.
    description: ?[]const u8 = null,

    /// The most recent time when the custom line item was modified.
    last_modified_time: ?i64 = null,

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

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateCustomLineItemInput, options: CallOptions) !UpdateCustomLineItemOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "billingconductor", client.config.http_client.clock_skew_offset);

    var response = try client.config.http_client.sendRequestWithOptions(&request, client.options);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = try parseErrorResponse(client.allocator, response.body, response.status);
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateCustomLineItemInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("billingconductor", "billingconductor", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/update-custom-line-item";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Arn\":");
    try aws.json.writeValue(@TypeOf(input.arn), input.arn, allocator, &body_buf);
    has_prev = true;
    if (input.billing_period_range) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"BillingPeriodRange\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.charge_details) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ChargeDetails\":");
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

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateCustomLineItemOutput {
    var result: UpdateCustomLineItemOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(UpdateCustomLineItemOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
