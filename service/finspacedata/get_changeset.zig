const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const ChangeType = @import("change_type.zig").ChangeType;
const ChangesetErrorInfo = @import("changeset_error_info.zig").ChangesetErrorInfo;
const IngestionStatus = @import("ingestion_status.zig").IngestionStatus;

pub const GetChangesetInput = struct {
    /// The unique identifier of the Changeset for which to get data.
    changeset_id: []const u8,

    /// The unique identifier for the FinSpace Dataset where the Changeset is
    /// created.
    dataset_id: []const u8,

    pub const json_field_names = .{
        .changeset_id = "changesetId",
        .dataset_id = "datasetId",
    };
};

pub const GetChangesetOutput = struct {
    /// Beginning time from which the Changeset is active. The value is determined
    /// as epoch time in milliseconds. For example, the value for Monday, November
    /// 1, 2021 12:00:00 PM UTC is specified as 1635768000000.
    active_from_timestamp: ?i64 = null,

    /// Time until which the Changeset is active. The value is determined as epoch
    /// time in milliseconds. For example, the value for Monday, November 1, 2021
    /// 12:00:00 PM UTC is specified as 1635768000000.
    active_until_timestamp: ?i64 = null,

    /// The ARN identifier of the Changeset.
    changeset_arn: ?[]const u8 = null,

    /// The unique identifier for a Changeset.
    changeset_id: ?[]const u8 = null,

    /// Type that indicates how a Changeset is applied to a Dataset.
    ///
    /// * `REPLACE` – Changeset is considered as a replacement to all prior loaded
    ///   Changesets.
    ///
    /// * `APPEND` – Changeset is considered as an addition to the end of all prior
    ///   loaded Changesets.
    ///
    /// * `MODIFY` – Changeset is considered as a replacement to a specific prior
    ///   ingested Changeset.
    change_type: ?ChangeType = null,

    /// The timestamp at which the Changeset was created in FinSpace. The value is
    /// determined as epoch time in milliseconds. For example, the value for Monday,
    /// November 1, 2021 12:00:00 PM UTC is specified as 1635768000000.
    create_time: ?i64 = null,

    /// The unique identifier for the FinSpace Dataset where the Changeset is
    /// created.
    dataset_id: ?[]const u8 = null,

    /// The structure with error messages.
    error_info: ?ChangesetErrorInfo = null,

    /// Structure of the source file(s).
    format_params: ?[]const aws.map.StringMapEntry = null,

    /// Options that define the location of the data being ingested.
    source_params: ?[]const aws.map.StringMapEntry = null,

    /// The status of Changeset creation operation.
    status: ?IngestionStatus = null,

    /// The unique identifier of the updated Changeset.
    updated_by_changeset_id: ?[]const u8 = null,

    /// The unique identifier of the Changeset that is being updated.
    updates_changeset_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .active_from_timestamp = "activeFromTimestamp",
        .active_until_timestamp = "activeUntilTimestamp",
        .changeset_arn = "changesetArn",
        .changeset_id = "changesetId",
        .change_type = "changeType",
        .create_time = "createTime",
        .dataset_id = "datasetId",
        .error_info = "errorInfo",
        .format_params = "formatParams",
        .source_params = "sourceParams",
        .status = "status",
        .updated_by_changeset_id = "updatedByChangesetId",
        .updates_changeset_id = "updatesChangesetId",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetChangesetInput, options: Options) !GetChangesetOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "finspacedata");

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

fn serializeRequest(alloc: std.mem.Allocator, input: GetChangesetInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("finspacedata", "finspace data", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(alloc, "/datasets/");
    try path_buf.appendSlice(alloc, input.dataset_id);
    try path_buf.appendSlice(alloc, "/changesetsv2/");
    try path_buf.appendSlice(alloc, input.changeset_id);
    const path = try path_buf.toOwnedSlice(alloc);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(host);
    request.method = .GET;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !GetChangesetOutput {
    var result: GetChangesetOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetChangesetOutput, body, alloc);
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
    if (std.mem.eql(u8, error_code, "LimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .limit_exceeded_exception = .{
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
