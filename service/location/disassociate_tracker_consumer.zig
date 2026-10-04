const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const DisassociateTrackerConsumerInput = struct {
    /// The Amazon Resource Name (ARN) for the geofence collection to be
    /// disassociated from the tracker resource. Used when you need to specify a
    /// resource across all Amazon Web Services.
    ///
    /// * Format example:
    ///   `arn:aws:geo:region:account-id:geofence-collection/ExampleGeofenceCollectionConsumer`
    consumer_arn: []const u8,

    /// The name of the tracker resource to be dissociated from the consumer.
    tracker_name: []const u8,

    pub const json_field_names = .{
        .consumer_arn = "ConsumerArn",
        .tracker_name = "TrackerName",
    };
};

pub const DisassociateTrackerConsumerOutput = struct {
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DisassociateTrackerConsumerInput, options: CallOptions) !DisassociateTrackerConsumerOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "geo", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DisassociateTrackerConsumerInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("geo", "Location", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/tracking/v0/trackers/");
    try path_buf.appendSlice(allocator, input.tracker_name);
    try path_buf.appendSlice(allocator, "/consumers/");
    try path_buf.appendSlice(allocator, input.consumer_arn);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .DELETE;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DisassociateTrackerConsumerOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: DisassociateTrackerConsumerOutput = .{};

    return result;
}
