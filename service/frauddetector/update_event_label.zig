const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const UpdateEventLabelInput = struct {
    /// The new label to assign to the event.
    assigned_label: []const u8,

    /// The ID of the event associated with the label to update.
    event_id: []const u8,

    /// The event type of the event associated with the label to update.
    event_type_name: []const u8,

    /// The timestamp associated with the label. The timestamp must be specified
    /// using ISO 8601 standard in UTC.
    label_timestamp: []const u8,

    pub const json_field_names = .{
        .assigned_label = "assignedLabel",
        .event_id = "eventId",
        .event_type_name = "eventTypeName",
        .label_timestamp = "labelTimestamp",
    };
};

pub const UpdateEventLabelOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateEventLabelInput, options: CallOptions) !UpdateEventLabelOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "frauddetector", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateEventLabelInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("frauddetector", "FraudDetector", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSHawksNestServiceFacade.UpdateEventLabel");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateEventLabelOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
}
