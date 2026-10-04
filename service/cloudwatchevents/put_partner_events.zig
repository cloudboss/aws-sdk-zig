const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const PutPartnerEventsRequestEntry = @import("put_partner_events_request_entry.zig").PutPartnerEventsRequestEntry;
const PutPartnerEventsResultEntry = @import("put_partner_events_result_entry.zig").PutPartnerEventsResultEntry;

pub const PutPartnerEventsInput = struct {
    /// The list of events to write to the event bus.
    entries: []const PutPartnerEventsRequestEntry,

    pub const json_field_names = .{
        .entries = "Entries",
    };
};

pub const PutPartnerEventsOutput = struct {
    /// The list of events from this operation that were successfully written to the
    /// partner event
    /// bus.
    entries: ?[]const PutPartnerEventsResultEntry = null,

    /// The number of events from this operation that could not be written to the
    /// partner event
    /// bus.
    failed_entry_count: ?i32 = null,

    pub const json_field_names = .{
        .entries = "Entries",
        .failed_entry_count = "FailedEntryCount",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutPartnerEventsInput, options: CallOptions) !PutPartnerEventsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "events", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: PutPartnerEventsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("events", "CloudWatch Events", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSEvents.PutPartnerEvents");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PutPartnerEventsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(PutPartnerEventsOutput, body, allocator);
}
