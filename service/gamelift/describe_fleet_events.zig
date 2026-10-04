const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Event = @import("event.zig").Event;

pub const DescribeFleetEventsInput = struct {
    /// The most recent date to retrieve event logs for. If no end time is
    /// specified, this
    /// call returns entries from the specified start time up to the present. Format
    /// is a number
    /// expressed in Unix time as milliseconds (ex: "1469498468.057").
    end_time: ?i64 = null,

    /// A unique identifier for the fleet to get event logs for. You can use either
    /// the fleet ID or ARN value.
    fleet_id: []const u8,

    /// The maximum number of results to return. Use this parameter with `NextToken`
    /// to get results as a set of sequential pages.
    limit: ?i32 = null,

    /// A token that indicates the start of the next sequential page of results. Use
    /// the token that is returned with a previous call to this operation. To start
    /// at the beginning of the result set, do not specify a value.
    next_token: ?[]const u8 = null,

    /// The earliest date to retrieve event logs for. If no start time is specified,
    /// this call
    /// returns entries starting from when the fleet was created to the specified
    /// end time.
    /// Format is a number expressed in Unix time as milliseconds (ex:
    /// "1469498468.057").
    start_time: ?i64 = null,

    pub const json_field_names = .{
        .end_time = "EndTime",
        .fleet_id = "FleetId",
        .limit = "Limit",
        .next_token = "NextToken",
        .start_time = "StartTime",
    };
};

pub const DescribeFleetEventsOutput = struct {
    /// A collection of objects containing event log entries for the specified
    /// fleet.
    events: ?[]const Event = null,

    /// A token that indicates where to resume retrieving results on the next call
    /// to this operation. If no token is returned, these results represent the end
    /// of the list.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .events = "Events",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeFleetEventsInput, options: CallOptions) !DescribeFleetEventsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "gamelift", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeFleetEventsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("gamelift", "GameLift", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "GameLift.DescribeFleetEvents");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeFleetEventsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeFleetEventsOutput, body, allocator);
}
