const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const FileUseCaseType = @import("file_use_case_type.zig").FileUseCaseType;
const FileStatusType = @import("file_status_type.zig").FileStatusType;

pub const CreateAttachedFileInput = struct {
    /// The ARN of the completed voice contact to attach the file to. Only voice
    /// contacts with Telephony subtype are
    /// supported.
    ///
    /// This value must be a valid ARN.
    associated_resource_arn: []const u8,

    /// A unique, case-sensitive identifier that you provide to ensure the
    /// idempotency of the
    /// request. If not provided, the Amazon Web Services
    /// SDK populates this field. For more information about idempotency, see
    /// [Making retries safe with idempotent
    /// APIs](https://aws.amazon.com/builders-library/making-retries-safe-with-idempotent-APIs/).
    client_token: ?[]const u8 = null,

    /// The S3 URI of the file to be attached. Only S3 source URIs are supported.
    file_source_uri: []const u8,

    /// The use case for the file.
    ///
    /// Only `VOICE_RECORDING` is supported.
    file_use_case_type: FileUseCaseType,

    /// The identifier of the Connect Customer instance. You can [find the instance
    /// ID](https://docs.aws.amazon.com/connect/latest/adminguide/find-instance-arn.html) in the Amazon Resource Name (ARN) of the instance.
    instance_id: []const u8,

    /// The tags used to organize, track, or control access for this resource. For
    /// example, `{ "Tags":
    /// {"key1":"value1", "key2":"value2"} }`.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .associated_resource_arn = "AssociatedResourceArn",
        .client_token = "ClientToken",
        .file_source_uri = "FileSourceUri",
        .file_use_case_type = "FileUseCaseType",
        .instance_id = "InstanceId",
        .tags = "Tags",
    };
};

pub const CreateAttachedFileOutput = struct {
    /// The time of Creation of the file resource as an ISO timestamp. It's
    /// specified in ISO 8601 format:
    /// `yyyy-MM-ddThh:mm:ss.SSSZ`. For example, `2024-05-03T02:41:28.172Z`.
    creation_time: ?[]const u8 = null,

    /// The unique identifier of the attached file resource (ARN).
    file_arn: ?[]const u8 = null,

    /// The unique identifier of the attached file resource.
    file_id: ?[]const u8 = null,

    /// The current status of the attached file. Valid values: `PROCESSING` |
    /// `APPROVED` |
    /// `REJECTED` | `FAILED`.
    file_status: ?FileStatusType = null,

    pub const json_field_names = .{
        .creation_time = "CreationTime",
        .file_arn = "FileArn",
        .file_id = "FileId",
        .file_status = "FileStatus",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateAttachedFileInput, options: CallOptions) !CreateAttachedFileOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "connect", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateAttachedFileInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("connect", "Connect", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/attached-files/");
    try path_buf.appendSlice(allocator, input.instance_id);
    try path_buf.appendSlice(allocator, "/files");
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "associatedResourceArn=");
    try aws.url.appendUrlEncoded(allocator, &query_buf, input.associated_resource_arn);
    query_has_prev = true;
    const query = try query_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ClientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"FileSourceUri\":");
    try aws.json.writeValue(@TypeOf(input.file_source_uri), input.file_source_uri, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"FileUseCaseType\":");
    try aws.json.writeValue(@TypeOf(input.file_use_case_type), input.file_use_case_type, allocator, &body_buf);
    has_prev = true;
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Tags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PUT;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateAttachedFileOutput {
    const result: CreateAttachedFileOutput = try aws.json.parseJsonObject(
        CreateAttachedFileOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
