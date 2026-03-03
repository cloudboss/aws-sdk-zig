const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const ScheduleRunConfiguration = @import("schedule_run_configuration.zig").ScheduleRunConfiguration;
const ScheduleRunTest = @import("schedule_run_test.zig").ScheduleRunTest;
const TestType = @import("test_type.zig").TestType;
const DevicePoolCompatibilityResult = @import("device_pool_compatibility_result.zig").DevicePoolCompatibilityResult;

pub const GetDevicePoolCompatibilityInput = struct {
    /// The ARN of the app that is associated with the specified device pool.
    app_arn: ?[]const u8 = null,

    /// An object that contains information about the settings for a run.
    configuration: ?ScheduleRunConfiguration = null,

    /// The device pool's ARN.
    device_pool_arn: []const u8,

    /// The ARN of the project for which you want to check
    /// device pool compatibility.
    project_arn: ?[]const u8 = null,

    /// Information about the uploaded test to be run against the device pool.
    @"test": ?ScheduleRunTest = null,

    /// The test type for the specified device pool.
    ///
    /// Allowed values include the following:
    ///
    /// * BUILTIN_FUZZ.
    ///
    /// * APPIUM_JAVA_JUNIT.
    ///
    /// * APPIUM_JAVA_TESTNG.
    ///
    /// * APPIUM_PYTHON.
    ///
    /// * APPIUM_NODE.
    ///
    /// * APPIUM_RUBY.
    ///
    /// * APPIUM_WEB_JAVA_JUNIT.
    ///
    /// * APPIUM_WEB_JAVA_TESTNG.
    ///
    /// * APPIUM_WEB_PYTHON.
    ///
    /// * APPIUM_WEB_NODE.
    ///
    /// * APPIUM_WEB_RUBY.
    ///
    /// * INSTRUMENTATION.
    ///
    /// * XCTEST.
    ///
    /// * XCTEST_UI.
    test_type: ?TestType = null,

    pub const json_field_names = .{
        .app_arn = "appArn",
        .configuration = "configuration",
        .device_pool_arn = "devicePoolArn",
        .project_arn = "projectArn",
        .@"test" = "test",
        .test_type = "testType",
    };
};

pub const GetDevicePoolCompatibilityOutput = struct {
    /// Information about compatible devices.
    compatible_devices: ?[]const DevicePoolCompatibilityResult = null,

    /// Information about incompatible devices.
    incompatible_devices: ?[]const DevicePoolCompatibilityResult = null,

    pub const json_field_names = .{
        .compatible_devices = "compatibleDevices",
        .incompatible_devices = "incompatibleDevices",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetDevicePoolCompatibilityInput, options: CallOptions) !GetDevicePoolCompatibilityOutput {
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
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: GetDevicePoolCompatibilityInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("devicefarm", "Device Farm", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "DeviceFarm_20150623.GetDevicePoolCompatibility");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetDevicePoolCompatibilityOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetDevicePoolCompatibilityOutput, body, allocator);
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
