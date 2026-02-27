const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const TestSetGenerationDataSource = @import("test_set_generation_data_source.zig").TestSetGenerationDataSource;
const TestSetStorageLocation = @import("test_set_storage_location.zig").TestSetStorageLocation;
const TestSetGenerationStatus = @import("test_set_generation_status.zig").TestSetGenerationStatus;

pub const StartTestSetGenerationInput = struct {
    /// The test set description for the test set generation request.
    description: ?[]const u8 = null,

    /// The data source for the test set generation.
    generation_data_source: TestSetGenerationDataSource,

    /// The roleARN used for any operation in the test set to access
    /// resources in the Amazon Web Services account.
    role_arn: []const u8,

    /// The Amazon S3 storage location for the test set generation.
    storage_location: TestSetStorageLocation,

    /// The test set name for the test set generation request.
    test_set_name: []const u8,

    /// A list of tags to add to the test set. You can only add tags when you
    /// import/generate a new test set. You can't use the `UpdateTestSet` operation
    /// to update tags. To update tags, use the `TagResource` operation.
    test_set_tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .description = "description",
        .generation_data_source = "generationDataSource",
        .role_arn = "roleArn",
        .storage_location = "storageLocation",
        .test_set_name = "testSetName",
        .test_set_tags = "testSetTags",
    };
};

pub const StartTestSetGenerationOutput = struct {
    /// The creation date and time for the test set generation.
    creation_date_time: ?i64 = null,

    /// The description used for the test set generation.
    description: ?[]const u8 = null,

    /// The data source for the test set generation.
    generation_data_source: ?TestSetGenerationDataSource = null,

    /// The roleARN used for any operation in the test set to access resources
    /// in the Amazon Web Services account.
    role_arn: ?[]const u8 = null,

    /// The Amazon S3 storage location for the test set generation.
    storage_location: ?TestSetStorageLocation = null,

    /// The unique identifier of the test set generation to describe.
    test_set_generation_id: ?[]const u8 = null,

    /// The status for the test set generation.
    test_set_generation_status: ?TestSetGenerationStatus = null,

    /// The test set name used for the test set generation.
    test_set_name: ?[]const u8 = null,

    /// A list of tags that was used for the test set that is being generated.
    test_set_tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .creation_date_time = "creationDateTime",
        .description = "description",
        .generation_data_source = "generationDataSource",
        .role_arn = "roleArn",
        .storage_location = "storageLocation",
        .test_set_generation_id = "testSetGenerationId",
        .test_set_generation_status = "testSetGenerationStatus",
        .test_set_name = "testSetName",
        .test_set_tags = "testSetTags",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartTestSetGenerationInput, options: Options) !StartTestSetGenerationOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: StartTestSetGenerationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("lexmodelsv2", "Lex Models V2", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const path = "/testsetgenerations";

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(alloc, "{");

    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"description\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(alloc, ",");
    try body_buf.appendSlice(alloc, "\"generationDataSource\":");
    try aws.json.writeValue(@TypeOf(input.generation_data_source), input.generation_data_source, alloc, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(alloc, ",");
    try body_buf.appendSlice(alloc, "\"roleArn\":");
    try aws.json.writeValue(@TypeOf(input.role_arn), input.role_arn, alloc, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(alloc, ",");
    try body_buf.appendSlice(alloc, "\"storageLocation\":");
    try aws.json.writeValue(@TypeOf(input.storage_location), input.storage_location, alloc, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(alloc, ",");
    try body_buf.appendSlice(alloc, "\"testSetName\":");
    try aws.json.writeValue(@TypeOf(input.test_set_name), input.test_set_name, alloc, &body_buf);
    has_prev = true;
    if (input.test_set_tags) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"testSetTags\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }

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

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !StartTestSetGenerationOutput {
    var result: StartTestSetGenerationOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(StartTestSetGenerationOutput, body, alloc);
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
