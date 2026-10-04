const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const BillingPeriodRange = @import("billing_period_range.zig").BillingPeriodRange;
const GroupByAttributeName = @import("group_by_attribute_name.zig").GroupByAttributeName;
const BillingGroupCostReportResultElement = @import("billing_group_cost_report_result_element.zig").BillingGroupCostReportResultElement;

pub const GetBillingGroupCostReportInput = struct {
    /// The Amazon Resource Number (ARN) that uniquely identifies the billing group.
    arn: []const u8,

    /// A time range for which the margin summary is effective. You can specify up
    /// to 12 months.
    billing_period_range: ?BillingPeriodRange = null,

    /// A list of strings that specify the attributes that are used to break down
    /// costs in the margin summary reports for the billing group. For example, you
    /// can view your costs by the Amazon Web Services service name or the billing
    /// period.
    group_by: ?[]const GroupByAttributeName = null,

    /// The maximum number of margin summary reports to retrieve.
    max_results: ?i32 = null,

    /// The pagination token used on subsequent calls to get reports.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .billing_period_range = "BillingPeriodRange",
        .group_by = "GroupBy",
        .max_results = "MaxResults",
        .next_token = "NextToken",
    };
};

pub const GetBillingGroupCostReportOutput = struct {
    /// The list of margin summary reports.
    billing_group_cost_report_results: ?[]const BillingGroupCostReportResultElement = null,

    /// The pagination token used on subsequent calls to get reports.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .billing_group_cost_report_results = "BillingGroupCostReportResults",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetBillingGroupCostReportInput, options: CallOptions) !GetBillingGroupCostReportOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetBillingGroupCostReportInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("billingconductor", "billingconductor", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/get-billing-group-cost-report";

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
    if (input.group_by) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"GroupBy\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetBillingGroupCostReportOutput {
    const result: GetBillingGroupCostReportOutput = try aws.json.parseJsonObject(
        GetBillingGroupCostReportOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
