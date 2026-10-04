const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ArchiveState = @import("archive_state.zig").ArchiveState;

pub const DescribeArchiveInput = struct {
    /// The name of the archive to retrieve.
    archive_name: []const u8,

    pub const json_field_names = .{
        .archive_name = "ArchiveName",
    };
};

pub const DescribeArchiveOutput = struct {
    /// The ARN of the archive.
    archive_arn: ?[]const u8 = null,

    /// The name of the archive.
    archive_name: ?[]const u8 = null,

    /// The time at which the archive was created.
    creation_time: ?i64 = null,

    /// The description of the archive.
    description: ?[]const u8 = null,

    /// The number of events in the archive.
    event_count: ?i64 = null,

    /// The event pattern used to filter events sent to the archive.
    event_pattern: ?[]const u8 = null,

    /// The ARN of the event source associated with the archive.
    event_source_arn: ?[]const u8 = null,

    /// The identifier of the KMS
    /// customer managed key for EventBridge to use to encrypt this archive, if one
    /// has been specified.
    ///
    /// For more information, see [Encrypting
    /// archives](https://docs.aws.amazon.com/eventbridge/latest/userguide/encryption-archives.html) in the *Amazon EventBridge User Guide*.
    kms_key_identifier: ?[]const u8 = null,

    /// The number of days to retain events for in the archive.
    retention_days: ?i32 = null,

    /// The size of the archive in bytes.
    size_bytes: ?i64 = null,

    /// The state of the archive.
    state: ?ArchiveState = null,

    /// The reason that the archive is in the state.
    state_reason: ?[]const u8 = null,

    pub const json_field_names = .{
        .archive_arn = "ArchiveArn",
        .archive_name = "ArchiveName",
        .creation_time = "CreationTime",
        .description = "Description",
        .event_count = "EventCount",
        .event_pattern = "EventPattern",
        .event_source_arn = "EventSourceArn",
        .kms_key_identifier = "KmsKeyIdentifier",
        .retention_days = "RetentionDays",
        .size_bytes = "SizeBytes",
        .state = "State",
        .state_reason = "StateReason",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeArchiveInput, options: CallOptions) !DescribeArchiveOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeArchiveInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("events", "EventBridge", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSEvents.DescribeArchive");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeArchiveOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeArchiveOutput, body, allocator);
}
