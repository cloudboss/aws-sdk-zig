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

pub const CreateReplicationConfigurationTemplateInput = struct {
    /// Whether to associate the default Elastic Disaster Recovery Security group
    /// with the Replication Configuration Template.
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
    ebs_encryption: ReplicationConfigurationEbsEncryption,

    /// The ARN of the EBS encryption key to be used during replication.
    ebs_encryption_key_arn: ?[]const u8 = null,

    /// Which version of the Internet Protocol to use for replication of data. (IPv4
    /// or IPv6)
    internet_protocol: ?InternetProtocol = null,

    /// The Point in time (PIT) policy to manage snapshots taken during replication.
    pit_policy: []const PITPolicyRule,

    /// The instance type to be used for the replication server.
    replication_server_instance_type: ?[]const u8 = null,

    /// The security group IDs that will be used by the replication server.
    replication_servers_security_groups_i_ds: []const []const u8,

    /// The subnet to be used by the replication staging area.
    staging_area_subnet_id: []const u8,

    /// A set of tags to be associated with all resources created in the replication
    /// staging area: EC2 replication server, EBS volumes, EBS snapshots, etc.
    staging_area_tags: []const aws.map.StringMapEntry,

    /// A set of tags to be associated with the Replication Configuration Template
    /// resource.
    tags: ?[]const aws.map.StringMapEntry = null,

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
        .pit_policy = "pitPolicy",
        .replication_server_instance_type = "replicationServerInstanceType",
        .replication_servers_security_groups_i_ds = "replicationServersSecurityGroupsIDs",
        .staging_area_subnet_id = "stagingAreaSubnetId",
        .staging_area_tags = "stagingAreaTags",
        .tags = "tags",
        .use_dedicated_replication_server = "useDedicatedReplicationServer",
    };
};

pub const CreateReplicationConfigurationTemplateOutput = @import("replication_configuration_template.zig").ReplicationConfigurationTemplate;

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateReplicationConfigurationTemplateInput, options: CallOptions) !CreateReplicationConfigurationTemplateOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateReplicationConfigurationTemplateInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("drs", "drs", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/CreateReplicationConfigurationTemplate";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.associate_default_security_group) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"associateDefaultSecurityGroup\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.auto_replicate_new_disks) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"autoReplicateNewDisks\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"bandwidthThrottling\":");
    try aws.json.writeValue(@TypeOf(input.bandwidth_throttling), input.bandwidth_throttling, allocator, &body_buf);
    has_prev = true;
    if (input.create_public_ip) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"createPublicIP\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.data_plane_routing) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"dataPlaneRouting\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.default_large_staging_disk_type) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"defaultLargeStagingDiskType\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"ebsEncryption\":");
    try aws.json.writeValue(@TypeOf(input.ebs_encryption), input.ebs_encryption, allocator, &body_buf);
    has_prev = true;
    if (input.ebs_encryption_key_arn) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ebsEncryptionKeyArn\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.internet_protocol) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"internetProtocol\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"pitPolicy\":");
    try aws.json.writeValue(@TypeOf(input.pit_policy), input.pit_policy, allocator, &body_buf);
    has_prev = true;
    if (input.replication_server_instance_type) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"replicationServerInstanceType\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"replicationServersSecurityGroupsIDs\":");
    try aws.json.writeValue(@TypeOf(input.replication_servers_security_groups_i_ds), input.replication_servers_security_groups_i_ds, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"stagingAreaSubnetId\":");
    try aws.json.writeValue(@TypeOf(input.staging_area_subnet_id), input.staging_area_subnet_id, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"stagingAreaTags\":");
    try aws.json.writeValue(@TypeOf(input.staging_area_tags), input.staging_area_tags, allocator, &body_buf);
    has_prev = true;
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"tags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.use_dedicated_replication_server) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"useDedicatedReplicationServer\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateReplicationConfigurationTemplateOutput {
    const result: CreateReplicationConfigurationTemplateOutput = try aws.json.parseJsonObject(
        CreateReplicationConfigurationTemplateOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
