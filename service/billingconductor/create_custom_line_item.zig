const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CustomLineItemBillingPeriodRange = @import("custom_line_item_billing_period_range.zig").CustomLineItemBillingPeriodRange;
const CustomLineItemChargeDetails = @import("custom_line_item_charge_details.zig").CustomLineItemChargeDetails;
const ComputationRuleEnum = @import("computation_rule_enum.zig").ComputationRuleEnum;
const PresentationObject = @import("presentation_object.zig").PresentationObject;

pub const CreateCustomLineItemInput = struct {
    /// The Amazon Web Services account in which this custom line item will be
    /// applied to.
    account_id: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) that references the billing group where the
    /// custom line item applies to.
    billing_group_arn: []const u8,

    /// A time range for which the custom line item is effective.
    billing_period_range: ?CustomLineItemBillingPeriodRange = null,

    /// A `CustomLineItemChargeDetails` that describes the charge details for a
    /// custom line item.
    charge_details: CustomLineItemChargeDetails,

    /// A unique, case-sensitive identifier that you specify to ensure idempotency
    /// of the request. Idempotency ensures that an API request completes no more
    /// than one time. With an idempotent request, if the original request completes
    /// successfully, any subsequent retries complete successfully without
    /// performing any further actions.
    client_token: ?[]const u8 = null,

    /// Specifies how the custom line item charges are computed.
    computation_rule: ?ComputationRuleEnum = null,

    /// The description of the custom line item. This is shown on the Bills page in
    /// association with the charge value.
    description: []const u8,

    /// The name of the custom line item.
    name: []const u8,

    /// Details controlling how the custom line item charges are presented in the
    /// bill. Contains specifications for which service the charges will be shown
    /// under.
    presentation_details: ?PresentationObject = null,

    /// A map that contains tag keys and tag values that are attached to a custom
    /// line item.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .account_id = "AccountId",
        .billing_group_arn = "BillingGroupArn",
        .billing_period_range = "BillingPeriodRange",
        .charge_details = "ChargeDetails",
        .client_token = "ClientToken",
        .computation_rule = "ComputationRule",
        .description = "Description",
        .name = "Name",
        .presentation_details = "PresentationDetails",
        .tags = "Tags",
    };
};

pub const CreateCustomLineItemOutput = struct {
    /// The Amazon Resource Name (ARN) of the created custom line item.
    arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "Arn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateCustomLineItemInput, options: CallOptions) !CreateCustomLineItemOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateCustomLineItemInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("billingconductor", "billingconductor", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/create-custom-line-item";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.account_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"AccountId\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"BillingGroupArn\":");
    try aws.json.writeValue(@TypeOf(input.billing_group_arn), input.billing_group_arn, allocator, &body_buf);
    has_prev = true;
    if (input.billing_period_range) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"BillingPeriodRange\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"ChargeDetails\":");
    try aws.json.writeValue(@TypeOf(input.charge_details), input.charge_details, allocator, &body_buf);
    has_prev = true;
    if (input.computation_rule) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ComputationRule\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Description\":");
    try aws.json.writeValue(@TypeOf(input.description), input.description, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Name\":");
    try aws.json.writeValue(@TypeOf(input.name), input.name, allocator, &body_buf);
    has_prev = true;
    if (input.presentation_details) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"PresentationDetails\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Tags\":");
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
    if (input.client_token) |v| {
        try request.headers.put(allocator, "X-Amzn-Client-Token", v);
    }

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateCustomLineItemOutput {
    var result: CreateCustomLineItemOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateCustomLineItemOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
