const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Tag = @import("tag.zig").Tag;

pub const UpdateSnapshotScheduleInput = struct {
    /// Optional description of the snapshot that overwrites the existing
    /// description.
    description: ?[]const u8 = null,

    /// Frequency of snapshots. Specify the number of hours between snapshots.
    recurrence_in_hours: i32,

    /// The hour of the day at which the snapshot schedule begins represented as
    /// *hh*, where *hh* is the hour (0 to 23). The hour
    /// of the day is in the time zone of the gateway.
    start_at: i32,

    /// A list of up to 50 tags that can be assigned to a snapshot. Each tag is a
    /// key-value
    /// pair.
    ///
    /// Valid characters for key and value are letters, spaces, and numbers
    /// representable in
    /// UTF-8 format, and the following special characters: + - = . _ : / @. The
    /// maximum length
    /// of a tag's key is 128 characters, and the maximum length for a tag's value
    /// is
    /// 256.
    tags: ?[]const Tag = null,

    /// The Amazon Resource Name (ARN) of the volume. Use the ListVolumes
    /// operation to return a list of gateway volumes.
    volume_arn: []const u8,

    pub const json_field_names = .{
        .description = "Description",
        .recurrence_in_hours = "RecurrenceInHours",
        .start_at = "StartAt",
        .tags = "Tags",
        .volume_arn = "VolumeARN",
    };
};

pub const UpdateSnapshotScheduleOutput = struct {
    /// The Amazon Resource Name (ARN) of the volume. Use the ListVolumes
    /// operation to return a list of gateway volumes.
    volume_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .volume_arn = "VolumeARN",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateSnapshotScheduleInput, options: CallOptions) !UpdateSnapshotScheduleOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "storagegateway", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateSnapshotScheduleInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("storagegateway", "Storage Gateway", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "StorageGateway_20130630.UpdateSnapshotSchedule");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateSnapshotScheduleOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(UpdateSnapshotScheduleOutput, body, allocator);
}
