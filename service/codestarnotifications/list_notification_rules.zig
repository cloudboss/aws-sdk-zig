const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ListNotificationRulesFilter = @import("list_notification_rules_filter.zig").ListNotificationRulesFilter;
const NotificationRuleSummary = @import("notification_rule_summary.zig").NotificationRuleSummary;

pub const ListNotificationRulesInput = struct {
    /// The filters to use to return information by service or resource type. For
    /// valid values,
    /// see ListNotificationRulesFilter.
    ///
    /// A filter with the same name can appear more than once when used with OR
    /// statements. Filters with different names should be applied with AND
    /// statements.
    filters: ?[]const ListNotificationRulesFilter = null,

    /// A non-negative integer used to limit the number of returned results. The
    /// maximum number of
    /// results that can be returned is 100.
    max_results: ?i32 = null,

    /// An enumeration token that, when provided in a request, returns the next
    /// batch of the
    /// results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .filters = "Filters",
        .max_results = "MaxResults",
        .next_token = "NextToken",
    };
};

pub const ListNotificationRulesOutput = struct {
    /// An enumeration token that can be used in a request to return the next batch
    /// of the results.
    next_token: ?[]const u8 = null,

    /// The list of notification rules for the Amazon Web Services account, by
    /// Amazon Resource Name (ARN) and ID.
    notification_rules: ?[]const NotificationRuleSummary = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .notification_rules = "NotificationRules",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListNotificationRulesInput, options: CallOptions) !ListNotificationRulesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "codestar-notifications", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListNotificationRulesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("codestar-notifications", "codestar notifications", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/listNotificationRules";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListNotificationRulesOutput {
    var result: ListNotificationRulesOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ListNotificationRulesOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
