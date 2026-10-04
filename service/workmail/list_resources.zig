const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ListResourcesFilters = @import("list_resources_filters.zig").ListResourcesFilters;
const Resource = @import("resource.zig").Resource;

pub const ListResourcesInput = struct {
    /// Limit the resource search results based on the filter criteria. You can only
    /// use one filter per request.
    filters: ?ListResourcesFilters = null,

    /// The maximum number of results to return in a single call.
    max_results: ?i32 = null,

    /// The token to use to retrieve the next page of results. The first call does
    /// not
    /// contain any tokens.
    next_token: ?[]const u8 = null,

    /// The identifier for the organization under which the resources exist.
    organization_id: []const u8,

    pub const json_field_names = .{
        .filters = "Filters",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .organization_id = "OrganizationId",
    };
};

pub const ListResourcesOutput = struct {
    /// The token used to paginate through all the organization's resources. While
    /// results
    /// are still available, it has an associated value. When the last page is
    /// reached, the token
    /// is empty.
    next_token: ?[]const u8 = null,

    /// One page of the organization's resource representation.
    resources: ?[]const Resource = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .resources = "Resources",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListResourcesInput, options: CallOptions) !ListResourcesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "workmail", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListResourcesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("workmail", "WorkMail", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "WorkMailService.ListResources");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListResourcesOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListResourcesOutput, body, allocator);
}
