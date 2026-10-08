const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const EventDestinationDefinition = @import("event_destination_definition.zig").EventDestinationDefinition;

pub const UpdateConfigurationSetEventDestinationInput = struct {
    /// The name of the configuration set that contains the event destination that
    /// you want to
    /// modify.
    configuration_set_name: []const u8,

    /// An object that defines the event destination.
    event_destination: EventDestinationDefinition,

    /// The name of the event destination that you want to modify.
    event_destination_name: []const u8,

    pub const json_field_names = .{
        .configuration_set_name = "ConfigurationSetName",
        .event_destination = "EventDestination",
        .event_destination_name = "EventDestinationName",
    };
};

pub const UpdateConfigurationSetEventDestinationOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateConfigurationSetEventDestinationInput, options: CallOptions) !UpdateConfigurationSetEventDestinationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "ses", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateConfigurationSetEventDestinationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("email", "Pinpoint Email", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v1/email/configuration-sets/");
    try path_buf.appendSlice(allocator, input.configuration_set_name);
    try path_buf.appendSlice(allocator, "/event-destinations/");
    try path_buf.appendSlice(allocator, input.event_destination_name);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"EventDestination\":");
    try aws.json.writeValue(@TypeOf(input.event_destination), input.event_destination, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PUT;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateConfigurationSetEventDestinationOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: UpdateConfigurationSetEventDestinationOutput = .{};

    return result;
}
