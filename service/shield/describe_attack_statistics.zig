const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AttackStatisticsDataItem = @import("attack_statistics_data_item.zig").AttackStatisticsDataItem;
const TimeRange = @import("time_range.zig").TimeRange;

pub const DescribeAttackStatisticsInput = struct {};

pub const DescribeAttackStatisticsOutput = struct {
    /// The data that describes the attacks detected during the time period.
    data_items: ?[]const AttackStatisticsDataItem = null,

    /// The time range of the attack.
    time_range: ?TimeRange = null,

    pub const json_field_names = .{
        .data_items = "DataItems",
        .time_range = "TimeRange",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeAttackStatisticsInput, options: CallOptions) !DescribeAttackStatisticsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "shield", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeAttackStatisticsInput, config: *aws.Config) !aws.http.Request {
    _ = input;
    const endpoint = try config.getEndpointForService("shield", "Shield", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = "{}";

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSShield_20160616.DescribeAttackStatistics");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeAttackStatisticsOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(DescribeAttackStatisticsOutput, body, allocator);
}
