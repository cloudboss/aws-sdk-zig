const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ClientLocation = @import("client_location.zig").ClientLocation;
const InternetEventStatus = @import("internet_event_status.zig").InternetEventStatus;
const InternetEventType = @import("internet_event_type.zig").InternetEventType;

pub const GetInternetEventInput = struct {
    /// The `EventId` of the internet event to return information for.
    event_id: []const u8,

    pub const json_field_names = .{
        .event_id = "EventId",
    };
};

pub const GetInternetEventOutput = struct {
    /// The impacted location, such as a city, where clients access Amazon Web
    /// Services application resources.
    client_location: ?ClientLocation = null,

    /// The time when the internet event ended. If the event hasn't ended yet, this
    /// value is empty.
    ended_at: ?i64 = null,

    /// The Amazon Resource Name (ARN) of the internet event.
    event_arn: []const u8,

    /// The internally-generated identifier of an internet event.
    event_id: []const u8,

    /// The status of the internet event.
    event_status: InternetEventStatus,

    /// The type of network impairment.
    event_type: InternetEventType,

    /// The time when the internet event started.
    started_at: i64,

    pub const json_field_names = .{
        .client_location = "ClientLocation",
        .ended_at = "EndedAt",
        .event_arn = "EventArn",
        .event_id = "EventId",
        .event_status = "EventStatus",
        .event_type = "EventType",
        .started_at = "StartedAt",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetInternetEventInput, options: CallOptions) !GetInternetEventOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "internetmonitor", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetInternetEventInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("internetmonitor", "InternetMonitor", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v20210603/InternetEvents/");
    try path_buf.appendSlice(allocator, input.event_id);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetInternetEventOutput {
    var result: GetInternetEventOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetInternetEventOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
