const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const MergeStrategy = @import("merge_strategy.zig").MergeStrategy;
const ResourceType = @import("resource_type.zig").ResourceType;
const Tag = @import("tag.zig").Tag;
const ImportStatus = @import("import_status.zig").ImportStatus;

pub const StartImportInput = struct {
    /// Specifies the action that the `StartImport` operation
    /// should take when there is an existing resource with the same
    /// name.
    ///
    /// * FAIL_ON_CONFLICT - The import operation is stopped on the first
    /// conflict between a resource in the import file and an existing
    /// resource. The name of the resource causing the conflict is in the
    /// `failureReason` field of the response to the
    /// `GetImport` operation.
    ///
    /// OVERWRITE_LATEST - The import operation proceeds even if there
    /// is a conflict with an existing resource. The $LASTEST version of the
    /// existing resource is overwritten with the data from the import
    /// file.
    merge_strategy: MergeStrategy,

    /// A zip archive in binary format. The archive should contain one file, a
    /// JSON file containing the resource to import. The resource should match the
    /// type specified in the `resourceType` field.
    payload: []const u8,

    /// Specifies the type of resource to export. Each resource also
    /// exports any resources that it depends on.
    ///
    /// * A bot exports dependent intents.
    ///
    /// * An intent exports dependent slot types.
    resource_type: ResourceType,

    /// A list of tags to add to the imported bot. You can only add tags when
    /// you import a bot, you can't add tags to an intent or slot type.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .merge_strategy = "mergeStrategy",
        .payload = "payload",
        .resource_type = "resourceType",
        .tags = "tags",
    };
};

pub const StartImportOutput = struct {
    /// A timestamp for the date and time that the import job was
    /// requested.
    created_date: ?i64 = null,

    /// The identifier for the specific import job.
    import_id: ?[]const u8 = null,

    /// The status of the import job. If the status is `FAILED`,
    /// you can get the reason for the failure using the `GetImport`
    /// operation.
    import_status: ?ImportStatus = null,

    /// The action to take when there is a merge conflict.
    merge_strategy: ?MergeStrategy = null,

    /// The name given to the import job.
    name: ?[]const u8 = null,

    /// The type of resource to import.
    resource_type: ?ResourceType = null,

    /// A list of tags added to the imported bot.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .created_date = "createdDate",
        .import_id = "importId",
        .import_status = "importStatus",
        .merge_strategy = "mergeStrategy",
        .name = "name",
        .resource_type = "resourceType",
        .tags = "tags",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartImportInput, options: CallOptions) !StartImportOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "lex");

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

fn serializeRequest(allocator: std.mem.Allocator, input: StartImportInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("models.lex", "Lex Model Building Service", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const path = "/imports";

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"mergeStrategy\":");
    try aws.json.writeValue(@TypeOf(input.merge_strategy), input.merge_strategy, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"payload\":");
    try aws.json.writeValue(@TypeOf(input.payload), input.payload, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"resourceType\":");
    try aws.json.writeValue(@TypeOf(input.resource_type), input.resource_type, allocator, &body_buf);
    has_prev = true;
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartImportOutput {
    var result: StartImportOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(StartImportOutput, body, allocator);
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
    if (std.mem.eql(u8, error_code, "BadRequestException")) {
        return .{ .arena = arena, .kind = .{ .bad_request_exception = .{
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
    if (std.mem.eql(u8, error_code, "InternalFailureException")) {
        return .{ .arena = arena, .kind = .{ .internal_failure_exception = .{
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
    if (std.mem.eql(u8, error_code, "NotFoundException")) {
        return .{ .arena = arena, .kind = .{ .not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "PreconditionFailedException")) {
        return .{ .arena = arena, .kind = .{ .precondition_failed_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceInUseException")) {
        return .{ .arena = arena, .kind = .{ .resource_in_use_exception = .{
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
