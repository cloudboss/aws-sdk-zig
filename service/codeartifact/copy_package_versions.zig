const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const PackageFormat = @import("package_format.zig").PackageFormat;
const PackageVersionError = @import("package_version_error.zig").PackageVersionError;
const SuccessfulPackageVersionInfo = @import("successful_package_version_info.zig").SuccessfulPackageVersionInfo;

pub const CopyPackageVersionsInput = struct {
    /// Set to true to overwrite a package version that already exists in the
    /// destination repository.
    /// If set to false and the package version already exists in the destination
    /// repository,
    /// the package version is returned in the `failedVersions` field of the
    /// response with
    /// an `ALREADY_EXISTS` error code.
    allow_overwrite: ?bool = null,

    /// The name of the repository into which package versions are copied.
    destination_repository: []const u8,

    /// The name of the domain that contains the source and destination
    /// repositories.
    domain: []const u8,

    /// The 12-digit account number of the Amazon Web Services account that owns the
    /// domain. It does not include
    /// dashes or spaces.
    domain_owner: ?[]const u8 = null,

    /// The format of the package versions to be copied.
    format: PackageFormat,

    /// Set to true to copy packages from repositories that are upstream from the
    /// source
    /// repository to the destination repository. The default setting is false. For
    /// more information,
    /// see [Working with
    /// upstream
    /// repositories](https://docs.aws.amazon.com/codeartifact/latest/ug/repos-upstream.html).
    include_from_upstream: ?bool = null,

    /// The namespace of the package versions to be copied. The package component
    /// that specifies its namespace depends on its type. For example:
    ///
    /// The namespace is required when copying package versions of the following
    /// formats:
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

    /// The name of the package that contains the versions to be copied.
    package: []const u8,

    /// The name of the repository that contains the package versions to be copied.
    source_repository: []const u8,

    /// A list of key-value pairs. The keys are package versions and the values are
    /// package version revisions. A `CopyPackageVersion` operation
    /// succeeds if the specified versions in the source repository match the
    /// specified package version revision.
    ///
    /// You must specify `versions` or `versionRevisions`. You cannot specify both.
    version_revisions: ?[]const aws.map.StringMapEntry = null,

    /// The versions of the package to be copied.
    ///
    /// You must specify `versions` or `versionRevisions`. You cannot specify both.
    versions: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .allow_overwrite = "allowOverwrite",
        .destination_repository = "destinationRepository",
        .domain = "domain",
        .domain_owner = "domainOwner",
        .format = "format",
        .include_from_upstream = "includeFromUpstream",
        .namespace = "namespace",
        .package = "package",
        .source_repository = "sourceRepository",
        .version_revisions = "versionRevisions",
        .versions = "versions",
    };
};

pub const CopyPackageVersionsOutput = struct {
    /// A map of package versions that failed to copy and their error codes. The
    /// possible error codes are in
    /// the `PackageVersionError` data type. They are:
    ///
    /// * `ALREADY_EXISTS`
    ///
    /// * `MISMATCHED_REVISION`
    ///
    /// * `MISMATCHED_STATUS`
    ///
    /// * `NOT_ALLOWED`
    ///
    /// * `NOT_FOUND`
    ///
    /// * `SKIPPED`
    failed_versions: ?[]const aws.map.MapEntry(PackageVersionError) = null,

    /// A list of the package versions that were successfully copied to your
    /// repository.
    successful_versions: ?[]const aws.map.MapEntry(SuccessfulPackageVersionInfo) = null,

    pub const json_field_names = .{
        .failed_versions = "failedVersions",
        .successful_versions = "successfulVersions",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CopyPackageVersionsInput, options: CallOptions) !CopyPackageVersionsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CopyPackageVersionsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("codeartifact", "codeartifact", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/v1/package/versions/copy";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "destination-repository=");
    try aws.url.appendUrlEncoded(allocator, &query_buf, input.destination_repository);
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
    try query_buf.appendSlice(allocator, "source-repository=");
    try aws.url.appendUrlEncoded(allocator, &query_buf, input.source_repository);
    query_has_prev = true;
    const query = try query_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.allow_overwrite) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"allowOverwrite\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.include_from_upstream) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"includeFromUpstream\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.version_revisions) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"versionRevisions\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.versions) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"versions\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CopyPackageVersionsOutput {
    var result: CopyPackageVersionsOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CopyPackageVersionsOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
