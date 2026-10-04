const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Delegate = @import("delegate.zig").Delegate;

pub const ListResourceDelegatesInput = struct {
    /// The number of maximum results in a page.
    max_results: ?i32 = null,

    /// The token used to paginate through the delegates associated with a
    /// resource.
    next_token: ?[]const u8 = null,

    /// The identifier for the organization that contains the resource for which
    /// delegates
    /// are listed.
    organization_id: []const u8,

    /// The identifier for the resource whose delegates are listed.
    ///
    /// The identifier can accept *ResourceId*, *Resourcename*, or *email*. The
    /// following identity formats are available:
    ///
    /// * Resource ID: r-0123456789a0123456789b0123456789
    ///
    /// * Email address: resource@domain.tld
    ///
    /// * Resource name: resource
    resource_id: []const u8,

    pub const json_field_names = .{
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .organization_id = "OrganizationId",
        .resource_id = "ResourceId",
    };
};

pub const ListResourceDelegatesOutput = struct {
    /// One page of the resource's delegates.
    delegates: ?[]const Delegate = null,

    /// The token used to paginate through the delegates associated with a resource.
    /// While
    /// results are still available, it has an associated value. When the last page
    /// is reached, the
    /// token is empty.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .delegates = "Delegates",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListResourceDelegatesInput, options: CallOptions) !ListResourceDelegatesOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListResourceDelegatesInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "WorkMailService.ListResourceDelegates");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListResourceDelegatesOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListResourceDelegatesOutput, body, allocator);
}
