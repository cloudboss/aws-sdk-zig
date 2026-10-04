const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const PackageContentType = @import("package_content_type.zig").PackageContentType;
const PutSolNetworkPackageContentMetadata = @import("put_sol_network_package_content_metadata.zig").PutSolNetworkPackageContentMetadata;

pub const PutSolNetworkPackageContentInput = struct {
    /// Network package content type.
    content_type: ?PackageContentType = null,

    /// Network package file.
    file: []const u8,

    /// Network service descriptor info ID.
    nsd_info_id: []const u8,

    pub const json_field_names = .{
        .content_type = "contentType",
        .file = "file",
        .nsd_info_id = "nsdInfoId",
    };
};

pub const PutSolNetworkPackageContentOutput = struct {
    /// Network package ARN.
    arn: []const u8,

    /// Network package ID.
    id: []const u8,

    /// Network package metadata.
    metadata: ?PutSolNetworkPackageContentMetadata = null,

    /// Network service descriptor ID.
    nsd_id: []const u8,

    /// Network service descriptor name.
    nsd_name: []const u8,

    /// Network service descriptor version.
    nsd_version: []const u8,

    /// Function package IDs.
    vnf_pkg_ids: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .arn = "arn",
        .id = "id",
        .metadata = "metadata",
        .nsd_id = "nsdId",
        .nsd_name = "nsdName",
        .nsd_version = "nsdVersion",
        .vnf_pkg_ids = "vnfPkgIds",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutSolNetworkPackageContentInput, options: CallOptions) !PutSolNetworkPackageContentOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "tnb", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: PutSolNetworkPackageContentInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("tnb", "tnb", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/sol/nsd/v1/ns_descriptors/");
    try path_buf.appendSlice(allocator, input.nsd_info_id);
    try path_buf.appendSlice(allocator, "/nsd_content");
    const path = try path_buf.toOwnedSlice(allocator);

    const body = input.file;

    var request = aws.http.Request.init(ep.host);
    request.method = .PUT;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");
    if (input.content_type) |v| {
        try request.headers.put(allocator, "Content-Type", v.wireName());
    }

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PutSolNetworkPackageContentOutput {
    const result: PutSolNetworkPackageContentOutput = try aws.json.parseJsonObject(
        PutSolNetworkPackageContentOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
