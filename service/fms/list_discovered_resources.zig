const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DiscoveredResource = @import("discovered_resource.zig").DiscoveredResource;

pub const ListDiscoveredResourcesInput = struct {
    /// The maximum number of objects that you want Firewall Manager to return for
    /// this request. If more
    /// objects are available, in the response, Firewall Manager provides a
    /// `NextToken` value that you can use in a subsequent call to get the next
    /// batch of objects.
    max_results: ?i32 = null,

    /// The Amazon Web Services account IDs to discover resources in. Only one
    /// account is supported per request. The account must be a member of your
    /// organization.
    member_account_ids: []const []const u8,

    /// When you request a list of objects with a `MaxResults` setting, if the
    /// number of objects that are still available
    /// for retrieval exceeds the maximum you requested, Firewall Manager returns a
    /// `NextToken`
    /// value in the response. To retrieve the next batch of objects, use the token
    /// returned from the prior request in your next request.
    next_token: ?[]const u8 = null,

    /// The type of resources to discover.
    resource_type: []const u8,

    pub const json_field_names = .{
        .max_results = "MaxResults",
        .member_account_ids = "MemberAccountIds",
        .next_token = "NextToken",
        .resource_type = "ResourceType",
    };
};

pub const ListDiscoveredResourcesOutput = struct {
    /// Details of the resources that were discovered.
    items: ?[]const DiscoveredResource = null,

    /// When you request a list of objects with a `MaxResults` setting, if the
    /// number of objects that are still available
    /// for retrieval exceeds the maximum you requested, Firewall Manager returns a
    /// `NextToken`
    /// value in the response. To retrieve the next batch of objects, use the token
    /// returned from the prior request in your next request.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .items = "Items",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListDiscoveredResourcesInput, options: CallOptions) !ListDiscoveredResourcesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "fms", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListDiscoveredResourcesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("fms", "FMS", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSFMS_20180101.ListDiscoveredResources");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListDiscoveredResourcesOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListDiscoveredResourcesOutput, body, allocator);
}
