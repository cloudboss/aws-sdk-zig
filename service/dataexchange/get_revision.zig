const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;

pub const GetRevisionInput = struct {
    /// The unique identifier for a data set.
    data_set_id: []const u8,

    /// The unique identifier for a revision.
    revision_id: []const u8,

    pub const json_field_names = .{
        .data_set_id = "DataSetId",
        .revision_id = "RevisionId",
    };
};

pub const GetRevisionOutput = struct {
    /// The ARN for the revision.
    arn: ?[]const u8 = null,

    /// An optional comment about the revision.
    comment: ?[]const u8 = null,

    /// The date and time that the revision was created, in ISO 8601 format.
    created_at: ?i64 = null,

    /// The unique identifier for the data set associated with the data set
    /// revision.
    data_set_id: ?[]const u8 = null,

    /// To publish a revision to a data set in a product, the revision must first be
    /// finalized.
    /// Finalizing a revision tells AWS Data Exchange that your changes to the
    /// assets in the
    /// revision are complete. After it's in this read-only state, you can publish
    /// the revision to
    /// your products. Finalized revisions can be published through the AWS Data
    /// Exchange console
    /// or the AWS Marketplace Catalog API, using the StartChangeSet AWS Marketplace
    /// Catalog API
    /// action. When using the API, revisions are uniquely identified by their ARN.
    finalized: ?bool = null,

    /// The unique identifier for the revision.
    id: ?[]const u8 = null,

    /// A required comment to inform subscribers of the reason their access to the
    /// revision was
    /// revoked.
    revocation_comment: ?[]const u8 = null,

    /// A status indicating that subscribers' access to the revision was revoked.
    revoked: ?bool = null,

    /// The date and time that the revision was revoked, in ISO 8601 format.
    revoked_at: ?i64 = null,

    /// The revision ID of the owned revision corresponding to the entitled revision
    /// being
    /// viewed. This parameter is returned when a revision owner is viewing the
    /// entitled copy of
    /// its owned revision.
    source_id: ?[]const u8 = null,

    /// The tags for the revision.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The date and time that the revision was last updated, in ISO 8601 format.
    updated_at: ?i64 = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .comment = "Comment",
        .created_at = "CreatedAt",
        .data_set_id = "DataSetId",
        .finalized = "Finalized",
        .id = "Id",
        .revocation_comment = "RevocationComment",
        .revoked = "Revoked",
        .revoked_at = "RevokedAt",
        .source_id = "SourceId",
        .tags = "Tags",
        .updated_at = "UpdatedAt",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetRevisionInput, options: CallOptions) !GetRevisionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "dataexchange");

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetRevisionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("dataexchange", "DataExchange", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/v1/data-sets/");
    try path_buf.appendSlice(allocator, input.data_set_id);
    try path_buf.appendSlice(allocator, "/revisions/");
    try path_buf.appendSlice(allocator, input.revision_id);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(host);
    request.method = .GET;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetRevisionOutput {
    var result: GetRevisionOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetRevisionOutput, body, allocator);
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
    if (std.mem.eql(u8, error_code, "ServiceLimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .service_limit_exceeded_exception = .{
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
