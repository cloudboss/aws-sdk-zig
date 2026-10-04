const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DataFormat = @import("data_format.zig").DataFormat;
const SegmentSnapshotStatus = @import("segment_snapshot_status.zig").SegmentSnapshotStatus;

pub const GetSegmentSnapshotInput = struct {
    /// The unique identifier of the domain.
    domain_name: []const u8,

    /// The unique name of the segment definition.
    segment_definition_name: []const u8,

    /// The unique identifier of the segment snapshot.
    snapshot_id: []const u8,

    pub const json_field_names = .{
        .domain_name = "DomainName",
        .segment_definition_name = "SegmentDefinitionName",
        .snapshot_id = "SnapshotId",
    };
};

pub const GetSegmentSnapshotOutput = struct {
    /// The format in which the segment will be exported.
    data_format: DataFormat,

    /// The destination to which the segment will be exported. This field must be
    /// provided if
    /// the request is not submitted from the Connect Customer Admin Website.
    destination_uri: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the KMS key used to encrypt the exported
    /// segment.
    encryption_key: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the IAM role that allows Customer Profiles
    /// service
    /// principal to assume the role for conducting KMS and S3 operations.
    role_arn: ?[]const u8 = null,

    /// The unique identifier of the segment snapshot.
    snapshot_id: []const u8,

    /// The status of the asynchronous job for exporting the segment snapshot.
    status: SegmentSnapshotStatus,

    /// The status message of the asynchronous job for exporting the segment
    /// snapshot.
    status_message: ?[]const u8 = null,

    pub const json_field_names = .{
        .data_format = "DataFormat",
        .destination_uri = "DestinationUri",
        .encryption_key = "EncryptionKey",
        .role_arn = "RoleArn",
        .snapshot_id = "SnapshotId",
        .status = "Status",
        .status_message = "StatusMessage",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetSegmentSnapshotInput, options: CallOptions) !GetSegmentSnapshotOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "profile", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetSegmentSnapshotInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("profile", "Customer Profiles", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/domains/");
    try path_buf.appendSlice(allocator, input.domain_name);
    try path_buf.appendSlice(allocator, "/segments/");
    try path_buf.appendSlice(allocator, input.segment_definition_name);
    try path_buf.appendSlice(allocator, "/snapshots/");
    try path_buf.appendSlice(allocator, input.snapshot_id);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetSegmentSnapshotOutput {
    const result: GetSegmentSnapshotOutput = try aws.json.parseJsonObject(
        GetSegmentSnapshotOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
