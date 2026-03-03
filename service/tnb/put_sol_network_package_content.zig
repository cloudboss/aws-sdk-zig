const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
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

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "tnb");

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

fn serializeRequest(allocator: std.mem.Allocator, input: PutSolNetworkPackageContentInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("tnb", "tnb", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/sol/nsd/v1/ns_descriptors/");
    try path_buf.appendSlice(allocator, input.nsd_info_id);
    try path_buf.appendSlice(allocator, "/nsd_content");
    const path = try path_buf.toOwnedSlice(allocator);

    const body = input.file;

    var request = aws.http.Request.init(host);
    request.method = .PUT;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");
    if (input.content_type) |v| {
        try request.headers.put(allocator, "Content-Type", v.wireName());
    }

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PutSolNetworkPackageContentOutput {
    var result: PutSolNetworkPackageContentOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(PutSolNetworkPackageContentOutput, body, allocator);
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
