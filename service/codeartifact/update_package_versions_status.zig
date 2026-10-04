const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const PackageVersionStatus = @import("package_version_status.zig").PackageVersionStatus;
const PackageFormat = @import("package_format.zig").PackageFormat;
const PackageVersionError = @import("package_version_error.zig").PackageVersionError;
const SuccessfulPackageVersionInfo = @import("successful_package_version_info.zig").SuccessfulPackageVersionInfo;

pub const UpdatePackageVersionsStatusInput = struct {
    /// The name of the domain that contains the repository that contains the
    /// package versions with a status to be updated.
    domain: []const u8,

    /// The 12-digit account number of the Amazon Web Services account that owns the
    /// domain. It does not include
    /// dashes or spaces.
    domain_owner: ?[]const u8 = null,

    /// The package version’s expected status before it is updated. If
    /// `expectedStatus` is provided, the package version's status is updated only
    /// if its
    /// status at the time `UpdatePackageVersionsStatus` is called matches
    /// `expectedStatus`.
    expected_status: ?PackageVersionStatus = null,

    /// A format that specifies the type of the package with the statuses to update.
    format: PackageFormat,

    /// The namespace of the package version to be updated. The package component
    /// that specifies its
    /// namespace depends on its type. For example:
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

    /// The name of the package with the version statuses to update.
    package: []const u8,

    /// The repository that contains the package versions with the status you want
    /// to update.
    repository: []const u8,

    /// The status you want to change the package version status to.
    target_status: PackageVersionStatus,

    /// A map of package versions and package version revisions. The map `key` is
    /// the
    /// package version (for example, `3.5.2`), and the map `value` is the
    /// package version revision.
    version_revisions: ?[]const aws.map.StringMapEntry = null,

    /// An array of strings that specify the versions of the package with the
    /// statuses to update.
    versions: []const []const u8,

    pub const json_field_names = .{
        .domain = "domain",
        .domain_owner = "domainOwner",
        .expected_status = "expectedStatus",
        .format = "format",
        .namespace = "namespace",
        .package = "package",
        .repository = "repository",
        .target_status = "targetStatus",
        .version_revisions = "versionRevisions",
        .versions = "versions",
    };
};

pub const UpdatePackageVersionsStatusOutput = struct {
    /// A list of `SuccessfulPackageVersionInfo` objects, one for each package
    /// version
    /// with a status that successfully updated.
    failed_versions: ?[]const aws.map.MapEntry(PackageVersionError) = null,

    /// A list of `PackageVersionError` objects, one for each package version with
    /// a status that failed to update.
    successful_versions: ?[]const aws.map.MapEntry(SuccessfulPackageVersionInfo) = null,

    pub const json_field_names = .{
        .failed_versions = "failedVersions",
        .successful_versions = "successfulVersions",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdatePackageVersionsStatusInput, options: CallOptions) !UpdatePackageVersionsStatusOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdatePackageVersionsStatusInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("codeartifact", "codeartifact", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/v1/package/versions/update_status";

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
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "package=");
    try aws.url.appendUrlEncoded(allocator, &query_buf, input.package);
    query_has_prev = true;
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "repository=");
    try aws.url.appendUrlEncoded(allocator, &query_buf, input.repository);
    query_has_prev = true;
    const query = try query_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.expected_status) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"expectedStatus\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"targetStatus\":");
    try aws.json.writeValue(@TypeOf(input.target_status), input.target_status, allocator, &body_buf);
    has_prev = true;
    if (input.version_revisions) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"versionRevisions\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"versions\":");
    try aws.json.writeValue(@TypeOf(input.versions), input.versions, allocator, &body_buf);
    has_prev = true;

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdatePackageVersionsStatusOutput {
    const result: UpdatePackageVersionsStatusOutput = try aws.json.parseJsonObject(
        UpdatePackageVersionsStatusOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
