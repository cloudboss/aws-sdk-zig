const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CapacityForecast = @import("capacity_forecast.zig").CapacityForecast;
const LoadForecast = @import("load_forecast.zig").LoadForecast;
const serde = @import("serde.zig");

pub const GetPredictiveScalingForecastInput = struct {
    /// The name of the Auto Scaling group.
    auto_scaling_group_name: []const u8,

    /// The exclusive end time of the time range for the forecast data to get. The
    /// maximum
    /// time duration between the start and end time is 30 days.
    ///
    /// Although this parameter can accept a date and time that is more than two
    /// days in the
    /// future, the availability of forecast data has limits. Amazon EC2 Auto
    /// Scaling only issues forecasts for
    /// periods of two days in advance.
    end_time: i64,

    /// The name of the policy.
    policy_name: []const u8,

    /// The inclusive start time of the time range for the forecast data to get. At
    /// most, the
    /// date and time can be one year before the current date and time.
    start_time: i64,
};

pub const GetPredictiveScalingForecastOutput = struct {
    /// The capacity forecast.
    capacity_forecast: ?CapacityForecast = null,

    /// The load forecast.
    load_forecast: ?[]const LoadForecast = null,

    /// The time the forecast was made.
    update_time: i64,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetPredictiveScalingForecastInput, options: CallOptions) !GetPredictiveScalingForecastOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "autoscaling", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetPredictiveScalingForecastInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("autoscaling", "Auto Scaling", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=GetPredictiveScalingForecast&Version=2011-01-01");
    try body_buf.appendSlice(allocator, "&AutoScalingGroupName=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.auto_scaling_group_name);
    try body_buf.appendSlice(allocator, "&EndTime=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{input.end_time}) catch "");
    try body_buf.appendSlice(allocator, "&PolicyName=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.policy_name);
    try body_buf.appendSlice(allocator, "&StartTime=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{input.start_time}) catch "");

    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-www-form-urlencoded");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetPredictiveScalingForecastOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "GetPredictiveScalingForecastResult")) break;
            },
            else => {},
        }
    }

    var result: GetPredictiveScalingForecastOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CapacityForecast")) {
                    result.capacity_forecast = try serde.deserializeCapacityForecast(allocator, &reader);
                } else if (std.mem.eql(u8, e.local, "LoadForecast")) {
                    result.load_forecast = try serde.deserializeLoadForecasts(allocator, &reader, "member");
                } else if (std.mem.eql(u8, e.local, "UpdateTime")) {
                    result.update_time = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }

    return result;
}
