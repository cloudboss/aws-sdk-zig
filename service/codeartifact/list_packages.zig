const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const PackageFormat = @import("package_format.zig").PackageFormat;
const AllowPublish = @import("allow_publish.zig").AllowPublish;
const AllowUpstream = @import("allow_upstream.zig").AllowUpstream;
const PackageSummary = @import("package_summary.zig").PackageSummary;

pub const ListPackagesInput = struct {
    /// The name of the domain that contains the repository that contains the
    /// requested packages.
    domain: []const u8,

    /// The 12-digit account number of the Amazon Web Services account that owns the
    /// domain. It does not include
    /// dashes or spaces.
    domain_owner: ?[]const u8 = null,

    /// The format used to filter requested packages. Only packages from the
    /// provided format will be returned.
    format: ?PackageFormat = null,

    /// The maximum number of results to return per page.
    max_results: ?i32 = null,

    /// The namespace prefix used to filter requested packages.
    /// Only packages with a namespace that starts with the provided string value
    /// are returned.
    /// Note that although this option is called `--namespace` and not
    /// `--namespace-prefix`, it has prefix-matching behavior.
    ///
    /// Each package format uses namespace as follows:
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

    /// A prefix used to filter requested packages. Only packages with names that
    /// start with
    /// `packagePrefix` are returned.
    package_prefix: ?[]const u8 = null,

    /// The value of the `Publish` package origin control restriction used to filter
    /// requested packages.
    /// Only packages with the provided restriction are returned.
    /// For more information, see
    /// [PackageOriginRestrictions](https://docs.aws.amazon.com/codeartifact/latest/APIReference/API_PackageOriginRestrictions.html).
    publish: ?AllowPublish = null,

    /// The name of the repository that contains the requested packages.
    repository: []const u8,

    /// The value of the `Upstream` package origin control restriction used to
    /// filter requested packages.
    /// Only packages with the provided restriction are returned. For more
    /// information, see
    /// [PackageOriginRestrictions](https://docs.aws.amazon.com/codeartifact/latest/APIReference/API_PackageOriginRestrictions.html).
    upstream: ?AllowUpstream = null,

    pub const json_field_names = .{
        .domain = "domain",
        .domain_owner = "domainOwner",
        .format = "format",
        .max_results = "maxResults",
        .namespace = "namespace",
        .next_token = "nextToken",
        .package_prefix = "packagePrefix",
        .publish = "publish",
        .repository = "repository",
        .upstream = "upstream",
    };
};

pub const ListPackagesOutput = struct {
    /// If there are additional results, this is the token for the next set of
    /// results.
    next_token: ?[]const u8 = null,

    /// The list of returned
    /// [PackageSummary](https://docs.aws.amazon.com/codeartifact/latest/APIReference/API_PackageSummary.html)
    /// objects.
    packages: ?[]const PackageSummary = null,

    pub const json_field_names = .{
        .next_token = "nextToken",
        .packages = "packages",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListPackagesInput, options: Options) !ListPackagesOutput {
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
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: ListPackagesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("codeartifact", "codeartifact", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const path = "/v1/packages";

    var query_buf: std.ArrayList(u8) = .{};
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
    if (input.format) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "format=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, @tagName(v));
        query_has_prev = true;
    }
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
    if (input.package_prefix) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "package-prefix=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.publish) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "publish=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, @tagName(v));
        query_has_prev = true;
    }
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "repository=");
    try aws.url.appendUrlEncoded(allocator, &query_buf, input.repository);
    query_has_prev = true;
    if (input.upstream) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "upstream=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, @tagName(v));
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListPackagesOutput {
    var result: ListPackagesOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ListPackagesOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
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
