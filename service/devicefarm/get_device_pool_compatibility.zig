const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const errors = @import("errors.zig");
const ServiceError = errors.ServiceError;
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

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "devicefarm", client.config.http_client.clock_skew_offset);

    var response = try client.config.http_client.sendRequestWithOptions(&request, client.options);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch return error.OutOfMemory;
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: GetDevicePoolCompatibilityInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("devicefarm", "Device Farm", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
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
        if (std.mem.findScalarLast(u8, type_str, '#')) |idx| {
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
        const parsed_error: ?errors.ArgumentException = aws.json.parseJsonObject(errors.ArgumentException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .argument_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "CannotDeleteException")) {
        const parsed_error: ?errors.CannotDeleteException = aws.json.parseJsonObject(errors.CannotDeleteException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .cannot_delete_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "IdempotencyException")) {
        const parsed_error: ?errors.IdempotencyException = aws.json.parseJsonObject(errors.IdempotencyException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .idempotency_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InternalServiceException")) {
        const parsed_error: ?errors.InternalServiceException = aws.json.parseJsonObject(errors.InternalServiceException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .internal_service_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidOperationException")) {
        const parsed_error: ?errors.InvalidOperationException = aws.json.parseJsonObject(errors.InvalidOperationException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_operation_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "LimitExceededException")) {
        const parsed_error: ?errors.LimitExceededException = aws.json.parseJsonObject(errors.LimitExceededException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .limit_exceeded_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "NotEligibleException")) {
        const parsed_error: ?errors.NotEligibleException = aws.json.parseJsonObject(errors.NotEligibleException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .not_eligible_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "NotFoundException")) {
        const parsed_error: ?errors.NotFoundException = aws.json.parseJsonObject(errors.NotFoundException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .not_found_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ServiceAccountException")) {
        const parsed_error: ?errors.ServiceAccountException = aws.json.parseJsonObject(errors.ServiceAccountException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .service_account_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "TagOperationException")) {
        const parsed_error: ?errors.TagOperationException = aws.json.parseJsonObject(errors.TagOperationException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .tag_operation_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "TagPolicyException")) {
        const parsed_error: ?errors.TagPolicyException = aws.json.parseJsonObject(errors.TagPolicyException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .tag_policy_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "TooManyTagsException")) {
        const parsed_error: ?errors.TooManyTagsException = aws.json.parseJsonObject(errors.TooManyTagsException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .too_many_tags_exception = typed_error } };
        }
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
