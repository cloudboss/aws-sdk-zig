const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const EvictFilesFailingUploadInput = struct {
    /// The Amazon Resource Name (ARN) of the file share for which you want to start
    /// the cache
    /// clean operation.
    file_share_arn: []const u8,

    /// Specifies whether cache entries with full or partial file data currently
    /// stored on the
    /// gateway will be forcibly removed by the cache clean operation.
    ///
    /// Valid arguments:
    ///
    /// * `False` - The cache clean operation skips cache entries failing upload
    /// if they are associated with data currently stored on the gateway. This
    /// preserves the
    /// cached data.
    ///
    /// * `True` - The cache clean operation removes cache entries failing upload
    /// even if they are associated with data currently stored on the gateway. This
    /// deletes
    /// the cached data.
    ///
    /// If `ForceRemove` is set to `True`, the cache clean
    /// operation will delete file data from the gateway which might otherwise be
    /// recoverable.
    force_remove: ?bool = null,

    pub const json_field_names = .{
        .file_share_arn = "FileShareARN",
        .force_remove = "ForceRemove",
    };
};

pub const EvictFilesFailingUploadOutput = struct {
    /// The randomly generated ID of the CloudWatch notification associated with the
    /// cache clean operation. This ID is in UUID format.
    notification_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .notification_id = "NotificationId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: EvictFilesFailingUploadInput, options: CallOptions) !EvictFilesFailingUploadOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: EvictFilesFailingUploadInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "StorageGateway_20130630.EvictFilesFailingUpload");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !EvictFilesFailingUploadOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(EvictFilesFailingUploadOutput, body, allocator);
}
