const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const GroupByRule = @import("group_by_rule.zig").GroupByRule;
const FindingScopes = @import("finding_scopes.zig").FindingScopes;
const SortOrder = @import("sort_order.zig").SortOrder;
const GroupByResult = @import("group_by_result.zig").GroupByResult;

pub const GetFindingStatisticsV2Input = struct {
    /// Specifies how security findings should be aggregated and organized in the
    /// statistical analysis.
    /// It can accept up to 5 `groupBy` fields in a single call.
    group_by_rules: []const GroupByRule,

    /// The maximum number of results to be returned.
    max_statistic_results: ?i32 = null,

    /// Limits the results to findings from specific organizational units or from
    /// the delegated administrator's organization.
    /// Only the delegated administrator account can use this parameter. Other
    /// accounts receive an `AccessDeniedException`.
    ///
    /// This parameter is optional. If you omit it, the delegated administrator sees
    /// statistics from all accounts across the entire organization. Other accounts
    /// see only statistics for their own findings.
    ///
    /// You can specify up to 10 entries in `Scopes.AwsOrganizations`. If multiple
    /// entries are specified, the entries are combined using OR logic.
    scopes: ?FindingScopes = null,

    /// Orders the aggregation count in descending or ascending order.
    /// Descending order is the default.
    sort_order: ?SortOrder = null,

    pub const json_field_names = .{
        .group_by_rules = "GroupByRules",
        .max_statistic_results = "MaxStatisticResults",
        .scopes = "Scopes",
        .sort_order = "SortOrder",
    };
};

pub const GetFindingStatisticsV2Output = struct {
    /// Aggregated statistics about security findings based on specified grouping
    /// criteria.
    group_by_results: ?[]const GroupByResult = null,

    pub const json_field_names = .{
        .group_by_results = "GroupByResults",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetFindingStatisticsV2Input, options: CallOptions) !GetFindingStatisticsV2Output {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "securityhub", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetFindingStatisticsV2Input, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("securityhub", "SecurityHub", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/findingsv2/statistics";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"GroupByRules\":");
    try aws.json.writeValue(@TypeOf(input.group_by_rules), input.group_by_rules, allocator, &body_buf);
    has_prev = true;
    if (input.max_statistic_results) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"MaxStatisticResults\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.scopes) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Scopes\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.sort_order) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"SortOrder\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetFindingStatisticsV2Output {
    const result: GetFindingStatisticsV2Output = try aws.json.parseJsonObject(
        GetFindingStatisticsV2Output,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
