const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
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

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "cloudhsm");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: CopyBackupToRegionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cloudhsmv2", "CloudHSM V2", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
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

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "CloudHsmAccessDeniedException")) {
        return .{ .arena = arena, .kind = .{ .cloud_hsm_access_denied_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "CloudHsmInternalFailureException")) {
        return .{ .arena = arena, .kind = .{ .cloud_hsm_internal_failure_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "CloudHsmInvalidRequestException")) {
        return .{ .arena = arena, .kind = .{ .cloud_hsm_invalid_request_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "CloudHsmResourceLimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .cloud_hsm_resource_limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "CloudHsmResourceNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .cloud_hsm_resource_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "CloudHsmServiceException")) {
        return .{ .arena = arena, .kind = .{ .cloud_hsm_service_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "CloudHsmTagException")) {
        return .{ .arena = arena, .kind = .{ .cloud_hsm_tag_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
