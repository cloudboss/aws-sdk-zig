const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Tag = @import("tag.zig").Tag;
const Backup = @import("backup.zig").Backup;

pub const CopyBackupInput = struct {
    client_request_token: ?[]const u8 = null,

    /// A Boolean flag indicating whether tags from the source backup should be
    /// copied to the
    /// backup copy. This value defaults to `false`.
    ///
    /// If you set `CopyTags` to `true` and the source backup has existing
    /// tags, you can use the `Tags` parameter to create new tags, provided that the
    /// sum
    /// of the source backup tags and the new tags doesn't exceed 50. Both sets of
    /// tags are
    /// merged. If there are tag conflicts (for example, two tags with the same key
    /// but different
    /// values), the tags created with the `Tags` parameter take precedence.
    copy_tags: ?bool = null,

    kms_key_id: ?[]const u8 = null,

    /// The ID of the source backup. Specifies the ID of the backup that's being
    /// copied.
    source_backup_id: []const u8,

    /// The source Amazon Web Services Region of the backup. Specifies the Amazon
    /// Web Services Region from which the backup is being copied. The source and
    /// destination
    /// Regions must be in the same Amazon Web Services partition. If you don't
    /// specify a
    /// Region, `SourceRegion` defaults to the Region where the request is sent from
    /// (in-Region copy).
    source_region: ?[]const u8 = null,

    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .client_request_token = "ClientRequestToken",
        .copy_tags = "CopyTags",
        .kms_key_id = "KmsKeyId",
        .source_backup_id = "SourceBackupId",
        .source_region = "SourceRegion",
        .tags = "Tags",
    };
};

pub const CopyBackupOutput = struct {
    backup: ?Backup = null,

    pub const json_field_names = .{
        .backup = "Backup",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CopyBackupInput, options: CallOptions) !CopyBackupOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "fsx", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CopyBackupInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("fsx", "FSx", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSSimbaAPIService_v20180301.CopyBackup");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CopyBackupOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CopyBackupOutput, body, allocator);
}
