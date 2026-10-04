const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const RepositoryDescription = @import("repository_description.zig").RepositoryDescription;

pub const AssociateExternalConnectionInput = struct {
    /// The name of the domain that contains the repository.
    domain: []const u8,

    /// The 12-digit account number of the Amazon Web Services account that owns the
    /// domain. It does not include
    /// dashes or spaces.
    domain_owner: ?[]const u8 = null,

    /// The name of the external connection to add to the repository. The following
    /// values are supported:
    ///
    /// * `public:npmjs` - for the npm public repository.
    ///
    /// * `public:nuget-org` - for the NuGet Gallery.
    ///
    /// * `public:pypi` - for the Python Package Index.
    ///
    /// * `public:maven-central` - for Maven Central.
    ///
    /// * `public:maven-googleandroid` - for the Google Android repository.
    ///
    /// * `public:maven-gradleplugins` - for the Gradle plugins repository.
    ///
    /// * `public:maven-commonsware` - for the CommonsWare Android repository.
    ///
    /// * `public:maven-clojars` - for the Clojars repository.
    ///
    /// * `public:ruby-gems-org` - for RubyGems.org.
    ///
    /// * `public:crates-io` - for Crates.io.
    external_connection: []const u8,

    /// The name of the repository to which the external connection is added.
    repository: []const u8,

    pub const json_field_names = .{
        .domain = "domain",
        .domain_owner = "domainOwner",
        .external_connection = "externalConnection",
        .repository = "repository",
    };
};

pub const AssociateExternalConnectionOutput = struct {
    /// Information about the connected repository after processing the request.
    repository: ?RepositoryDescription = null,

    pub const json_field_names = .{
        .repository = "repository",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: AssociateExternalConnectionInput, options: CallOptions) !AssociateExternalConnectionOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: AssociateExternalConnectionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("codeartifact", "codeartifact", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/v1/repository/external-connection";

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
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "external-connection=");
    try aws.url.appendUrlEncoded(allocator, &query_buf, input.external_connection);
    query_has_prev = true;
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "repository=");
    try aws.url.appendUrlEncoded(allocator, &query_buf, input.repository);
    query_has_prev = true;
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !AssociateExternalConnectionOutput {
    var result: AssociateExternalConnectionOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(AssociateExternalConnectionOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
