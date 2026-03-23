const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const KxAzMode = @import("kx_az_mode.zig").KxAzMode;
const KxDataviewSegmentConfiguration = @import("kx_dataview_segment_configuration.zig").KxDataviewSegmentConfiguration;
const KxDataviewStatus = @import("kx_dataview_status.zig").KxDataviewStatus;

pub const CreateKxDataviewInput = struct {
    /// The option to specify whether you want to apply all the future additions and
    /// corrections automatically to the dataview, when you ingest new changesets.
    /// The default value is false.
    auto_update: ?bool = null,

    /// The identifier of the availability zones.
    availability_zone_id: ?[]const u8 = null,

    /// The number of availability zones you want to assign per volume. Currently,
    /// FinSpace only supports `SINGLE` for volumes. This places dataview in a
    /// single AZ.
    az_mode: KxAzMode,

    /// A unique identifier of the changeset that you want to use to ingest data.
    changeset_id: ?[]const u8 = null,

    /// A token that ensures idempotency. This token expires in 10 minutes.
    client_token: []const u8,

    /// The name of the database where you want to create a dataview.
    database_name: []const u8,

    /// A unique identifier for the dataview.
    dataview_name: []const u8,

    /// A description of the dataview.
    description: ?[]const u8 = null,

    /// A unique identifier for the kdb environment, where you want to create the
    /// dataview.
    environment_id: []const u8,

    /// The option to specify whether you want to make the dataview writable to
    /// perform database maintenance. The following are some considerations related
    /// to writable dataviews.
    ///
    /// * You cannot create partial writable dataviews. When you create writeable
    ///   dataviews you must
    /// provide the entire database path.
    ///
    /// * You cannot perform updates on a writeable dataview. Hence, `autoUpdate`
    ///   must be set
    /// as **False** if `readWrite` is **True** for a dataview.
    ///
    /// * You must also use a unique volume for creating a writeable dataview. So,
    ///   if you choose a
    /// volume that is already in use by another dataview, the dataview creation
    /// fails.
    ///
    /// * Once you create a dataview as writeable, you cannot change it to
    ///   read-only. So, you cannot
    /// update the `readWrite` parameter later.
    read_write: ?bool = null,

    /// The configuration that contains the database path of the data that you want
    /// to place on each selected volume. Each segment must have a unique database
    /// path for each volume. If you do not explicitly specify any database path for
    /// a volume, they are accessible from the cluster through the default S3/object
    /// store segment.
    segment_configurations: ?[]const KxDataviewSegmentConfiguration = null,

    /// A list of key-value pairs to label the dataview. You can add up to 50 tags
    /// to a dataview.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .auto_update = "autoUpdate",
        .availability_zone_id = "availabilityZoneId",
        .az_mode = "azMode",
        .changeset_id = "changesetId",
        .client_token = "clientToken",
        .database_name = "databaseName",
        .dataview_name = "dataviewName",
        .description = "description",
        .environment_id = "environmentId",
        .read_write = "readWrite",
        .segment_configurations = "segmentConfigurations",
        .tags = "tags",
    };
};

pub const CreateKxDataviewOutput = struct {
    /// The option to select whether you want to apply all the future additions and
    /// corrections automatically to the dataview when you ingest new changesets.
    /// The default value is false.
    auto_update: ?bool = null,

    /// The identifier of the availability zones.
    availability_zone_id: ?[]const u8 = null,

    /// The number of availability zones you want to assign per volume. Currently,
    /// FinSpace only supports `SINGLE` for volumes. This places dataview in a
    /// single AZ.
    az_mode: ?KxAzMode = null,

    /// A unique identifier for the changeset.
    changeset_id: ?[]const u8 = null,

    /// The timestamp at which the dataview was created in FinSpace. The value is
    /// determined as epoch time in milliseconds. For example, the value for Monday,
    /// November 1, 2021 12:00:00 PM UTC is specified as 1635768000000.
    created_timestamp: ?i64 = null,

    /// The name of the database where you want to create a dataview.
    database_name: ?[]const u8 = null,

    /// A unique identifier for the dataview.
    dataview_name: ?[]const u8 = null,

    /// A description of the dataview.
    description: ?[]const u8 = null,

    /// A unique identifier for the kdb environment, where you want to create the
    /// dataview.
    environment_id: ?[]const u8 = null,

    /// The last time that the dataview was updated in FinSpace. The value is
    /// determined as epoch time in milliseconds. For example, the value for Monday,
    /// November 1, 2021 12:00:00 PM UTC is specified as 1635768000000.
    last_modified_timestamp: ?i64 = null,

    /// Returns True if the dataview is created as writeable and False otherwise.
    read_write: ?bool = null,

    /// The configuration that contains the database path of the data that you want
    /// to place on each selected volume. Each segment must have a unique database
    /// path for each volume. If you do not explicitly specify any database path for
    /// a volume, they are accessible from the cluster through the default S3/object
    /// store segment.
    segment_configurations: ?[]const KxDataviewSegmentConfiguration = null,

    /// The status of dataview creation.
    ///
    /// * `CREATING` – The dataview creation is in progress.
    ///
    /// * `UPDATING` – The dataview is in the process of being updated.
    ///
    /// * `ACTIVE` – The dataview is active.
    status: ?KxDataviewStatus = null,

    pub const json_field_names = .{
        .auto_update = "autoUpdate",
        .availability_zone_id = "availabilityZoneId",
        .az_mode = "azMode",
        .changeset_id = "changesetId",
        .created_timestamp = "createdTimestamp",
        .database_name = "databaseName",
        .dataview_name = "dataviewName",
        .description = "description",
        .environment_id = "environmentId",
        .last_modified_timestamp = "lastModifiedTimestamp",
        .read_write = "readWrite",
        .segment_configurations = "segmentConfigurations",
        .status = "status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateKxDataviewInput, options: CallOptions) !CreateKxDataviewOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "finspace");

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateKxDataviewInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("finspace", "finspace", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/kx/environments/");
    try path_buf.appendSlice(allocator, input.environment_id);
    try path_buf.appendSlice(allocator, "/databases/");
    try path_buf.appendSlice(allocator, input.database_name);
    try path_buf.appendSlice(allocator, "/dataviews");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.auto_update) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"autoUpdate\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.availability_zone_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"availabilityZoneId\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"azMode\":");
    try aws.json.writeValue(@TypeOf(input.az_mode), input.az_mode, allocator, &body_buf);
    has_prev = true;
    if (input.changeset_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"changesetId\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"clientToken\":");
    try aws.json.writeValue(@TypeOf(input.client_token), input.client_token, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"dataviewName\":");
    try aws.json.writeValue(@TypeOf(input.dataview_name), input.dataview_name, allocator, &body_buf);
    has_prev = true;
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.read_write) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"readWrite\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.segment_configurations) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"segmentConfigurations\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"tags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateKxDataviewOutput {
    var result: CreateKxDataviewOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateKxDataviewOutput, body, allocator);
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
    if (std.mem.eql(u8, error_code, "InvalidRequestException")) {
        return .{ .arena = arena, .kind = .{ .invalid_request_exception = .{
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
    if (std.mem.eql(u8, error_code, "ResourceAlreadyExistsException")) {
        return .{ .arena = arena, .kind = .{ .resource_already_exists_exception = .{
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
