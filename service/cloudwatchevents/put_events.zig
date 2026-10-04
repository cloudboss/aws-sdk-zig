const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const PutEventsRequestEntry = @import("put_events_request_entry.zig").PutEventsRequestEntry;
const PutEventsResultEntry = @import("put_events_result_entry.zig").PutEventsResultEntry;

pub const PutEventsInput = struct {
    /// The entry that defines an event in your system. You can specify several
    /// parameters for the
    /// entry such as the source and type of the event, resources associated with
    /// the event, and so
    /// on.
    entries: []const PutEventsRequestEntry,

    pub const json_field_names = .{
        .entries = "Entries",
    };
};

pub const PutEventsOutput = struct {
    /// The successfully and unsuccessfully ingested events results. If the
    /// ingestion was
    /// successful, the entry has the event ID in it. Otherwise, you can use the
    /// error code and error
    /// message to identify the problem with the entry.
    entries: ?[]const PutEventsResultEntry = null,

    /// The number of failed entries.
    failed_entry_count: ?i32 = null,

    pub const json_field_names = .{
        .entries = "Entries",
        .failed_entry_count = "FailedEntryCount",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutEventsInput, options: CallOptions) !PutEventsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: PutEventsInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSEvents.PutEvents");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PutEventsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(PutEventsOutput, body, allocator);
}
