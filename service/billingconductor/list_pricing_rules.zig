const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ListPricingRulesFilter = @import("list_pricing_rules_filter.zig").ListPricingRulesFilter;
const PricingRuleListElement = @import("pricing_rule_list_element.zig").PricingRuleListElement;

pub const ListPricingRulesInput = struct {
    /// The preferred billing period to get the pricing plan.
    billing_period: ?[]const u8 = null,

    /// A `DescribePricingRuleFilter` that specifies the Amazon Resource Name (ARNs)
    /// of pricing rules to retrieve pricing rules information.
    filters: ?ListPricingRulesFilter = null,

    /// The maximum number of pricing rules to retrieve.
    max_results: ?i32 = null,

    /// The pagination token that's used on subsequent call to get pricing rules.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .billing_period = "BillingPeriod",
        .filters = "Filters",
        .max_results = "MaxResults",
        .next_token = "NextToken",
    };
};

pub const ListPricingRulesOutput = struct {
    /// The billing period for which the described pricing rules are applicable.
    billing_period: ?[]const u8 = null,

    /// The pagination token that's used on subsequent calls to get pricing rules.
    next_token: ?[]const u8 = null,

    /// A list containing the described pricing rules.
    pricing_rules: ?[]const PricingRuleListElement = null,

    pub const json_field_names = .{
        .billing_period = "BillingPeriod",
        .next_token = "NextToken",
        .pricing_rules = "PricingRules",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListPricingRulesInput, options: CallOptions) !ListPricingRulesOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListPricingRulesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("billingconductor", "billingconductor", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/list-pricing-rules";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.billing_period) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"BillingPeriod\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.filters) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Filters\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListPricingRulesOutput {
    var result: ListPricingRulesOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ListPricingRulesOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
