const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const DeregisterPackageVersionInput = struct {
    /// An owner account.
    owner_account: ?[]const u8 = null,

    /// A package ID.
    package_id: []const u8,

    /// A package version.
    package_version: []const u8,

    /// A patch version.
    patch_version: []const u8,

    /// If the version was marked latest, the new version to maker as latest.
    updated_latest_patch_version: ?[]const u8 = null,

    pub const json_field_names = .{
        .owner_account = "OwnerAccount",
        .package_id = "PackageId",
        .package_version = "PackageVersion",
        .patch_version = "PatchVersion",
        .updated_latest_patch_version = "UpdatedLatestPatchVersion",
    };
};

pub const DeregisterPackageVersionOutput = struct {
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeregisterPackageVersionInput, options: CallOptions) !DeregisterPackageVersionOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DeregisterPackageVersionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("panorama", "Panorama", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/packages/");
    try path_buf.appendSlice(allocator, input.package_id);
    try path_buf.appendSlice(allocator, "/versions/");
    try path_buf.appendSlice(allocator, input.package_version);
    try path_buf.appendSlice(allocator, "/patch/");
    try path_buf.appendSlice(allocator, input.patch_version);
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.owner_account) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "OwnerAccount=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.updated_latest_patch_version) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "UpdatedLatestPatchVersion=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .DELETE;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeregisterPackageVersionOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: DeregisterPackageVersionOutput = .{};

    return result;
}
