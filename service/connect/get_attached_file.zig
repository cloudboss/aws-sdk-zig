const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CreatedByInfo = @import("created_by_info.zig").CreatedByInfo;
const DownloadUrlMetadata = @import("download_url_metadata.zig").DownloadUrlMetadata;
const FileStatusType = @import("file_status_type.zig").FileStatusType;
const FileUseCaseType = @import("file_use_case_type.zig").FileUseCaseType;

pub const GetAttachedFileInput = struct {
    /// The resource to which the attached file is (being) uploaded to. The
    /// supported resources are
    /// [Cases](https://docs.aws.amazon.com/connect/latest/adminguide/cases.html),
    /// [Email](https://docs.aws.amazon.com/connect/latest/adminguide/setup-email-channel.html), and [Task](https://docs.aws.amazon.com/connect/latest/adminguide/concepts-getting-started-tasks.html).
    ///
    /// This value must be a valid ARN.
    associated_resource_arn: []const u8,

    /// The unique identifier of the attached file resource.
    file_id: []const u8,

    /// The unique identifier of the Connect Customer instance.
    instance_id: []const u8,

    /// Optional override for the expiry of the pre-signed S3 URL in seconds. The
    /// default value is 300.
    url_expiry_in_seconds: ?i32 = null,

    pub const json_field_names = .{
        .associated_resource_arn = "AssociatedResourceArn",
        .file_id = "FileId",
        .instance_id = "InstanceId",
        .url_expiry_in_seconds = "UrlExpiryInSeconds",
    };
};

pub const GetAttachedFileOutput = struct {
    /// The resource to which the attached file is (being) uploaded to. The
    /// supported resources are
    /// [Cases](https://docs.aws.amazon.com/connect/latest/adminguide/cases.html),
    /// [Email](https://docs.aws.amazon.com/connect/latest/adminguide/setup-email-channel.html), and [Task](https://docs.aws.amazon.com/connect/latest/adminguide/concepts-getting-started-tasks.html).
    associated_resource_arn: ?[]const u8 = null,

    /// Represents the identity that created the file.
    created_by: ?CreatedByInfo = null,

    /// The time of Creation of the file resource as an ISO timestamp. It's
    /// specified in ISO 8601 format:
    /// `yyyy-MM-ddThh:mm:ss.SSSZ`. For example, `2024-05-03T02:41:28.172Z`.
    creation_time: ?[]const u8 = null,

    /// URL and expiry to be used when downloading the attached file.
    download_url_metadata: ?DownloadUrlMetadata = null,

    /// The unique identifier of the attached file resource (ARN).
    file_arn: ?[]const u8 = null,

    /// The unique identifier of the attached file resource.
    file_id: ?[]const u8 = null,

    /// A case-sensitive name of the attached file being uploaded.
    file_name: ?[]const u8 = null,

    /// The size of the attached file in bytes.
    file_size_in_bytes: i64,

    /// The current status of the attached file.
    file_status: ?FileStatusType = null,

    /// The use case for the file.
    file_use_case_type: ?FileUseCaseType = null,

    /// The tags used to organize, track, or control access for this resource. For
    /// example, `{ "Tags":
    /// {"key1":"value1", "key2":"value2"} }`.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .associated_resource_arn = "AssociatedResourceArn",
        .created_by = "CreatedBy",
        .creation_time = "CreationTime",
        .download_url_metadata = "DownloadUrlMetadata",
        .file_arn = "FileArn",
        .file_id = "FileId",
        .file_name = "FileName",
        .file_size_in_bytes = "FileSizeInBytes",
        .file_status = "FileStatus",
        .file_use_case_type = "FileUseCaseType",
        .tags = "Tags",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetAttachedFileInput, options: CallOptions) !GetAttachedFileOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetAttachedFileInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("connect", "Connect", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/attached-files/");
    try path_buf.appendSlice(allocator, input.instance_id);
    try path_buf.appendSlice(allocator, "/");
    try path_buf.appendSlice(allocator, input.file_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "associatedResourceArn=");
    try aws.url.appendUrlEncoded(allocator, &query_buf, input.associated_resource_arn);
    query_has_prev = true;
    if (input.url_expiry_in_seconds) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "urlExpiryInSeconds=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetAttachedFileOutput {
    const result: GetAttachedFileOutput = try aws.json.parseJsonObject(
        GetAttachedFileOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
