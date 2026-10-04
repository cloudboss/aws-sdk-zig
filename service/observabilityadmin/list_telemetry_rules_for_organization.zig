const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const TelemetryRuleSummary = @import("telemetry_rule_summary.zig").TelemetryRuleSummary;

pub const ListTelemetryRulesForOrganizationInput = struct {
    /// The maximum number of organization telemetry rules to return in a single
    /// call.
    max_results: ?i32 = null,

    /// The token for the next set of results. A previous call generates this token.
    next_token: ?[]const u8 = null,

    /// A string to filter organization telemetry rules whose names begin with the
    /// specified prefix.
    rule_name_prefix: ?[]const u8 = null,

    /// The list of account IDs to filter organization telemetry rules by their
    /// source accounts.
    source_account_ids: ?[]const []const u8 = null,

    /// The list of organizational unit IDs to filter organization telemetry rules
    /// by their source organizational units.
    source_organization_unit_ids: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .rule_name_prefix = "RuleNamePrefix",
        .source_account_ids = "SourceAccountIds",
        .source_organization_unit_ids = "SourceOrganizationUnitIds",
    };
};

pub const ListTelemetryRulesForOrganizationOutput = struct {
    /// A token to resume pagination of results.
    next_token: ?[]const u8 = null,

    /// A list of organization telemetry rule summaries.
    telemetry_rule_summaries: ?[]const TelemetryRuleSummary = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .telemetry_rule_summaries = "TelemetryRuleSummaries",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListTelemetryRulesForOrganizationInput, options: CallOptions) !ListTelemetryRulesForOrganizationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListTelemetryRulesForOrganizationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("observabilityadmin", "ObservabilityAdmin", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/ListTelemetryRulesForOrganization";

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
    if (input.source_account_ids) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"SourceAccountIds\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.source_organization_unit_ids) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"SourceOrganizationUnitIds\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListTelemetryRulesForOrganizationOutput {
    var result: ListTelemetryRulesForOrganizationOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ListTelemetryRulesForOrganizationOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
