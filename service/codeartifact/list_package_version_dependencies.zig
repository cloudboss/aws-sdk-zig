const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const PackageFormat = @import("package_format.zig").PackageFormat;
const PackageDependency = @import("package_dependency.zig").PackageDependency;

pub const ListPackageVersionDependenciesInput = struct {
    /// The name of the domain that contains the repository that contains the
    /// requested package version dependencies.
    domain: []const u8,

    /// The 12-digit account number of the Amazon Web Services account that owns the
    /// domain. It does not include
    /// dashes or spaces.
    domain_owner: ?[]const u8 = null,

    /// The format of the package with the requested dependencies.
    format: PackageFormat,

    /// The namespace of the package version with the requested dependencies. The
    /// package component that specifies its
    /// namespace depends on its type. For example:
    ///
    /// The namespace is required when listing dependencies from package versions of
    /// the following formats:
    ///
    /// * Maven
    ///
    /// * The namespace of a Maven package version is its `groupId`.
    ///
    /// * The namespace of an npm package version is its `scope`.
    ///
    /// * Python and NuGet package versions do not contain a corresponding
    ///   component, package versions
    /// of those formats do not have a namespace.
    namespace: ?[]const u8 = null,

    /// The token for the next set of results. Use the value returned in the
    /// previous response in the next request to retrieve the next set of results.
    next_token: ?[]const u8 = null,

    /// The name of the package versions' package.
    package: []const u8,

    /// A string that contains the package version (for example, `3.5.2`).
    package_version: []const u8,

    /// The name of the repository that contains the requested package version.
    repository: []const u8,

    pub const json_field_names = .{
        .domain = "domain",
        .domain_owner = "domainOwner",
        .format = "format",
        .namespace = "namespace",
        .next_token = "nextToken",
        .package = "package",
        .package_version = "packageVersion",
        .repository = "repository",
    };
};

pub const ListPackageVersionDependenciesOutput = struct {
    /// The returned list of
    /// [PackageDependency](https://docs.aws.amazon.com/codeartifact/latest/APIReference/API_PackageDependency.html) objects.
    dependencies: ?[]const PackageDependency = null,

    /// A format that specifies the type of the package that contains the returned
    /// dependencies.
    format: ?PackageFormat = null,

    /// The namespace of the package version that contains the returned
    /// dependencies. The package component that specifies its
    /// namespace depends on its type. For example:
    ///
    /// The namespace is required when listing dependencies from package versions of
    /// the following formats:
    ///
    /// * Maven
    ///
    /// * The namespace of a Maven package version is its `groupId`.
    ///
    /// * The namespace of an npm package version is its `scope`.
    ///
    /// * Python and NuGet package versions do not contain a corresponding
    ///   component, package versions
    /// of those formats do not have a namespace.
    namespace: ?[]const u8 = null,

    /// The token for the next set of results. Use the value returned in the
    /// previous response in the next request to retrieve the next set of results.
    next_token: ?[]const u8 = null,

    /// The name of the package that contains the returned package versions
    /// dependencies.
    package: ?[]const u8 = null,

    /// The version of the package that is specified in the request.
    version: ?[]const u8 = null,

    /// The current revision associated with the package version.
    version_revision: ?[]const u8 = null,

    pub const json_field_names = .{
        .dependencies = "dependencies",
        .format = "format",
        .namespace = "namespace",
        .next_token = "nextToken",
        .package = "package",
        .version = "version",
        .version_revision = "versionRevision",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListPackageVersionDependenciesInput, options: CallOptions) !ListPackageVersionDependenciesOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListPackageVersionDependenciesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("codeartifact", "codeartifact", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/v1/package/version/dependencies";

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
    try query_buf.appendSlice(allocator, "format=");
    try aws.url.appendUrlEncoded(allocator, &query_buf, input.format.wireName());
    query_has_prev = true;
    if (input.namespace) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "namespace=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.next_token) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "next-token=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "package=");
    try aws.url.appendUrlEncoded(allocator, &query_buf, input.package);
    query_has_prev = true;
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "version=");
    try aws.url.appendUrlEncoded(allocator, &query_buf, input.package_version);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListPackageVersionDependenciesOutput {
    var result: ListPackageVersionDependenciesOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ListPackageVersionDependenciesOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
