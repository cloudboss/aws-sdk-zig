const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const InitiateMultipartUploadInput = struct {
    /// The `AccountId` value is the AWS account ID of the account that owns the
    /// vault. You can either specify an AWS account ID or optionally a single '`-`'
    /// (hyphen), in which case Amazon Glacier uses the AWS account ID associated
    /// with the
    /// credentials used to sign the request. If you use an account ID, do not
    /// include any hyphens
    /// ('-') in the ID.
    account_id: []const u8,

    /// The archive description that you are uploading in parts.
    ///
    /// The part size must be a megabyte (1024 KB) multiplied by a power of 2, for
    /// example
    /// 1048576 (1 MB), 2097152 (2 MB), 4194304 (4 MB), 8388608 (8 MB), and so on.
    /// The minimum
    /// allowable part size is 1 MB, and the maximum is 4 GB (4096 MB).
    archive_description: ?[]const u8 = null,

    /// The size of each part except the last, in bytes. The last part can be
    /// smaller than
    /// this part size.
    part_size: ?[]const u8 = null,

    /// The name of the vault.
    vault_name: []const u8,

    pub const json_field_names = .{
        .account_id = "accountId",
        .archive_description = "archiveDescription",
        .part_size = "partSize",
        .vault_name = "vaultName",
    };
};

pub const InitiateMultipartUploadOutput = struct {
    /// The relative URI path of the multipart upload ID Amazon Glacier created.
    location: ?[]const u8 = null,

    /// The ID of the multipart upload. This value is also included as part of the
    /// location.
    upload_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .location = "location",
        .upload_id = "uploadId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: InitiateMultipartUploadInput, options: CallOptions) !InitiateMultipartUploadOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "glacier", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: InitiateMultipartUploadInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("glacier", "Glacier", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/");
    try path_buf.appendSlice(allocator, input.account_id);
    try path_buf.appendSlice(allocator, "/vaults/");
    try path_buf.appendSlice(allocator, input.vault_name);
    try path_buf.appendSlice(allocator, "/multipart-uploads");
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");
    if (input.archive_description) |v| {
        try request.headers.put(allocator, "x-amz-archive-description", v);
    }
    if (input.part_size) |v| {
        try request.headers.put(allocator, "x-amz-part-size", v);
    }

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !InitiateMultipartUploadOutput {
    var result: InitiateMultipartUploadOutput = .{};
    _ = body;
    _ = status;
    if (headers.get("location")) |value| {
        result.location = try allocator.dupe(u8, value);
    }
    if (headers.get("x-amz-multipart-upload-id")) |value| {
        result.upload_id = try allocator.dupe(u8, value);
    }

    return result;
}
