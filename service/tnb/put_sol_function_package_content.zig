const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const PackageContentType = @import("package_content_type.zig").PackageContentType;
const PutSolFunctionPackageContentMetadata = @import("put_sol_function_package_content_metadata.zig").PutSolFunctionPackageContentMetadata;

pub const PutSolFunctionPackageContentInput = struct {
    /// Function package content type.
    content_type: ?PackageContentType = null,

    /// Function package file.
    file: []const u8,

    /// Function package ID.
    vnf_pkg_id: []const u8,

    pub const json_field_names = .{
        .content_type = "contentType",
        .file = "file",
        .vnf_pkg_id = "vnfPkgId",
    };
};

pub const PutSolFunctionPackageContentOutput = struct {
    /// Function package ID.
    id: []const u8,

    /// Function package metadata.
    metadata: ?PutSolFunctionPackageContentMetadata = null,

    /// Function package descriptor ID.
    vnfd_id: []const u8,

    /// Function package descriptor version.
    vnfd_version: []const u8,

    /// Function product name.
    vnf_product_name: []const u8,

    /// Function provider.
    vnf_provider: []const u8,

    pub const json_field_names = .{
        .id = "id",
        .metadata = "metadata",
        .vnfd_id = "vnfdId",
        .vnfd_version = "vnfdVersion",
        .vnf_product_name = "vnfProductName",
        .vnf_provider = "vnfProvider",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutSolFunctionPackageContentInput, options: CallOptions) !PutSolFunctionPackageContentOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: PutSolFunctionPackageContentInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("tnb", "tnb", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/sol/vnfpkgm/v1/vnf_packages/");
    try path_buf.appendSlice(allocator, input.vnf_pkg_id);
    try path_buf.appendSlice(allocator, "/package_content");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PutSolFunctionPackageContentOutput {
    var result: PutSolFunctionPackageContentOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(PutSolFunctionPackageContentOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
