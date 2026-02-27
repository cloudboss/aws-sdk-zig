const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
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

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CopyPackageVersionsInput, options: Options) !CopyPackageVersionsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "codeartifact");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(response.body, response.status, client.allocator) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(response.body, response.status, response.headers, allocator);
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: CopyPackageVersionsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("codeartifact", "codeartifact", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const path = "/v1/package/versions/copy";

    var query_buf: std.ArrayList(u8) = .{};
    var query_has_prev = false;
    if (query_has_prev) try query_buf.appendSlice(alloc, "&");
    try query_buf.appendSlice(alloc, "destination-repository=");
    try aws.url.appendUrlEncoded(alloc, &query_buf, input.destination_repository);
    query_has_prev = true;
    if (query_has_prev) try query_buf.appendSlice(alloc, "&");
    try query_buf.appendSlice(alloc, "domain=");
    try aws.url.appendUrlEncoded(alloc, &query_buf, input.domain);
    query_has_prev = true;
    if (input.domain_owner) |v| {
        if (query_has_prev) try query_buf.appendSlice(alloc, "&");
        try query_buf.appendSlice(alloc, "domain-owner=");
        try aws.url.appendUrlEncoded(alloc, &query_buf, v);
        query_has_prev = true;
    }
    if (query_has_prev) try query_buf.appendSlice(alloc, "&");
    try query_buf.appendSlice(alloc, "format=");
    try aws.url.appendUrlEncoded(alloc, &query_buf, @tagName(input.format));
    query_has_prev = true;
    if (input.namespace) |v| {
        if (query_has_prev) try query_buf.appendSlice(alloc, "&");
        try query_buf.appendSlice(alloc, "namespace=");
        try aws.url.appendUrlEncoded(alloc, &query_buf, v);
        query_has_prev = true;
    }
    if (query_has_prev) try query_buf.appendSlice(alloc, "&");
    try query_buf.appendSlice(alloc, "package=");
    try aws.url.appendUrlEncoded(alloc, &query_buf, input.package);
    query_has_prev = true;
    if (query_has_prev) try query_buf.appendSlice(alloc, "&");
    try query_buf.appendSlice(alloc, "source-repository=");
    try aws.url.appendUrlEncoded(alloc, &query_buf, input.source_repository);
    query_has_prev = true;
    const query = try query_buf.toOwnedSlice(alloc);

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(alloc, "{");

    if (input.allow_overwrite) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"allowOverwrite\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.include_from_upstream) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"includeFromUpstream\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.version_revisions) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"versionRevisions\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.versions) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"versions\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(alloc, "}");
    const body = try body_buf.toOwnedSlice(alloc);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    request.query = query;
    try request.headers.put(alloc, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !CopyPackageVersionsOutput {
    var result: CopyPackageVersionsOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CopyPackageVersionsOutput, body, alloc);
    }
    _ = status;
    _ = headers;

    return result;
}

fn parseErrorResponse(body: []const u8, status: u16, alloc: std.mem.Allocator) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(alloc);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "AccessDeniedException")) {
        return .{ .arena = arena, .kind = .{ .access_denied_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ConflictException")) {
        return .{ .arena = arena, .kind = .{ .conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalServerException")) {
        return .{ .arena = arena, .kind = .{ .internal_server_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServiceQuotaExceededException")) {
        return .{ .arena = arena, .kind = .{ .service_quota_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ThrottlingException")) {
        return .{ .arena = arena, .kind = .{ .throttling_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ValidationException")) {
        return .{ .arena = arena, .kind = .{ .validation_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
