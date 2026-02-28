const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const CopyImageSetInformation = @import("copy_image_set_information.zig").CopyImageSetInformation;
const CopyDestinationImageSetProperties = @import("copy_destination_image_set_properties.zig").CopyDestinationImageSetProperties;
const CopySourceImageSetProperties = @import("copy_source_image_set_properties.zig").CopySourceImageSetProperties;

pub const CopyImageSetInput = struct {
    /// Copy image set information.
    copy_image_set_information: CopyImageSetInformation,

    /// The data store identifier.
    datastore_id: []const u8,

    /// Providing this parameter will force completion of the `CopyImageSet`
    /// operation, even if there are inconsistent Patient, Study, and/or Series
    /// level metadata elements between the `sourceImageSet` and
    /// `destinationImageSet`.
    force: ?bool = null,

    /// Providing this parameter will configure the `CopyImageSet` operation to
    /// promote the given image set to the primary DICOM hierarchy. If successful, a
    /// new primary image set ID will be returned as the destination image set.
    promote_to_primary: ?bool = null,

    /// The source image set identifier.
    source_image_set_id: []const u8,

    pub const json_field_names = .{
        .copy_image_set_information = "copyImageSetInformation",
        .datastore_id = "datastoreId",
        .force = "force",
        .promote_to_primary = "promoteToPrimary",
        .source_image_set_id = "sourceImageSetId",
    };
};

pub const CopyImageSetOutput = struct {
    /// The data store identifier.
    datastore_id: []const u8,

    /// The properties of the destination image set.
    destination_image_set_properties: ?CopyDestinationImageSetProperties = null,

    /// The properties of the source image set.
    source_image_set_properties: ?CopySourceImageSetProperties = null,

    pub const json_field_names = .{
        .datastore_id = "datastoreId",
        .destination_image_set_properties = "destinationImageSetProperties",
        .source_image_set_properties = "sourceImageSetProperties",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CopyImageSetInput, options: Options) !CopyImageSetOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "medicalimaging");

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

fn serializeRequest(alloc: std.mem.Allocator, input: CopyImageSetInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("medicalimaging", "Medical Imaging", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(alloc, "/datastore/");
    try path_buf.appendSlice(alloc, input.datastore_id);
    try path_buf.appendSlice(alloc, "/imageSet/");
    try path_buf.appendSlice(alloc, input.source_image_set_id);
    try path_buf.appendSlice(alloc, "/copyImageSet");
    const path = try path_buf.toOwnedSlice(alloc);

    var query_buf: std.ArrayList(u8) = .{};
    var query_has_prev = false;
    if (input.force) |v| {
        if (query_has_prev) try query_buf.appendSlice(alloc, "&");
        try query_buf.appendSlice(alloc, "force=");
        try query_buf.appendSlice(alloc, if (v) "true" else "false");
        query_has_prev = true;
    }
    if (input.promote_to_primary) |v| {
        if (query_has_prev) try query_buf.appendSlice(alloc, "&");
        try query_buf.appendSlice(alloc, "promoteToPrimary=");
        try query_buf.appendSlice(alloc, if (v) "true" else "false");
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(alloc);

    const body = try aws.json.jsonStringify(input.copy_image_set_information, alloc);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    request.query = query;
    try request.headers.put(alloc, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !CopyImageSetOutput {
    var result: CopyImageSetOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CopyImageSetOutput, body, alloc);
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
