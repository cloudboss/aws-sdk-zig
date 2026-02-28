const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const ReplicationConfigurationDataPlaneRouting = @import("replication_configuration_data_plane_routing.zig").ReplicationConfigurationDataPlaneRouting;
const ReplicationConfigurationDefaultLargeStagingDiskType = @import("replication_configuration_default_large_staging_disk_type.zig").ReplicationConfigurationDefaultLargeStagingDiskType;
const ReplicationConfigurationEbsEncryption = @import("replication_configuration_ebs_encryption.zig").ReplicationConfigurationEbsEncryption;
const PITPolicyRule = @import("pit_policy_rule.zig").PITPolicyRule;
const ReplicationConfigurationReplicatedDisk = @import("replication_configuration_replicated_disk.zig").ReplicationConfigurationReplicatedDisk;

pub const GetReplicationConfigurationInput = struct {
    /// The ID of the Source Serve for this Replication Configuration.r
    source_server_id: []const u8,

    pub const json_field_names = .{
        .source_server_id = "sourceServerID",
    };
};

pub const GetReplicationConfigurationOutput = struct {
    /// Whether to associate the default Elastic Disaster Recovery Security group
    /// with the Replication Configuration.
    associate_default_security_group: ?bool = null,

    /// Whether to allow the AWS replication agent to automatically replicate newly
    /// added disks.
    auto_replicate_new_disks: ?bool = null,

    /// Configure bandwidth throttling for the outbound data transfer rate of the
    /// Source Server in Mbps.
    bandwidth_throttling: ?i64 = null,

    /// Whether to create a Public IP for the Recovery Instance by default.
    create_public_ip: ?bool = null,

    /// The data plane routing mechanism that will be used for replication.
    data_plane_routing: ?ReplicationConfigurationDataPlaneRouting = null,

    /// The Staging Disk EBS volume type to be used during replication.
    default_large_staging_disk_type: ?ReplicationConfigurationDefaultLargeStagingDiskType = null,

    /// The type of EBS encryption to be used during replication.
    ebs_encryption: ?ReplicationConfigurationEbsEncryption = null,

    /// The ARN of the EBS encryption key to be used during replication.
    ebs_encryption_key_arn: ?[]const u8 = null,

    /// The name of the Replication Configuration.
    name: ?[]const u8 = null,

    /// The Point in time (PIT) policy to manage snapshots taken during replication.
    pit_policy: ?[]const PITPolicyRule = null,

    /// The configuration of the disks of the Source Server to be replicated.
    replicated_disks: ?[]const ReplicationConfigurationReplicatedDisk = null,

    /// The instance type to be used for the replication server.
    replication_server_instance_type: ?[]const u8 = null,

    /// The security group IDs that will be used by the replication server.
    replication_servers_security_groups_i_ds: ?[]const []const u8 = null,

    /// The ID of the Source Server for this Replication Configuration.
    source_server_id: ?[]const u8 = null,

    /// The subnet to be used by the replication staging area.
    staging_area_subnet_id: ?[]const u8 = null,

    /// A set of tags to be associated with all resources created in the replication
    /// staging area: EC2 replication server, EBS volumes, EBS snapshots, etc.
    staging_area_tags: ?[]const aws.map.StringMapEntry = null,

    /// Whether to use a dedicated Replication Server in the replication staging
    /// area.
    use_dedicated_replication_server: ?bool = null,

    pub const json_field_names = .{
        .associate_default_security_group = "associateDefaultSecurityGroup",
        .auto_replicate_new_disks = "autoReplicateNewDisks",
        .bandwidth_throttling = "bandwidthThrottling",
        .create_public_ip = "createPublicIP",
        .data_plane_routing = "dataPlaneRouting",
        .default_large_staging_disk_type = "defaultLargeStagingDiskType",
        .ebs_encryption = "ebsEncryption",
        .ebs_encryption_key_arn = "ebsEncryptionKeyArn",
        .name = "name",
        .pit_policy = "pitPolicy",
        .replicated_disks = "replicatedDisks",
        .replication_server_instance_type = "replicationServerInstanceType",
        .replication_servers_security_groups_i_ds = "replicationServersSecurityGroupsIDs",
        .source_server_id = "sourceServerID",
        .staging_area_subnet_id = "stagingAreaSubnetId",
        .staging_area_tags = "stagingAreaTags",
        .use_dedicated_replication_server = "useDedicatedReplicationServer",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetReplicationConfigurationInput, options: Options) !GetReplicationConfigurationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "drs");

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

fn serializeRequest(alloc: std.mem.Allocator, input: GetReplicationConfigurationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("drs", "drs", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const path = "/GetReplicationConfiguration";

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(alloc, "{");

    if (has_prev) try body_buf.appendSlice(alloc, ",");
    try body_buf.appendSlice(alloc, "\"sourceServerID\":");
    try aws.json.writeValue(@TypeOf(input.source_server_id), input.source_server_id, alloc, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(alloc, "}");
    const body = try body_buf.toOwnedSlice(alloc);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !GetReplicationConfigurationOutput {
    var result: GetReplicationConfigurationOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetReplicationConfigurationOutput, body, alloc);
    }
    _ = status;
    _ = headers;

    return result;
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
