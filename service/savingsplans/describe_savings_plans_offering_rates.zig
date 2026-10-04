const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SavingsPlanOfferingRateFilterElement = @import("savings_plan_offering_rate_filter_element.zig").SavingsPlanOfferingRateFilterElement;
const SavingsPlanProductType = @import("savings_plan_product_type.zig").SavingsPlanProductType;
const SavingsPlanPaymentOption = @import("savings_plan_payment_option.zig").SavingsPlanPaymentOption;
const SavingsPlanType = @import("savings_plan_type.zig").SavingsPlanType;
const SavingsPlanRateServiceCode = @import("savings_plan_rate_service_code.zig").SavingsPlanRateServiceCode;
const SavingsPlanOfferingRate = @import("savings_plan_offering_rate.zig").SavingsPlanOfferingRate;

pub const DescribeSavingsPlansOfferingRatesInput = struct {
    /// The filters.
    filters: ?[]const SavingsPlanOfferingRateFilterElement = null,

    /// The maximum number of results to return with a single call. To retrieve
    /// additional
    /// results, make another call with the returned token value.
    max_results: ?i32 = null,

    /// The token for the next page of results.
    next_token: ?[]const u8 = null,

    /// The specific Amazon Web Services operation for the line item in the billing
    /// report.
    operations: ?[]const []const u8 = null,

    /// The Amazon Web Services products.
    products: ?[]const SavingsPlanProductType = null,

    /// The IDs of the offerings.
    savings_plan_offering_ids: ?[]const []const u8 = null,

    /// The payment options.
    savings_plan_payment_options: ?[]const SavingsPlanPaymentOption = null,

    /// The plan types.
    savings_plan_types: ?[]const SavingsPlanType = null,

    /// The services.
    service_codes: ?[]const SavingsPlanRateServiceCode = null,

    /// The usage details of the line item in the billing report.
    usage_types: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .filters = "filters",
        .max_results = "maxResults",
        .next_token = "nextToken",
        .operations = "operations",
        .products = "products",
        .savings_plan_offering_ids = "savingsPlanOfferingIds",
        .savings_plan_payment_options = "savingsPlanPaymentOptions",
        .savings_plan_types = "savingsPlanTypes",
        .service_codes = "serviceCodes",
        .usage_types = "usageTypes",
    };
};

pub const DescribeSavingsPlansOfferingRatesOutput = struct {
    /// The token to use to retrieve the next page of results. This value is null
    /// when there are
    /// no more results to return.
    next_token: ?[]const u8 = null,

    /// Information about the Savings Plans offering rates.
    search_results: ?[]const SavingsPlanOfferingRate = null,

    pub const json_field_names = .{
        .next_token = "nextToken",
        .search_results = "searchResults",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeSavingsPlansOfferingRatesInput, options: CallOptions) !DescribeSavingsPlansOfferingRatesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "savingsplans", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeSavingsPlansOfferingRatesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("savingsplans", "savingsplans", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/DescribeSavingsPlansOfferingRates";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.filters) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"filters\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.max_results) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"maxResults\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.next_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"nextToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.operations) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"operations\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.products) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"products\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.savings_plan_offering_ids) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"savingsPlanOfferingIds\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.savings_plan_payment_options) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"savingsPlanPaymentOptions\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.savings_plan_types) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"savingsPlanTypes\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.service_codes) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"serviceCodes\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.usage_types) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"usageTypes\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeSavingsPlansOfferingRatesOutput {
    const result: DescribeSavingsPlansOfferingRatesOutput = try aws.json.parseJsonObject(
        DescribeSavingsPlansOfferingRatesOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
