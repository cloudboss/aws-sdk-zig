const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const MetadataUpdates = @import("metadata_updates.zig").MetadataUpdates;
const ImageSetState = @import("image_set_state.zig").ImageSetState;
const ImageSetWorkflowStatus = @import("image_set_workflow_status.zig").ImageSetWorkflowStatus;

pub const UpdateImageSetMetadataInput = struct {
    /// The data store identifier.
    datastore_id: []const u8,

    /// Setting this flag will force the `UpdateImageSetMetadata` operation for the
    /// following attributes:
    ///
    /// * `Tag.StudyInstanceUID`, `Tag.SeriesInstanceUID`, `Tag.SOPInstanceUID`, and
    ///   `Tag.StudyID`
    /// * Adding, removing, or updating private tags for an individual SOP Instance
    force: ?bool = null,

    /// The image set identifier.
    image_set_id: []const u8,

    /// The latest image set version identifier.
    latest_version_id: []const u8,

    /// Update image set metadata updates.
    update_image_set_metadata_updates: MetadataUpdates,

    pub const json_field_names = .{
        .datastore_id = "datastoreId",
        .force = "force",
        .image_set_id = "imageSetId",
        .latest_version_id = "latestVersionId",
        .update_image_set_metadata_updates = "updateImageSetMetadataUpdates",
    };
};

pub const UpdateImageSetMetadataOutput = struct {
    /// The timestamp when image set metadata was created.
    created_at: ?i64 = null,

    /// The data store identifier.
    datastore_id: []const u8,

    /// The image set identifier.
    image_set_id: []const u8,

    /// The image set state.
    image_set_state: ImageSetState,

    /// The image set workflow status.
    image_set_workflow_status: ?ImageSetWorkflowStatus = null,

    /// The latest image set version identifier.
    latest_version_id: []const u8,

    /// The error message thrown if an update image set metadata action fails.
    message: ?[]const u8 = null,

    /// The timestamp when image set metadata was updated.
    updated_at: ?i64 = null,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .datastore_id = "datastoreId",
        .image_set_id = "imageSetId",
        .image_set_state = "imageSetState",
        .image_set_workflow_status = "imageSetWorkflowStatus",
        .latest_version_id = "latestVersionId",
        .message = "message",
        .updated_at = "updatedAt",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateImageSetMetadataInput, options: Options) !UpdateImageSetMetadataOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: UpdateImageSetMetadataInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("medicalimaging", "Medical Imaging", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(alloc, "/datastore/");
    try path_buf.appendSlice(alloc, input.datastore_id);
    try path_buf.appendSlice(alloc, "/imageSet/");
    try path_buf.appendSlice(alloc, input.image_set_id);
    try path_buf.appendSlice(alloc, "/updateImageSetMetadata");
    const path = try path_buf.toOwnedSlice(alloc);

    var query_buf: std.ArrayList(u8) = .{};
    var query_has_prev = false;
    if (input.force) |v| {
        if (query_has_prev) try query_buf.appendSlice(alloc, "&");
        try query_buf.appendSlice(alloc, "force=");
        try query_buf.appendSlice(alloc, if (v) "true" else "false");
        query_has_prev = true;
    }
    if (query_has_prev) try query_buf.appendSlice(alloc, "&");
    try query_buf.appendSlice(alloc, "latestVersion=");
    try aws.url.appendUrlEncoded(alloc, &query_buf, input.latest_version_id);
    query_has_prev = true;
    const query = try query_buf.toOwnedSlice(alloc);

    const body: ?[]const u8 = null;

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

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !UpdateImageSetMetadataOutput {
    var result: UpdateImageSetMetadataOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(UpdateImageSetMetadataOutput, body, alloc);
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
