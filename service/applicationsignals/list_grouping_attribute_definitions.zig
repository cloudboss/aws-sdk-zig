const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const GroupingAttributeDefinition = @import("grouping_attribute_definition.zig").GroupingAttributeDefinition;

pub const ListGroupingAttributeDefinitionsInput = struct {
    /// The Amazon Web Services account ID to retrieve grouping attribute
    /// definitions for. Use this when accessing grouping configurations from a
    /// different account in cross-account monitoring scenarios.
    aws_account_id: ?[]const u8 = null,

    /// If you are using this operation in a monitoring account, specify `true` to
    /// include grouping attributes from source accounts in the returned data.
    include_linked_accounts: ?bool = null,

    /// Include this value, if it was returned by the previous operation, to get the
    /// next set of grouping attribute definitions.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .aws_account_id = "AwsAccountId",
        .include_linked_accounts = "IncludeLinkedAccounts",
        .next_token = "NextToken",
    };
};

pub const ListGroupingAttributeDefinitionsOutput = struct {
    /// An array of structures, where each structure contains information about one
    /// grouping attribute definition, including the grouping name, source keys, and
    /// default values.
    grouping_attribute_definitions: ?[]const GroupingAttributeDefinition = null,

    /// Include this value in your next use of this API to get the next set of
    /// grouping attribute definitions.
    next_token: ?[]const u8 = null,

    /// The timestamp when the grouping configuration was last updated. When used in
    /// a raw HTTP Query API, it is formatted as epoch time in seconds.
    updated_at: ?i64 = null,

    pub const json_field_names = .{
        .grouping_attribute_definitions = "GroupingAttributeDefinitions",
        .next_token = "NextToken",
        .updated_at = "UpdatedAt",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListGroupingAttributeDefinitionsInput, options: CallOptions) !ListGroupingAttributeDefinitionsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "application-signals", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListGroupingAttributeDefinitionsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("application-signals", "Application Signals", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/grouping-attribute-definitions";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.aws_account_id) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "AwsAccountId=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.include_linked_accounts) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "IncludeLinkedAccounts=");
        try query_buf.appendSlice(allocator, if (v) "true" else "false");
        query_has_prev = true;
    }
    if (input.next_token) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "NextToken=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListGroupingAttributeDefinitionsOutput {
    const result: ListGroupingAttributeDefinitionsOutput = try aws.json.parseJsonObject(
        ListGroupingAttributeDefinitionsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
