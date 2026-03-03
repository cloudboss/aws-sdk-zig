const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const SoftwareUpdatePreferences = @import("software_update_preferences.zig").SoftwareUpdatePreferences;

pub const DescribeMaintenanceStartTimeInput = struct {
    gateway_arn: []const u8,

    pub const json_field_names = .{
        .gateway_arn = "GatewayARN",
    };
};

pub const DescribeMaintenanceStartTimeOutput = struct {
    /// The day of the month component of the maintenance start time represented as
    /// an ordinal
    /// number from 1 to 28, where 1 represents the first day of the month. It is
    /// not possible to
    /// set the maintenance schedule to start on days 29 through 31.
    day_of_month: ?i32 = null,

    /// An ordinal number between 0 and 6 that represents the day of the week, where
    /// 0
    /// represents Sunday and 6 represents Saturday. The day of week is in the time
    /// zone of the
    /// gateway.
    day_of_week: ?i32 = null,

    gateway_arn: ?[]const u8 = null,

    /// The hour component of the maintenance start time represented as *hh*,
    /// where *hh* is the hour (0 to 23). The hour of the day is in the time
    /// zone of the gateway.
    hour_of_day: ?i32 = null,

    /// The minute component of the maintenance start time represented as
    /// *mm*, where *mm* is the minute (0 to 59). The
    /// minute of the hour is in the time zone of the gateway.
    minute_of_hour: ?i32 = null,

    /// A set of variables indicating the software update preferences for the
    /// gateway.
    ///
    /// Includes `AutomaticUpdatePolicy` parameter with the following inputs:
    ///
    /// `ALL_VERSIONS` - Enables regular gateway maintenance updates.
    ///
    /// `EMERGENCY_VERSIONS_ONLY` - Disables regular gateway maintenance updates.
    /// The
    /// gateway will still receive emergency version updates on rare occasions if
    /// necessary to
    /// remedy highly critical security or durability issues. You will be notified
    /// before an
    /// emergency version update is applied. These updates are applied during your
    /// gateway's
    /// scheduled maintenance window.
    software_update_preferences: ?SoftwareUpdatePreferences = null,

    /// A value that indicates the time zone that is set for the gateway. The start
    /// time and day
    /// of week specified should be in the time zone of the gateway.
    timezone: ?[]const u8 = null,

    pub const json_field_names = .{
        .day_of_month = "DayOfMonth",
        .day_of_week = "DayOfWeek",
        .gateway_arn = "GatewayARN",
        .hour_of_day = "HourOfDay",
        .minute_of_hour = "MinuteOfHour",
        .software_update_preferences = "SoftwareUpdatePreferences",
        .timezone = "Timezone",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeMaintenanceStartTimeInput, options: Options) !DescribeMaintenanceStartTimeOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "storagegateway");

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeMaintenanceStartTimeInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("storagegateway", "Storage Gateway", allocator);

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
    try request.headers.put(allocator, "X-Amz-Target", "StorageGateway_20130630.DescribeMaintenanceStartTime");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeMaintenanceStartTimeOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeMaintenanceStartTimeOutput, body, allocator);
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

    if (std.mem.eql(u8, error_code, "InternalServerError")) {
        return .{ .arena = arena, .kind = .{ .internal_server_error = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidGatewayRequestException")) {
        return .{ .arena = arena, .kind = .{ .invalid_gateway_request_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServiceUnavailableError")) {
        return .{ .arena = arena, .kind = .{ .service_unavailable_error = .{
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
