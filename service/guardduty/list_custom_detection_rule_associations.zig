const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AssociationMode = @import("association_mode.zig").AssociationMode;
const AssociationSummary = @import("association_summary.zig").AssociationSummary;

pub const ListCustomDetectionRuleAssociationsInput = struct {
    /// The maximum number of results to return in a single page. Minimum value of
    /// 1, maximum value of 100.
    max_results: ?i32 = null,

    /// The rule execution mode to filter associations by.
    mode: ?AssociationMode = null,

    /// A pagination token from a previous response. Use this token to retrieve the
    /// next page of results.
    next_token: ?[]const u8 = null,

    /// The unique identifier for the custom detection rule to filter associations
    /// by.
    rule_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .max_results = "MaxResults",
        .mode = "Mode",
        .next_token = "NextToken",
        .rule_id = "RuleId",
    };
};

pub const ListCustomDetectionRuleAssociationsOutput = struct {
    /// A pagination token to retrieve the next page of results. If this field is
    /// empty, there are no additional results.
    next_token: ?[]const u8 = null,

    /// A list of custom detection rule association summaries.
    rule_associations: ?[]const AssociationSummary = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .rule_associations = "RuleAssociations",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListCustomDetectionRuleAssociationsInput, options: CallOptions) !ListCustomDetectionRuleAssociationsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "guardduty", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListCustomDetectionRuleAssociationsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("guardduty", "GuardDuty", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/custom-detection-rule/association";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.max_results) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "maxResults=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
        query_has_prev = true;
    }
    if (input.mode) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "mode=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v.wireName());
        query_has_prev = true;
    }
    if (input.next_token) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "nextToken=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.rule_id) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "ruleId=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListCustomDetectionRuleAssociationsOutput {
    const result: ListCustomDetectionRuleAssociationsOutput = try aws.json.parseJsonObject(
        ListCustomDetectionRuleAssociationsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
