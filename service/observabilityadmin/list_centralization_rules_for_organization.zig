const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CentralizationRuleSummary = @import("centralization_rule_summary.zig").CentralizationRuleSummary;

pub const ListCentralizationRulesForOrganizationInput = struct {
    /// A flag determining whether to return organization centralization rules from
    /// all regions or only the current region.
    all_regions: ?bool = null,

    /// The maximum number of organization centralization rules to return in a
    /// single call.
    max_results: ?i32 = null,

    /// The token for the next set of results. A previous call generates this token.
    next_token: ?[]const u8 = null,

    /// A string to filter organization centralization rules whose names begin with
    /// the specified prefix.
    rule_name_prefix: ?[]const u8 = null,

    pub const json_field_names = .{
        .all_regions = "AllRegions",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .rule_name_prefix = "RuleNamePrefix",
    };
};

pub const ListCentralizationRulesForOrganizationOutput = struct {
    /// A list of centralization rule summaries.
    centralization_rule_summaries: ?[]const CentralizationRuleSummary = null,

    /// A token to resume pagination of results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .centralization_rule_summaries = "CentralizationRuleSummaries",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListCentralizationRulesForOrganizationInput, options: CallOptions) !ListCentralizationRulesForOrganizationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListCentralizationRulesForOrganizationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("observabilityadmin", "ObservabilityAdmin", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/ListCentralizationRulesForOrganization";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.all_regions) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"AllRegions\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListCentralizationRulesForOrganizationOutput {
    const result: ListCentralizationRulesForOrganizationOutput = try aws.json.parseJsonObject(
        ListCentralizationRulesForOrganizationOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
