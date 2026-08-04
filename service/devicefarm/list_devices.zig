const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const errors = @import("errors.zig");
const ServiceError = errors.ServiceError;
const DeviceFilter = @import("device_filter.zig").DeviceFilter;
const Device = @import("device.zig").Device;

pub const ListDevicesInput = struct {
    /// The Amazon Resource Name (ARN) of the project.
    arn: ?[]const u8 = null,

    /// Used to select a set of devices. A filter is made up of an attribute, an
    /// operator, and
    /// one or more values.
    ///
    /// * Attribute: The aspect of a device such as platform or model used as the
    /// selection criteria in a device filter.
    ///
    /// Allowed values include:
    ///
    /// * ARN: The Amazon Resource Name (ARN) of the device (for example,
    /// `arn:aws:devicefarm:us-west-2::device:12345Example`).
    ///
    /// * PLATFORM: The device platform. Valid values are ANDROID or IOS.
    ///
    /// * OS_VERSION: The operating system version (for example, 10.3.2).
    ///
    /// * MODEL: The device model (for example, iPad 5th Gen).
    ///
    /// * AVAILABILITY: The current availability of the device. Valid values are
    ///   AVAILABLE,
    /// HIGHLY_AVAILABLE, BUSY, or TEMPORARY_NOT_AVAILABLE.
    ///
    /// * FORM_FACTOR: The device form factor. Valid values are PHONE or TABLET.
    ///
    /// * MANUFACTURER: The device manufacturer (for example, Apple).
    ///
    /// * REMOTE_ACCESS_ENABLED: Whether the device is enabled for remote access.
    ///   Valid values
    /// are TRUE or FALSE.
    ///
    /// * REMOTE_DEBUG_ENABLED: Whether the device is enabled for remote debugging.
    ///   Valid values
    /// are TRUE or FALSE. Because remote debugging is [no
    /// longer
    /// supported](https://docs.aws.amazon.com/devicefarm/latest/developerguide/history.html), this attribute is ignored.
    ///
    /// * INSTANCE_ARN: The Amazon Resource Name (ARN) of the device
    /// instance.
    ///
    /// * INSTANCE_LABELS: The label of the device instance.
    ///
    /// * FLEET_TYPE: The fleet type. Valid values are PUBLIC or PRIVATE.
    ///
    /// * Operator: The filter operator.
    ///
    /// * The EQUALS operator is available for every attribute except
    /// INSTANCE_LABELS.
    ///
    /// * The CONTAINS operator is available for the INSTANCE_LABELS and MODEL
    /// attributes.
    ///
    /// * The IN and NOT_IN operators are available for the ARN, OS_VERSION,
    /// MODEL, MANUFACTURER, and INSTANCE_ARN attributes.
    ///
    /// * The LESS_THAN, GREATER_THAN, LESS_THAN_OR_EQUALS, and
    /// GREATER_THAN_OR_EQUALS operators are also available for the OS_VERSION
    /// attribute.
    ///
    /// * Values: An array of one or more filter values.
    ///
    /// * The IN and NOT_IN operators take a values array that has one or more
    /// elements.
    ///
    /// * The other operators require an array with a single element.
    ///
    /// * In a request, the AVAILABILITY attribute takes the following values:
    ///   AVAILABLE,
    /// HIGHLY_AVAILABLE, BUSY, or TEMPORARY_NOT_AVAILABLE.
    filters: ?[]const DeviceFilter = null,

    /// An identifier that was returned from the previous call to this operation,
    /// which can
    /// be used to return the next set of items in the list.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "arn",
        .filters = "filters",
        .next_token = "nextToken",
    };
};

pub const ListDevicesOutput = struct {
    /// Information about the devices.
    devices: ?[]const Device = null,

    /// If the number of items that are returned is significantly large, this is an
    /// identifier that is also
    /// returned. It can be used in a subsequent call to this operation to return
    /// the next set of items in the
    /// list.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .devices = "devices",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListDevicesInput, options: CallOptions) !ListDevicesOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListDevicesInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "DeviceFarm_20150623.ListDevices");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListDevicesOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListDevicesOutput, body, allocator);
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
