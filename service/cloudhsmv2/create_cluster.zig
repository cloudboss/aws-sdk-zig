const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const BackupRetentionPolicy = @import("backup_retention_policy.zig").BackupRetentionPolicy;
const ClusterMode = @import("cluster_mode.zig").ClusterMode;
const NetworkType = @import("network_type.zig").NetworkType;
const Tag = @import("tag.zig").Tag;
const Cluster = @import("cluster.zig").Cluster;

pub const CreateClusterInput = struct {
    /// A policy that defines how the service retains backups.
    backup_retention_policy: ?BackupRetentionPolicy = null,

    /// The type of HSM to use in the cluster. The allowed values are
    /// `hsm1.medium` and `hsm2m.medium`.
    hsm_type: []const u8,

    /// The mode to use in the cluster. The allowed values are
    /// `FIPS` and `NON_FIPS`.
    mode: ?ClusterMode = null,

    /// The NetworkType to create a cluster with. The allowed values are
    /// `IPV4` and `DUALSTACK`.
    network_type: ?NetworkType = null,

    /// The identifier (ID) or the Amazon Resource Name (ARN) of the cluster backup
    /// to restore. Use this value to restore the
    /// cluster from a backup instead of creating a new cluster. To find the backup
    /// ID or ARN, use DescribeBackups. *If using a backup in another account, the
    /// full ARN must be supplied.*
    source_backup_id: ?[]const u8 = null,

    /// The identifiers (IDs) of the subnets where you are creating the cluster. You
    /// must
    /// specify at least one subnet. If you specify multiple subnets, they must meet
    /// the following
    /// criteria:
    ///
    /// * All subnets must be in the same virtual private cloud (VPC).
    ///
    /// * You can specify only one subnet per Availability Zone.
    subnet_ids: []const []const u8,

    /// Tags to apply to the CloudHSM cluster during creation.
    tag_list: ?[]const Tag = null,

    pub const json_field_names = .{
        .backup_retention_policy = "BackupRetentionPolicy",
        .hsm_type = "HsmType",
        .mode = "Mode",
        .network_type = "NetworkType",
        .source_backup_id = "SourceBackupId",
        .subnet_ids = "SubnetIds",
        .tag_list = "TagList",
    };
};

pub const CreateClusterOutput = struct {
    /// Information about the cluster that was created.
    cluster: ?Cluster = null,

    pub const json_field_names = .{
        .cluster = "Cluster",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateClusterInput, options: CallOptions) !CreateClusterOutput {
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
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: CreateClusterInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "BaldrApiService.CreateCluster");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateClusterOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateClusterOutput, body, allocator);
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
