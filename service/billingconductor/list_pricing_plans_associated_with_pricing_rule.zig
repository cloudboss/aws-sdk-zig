const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const ListPricingPlansAssociatedWithPricingRuleInput = struct {
    /// The pricing plan billing period for which associations will be listed.
    billing_period: ?[]const u8 = null,

    /// The optional maximum number of pricing rule associations to retrieve.
    max_results: ?i32 = null,

    /// The optional pagination token returned by a previous call.
    next_token: ?[]const u8 = null,

    /// The pricing rule Amazon Resource Name (ARN) for which associations will be
    /// listed.
    pricing_rule_arn: []const u8,

    pub const json_field_names = .{
        .billing_period = "BillingPeriod",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .pricing_rule_arn = "PricingRuleArn",
    };
};

pub const ListPricingPlansAssociatedWithPricingRuleOutput = struct {
    /// The pricing plan billing period for which associations will be listed.
    billing_period: ?[]const u8 = null,

    /// The pagination token to be used on subsequent calls.
    next_token: ?[]const u8 = null,

    /// The list containing pricing plans that are associated with the requested
    /// pricing rule.
    pricing_plan_arns: ?[]const []const u8 = null,

    /// The pricing rule Amazon Resource Name (ARN) for which associations will be
    /// listed.
    pricing_rule_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .billing_period = "BillingPeriod",
        .next_token = "NextToken",
        .pricing_plan_arns = "PricingPlanArns",
        .pricing_rule_arn = "PricingRuleArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListPricingPlansAssociatedWithPricingRuleInput, options: CallOptions) !ListPricingPlansAssociatedWithPricingRuleOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListPricingPlansAssociatedWithPricingRuleInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("billingconductor", "billingconductor", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/list-pricing-plans-associated-with-pricing-rule";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.billing_period) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"BillingPeriod\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.max_results) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"MaxResults\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.next_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"NextToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"PricingRuleArn\":");
    try aws.json.writeValue(@TypeOf(input.pricing_rule_arn), input.pricing_rule_arn, allocator, &body_buf);
    has_prev = true;

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListPricingPlansAssociatedWithPricingRuleOutput {
    var result: ListPricingPlansAssociatedWithPricingRuleOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ListPricingPlansAssociatedWithPricingRuleOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
