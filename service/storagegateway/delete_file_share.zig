const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const DeleteFileShareInput = struct {
    /// The Amazon Resource Name (ARN) of the file share to be deleted.
    file_share_arn: []const u8,

    /// If this value is set to `true`, the operation deletes a file share
    /// immediately and aborts all data uploads to Amazon Web Services. Otherwise,
    /// the file share is
    /// not deleted until all data is uploaded to Amazon Web Services. This process
    /// aborts the data
    /// upload process, and the file share enters the `FORCE_DELETING` status.
    ///
    /// Valid Values: `true` | `false`
    force_delete: ?bool = null,

    pub const json_field_names = .{
        .file_share_arn = "FileShareARN",
        .force_delete = "ForceDelete",
    };
};

pub const DeleteFileShareOutput = struct {
    /// The Amazon Resource Name (ARN) of the deleted file share.
    file_share_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .file_share_arn = "FileShareARN",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeleteFileShareInput, options: CallOptions) !DeleteFileShareOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DeleteFileShareInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "StorageGateway_20130630.DeleteFileShare");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeleteFileShareOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DeleteFileShareOutput, body, allocator);
}
