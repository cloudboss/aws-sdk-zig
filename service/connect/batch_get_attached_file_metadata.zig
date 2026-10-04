const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AttachedFileError = @import("attached_file_error.zig").AttachedFileError;
const AttachedFile = @import("attached_file.zig").AttachedFile;

pub const BatchGetAttachedFileMetadataInput = struct {
    /// The resource to which the attached file is (being) uploaded to. The
    /// supported resources are
    /// [Cases](https://docs.aws.amazon.com/connect/latest/adminguide/cases.html)
    /// and
    /// [Email](https://docs.aws.amazon.com/connect/latest/adminguide/setup-email-channel.html).
    ///
    /// This value must be a valid ARN.
    associated_resource_arn: []const u8,

    /// The unique identifiers of the attached file resource.
    file_ids: []const []const u8,

    /// The unique identifier of the Connect instance.
    instance_id: []const u8,

    pub const json_field_names = .{
        .associated_resource_arn = "AssociatedResourceArn",
        .file_ids = "FileIds",
        .instance_id = "InstanceId",
    };
};

pub const BatchGetAttachedFileMetadataOutput = struct {
    /// List of errors of attached files that could not be retrieved.
    errors: ?[]const AttachedFileError = null,

    /// List of attached files that were successfully retrieved.
    files: ?[]const AttachedFile = null,

    pub const json_field_names = .{
        .errors = "Errors",
        .files = "Files",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: BatchGetAttachedFileMetadataInput, options: CallOptions) !BatchGetAttachedFileMetadataOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: BatchGetAttachedFileMetadataInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("connect", "Connect", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/attached-files/");
    try path_buf.appendSlice(allocator, input.instance_id);
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

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"FileIds\":");
    try aws.json.writeValue(@TypeOf(input.file_ids), input.file_ids, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !BatchGetAttachedFileMetadataOutput {
    var result: BatchGetAttachedFileMetadataOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(BatchGetAttachedFileMetadataOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
