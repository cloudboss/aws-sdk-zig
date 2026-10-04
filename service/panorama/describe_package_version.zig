const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const PackageVersionStatus = @import("package_version_status.zig").PackageVersionStatus;

pub const DescribePackageVersionInput = struct {
    /// The version's owner account.
    owner_account: ?[]const u8 = null,

    /// The version's ID.
    package_id: []const u8,

    /// The version's version.
    package_version: []const u8,

    /// The version's patch version.
    patch_version: ?[]const u8 = null,

    pub const json_field_names = .{
        .owner_account = "OwnerAccount",
        .package_id = "PackageId",
        .package_version = "PackageVersion",
        .patch_version = "PatchVersion",
    };
};

pub const DescribePackageVersionOutput = struct {
    /// Whether the version is the latest available.
    is_latest_patch: ?bool = null,

    /// The account ID of the version's owner.
    owner_account: ?[]const u8 = null,

    /// The ARN of the package.
    package_arn: ?[]const u8 = null,

    /// The version's ID.
    package_id: []const u8,

    /// The version's name.
    package_name: []const u8,

    /// The version's version.
    package_version: []const u8,

    /// The version's patch version.
    patch_version: []const u8,

    /// The version's registered time.
    registered_time: ?i64 = null,

    /// The version's status.
    status: PackageVersionStatus,

    /// The version's status description.
    status_description: ?[]const u8 = null,

    pub const json_field_names = .{
        .is_latest_patch = "IsLatestPatch",
        .owner_account = "OwnerAccount",
        .package_arn = "PackageArn",
        .package_id = "PackageId",
        .package_name = "PackageName",
        .package_version = "PackageVersion",
        .patch_version = "PatchVersion",
        .registered_time = "RegisteredTime",
        .status = "Status",
        .status_description = "StatusDescription",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribePackageVersionInput, options: CallOptions) !DescribePackageVersionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "panorama", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribePackageVersionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("panorama", "Panorama", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/packages/metadata/");
    try path_buf.appendSlice(allocator, input.package_id);
    try path_buf.appendSlice(allocator, "/versions/");
    try path_buf.appendSlice(allocator, input.package_version);
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.owner_account) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "OwnerAccount=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.patch_version) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "PatchVersion=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribePackageVersionOutput {
    var result: DescribePackageVersionOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(DescribePackageVersionOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
