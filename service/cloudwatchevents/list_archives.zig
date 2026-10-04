const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ArchiveState = @import("archive_state.zig").ArchiveState;
const Archive = @import("archive.zig").Archive;

pub const ListArchivesInput = struct {
    /// The ARN of the event source associated with the archive.
    event_source_arn: ?[]const u8 = null,

    /// The maximum number of results to return.
    limit: ?i32 = null,

    /// A name prefix to filter the archives returned. Only archives with name that
    /// match the
    /// prefix are returned.
    name_prefix: ?[]const u8 = null,

    /// The token returned by a previous call to retrieve the next set of results.
    next_token: ?[]const u8 = null,

    /// The state of the archive.
    state: ?ArchiveState = null,

    pub const json_field_names = .{
        .event_source_arn = "EventSourceArn",
        .limit = "Limit",
        .name_prefix = "NamePrefix",
        .next_token = "NextToken",
        .state = "State",
    };
};

pub const ListArchivesOutput = struct {
    /// An array of `Archive` objects that include details about an archive.
    archives: ?[]const Archive = null,

    /// The token returned by a previous call to retrieve the next set of results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .archives = "Archives",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListArchivesInput, options: CallOptions) !ListArchivesOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListArchivesInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSEvents.ListArchives");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListArchivesOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListArchivesOutput, body, allocator);
}
