const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const PackageFormat = @import("package_format.zig").PackageFormat;
const PackageVersionOriginType = @import("package_version_origin_type.zig").PackageVersionOriginType;
const PackageVersionSortType = @import("package_version_sort_type.zig").PackageVersionSortType;
const PackageVersionStatus = @import("package_version_status.zig").PackageVersionStatus;
const PackageVersionSummary = @import("package_version_summary.zig").PackageVersionSummary;

pub const ListPackageVersionsInput = struct {
    /// The name of the domain that contains the repository that contains the
    /// requested package versions.
    domain: []const u8,

    /// The 12-digit account number of the Amazon Web Services account that owns the
    /// domain. It does not include
    /// dashes or spaces.
    domain_owner: ?[]const u8 = null,

    /// The format of the package versions you want to list.
    format: PackageFormat,

    /// The maximum number of results to return per page.
    max_results: ?i32 = null,

    /// The namespace of the package that contains the requested package versions.
    /// The package component that specifies its
    /// namespace depends on its type. For example:
    ///
    /// The namespace is required when deleting package versions of the following
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

    /// The token for the next set of results. Use the value returned in the
    /// previous response in the next request to retrieve the next set of results.
    next_token: ?[]const u8 = null,

    /// The `originType` used to filter package versions.
    /// Only package versions with the provided `originType` will be returned.
    origin_type: ?PackageVersionOriginType = null,

    /// The name of the package for which you want to request package versions.
    package: []const u8,

    /// The name of the repository that contains the requested package versions.
    repository: []const u8,

    /// How to sort the requested list of package versions.
    sort_by: ?PackageVersionSortType = null,

    /// A string that filters the requested package versions by status.
    status: ?PackageVersionStatus = null,

    pub const json_field_names = .{
        .domain = "domain",
        .domain_owner = "domainOwner",
        .format = "format",
        .max_results = "maxResults",
        .namespace = "namespace",
        .next_token = "nextToken",
        .origin_type = "originType",
        .package = "package",
        .repository = "repository",
        .sort_by = "sortBy",
        .status = "status",
    };
};

pub const ListPackageVersionsOutput = struct {
    /// The default package version to display. This depends on the package format:
    ///
    /// * For Maven and PyPI packages, it's the most recently published package
    ///   version.
    ///
    /// * For npm packages, it's the version referenced by the
    /// `latest` tag. If the `latest` tag is not set, it's the most recently
    /// published package version.
    default_display_version: ?[]const u8 = null,

    /// A format of the package.
    format: ?PackageFormat = null,

    /// The namespace of the package that contains the requested package versions.
    /// The package component that specifies its
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

    /// If there are additional results, this is the token for the next set of
    /// results.
    next_token: ?[]const u8 = null,

    /// The name of the package.
    package: ?[]const u8 = null,

    /// The returned list of
    /// [PackageVersionSummary](https://docs.aws.amazon.com/codeartifact/latest/APIReference/API_PackageVersionSummary.html)
    /// objects.
    versions: ?[]const PackageVersionSummary = null,

    pub const json_field_names = .{
        .default_display_version = "defaultDisplayVersion",
        .format = "format",
        .namespace = "namespace",
        .next_token = "nextToken",
        .package = "package",
        .versions = "versions",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListPackageVersionsInput, options: CallOptions) !ListPackageVersionsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListPackageVersionsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("codeartifact", "codeartifact", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/v1/package/versions";

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
    if (input.max_results) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "max-results=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
        query_has_prev = true;
    }
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
    if (input.origin_type) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "originType=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v.wireName());
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
    if (input.sort_by) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "sortBy=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v.wireName());
        query_has_prev = true;
    }
    if (input.status) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "status=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v.wireName());
        query_has_prev = true;
    }
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListPackageVersionsOutput {
    const result: ListPackageVersionsOutput = try aws.json.parseJsonObject(
        ListPackageVersionsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
