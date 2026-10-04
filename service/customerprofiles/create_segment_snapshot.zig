const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DataFormat = @import("data_format.zig").DataFormat;

pub const CreateSegmentSnapshotInput = struct {
    /// The format in which the segment will be exported.
    data_format: DataFormat,

    /// The destination to which the segment will be exported. This field must be
    /// provided if
    /// the request is not submitted from the Connect Customer Admin Website.
    destination_uri: ?[]const u8 = null,

    /// The unique name of the domain.
    domain_name: []const u8,

    /// The Amazon Resource Name (ARN) of the KMS key used to encrypt the exported
    /// segment.
    encryption_key: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the IAM role that allows Customer Profiles
    /// service
    /// principal to assume the role for conducting KMS and S3 operations.
    role_arn: ?[]const u8 = null,

    /// The name of the segment definition used in this snapshot request.
    segment_definition_name: []const u8,

    pub const json_field_names = .{
        .data_format = "DataFormat",
        .destination_uri = "DestinationUri",
        .domain_name = "DomainName",
        .encryption_key = "EncryptionKey",
        .role_arn = "RoleArn",
        .segment_definition_name = "SegmentDefinitionName",
    };
};

pub const CreateSegmentSnapshotOutput = struct {
    /// The unique identifier of the segment snapshot.
    snapshot_id: []const u8,

    pub const json_field_names = .{
        .snapshot_id = "SnapshotId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateSegmentSnapshotInput, options: CallOptions) !CreateSegmentSnapshotOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateSegmentSnapshotInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("profile", "Customer Profiles", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/domains/");
    try path_buf.appendSlice(allocator, input.domain_name);
    try path_buf.appendSlice(allocator, "/segments/");
    try path_buf.appendSlice(allocator, input.segment_definition_name);
    try path_buf.appendSlice(allocator, "/snapshots");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"DataFormat\":");
    try aws.json.writeValue(@TypeOf(input.data_format), input.data_format, allocator, &body_buf);
    has_prev = true;
    if (input.destination_uri) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"DestinationUri\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.encryption_key) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"EncryptionKey\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.role_arn) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"RoleArn\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateSegmentSnapshotOutput {
    const result: CreateSegmentSnapshotOutput = try aws.json.parseJsonObject(
        CreateSegmentSnapshotOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
