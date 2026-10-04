const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
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
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "mgn", client.config.http_client.clock_skew_offset);

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
    const endpoint = try config.getEndpointForService("mgn", "mgn", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/GetReplicationConfiguration";

    var body_buf: std.ArrayList(u8) = .empty;
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
    var result: GetReplicationConfigurationOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetReplicationConfigurationOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
