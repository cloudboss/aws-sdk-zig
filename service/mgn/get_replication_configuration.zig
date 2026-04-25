const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const ReplicationConfigurationDataPlaneRouting = @import("replication_configuration_data_plane_routing.zig").ReplicationConfigurationDataPlaneRouting;
const ReplicationConfigurationDefaultLargeStagingDiskType = @import("replication_configuration_default_large_staging_disk_type.zig").ReplicationConfigurationDefaultLargeStagingDiskType;
const ReplicationConfigurationEbsEncryption = @import("replication_configuration_ebs_encryption.zig").ReplicationConfigurationEbsEncryption;
const InternetProtocol = @import("internet_protocol.zig").InternetProtocol;
const ReplicationConfigurationReplicatedDisk = @import("replication_configuration_replicated_disk.zig").ReplicationConfigurationReplicatedDisk;

pub const GetReplicationConfigurationInput = struct {
    /// Request to get Replication Configuration by Account ID.
    account_id: ?[]const u8 = null,

    /// Request to get Replication Configuration by Source Server ID.
    source_server_id: []const u8,

    pub const json_field_names = .{
        .account_id = "accountID",
        .source_server_id = "sourceServerID",
    };
};

pub const GetReplicationConfigurationOutput = struct {
    /// Replication Configuration associate default Application Migration Service
    /// Security Group.
    associate_default_security_group: ?bool = null,

    /// Replication Configuration set bandwidth throttling.
    bandwidth_throttling: ?i64 = null,

    /// Replication Configuration create Public IP.
    create_public_ip: ?bool = null,

    /// Replication Configuration data plane routing.
    data_plane_routing: ?ReplicationConfigurationDataPlaneRouting = null,

    /// Replication Configuration use default large Staging Disks.
    default_large_staging_disk_type: ?ReplicationConfigurationDefaultLargeStagingDiskType = null,

    /// Replication Configuration EBS encryption.
    ebs_encryption: ?ReplicationConfigurationEbsEncryption = null,

    /// Replication Configuration EBS encryption key ARN.
    ebs_encryption_key_arn: ?[]const u8 = null,

    /// Replication Configuration internet protocol.
    internet_protocol: ?InternetProtocol = null,

    /// Replication Configuration name.
    name: ?[]const u8 = null,

    /// Replication Configuration replicated disks.
    replicated_disks: ?[]const ReplicationConfigurationReplicatedDisk = null,

    /// Replication Configuration Replication Server instance type.
    replication_server_instance_type: ?[]const u8 = null,

    /// Replication Configuration Replication Server Security Group IDs.
    replication_servers_security_groups_i_ds: ?[]const []const u8 = null,

    /// Replication Configuration Source Server ID.
    source_server_id: ?[]const u8 = null,

    /// Replication Configuration Staging Area subnet ID.
    staging_area_subnet_id: ?[]const u8 = null,

    /// Replication Configuration Staging Area tags.
    staging_area_tags: ?[]const aws.map.StringMapEntry = null,

    /// Replication Configuration store snapshot on local zone.
    store_snapshot_on_local_zone: ?bool = null,

    /// Replication Configuration use Dedicated Replication Server.
    use_dedicated_replication_server: ?bool = null,

    /// Replication Configuration use Fips Endpoint.
    use_fips_endpoint: ?bool = null,

    pub const json_field_names = .{
        .associate_default_security_group = "associateDefaultSecurityGroup",
        .bandwidth_throttling = "bandwidthThrottling",
        .create_public_ip = "createPublicIP",
        .data_plane_routing = "dataPlaneRouting",
        .default_large_staging_disk_type = "defaultLargeStagingDiskType",
        .ebs_encryption = "ebsEncryption",
        .ebs_encryption_key_arn = "ebsEncryptionKeyArn",
        .internet_protocol = "internetProtocol",
        .name = "name",
        .replicated_disks = "replicatedDisks",
        .replication_server_instance_type = "replicationServerInstanceType",
        .replication_servers_security_groups_i_ds = "replicationServersSecurityGroupsIDs",
        .source_server_id = "sourceServerID",
        .staging_area_subnet_id = "stagingAreaSubnetId",
        .staging_area_tags = "stagingAreaTags",
        .store_snapshot_on_local_zone = "storeSnapshotOnLocalZone",
        .use_dedicated_replication_server = "useDedicatedReplicationServer",
        .use_fips_endpoint = "useFipsEndpoint",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetReplicationConfigurationInput, options: CallOptions) !GetReplicationConfigurationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "mgn");

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetReplicationConfigurationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("mgn", "mgn", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const path = "/GetReplicationConfiguration";

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.account_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"accountID\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"sourceServerID\":");
    try aws.json.writeValue(@TypeOf(input.source_server_id), input.source_server_id, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetReplicationConfigurationOutput {
    var result: GetReplicationConfigurationOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetReplicationConfigurationOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
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

    if (std.mem.eql(u8, error_code, "AccessDeniedException")) {
        return .{ .arena = arena, .kind = .{ .access_denied_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ConflictException")) {
        return .{ .arena = arena, .kind = .{ .conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalServerException")) {
        return .{ .arena = arena, .kind = .{ .internal_server_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServiceQuotaExceededException")) {
        return .{ .arena = arena, .kind = .{ .service_quota_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ThrottlingException")) {
        return .{ .arena = arena, .kind = .{ .throttling_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UninitializedAccountException")) {
        return .{ .arena = arena, .kind = .{ .uninitialized_account_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ValidationException")) {
        return .{ .arena = arena, .kind = .{ .validation_exception = .{
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
