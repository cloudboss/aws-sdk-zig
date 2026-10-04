const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const MultiplexOutputDestination = @import("multiplex_output_destination.zig").MultiplexOutputDestination;
const MultiplexSettings = @import("multiplex_settings.zig").MultiplexSettings;
const MultiplexState = @import("multiplex_state.zig").MultiplexState;

pub const StartMultiplexInput = struct {
    /// The ID of the multiplex.
    multiplex_id: []const u8,

    pub const json_field_names = .{
        .multiplex_id = "MultiplexId",
    };
};

pub const StartMultiplexOutput = struct {
    /// The unique arn of the multiplex.
    arn: ?[]const u8 = null,

    /// A list of availability zones for the multiplex.
    availability_zones: ?[]const []const u8 = null,

    /// A list of the multiplex output destinations.
    destinations: ?[]const MultiplexOutputDestination = null,

    /// The unique id of the multiplex.
    id: ?[]const u8 = null,

    /// Configuration for a multiplex event.
    multiplex_settings: ?MultiplexSettings = null,

    /// The name of the multiplex.
    name: ?[]const u8 = null,

    /// The number of currently healthy pipelines.
    pipelines_running_count: ?i32 = null,

    /// The number of programs in the multiplex.
    program_count: ?i32 = null,

    /// The current state of the multiplex.
    state: ?MultiplexState = null,

    /// A collection of key-value pairs.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .availability_zones = "AvailabilityZones",
        .destinations = "Destinations",
        .id = "Id",
        .multiplex_settings = "MultiplexSettings",
        .name = "Name",
        .pipelines_running_count = "PipelinesRunningCount",
        .program_count = "ProgramCount",
        .state = "State",
        .tags = "Tags",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartMultiplexInput, options: CallOptions) !StartMultiplexOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "medialive", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: StartMultiplexInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("medialive", "MediaLive", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/prod/multiplexes/");
    try path_buf.appendSlice(allocator, input.multiplex_id);
    try path_buf.appendSlice(allocator, "/start");
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartMultiplexOutput {
    var result: StartMultiplexOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(StartMultiplexOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
