const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const DeleteConfigurationSetEventDestinationInput = struct {
    /// The name of the configuration set that contains the event destination to
    /// delete.
    configuration_set_name: []const u8,

    /// The name of the event destination to delete.
    event_destination_name: []const u8,

    pub const json_field_names = .{
        .configuration_set_name = "ConfigurationSetName",
        .event_destination_name = "EventDestinationName",
    };
};

pub const DeleteConfigurationSetEventDestinationOutput = struct {
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeleteConfigurationSetEventDestinationInput, options: CallOptions) !DeleteConfigurationSetEventDestinationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DeleteConfigurationSetEventDestinationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("email", "SESv2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v2/email/configuration-sets/");
    try path_buf.appendSlice(allocator, input.configuration_set_name);
    try path_buf.appendSlice(allocator, "/event-destinations/");
    try path_buf.appendSlice(allocator, input.event_destination_name);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeleteConfigurationSetEventDestinationOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: DeleteConfigurationSetEventDestinationOutput = .{};

    return result;
}
