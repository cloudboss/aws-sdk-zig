const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const PutMaintenanceStartTimeInput = struct {
    /// The day of the month start maintenance on a gateway.
    ///
    /// Valid values range from `Sunday` to `Saturday`.
    day_of_month: ?i32 = null,

    /// The day of the week to start maintenance on a gateway.
    day_of_week: ?i32 = null,

    /// The Amazon Resource Name (ARN) for the gateway, used to specify its
    /// maintenance start
    /// time.
    gateway_arn: []const u8,

    /// The hour of the day to start maintenance on a gateway.
    hour_of_day: i32,

    /// The minute of the hour to start maintenance on a gateway.
    minute_of_hour: i32,

    pub const json_field_names = .{
        .day_of_month = "DayOfMonth",
        .day_of_week = "DayOfWeek",
        .gateway_arn = "GatewayArn",
        .hour_of_day = "HourOfDay",
        .minute_of_hour = "MinuteOfHour",
    };
};

pub const PutMaintenanceStartTimeOutput = struct {
    /// The Amazon Resource Name (ARN) of a gateway for which you set the
    /// maintenance start
    /// time.
    gateway_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .gateway_arn = "GatewayArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutMaintenanceStartTimeInput, options: CallOptions) !PutMaintenanceStartTimeOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "backup-gateway", client.config.http_client.clock_skew_offset);

    var response = try client.config.http_client.sendRequestWithOptions(&request, client.options);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = try parseErrorResponse(client.allocator, response.body, response.status);
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: PutMaintenanceStartTimeInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("backup-gateway", "Backup Gateway", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "BackupOnPremises_v20210101.PutMaintenanceStartTime");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PutMaintenanceStartTimeOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(PutMaintenanceStartTimeOutput, body, allocator);
}
