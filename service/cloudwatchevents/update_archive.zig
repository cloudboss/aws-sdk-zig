const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ArchiveState = @import("archive_state.zig").ArchiveState;

pub const UpdateArchiveInput = struct {
    /// The name of the archive to update.
    archive_name: []const u8,

    /// The description for the archive.
    description: ?[]const u8 = null,

    /// The event pattern to use to filter events sent to the archive.
    event_pattern: ?[]const u8 = null,

    /// The number of days to retain events in the archive.
    retention_days: ?i32 = null,

    pub const json_field_names = .{
        .archive_name = "ArchiveName",
        .description = "Description",
        .event_pattern = "EventPattern",
        .retention_days = "RetentionDays",
    };
};

pub const UpdateArchiveOutput = struct {
    /// The ARN of the archive.
    archive_arn: ?[]const u8 = null,

    /// The time at which the archive was updated.
    creation_time: ?i64 = null,

    /// The state of the archive.
    state: ?ArchiveState = null,

    /// The reason that the archive is in the current state.
    state_reason: ?[]const u8 = null,

    pub const json_field_names = .{
        .archive_arn = "ArchiveArn",
        .creation_time = "CreationTime",
        .state = "State",
        .state_reason = "StateReason",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateArchiveInput, options: CallOptions) !UpdateArchiveOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateArchiveInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSEvents.UpdateArchive");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateArchiveOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(UpdateArchiveOutput, body, allocator);
}
