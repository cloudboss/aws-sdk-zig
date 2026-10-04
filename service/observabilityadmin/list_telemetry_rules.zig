const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const TelemetryRuleSummary = @import("telemetry_rule_summary.zig").TelemetryRuleSummary;

pub const ListTelemetryRulesInput = struct {
    /// The maximum number of telemetry rules to return in a single call.
    max_results: ?i32 = null,

    /// The token for the next set of results. A previous call generates this token.
    next_token: ?[]const u8 = null,

    /// A string to filter telemetry rules whose names begin with the specified
    /// prefix.
    rule_name_prefix: ?[]const u8 = null,

    pub const json_field_names = .{
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .rule_name_prefix = "RuleNamePrefix",
    };
};

pub const ListTelemetryRulesOutput = struct {
    /// A token to resume pagination of results.
    next_token: ?[]const u8 = null,

    /// A list of telemetry rule summaries.
    telemetry_rule_summaries: ?[]const TelemetryRuleSummary = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .telemetry_rule_summaries = "TelemetryRuleSummaries",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListTelemetryRulesInput, options: CallOptions) !ListTelemetryRulesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "observabilityadmin", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListTelemetryRulesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("observabilityadmin", "ObservabilityAdmin", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/ListTelemetryRules";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

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
    if (input.rule_name_prefix) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"RuleNamePrefix\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListTelemetryRulesOutput {
    var result: ListTelemetryRulesOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ListTelemetryRulesOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
