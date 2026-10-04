const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ResourceCollectionType = @import("resource_collection_type.zig").ResourceCollectionType;
const ResourceCollectionFilter = @import("resource_collection_filter.zig").ResourceCollectionFilter;

pub const GetResourceCollectionInput = struct {
    /// The pagination token to use to retrieve
    /// the next page of results for this operation. If this value is null, it
    /// retrieves the first page.
    next_token: ?[]const u8 = null,

    /// The type of Amazon Web Services resource collections to return. The one
    /// valid value is
    /// `CLOUD_FORMATION` for Amazon Web Services CloudFormation stacks.
    resource_collection_type: ResourceCollectionType,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .resource_collection_type = "ResourceCollectionType",
    };
};

pub const GetResourceCollectionOutput = struct {
    /// The pagination token to use to retrieve
    /// the next page of results for this operation. If there are no more pages,
    /// this value is null.
    next_token: ?[]const u8 = null,

    /// The requested list of Amazon Web Services resource collections.
    /// The two types of Amazon Web Services resource collections supported are
    /// Amazon Web Services CloudFormation stacks and
    /// Amazon Web Services resources that contain the same Amazon Web Services tag.
    /// DevOps Guru can be configured to analyze
    /// the Amazon Web Services resources that are defined in the stacks or that are
    /// tagged using the same tag *key*. You can specify up to 500 Amazon Web
    /// Services CloudFormation stacks.
    resource_collection: ?ResourceCollectionFilter = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .resource_collection = "ResourceCollection",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetResourceCollectionInput, options: CallOptions) !GetResourceCollectionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "devops-guru", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetResourceCollectionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("devops-guru", "DevOps Guru", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/resource-collections/");
    try path_buf.appendSlice(allocator, input.resource_collection_type);
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.next_token) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "NextToken=");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetResourceCollectionOutput {
    var result: GetResourceCollectionOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetResourceCollectionOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
