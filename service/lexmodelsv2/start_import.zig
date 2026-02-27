const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const MergeStrategy = @import("merge_strategy.zig").MergeStrategy;
const ImportResourceSpecification = @import("import_resource_specification.zig").ImportResourceSpecification;
const ImportStatus = @import("import_status.zig").ImportStatus;

pub const StartImportInput = struct {
    /// The password used to encrypt the zip archive that contains the
    /// resource definition. You should always encrypt the zip archive to
    /// protect it during transit between your site and Amazon Lex.
    file_password: ?[]const u8 = null,

    /// The unique identifier for the import. It is included in the response
    /// from the
    /// [CreateUploadUrl](https://docs.aws.amazon.com/lexv2/latest/APIReference/API_CreateUploadUrl.html) operation.
    import_id: []const u8,

    /// The strategy to use when there is a name conflict between the
    /// imported resource and an existing resource. When the merge strategy is
    /// `FailOnConflict` existing resources are not overwritten
    /// and the import fails.
    merge_strategy: MergeStrategy,

    /// Parameters for creating the bot, bot locale or custom
    /// vocabulary.
    resource_specification: ImportResourceSpecification,

    pub const json_field_names = .{
        .file_password = "filePassword",
        .import_id = "importId",
        .merge_strategy = "mergeStrategy",
        .resource_specification = "resourceSpecification",
    };
};

pub const StartImportOutput = struct {
    /// The date and time that the import request was created.
    creation_date_time: ?i64 = null,

    /// A unique identifier for the import.
    import_id: ?[]const u8 = null,

    /// The current status of the import. When the status is
    /// `Complete` the bot, bot alias, or custom vocabulary is
    /// ready to use.
    import_status: ?ImportStatus = null,

    /// The strategy used when there was a name conflict between the
    /// imported resource and an existing resource. When the merge strategy is
    /// `FailOnConflict` existing resources are not overwritten
    /// and the import fails.
    merge_strategy: ?MergeStrategy = null,

    /// The parameters used when importing the resource.
    resource_specification: ?ImportResourceSpecification = null,

    pub const json_field_names = .{
        .creation_date_time = "creationDateTime",
        .import_id = "importId",
        .import_status = "importStatus",
        .merge_strategy = "mergeStrategy",
        .resource_specification = "resourceSpecification",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartImportInput, options: Options) !StartImportOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "lexmodelsv2");

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

fn serializeRequest(alloc: std.mem.Allocator, input: StartImportInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("lexmodelsv2", "Lex Models V2", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const path = "/imports";

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(alloc, "{");

    if (input.file_password) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"filePassword\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(alloc, ",");
    try body_buf.appendSlice(alloc, "\"importId\":");
    try aws.json.writeValue(@TypeOf(input.import_id), input.import_id, alloc, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(alloc, ",");
    try body_buf.appendSlice(alloc, "\"mergeStrategy\":");
    try aws.json.writeValue(@TypeOf(input.merge_strategy), input.merge_strategy, alloc, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(alloc, ",");
    try body_buf.appendSlice(alloc, "\"resourceSpecification\":");
    try aws.json.writeValue(@TypeOf(input.resource_specification), input.resource_specification, alloc, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(alloc, "}");
    const body = try body_buf.toOwnedSlice(alloc);

    var request = aws.http.Request.init(host);
    request.method = .PUT;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !StartImportOutput {
    var result: StartImportOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(StartImportOutput, body, alloc);
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
    if (std.mem.eql(u8, error_code, "PreconditionFailedException")) {
        return .{ .arena = arena, .kind = .{ .precondition_failed_exception = .{
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
