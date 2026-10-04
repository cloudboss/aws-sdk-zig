const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const EndpointType = @import("endpoint_type.zig").EndpointType;
const PackageFormat = @import("package_format.zig").PackageFormat;

pub const GetRepositoryEndpointInput = struct {
    /// The name of the domain that contains the repository.
    domain: []const u8,

    /// The 12-digit account number of the Amazon Web Services account that owns the
    /// domain that contains the repository. It does not include
    /// dashes or spaces.
    domain_owner: ?[]const u8 = null,

    /// A string that specifies the type of endpoint.
    endpoint_type: ?EndpointType = null,

    /// Returns which endpoint of a repository to return. A repository has one
    /// endpoint for each
    /// package format.
    format: PackageFormat,

    /// The name of the repository.
    repository: []const u8,

    pub const json_field_names = .{
        .domain = "domain",
        .domain_owner = "domainOwner",
        .endpoint_type = "endpointType",
        .format = "format",
        .repository = "repository",
    };
};

pub const GetRepositoryEndpointOutput = struct {
    /// A string that specifies the URL of the returned endpoint.
    repository_endpoint: ?[]const u8 = null,

    pub const json_field_names = .{
        .repository_endpoint = "repositoryEndpoint",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetRepositoryEndpointInput, options: CallOptions) !GetRepositoryEndpointOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "codeartifact", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetRepositoryEndpointInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("codeartifact", "codeartifact", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/v1/repository/endpoint";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "domain=");
    try aws.url.appendUrlEncoded(allocator, &query_buf, input.domain);
    query_has_prev = true;
    if (input.domain_owner) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "domain-owner=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.endpoint_type) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "endpointType=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v.wireName());
        query_has_prev = true;
    }
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "format=");
    try aws.url.appendUrlEncoded(allocator, &query_buf, input.format.wireName());
    query_has_prev = true;
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "repository=");
    try aws.url.appendUrlEncoded(allocator, &query_buf, input.repository);
    query_has_prev = true;
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetRepositoryEndpointOutput {
    const result: GetRepositoryEndpointOutput = try aws.json.parseJsonObject(
        GetRepositoryEndpointOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
