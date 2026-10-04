const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ArchiveState = @import("archive_state.zig").ArchiveState;

pub const CreateArchiveInput = struct {
    /// The name for the archive to create.
    archive_name: []const u8,

    /// A description for the archive.
    description: ?[]const u8 = null,

    /// An event pattern to use to filter events sent to the archive.
    event_pattern: ?[]const u8 = null,

    /// The ARN of the event bus that sends events to the archive.
    event_source_arn: []const u8,

    /// The number of days to retain events for. Default value is 0. If set to 0,
    /// events are
    /// retained indefinitely
    retention_days: ?i32 = null,

    pub const json_field_names = .{
        .archive_name = "ArchiveName",
        .description = "Description",
        .event_pattern = "EventPattern",
        .event_source_arn = "EventSourceArn",
        .retention_days = "RetentionDays",
    };
};

pub const CreateArchiveOutput = struct {
    /// The ARN of the archive that was created.
    archive_arn: ?[]const u8 = null,

    /// The time at which the archive was created.
    creation_time: ?i64 = null,

    /// The state of the archive that was created.
    state: ?ArchiveState = null,

    /// The reason that the archive is in the state.
    state_reason: ?[]const u8 = null,

    pub const json_field_names = .{
        .archive_arn = "ArchiveArn",
        .creation_time = "CreationTime",
        .state = "State",
        .state_reason = "StateReason",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateArchiveInput, options: CallOptions) !CreateArchiveOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateArchiveInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSEvents.CreateArchive");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateArchiveOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateArchiveOutput, body, allocator);
}
