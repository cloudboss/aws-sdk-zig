const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ReplicationConfigurationDataPlaneRouting = @import("replication_configuration_data_plane_routing.zig").ReplicationConfigurationDataPlaneRouting;
const ReplicationConfigurationDefaultLargeStagingDiskType = @import("replication_configuration_default_large_staging_disk_type.zig").ReplicationConfigurationDefaultLargeStagingDiskType;
const ReplicationConfigurationEbsEncryption = @import("replication_configuration_ebs_encryption.zig").ReplicationConfigurationEbsEncryption;
const InternetProtocol = @import("internet_protocol.zig").InternetProtocol;
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

    /// Which version of the Internet Protocol to use for replication of data. (IPv4
    /// or IPv6)
    internet_protocol: ?InternetProtocol = null,

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
        .internet_protocol = "internetProtocol",
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

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetReplicationConfigurationInput, options: CallOptions) !GetReplicationConfigurationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "drs", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetReplicationConfigurationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("drs", "drs", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/GetReplicationConfiguration";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"sourceServerID\":");
    try aws.json.writeValue(@TypeOf(input.source_server_id), input.source_server_id, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetReplicationConfigurationOutput {
    const result: GetReplicationConfigurationOutput = try aws.json.parseJsonObject(
        GetReplicationConfigurationOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
