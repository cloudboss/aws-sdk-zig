const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const UploadArchiveInput = struct {
    /// The `AccountId` value is the AWS account ID of the account that owns the
    /// vault. You can either specify an AWS account ID or optionally a single '`-`'
    /// (hyphen), in which case Amazon Glacier uses the AWS account ID associated
    /// with the
    /// credentials used to sign the request. If you use an account ID, do not
    /// include any hyphens
    /// ('-') in the ID.
    account_id: []const u8,

    /// The optional description of the archive you are uploading.
    archive_description: ?[]const u8 = null,

    /// The data to upload.
    body: ?[]const u8 = null,

    /// The SHA256 tree hash of the data being uploaded.
    checksum: ?[]const u8 = null,

    /// The name of the vault.
    vault_name: []const u8,

    pub const json_field_names = .{
        .account_id = "accountId",
        .archive_description = "archiveDescription",
        .body = "body",
        .checksum = "checksum",
        .vault_name = "vaultName",
    };
};

pub const UploadArchiveOutput = struct {
    /// The ID of the archive. This value is also included as part of the location.
    archive_id: ?[]const u8 = null,

    /// The checksum of the archive computed by Amazon Glacier.
    checksum: ?[]const u8 = null,

    /// The relative URI path of the newly added archive resource.
    location: ?[]const u8 = null,

    pub const json_field_names = .{
        .archive_id = "archiveId",
        .checksum = "checksum",
        .location = "location",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UploadArchiveInput, options: CallOptions) !UploadArchiveOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UploadArchiveInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("glacier", "Glacier", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/");
    try path_buf.appendSlice(allocator, input.account_id);
    try path_buf.appendSlice(allocator, "/vaults/");
    try path_buf.appendSlice(allocator, input.vault_name);
    try path_buf.appendSlice(allocator, "/archives");
    const path = try path_buf.toOwnedSlice(allocator);

    const body = input.body orelse "";

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
    if (input.checksum) |v| {
        try request.headers.put(allocator, "x-amz-sha256-tree-hash", v);
    }

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UploadArchiveOutput {
    var result: UploadArchiveOutput = .{};
    errdefer {
        if (result.archive_id) |value| allocator.free(value);
        if (result.checksum) |value| allocator.free(value);
        if (result.location) |value| allocator.free(value);
    }
    _ = body;
    _ = status;
    if (headers.get("x-amz-archive-id")) |value| {
        result.archive_id = try allocator.dupe(u8, value);
    }
    if (headers.get("x-amz-sha256-tree-hash")) |value| {
        result.checksum = try allocator.dupe(u8, value);
    }
    if (headers.get("location")) |value| {
        result.location = try allocator.dupe(u8, value);
    }

    return result;
}
