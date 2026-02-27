const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const Backup = @import("backup.zig").Backup;

pub const DescribeBackupsInput = struct {
    /// One or more filters to limit the items returned in the response.
    ///
    /// Use the `backupIds` filter to return only the specified backups. Specify
    /// backups by their backup identifier (ID).
    ///
    /// Use the `sourceBackupIds` filter to return only the backups created from a
    /// source backup. The `sourceBackupID` of a source backup is returned by the
    /// CopyBackupToRegion operation.
    ///
    /// Use the `clusterIds` filter to return only the backups for the specified
    /// clusters. Specify clusters by their cluster identifier (ID).
    ///
    /// Use the `states` filter to return only backups that match the specified
    /// state.
    ///
    /// Use the `neverExpires` filter to return backups filtered by the value in the
    /// `neverExpires` parameter. `True` returns all backups exempt from the
    /// backup retention policy. `False` returns all backups with a backup retention
    /// policy
    /// defined at the cluster.
    filters: ?[]const aws.map.MapEntry([]const []const u8) = null,

    /// The maximum number of backups to return in the response. When there are more
    /// backups
    /// than the number you specify, the response contains a `NextToken` value.
    max_results: ?i32 = null,

    /// The `NextToken` value that you received in the previous response. Use this
    /// value to get more backups.
    next_token: ?[]const u8 = null,

    /// Describe backups that are shared with you.
    ///
    /// By default when using this option, the command returns backups that have
    /// been shared using a standard Resource Access Manager
    /// resource share. In order for a backup that was shared using the
    /// PutResourcePolicy command to be returned, the share must be promoted to a
    /// standard resource share using the RAM
    /// [PromoteResourceShareCreatedFromPolicy](https://docs.aws.amazon.com/cli/latest/reference/ram/promote-resource-share-created-from-policy.html) API operation.
    ///
    /// For more information about sharing backups, see [ Working with shared
    /// backups](https://docs.aws.amazon.com/cloudhsm/latest/userguide/sharing.html)
    /// in the CloudHSM User Guide.
    shared: ?bool = null,

    /// Designates whether or not to sort the return backups by ascending
    /// chronological order
    /// of generation.
    sort_ascending: ?bool = null,

    pub const json_field_names = .{
        .filters = "Filters",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .shared = "Shared",
        .sort_ascending = "SortAscending",
    };
};

pub const DescribeBackupsOutput = struct {
    /// A list of backups.
    backups: ?[]const Backup = null,

    /// An opaque string that indicates that the response contains only a subset of
    /// backups.
    /// Use this value in a subsequent `DescribeBackups` request to get more
    /// backups.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .backups = "Backups",
        .next_token = "NextToken",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeBackupsInput, options: Options) !DescribeBackupsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "cloudhsmv2");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(response.body, response.status, client.allocator) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(response.body, response.status, response.headers, allocator);
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: DescribeBackupsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cloudhsmv2", "CloudHSM V2", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const body = try aws.json.jsonStringify(input, alloc);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(alloc, "X-Amz-Target", "BaldrApiService.DescribeBackups");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !DescribeBackupsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeBackupsOutput, body, alloc);
}

fn parseErrorResponse(body: []const u8, status: u16, alloc: std.mem.Allocator) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(alloc);
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
