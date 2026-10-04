const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const PackageFormat = @import("package_format.zig").PackageFormat;

pub const GetPackageVersionAssetInput = struct {
    /// The name of the requested asset.
    asset: []const u8,

    /// The name of the domain that contains the repository that contains the
    /// package version with the requested asset.
    domain: []const u8,

    /// The 12-digit account number of the Amazon Web Services account that owns the
    /// domain. It does not include
    /// dashes or spaces.
    domain_owner: ?[]const u8 = null,

    /// A format that specifies the type of the package version with the requested
    /// asset file.
    format: PackageFormat,

    /// The namespace of the package version with the requested asset file. The
    /// package component that specifies its
    /// namespace depends on its type. For example:
    ///
    /// The namespace is required when requesting assets from package versions of
    /// the following formats:
    ///
    /// * Maven
    ///
    /// * Swift
    ///
    /// * generic
    ///
    /// * The namespace of a Maven package version is its `groupId`.
    ///
    /// * The namespace of an npm or Swift package version is its `scope`.
    ///
    /// * The namespace of a generic package is its `namespace`.
    ///
    /// * Python, NuGet, Ruby, and Cargo package versions do not contain a
    ///   corresponding component, package versions
    /// of those formats do not have a namespace.
    namespace: ?[]const u8 = null,

    /// The name of the package that contains the requested asset.
    package: []const u8,

    /// A string that contains the package version (for example, `3.5.2`).
    package_version: []const u8,

    /// The name of the package version revision that contains the requested asset.
    package_version_revision: ?[]const u8 = null,

    /// The repository that contains the package version with the requested asset.
    repository: []const u8,

    pub const json_field_names = .{
        .asset = "asset",
        .domain = "domain",
        .domain_owner = "domainOwner",
        .format = "format",
        .namespace = "namespace",
        .package = "package",
        .package_version = "packageVersion",
        .package_version_revision = "packageVersionRevision",
        .repository = "repository",
    };
};

pub const GetPackageVersionAssetOutput = struct {
    /// The binary file, or asset, that is downloaded.
    asset: ?aws.http.StreamingBody = null,

    /// The name of the asset that is downloaded.
    asset_name: ?[]const u8 = null,

    /// A string that contains the package version (for example, `3.5.2`).
    package_version: ?[]const u8 = null,

    /// The name of the package version revision that contains the downloaded asset.
    package_version_revision: ?[]const u8 = null,

    pub fn deinit(self: *GetPackageVersionAssetOutput) void {
        if (self.asset) |*b| b.deinit();
    }

    pub const json_field_names = .{
        .asset = "asset",
        .asset_name = "assetName",
        .package_version = "packageVersion",
        .package_version_revision = "packageVersionRevision",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetPackageVersionAssetInput, options: CallOptions) !GetPackageVersionAssetOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "codeartifact", client.config.http_client.clock_skew_offset);

    var stream_resp = try client.config.http_client.sendStreamingRequestWithOptions(&request, client.options);

    arena.deinit();

    if (!stream_resp.isSuccess()) {
        defer stream_resp.deinit();
        const error_body = stream_resp.body.readAll(client.allocator, 10 * 1024 * 1024) catch return error.RequestFailed;
        defer client.allocator.free(error_body);
        if (options.diagnostic) |d| {
            d.* = try parseErrorResponse(client.allocator, error_body, stream_resp.status);
        }
        return error.ServiceError;
    }

    const result = try deserializeStreamingResponse(allocator, &stream_resp);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: GetPackageVersionAssetInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("codeartifact", "codeartifact", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/v1/package/version/asset";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "asset=");
    try aws.url.appendUrlEncoded(allocator, &query_buf, input.asset);
    query_has_prev = true;
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
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "package=");
    try aws.url.appendUrlEncoded(allocator, &query_buf, input.package);
    query_has_prev = true;
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "version=");
    try aws.url.appendUrlEncoded(allocator, &query_buf, input.package_version);
    query_has_prev = true;
    if (input.package_version_revision) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "revision=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
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

fn deserializeStreamingResponse(allocator: std.mem.Allocator, stream_resp: *aws.http.StreamingResponse) !GetPackageVersionAssetOutput {
    var result: GetPackageVersionAssetOutput = .{};
    result.asset = stream_resp.body;
    if (stream_resp.headers.get("x-assetname")) |value| {
        result.asset_name = try allocator.dupe(u8, value);
    }
    if (stream_resp.headers.get("x-packageversion")) |value| {
        result.package_version = try allocator.dupe(u8, value);
    }
    if (stream_resp.headers.get("x-packageversionrevision")) |value| {
        result.package_version_revision = try allocator.dupe(u8, value);
    }
    stream_resp.deinitHeaders();

    return result;
}
