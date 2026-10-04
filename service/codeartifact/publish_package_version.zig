const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const PackageFormat = @import("package_format.zig").PackageFormat;
const AssetSummary = @import("asset_summary.zig").AssetSummary;
const PackageVersionStatus = @import("package_version_status.zig").PackageVersionStatus;

pub const PublishPackageVersionInput = struct {
    /// The content of the asset to publish.
    asset_content: []const u8,

    /// The name of the asset to publish. Asset names can include Unicode letters
    /// and numbers, and
    /// the following special characters: `~ ! @ ^ & ( ) - ` _ + [ ] { } ; , .
    /// ``
    asset_name: []const u8,

    /// The SHA256 hash of the `assetContent` to publish. This value must be
    /// calculated
    /// by the caller and provided with the request (see [Publishing a generic
    /// package](https://docs.aws.amazon.com/codeartifact/latest/ug/using-generic.html#publishing-generic-packages) in the *CodeArtifact User
    /// Guide*).
    ///
    /// This value is used as an integrity check to verify that the `assetContent`
    /// has
    /// not changed after it was originally sent.
    asset_sha256: []const u8,

    /// The name of the domain that contains the repository that contains the
    /// package version to publish.
    domain: []const u8,

    /// The 12-digit account number of the AWS account that owns the domain. It does
    /// not include dashes or spaces.
    domain_owner: ?[]const u8 = null,

    /// A format that specifies the type of the package version with the requested
    /// asset file.
    ///
    /// The only supported value is `generic`.
    format: PackageFormat,

    /// The namespace of the package version to publish.
    namespace: ?[]const u8 = null,

    /// The name of the package version to publish.
    package: []const u8,

    /// The package version to publish (for example, `3.5.2`).
    package_version: []const u8,

    /// The name of the repository that the package version will be published to.
    repository: []const u8,

    /// Specifies whether the package version should remain in the `unfinished`
    /// state. If omitted, the package version status will be set to `Published`
    /// (see
    /// [Package version
    /// status](https://docs.aws.amazon.com/codeartifact/latest/ug/packages-overview.html#package-version-status) in the *CodeArtifact User Guide*).
    ///
    /// Valid values: `unfinished`
    unfinished: ?bool = null,

    pub const json_field_names = .{
        .asset_content = "assetContent",
        .asset_name = "assetName",
        .asset_sha256 = "assetSHA256",
        .domain = "domain",
        .domain_owner = "domainOwner",
        .format = "format",
        .namespace = "namespace",
        .package = "package",
        .package_version = "packageVersion",
        .repository = "repository",
        .unfinished = "unfinished",
    };
};

pub const PublishPackageVersionOutput = struct {
    /// An
    /// [AssetSummary](https://docs.aws.amazon.com/codeartifact/latest/APIReference/API_AssetSummary.html) for the published asset.
    asset: ?AssetSummary = null,

    /// The format of the package version.
    format: ?PackageFormat = null,

    /// The namespace of the package version.
    namespace: ?[]const u8 = null,

    /// The name of the package.
    package: ?[]const u8 = null,

    /// A string that contains the status of the package version. For more
    /// information, see [Package version
    /// status](https://docs.aws.amazon.com/codeartifact/latest/ug/packages-overview.html#package-version-status.html#package-version-status) in the *CodeArtifact User Guide*.
    status: ?PackageVersionStatus = null,

    /// The version of the package.
    version: ?[]const u8 = null,

    /// The revision of the package version.
    version_revision: ?[]const u8 = null,

    pub const json_field_names = .{
        .asset = "asset",
        .format = "format",
        .namespace = "namespace",
        .package = "package",
        .status = "status",
        .version = "version",
        .version_revision = "versionRevision",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PublishPackageVersionInput, options: CallOptions) !PublishPackageVersionOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: PublishPackageVersionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("codeartifact", "codeartifact", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/v1/package/version/publish";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "asset=");
    try aws.url.appendUrlEncoded(allocator, &query_buf, input.asset_name);
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
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "repository=");
    try aws.url.appendUrlEncoded(allocator, &query_buf, input.repository);
    query_has_prev = true;
    if (input.unfinished) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "unfinished=");
        try query_buf.appendSlice(allocator, if (v) "true" else "false");
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(allocator);

    const body = input.asset_content;

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");
    try request.headers.put(allocator, "x-amz-content-sha256", input.asset_sha256);

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PublishPackageVersionOutput {
    var result: PublishPackageVersionOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(PublishPackageVersionOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
