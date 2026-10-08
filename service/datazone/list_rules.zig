const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const RuleAction = @import("rule_action.zig").RuleAction;
const RuleType = @import("rule_type.zig").RuleType;
const RuleTargetType = @import("rule_target_type.zig").RuleTargetType;
const RuleSummary = @import("rule_summary.zig").RuleSummary;

pub const ListRulesInput = struct {
    /// The action of the rule.
    action: ?RuleAction = null,

    /// The asset types of the rule.
    asset_types: ?[]const []const u8 = null,

    /// The data product of the rule.
    data_product: ?bool = null,

    /// The ID of the domain in which the rules are to be listed.
    domain_identifier: []const u8,

    /// Specifies whether to include cascading rules in the results.
    include_cascaded: ?bool = null,

    /// The maximum number of rules to return in a single call to `ListRules`. When
    /// the number of rules to be listed is greater than the value of `MaxResults`,
    /// the response contains a `NextToken` value that you can use in a subsequent
    /// call to `ListRules` to list the next set of rules.
    max_results: ?i32 = null,

    /// When the number of rules is greater than the default value for the
    /// `MaxResults` parameter, or if you explicitly specify a value for
    /// `MaxResults` that is less than the number of rules, the response includes a
    /// pagination token named `NextToken`. You can specify this `NextToken` value
    /// in a subsequent call to `ListRules` to list the next set of rules.
    next_token: ?[]const u8 = null,

    /// The IDs of projects in which rules are to be listed.
    project_ids: ?[]const []const u8 = null,

    /// The type of the rule.
    rule_type: ?RuleType = null,

    /// The target ID of the rule.
    target_identifier: []const u8,

    /// The target type of the rule.
    target_type: RuleTargetType,

    pub const json_field_names = .{
        .action = "action",
        .asset_types = "assetTypes",
        .data_product = "dataProduct",
        .domain_identifier = "domainIdentifier",
        .include_cascaded = "includeCascaded",
        .max_results = "maxResults",
        .next_token = "nextToken",
        .project_ids = "projectIds",
        .rule_type = "ruleType",
        .target_identifier = "targetIdentifier",
        .target_type = "targetType",
    };
};

pub const ListRulesOutput = struct {
    /// The results of the `ListRules` action.
    items: ?[]const RuleSummary = null,

    /// When the number of rules is greater than the default value for the
    /// `MaxResults` parameter, or if you explicitly specify a value for
    /// `MaxResults` that is less than the number of rules, the response includes a
    /// pagination token named `NextToken`. You can specify this `NextToken` value
    /// in a subsequent call to `ListRules` to list the next set of rules.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .items = "items",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListRulesInput, options: CallOptions) !ListRulesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "datazone", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListRulesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("datazone", "DataZone", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v2/domains/");
    try path_buf.appendSlice(allocator, input.domain_identifier);
    try path_buf.appendSlice(allocator, "/list-rules/");
    try path_buf.appendSlice(allocator, input.target_type.wireName());
    try path_buf.appendSlice(allocator, "/");
    try path_buf.appendSlice(allocator, input.target_identifier);
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.action) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "ruleAction=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v.wireName());
        query_has_prev = true;
    }
    if (input.asset_types) |v| {
        for (v) |item| {
            if (query_has_prev) try query_buf.appendSlice(allocator, "&");
            try query_buf.appendSlice(allocator, "assetTypes=");
            try aws.url.appendUrlEncoded(allocator, &query_buf, item);
            query_has_prev = true;
        }
    }
    if (input.data_product) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "dataProduct=");
        try query_buf.appendSlice(allocator, if (v) "true" else "false");
        query_has_prev = true;
    }
    if (input.include_cascaded) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "includeCascaded=");
        try query_buf.appendSlice(allocator, if (v) "true" else "false");
        query_has_prev = true;
    }
    if (input.max_results) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "maxResults=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
        query_has_prev = true;
    }
    if (input.next_token) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "nextToken=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.project_ids) |v| {
        for (v) |item| {
            if (query_has_prev) try query_buf.appendSlice(allocator, "&");
            try query_buf.appendSlice(allocator, "projectIds=");
            try aws.url.appendUrlEncoded(allocator, &query_buf, item);
            query_has_prev = true;
        }
    }
    if (input.rule_type) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "ruleType=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v.wireName());
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListRulesOutput {
    const result: ListRulesOutput = try aws.json.parseJsonObject(
        ListRulesOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
