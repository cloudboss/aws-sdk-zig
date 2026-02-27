const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const PackageContentType = @import("package_content_type.zig").PackageContentType;
const ValidateSolFunctionPackageContentMetadata = @import("validate_sol_function_package_content_metadata.zig").ValidateSolFunctionPackageContentMetadata;

pub const ValidateSolFunctionPackageContentInput = struct {
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

pub const ValidateSolFunctionPackageContentOutput = struct {
    /// Function package ID.
    id: []const u8,

    /// Function package metadata.
    metadata: ?ValidateSolFunctionPackageContentMetadata = null,

    /// Function package descriptor ID.
    vnfd_id: []const u8,

    /// Function package descriptor version.
    vnfd_version: []const u8,

    /// Network function product name.
    vnf_product_name: []const u8,

    /// Network function provider.
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

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ValidateSolFunctionPackageContentInput, options: Options) !ValidateSolFunctionPackageContentOutput {
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
            d.* = parseErrorResponse(response.body, response.status, client.allocator) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(response.body, response.status, response.headers, allocator);
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: ValidateSolFunctionPackageContentInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("tnb", "tnb", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(alloc, "/sol/vnfpkgm/v1/vnf_packages/");
    try path_buf.appendSlice(alloc, input.vnf_pkg_id);
    try path_buf.appendSlice(alloc, "/package_content/validate");
    const path = try path_buf.toOwnedSlice(alloc);

    const body = input.file;

    var request = aws.http.Request.init(host);
    request.method = .PUT;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/json");
    if (input.content_type) |v| {
        try request.headers.put(alloc, "Content-Type", @tagName(v));
    }

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !ValidateSolFunctionPackageContentOutput {
    var result: ValidateSolFunctionPackageContentOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ValidateSolFunctionPackageContentOutput, body, alloc);
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
