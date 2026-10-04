const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Tag = @import("tag.zig").Tag;
const DestinationBackup = @import("destination_backup.zig").DestinationBackup;

pub const CopyBackupToRegionInput = struct {
    /// The ID of the backup that will be copied to the destination region.
    backup_id: []const u8,

    /// The AWS region that will contain your copied CloudHSM cluster backup.
    destination_region: []const u8,

    /// Tags to apply to the destination backup during creation. If you specify
    /// tags, only these tags will be applied to the destination backup. If you do
    /// not specify tags, the service copies tags from the source backup to the
    /// destination backup.
    tag_list: ?[]const Tag = null,

    pub const json_field_names = .{
        .backup_id = "BackupId",
        .destination_region = "DestinationRegion",
        .tag_list = "TagList",
    };
};

pub const CopyBackupToRegionOutput = struct {
    /// Information on the backup that will be copied to the destination region,
    /// including
    /// CreateTimestamp, SourceBackup, SourceCluster, and Source Region.
    /// CreateTimestamp of the
    /// destination backup will be the same as that of the source backup.
    ///
    /// You will need to use the `sourceBackupID` returned in this operation to use
    /// the DescribeBackups operation on the backup that will be copied to the
    /// destination region.
    destination_backup: ?DestinationBackup = null,

    pub const json_field_names = .{
        .destination_backup = "DestinationBackup",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CopyBackupToRegionInput, options: CallOptions) !CopyBackupToRegionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "cloudhsm", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CopyBackupToRegionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cloudhsmv2", "CloudHSM V2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "BaldrApiService.CopyBackupToRegion");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CopyBackupToRegionOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CopyBackupToRegionOutput, body, allocator);
}
