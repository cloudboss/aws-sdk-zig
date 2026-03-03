const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const TestSetGenerationDataSource = @import("test_set_generation_data_source.zig").TestSetGenerationDataSource;
const TestSetStorageLocation = @import("test_set_storage_location.zig").TestSetStorageLocation;
const TestSetGenerationStatus = @import("test_set_generation_status.zig").TestSetGenerationStatus;

pub const DescribeTestSetGenerationInput = struct {
    /// The unique identifier of the test set generation.
    test_set_generation_id: []const u8,

    pub const json_field_names = .{
        .test_set_generation_id = "testSetGenerationId",
    };
};

pub const DescribeTestSetGenerationOutput = struct {
    /// The creation date and time for the test set generation.
    creation_date_time: ?i64 = null,

    /// The test set description for the test set generation.
    description: ?[]const u8 = null,

    /// The reasons the test set generation failed.
    failure_reasons: ?[]const []const u8 = null,

    /// The data source of the test set used for the test set generation.
    generation_data_source: ?TestSetGenerationDataSource = null,

    /// The date and time of the last update for the test set generation.
    last_updated_date_time: ?i64 = null,

    /// The roleARN of the test set used for the test set generation.
    role_arn: ?[]const u8 = null,

    /// The Amazon S3 storage location for the test set generation.
    storage_location: ?TestSetStorageLocation = null,

    /// The unique identifier of the test set generation.
    test_set_generation_id: ?[]const u8 = null,

    /// The status for the test set generation.
    test_set_generation_status: ?TestSetGenerationStatus = null,

    /// The unique identifier for the test set created for the generated test set.
    test_set_id: ?[]const u8 = null,

    /// The test set name for the generated test set.
    test_set_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .creation_date_time = "creationDateTime",
        .description = "description",
        .failure_reasons = "failureReasons",
        .generation_data_source = "generationDataSource",
        .last_updated_date_time = "lastUpdatedDateTime",
        .role_arn = "roleArn",
        .storage_location = "storageLocation",
        .test_set_generation_id = "testSetGenerationId",
        .test_set_generation_status = "testSetGenerationStatus",
        .test_set_id = "testSetId",
        .test_set_name = "testSetName",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeTestSetGenerationInput, options: CallOptions) !DescribeTestSetGenerationOutput {
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
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeTestSetGenerationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("lexmodelsv2", "Lex Models V2", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/testsetgenerations/");
    try path_buf.appendSlice(allocator, input.test_set_generation_id);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeTestSetGenerationOutput {
    var result: DescribeTestSetGenerationOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(DescribeTestSetGenerationOutput, body, allocator);
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
