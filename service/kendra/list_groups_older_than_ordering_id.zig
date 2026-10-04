const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const GroupSummary = @import("group_summary.zig").GroupSummary;

pub const ListGroupsOlderThanOrderingIdInput = struct {
    /// The identifier of the data source for getting a list of groups mapped to
    /// users before
    /// a given ordering timestamp identifier.
    data_source_id: ?[]const u8 = null,

    /// The identifier of the index for getting a list of groups mapped to users
    /// before a
    /// given ordering or timestamp identifier.
    index_id: []const u8,

    /// The maximum number of returned groups that are mapped to users before a
    /// given
    /// ordering or timestamp identifier.
    max_results: ?i32 = null,

    /// If the previous response was incomplete (because there is more data to
    /// retrieve),
    /// Amazon Kendra returns a pagination token in the response. You can use this
    /// pagination token to retrieve the next set of groups that are mapped to users
    /// before a
    /// given ordering or timestamp identifier.
    next_token: ?[]const u8 = null,

    /// The timestamp identifier used for the latest `PUT` or `DELETE`
    /// action for mapping users to their groups.
    ordering_id: i64,

    pub const json_field_names = .{
        .data_source_id = "DataSourceId",
        .index_id = "IndexId",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .ordering_id = "OrderingId",
    };
};

pub const ListGroupsOlderThanOrderingIdOutput = struct {
    /// Summary information for list of groups that are mapped to users before a
    /// given
    /// ordering or timestamp identifier.
    groups_summaries: ?[]const GroupSummary = null,

    /// If the response is truncated, Amazon Kendra returns this token that you can
    /// use
    /// in the subsequent request to retrieve the next set of groups that are mapped
    /// to users
    /// before a given ordering or timestamp identifier.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .groups_summaries = "GroupsSummaries",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListGroupsOlderThanOrderingIdInput, options: CallOptions) !ListGroupsOlderThanOrderingIdOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "kendra", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListGroupsOlderThanOrderingIdInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("kendra", "kendra", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSKendraFrontendService.ListGroupsOlderThanOrderingId");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListGroupsOlderThanOrderingIdOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListGroupsOlderThanOrderingIdOutput, body, allocator);
}
