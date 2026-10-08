const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const PackageVersionAction = @import("package_version_action.zig").PackageVersionAction;
const PackageVersionArtifact = @import("package_version_artifact.zig").PackageVersionArtifact;

pub const UpdatePackageVersionInput = struct {
    /// The status that the package version should be assigned. For more
    /// information, see [Package version
    /// lifecycle](https://docs.aws.amazon.com/iot/latest/developerguide/preparing-to-use-software-package-catalog.html#package-version-lifecycle).
    action: ?PackageVersionAction = null,

    /// The various components that make up a software package version.
    artifact: ?PackageVersionArtifact = null,

    /// Metadata that can be used to define a package version’s configuration. For
    /// example, the Amazon S3 file location, configuration options that are being
    /// sent to the device or fleet.
    ///
    /// **Note:** Attributes can be updated only when the package version
    /// is in a draft state.
    ///
    /// The combined size of all the attributes on a package version is limited to
    /// 3KB.
    attributes: ?[]const aws.map.StringMapEntry = null,

    /// A unique case-sensitive identifier that you can provide to ensure the
    /// idempotency of the request.
    /// Don't reuse this client token if a new idempotent request is required.
    client_token: ?[]const u8 = null,

    /// The package version description.
    description: ?[]const u8 = null,

    /// The name of the associated software package.
    package_name: []const u8,

    /// The inline job document associated with a software package version used for
    /// a quick job
    /// deployment.
    recipe: ?[]const u8 = null,

    /// The name of the target package version.
    version_name: []const u8,

    pub const json_field_names = .{
        .action = "action",
        .artifact = "artifact",
        .attributes = "attributes",
        .client_token = "clientToken",
        .description = "description",
        .package_name = "packageName",
        .recipe = "recipe",
        .version_name = "versionName",
    };
};

pub const UpdatePackageVersionOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdatePackageVersionInput, options: CallOptions) !UpdatePackageVersionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "iot", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdatePackageVersionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iot", "IoT", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/packages/");
    try path_buf.appendSlice(allocator, input.package_name);
    try path_buf.appendSlice(allocator, "/versions/");
    try path_buf.appendSlice(allocator, input.version_name);
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.client_token) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "clientToken=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.action) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"action\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.artifact) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"artifact\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.attributes) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"attributes\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.recipe) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"recipe\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PATCH;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdatePackageVersionOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: UpdatePackageVersionOutput = .{};

    return result;
}
