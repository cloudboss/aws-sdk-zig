const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const TrafficDistributionGroup = @import("traffic_distribution_group.zig").TrafficDistributionGroup;

pub const DescribeTrafficDistributionGroupInput = struct {
    /// The identifier of the traffic distribution group.
    /// This can be the ID or the ARN if the API is being called in the Region where
    /// the traffic distribution group was created.
    /// The ARN must be provided if the call is from the replicated Region.
    traffic_distribution_group_id: []const u8,

    pub const json_field_names = .{
        .traffic_distribution_group_id = "TrafficDistributionGroupId",
    };
};

pub const DescribeTrafficDistributionGroupOutput = struct {
    /// Information about the traffic distribution group.
    traffic_distribution_group: ?TrafficDistributionGroup = null,

    pub const json_field_names = .{
        .traffic_distribution_group = "TrafficDistributionGroup",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeTrafficDistributionGroupInput, options: CallOptions) !DescribeTrafficDistributionGroupOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "connect", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeTrafficDistributionGroupInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("connect", "Connect", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/traffic-distribution-group/");
    try path_buf.appendSlice(allocator, input.traffic_distribution_group_id);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeTrafficDistributionGroupOutput {
    var result: DescribeTrafficDistributionGroupOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(DescribeTrafficDistributionGroupOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
