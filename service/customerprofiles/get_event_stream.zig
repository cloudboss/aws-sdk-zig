const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const EventStreamDestinationDetails = @import("event_stream_destination_details.zig").EventStreamDestinationDetails;
const EventStreamState = @import("event_stream_state.zig").EventStreamState;

pub const GetEventStreamInput = struct {
    /// The unique name of the domain.
    domain_name: []const u8,

    /// The name of the event stream provided during create operations.
    event_stream_name: []const u8,

    pub const json_field_names = .{
        .domain_name = "DomainName",
        .event_stream_name = "EventStreamName",
    };
};

pub const GetEventStreamOutput = struct {
    /// The timestamp of when the export was created.
    created_at: i64,

    /// Details regarding the Kinesis stream.
    destination_details: ?EventStreamDestinationDetails = null,

    /// The unique name of the domain.
    domain_name: []const u8,

    /// A unique identifier for the event stream.
    event_stream_arn: []const u8,

    /// The operational state of destination stream for export.
    state: EventStreamState,

    /// The timestamp when the `State` changed to `STOPPED`.
    stopped_since: ?i64 = null,

    /// The tags used to organize, track, or control access for this resource.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .created_at = "CreatedAt",
        .destination_details = "DestinationDetails",
        .domain_name = "DomainName",
        .event_stream_arn = "EventStreamArn",
        .state = "State",
        .stopped_since = "StoppedSince",
        .tags = "Tags",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetEventStreamInput, options: CallOptions) !GetEventStreamOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "profile", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetEventStreamInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("profile", "Customer Profiles", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/domains/");
    try path_buf.appendSlice(allocator, input.domain_name);
    try path_buf.appendSlice(allocator, "/event-streams/");
    try path_buf.appendSlice(allocator, input.event_stream_name);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetEventStreamOutput {
    var result: GetEventStreamOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetEventStreamOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
