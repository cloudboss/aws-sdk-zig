const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AuthorizedPrincipal = @import("authorized_principal.zig").AuthorizedPrincipal;

pub const ListVpcEndpointAccessInput = struct {
    /// The name of the OpenSearch Service domain to retrieve access information
    /// for.
    domain_name: []const u8,

    /// If your initial `ListVpcEndpointAccess` operation returns a
    /// `nextToken`, you can include the returned `nextToken` in
    /// subsequent `ListVpcEndpointAccess` operations, which returns results in the
    /// next page.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .domain_name = "DomainName",
        .next_token = "NextToken",
    };
};

pub const ListVpcEndpointAccessOutput = struct {
    /// A list of [IAM
    /// principals](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_policies_elements_principal.html) that can currently access the domain.
    authorized_principal_list: ?[]const AuthorizedPrincipal = null,

    /// When `nextToken` is returned, there are more results available. The value
    /// of `nextToken` is a unique pagination token for each page. Send the request
    /// again using the returned token to retrieve the next page.
    next_token: []const u8,

    pub const json_field_names = .{
        .authorized_principal_list = "AuthorizedPrincipalList",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListVpcEndpointAccessInput, options: CallOptions) !ListVpcEndpointAccessOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "es", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListVpcEndpointAccessInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("es", "OpenSearch", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/2021-01-01/opensearch/domain/");
    try path_buf.appendSlice(allocator, input.domain_name);
    try path_buf.appendSlice(allocator, "/listVpcEndpointAccess");
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.next_token) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "nextToken=");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListVpcEndpointAccessOutput {
    var result: ListVpcEndpointAccessOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ListVpcEndpointAccessOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
