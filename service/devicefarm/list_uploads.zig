const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const UploadType = @import("upload_type.zig").UploadType;
const Upload = @import("upload.zig").Upload;

pub const ListUploadsInput = struct {
    /// The Amazon Resource Name (ARN) of the project for which you want to list
    /// uploads.
    arn: []const u8,

    /// An identifier that was returned from the previous call to this operation,
    /// which can
    /// be used to return the next set of items in the list.
    next_token: ?[]const u8 = null,

    /// The type of upload.
    ///
    /// Must be one of the following values:
    ///
    /// * ANDROID_APP
    ///
    /// * IOS_APP
    ///
    /// * WEB_APP
    ///
    /// * EXTERNAL_DATA
    ///
    /// * APPIUM_JAVA_JUNIT_TEST_PACKAGE
    ///
    /// * APPIUM_JAVA_TESTNG_TEST_PACKAGE
    ///
    /// * APPIUM_PYTHON_TEST_PACKAGE
    ///
    /// * APPIUM_NODE_TEST_PACKAGE
    ///
    /// * APPIUM_RUBY_TEST_PACKAGE
    ///
    /// * APPIUM_WEB_JAVA_JUNIT_TEST_PACKAGE
    ///
    /// * APPIUM_WEB_JAVA_TESTNG_TEST_PACKAGE
    ///
    /// * APPIUM_WEB_PYTHON_TEST_PACKAGE
    ///
    /// * APPIUM_WEB_NODE_TEST_PACKAGE
    ///
    /// * APPIUM_WEB_RUBY_TEST_PACKAGE
    ///
    /// * INSTRUMENTATION_TEST_PACKAGE
    ///
    /// * XCTEST_TEST_PACKAGE
    ///
    /// * XCTEST_UI_TEST_PACKAGE
    ///
    /// * APPIUM_JAVA_JUNIT_TEST_SPEC
    ///
    /// * APPIUM_JAVA_TESTNG_TEST_SPEC
    ///
    /// * APPIUM_PYTHON_TEST_SPEC
    ///
    /// * APPIUM_NODE_TEST_SPEC
    ///
    /// * APPIUM_RUBY_TEST_SPEC
    ///
    /// * APPIUM_WEB_JAVA_JUNIT_TEST_SPEC
    ///
    /// * APPIUM_WEB_JAVA_TESTNG_TEST_SPEC
    ///
    /// * APPIUM_WEB_PYTHON_TEST_SPEC
    ///
    /// * APPIUM_WEB_NODE_TEST_SPEC
    ///
    /// * APPIUM_WEB_RUBY_TEST_SPEC
    ///
    /// * INSTRUMENTATION_TEST_SPEC
    ///
    /// * XCTEST_UI_TEST_SPEC
    @"type": ?UploadType = null,

    pub const json_field_names = .{
        .arn = "arn",
        .next_token = "nextToken",
        .@"type" = "type",
    };
};

pub const ListUploadsOutput = struct {
    /// If the number of items that are returned is significantly large, this is an
    /// identifier that is also
    /// returned. It can be used in a subsequent call to this operation to return
    /// the next set of items in the
    /// list.
    next_token: ?[]const u8 = null,

    /// Information about the uploads.
    uploads: ?[]const Upload = null,

    pub const json_field_names = .{
        .next_token = "nextToken",
        .uploads = "uploads",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListUploadsInput, options: Options) !ListUploadsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "devicefarm");

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

fn serializeRequest(alloc: std.mem.Allocator, input: ListUploadsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("devicefarm", "Device Farm", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const body = try aws.json.jsonStringify(input, alloc);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(alloc, "X-Amz-Target", "DeviceFarm_20150623.ListUploads");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !ListUploadsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListUploadsOutput, body, alloc);
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

    if (std.mem.eql(u8, error_code, "ArgumentException")) {
        return .{ .arena = arena, .kind = .{ .argument_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "CannotDeleteException")) {
        return .{ .arena = arena, .kind = .{ .cannot_delete_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "IdempotencyException")) {
        return .{ .arena = arena, .kind = .{ .idempotency_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalServiceException")) {
        return .{ .arena = arena, .kind = .{ .internal_service_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidOperationException")) {
        return .{ .arena = arena, .kind = .{ .invalid_operation_exception = .{
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
    if (std.mem.eql(u8, error_code, "NotEligibleException")) {
        return .{ .arena = arena, .kind = .{ .not_eligible_exception = .{
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
    if (std.mem.eql(u8, error_code, "ServiceAccountException")) {
        return .{ .arena = arena, .kind = .{ .service_account_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TagOperationException")) {
        return .{ .arena = arena, .kind = .{ .tag_operation_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TagPolicyException")) {
        return .{ .arena = arena, .kind = .{ .tag_policy_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyTagsException")) {
        return .{ .arena = arena, .kind = .{ .too_many_tags_exception = .{
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
