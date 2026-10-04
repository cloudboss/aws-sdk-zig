const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ReplicationConfigurationDataPlaneRouting = @import("replication_configuration_data_plane_routing.zig").ReplicationConfigurationDataPlaneRouting;
const ReplicationConfigurationDefaultLargeStagingDiskType = @import("replication_configuration_default_large_staging_disk_type.zig").ReplicationConfigurationDefaultLargeStagingDiskType;
const ReplicationConfigurationEbsEncryption = @import("replication_configuration_ebs_encryption.zig").ReplicationConfigurationEbsEncryption;
const InternetProtocol = @import("internet_protocol.zig").InternetProtocol;
const StorageConfiguration = @import("storage_configuration.zig").StorageConfiguration;

pub const UpdateReplicationConfigurationTemplateInput = struct {
    /// Update replication configuration template ARN request.
    arn: ?[]const u8 = null,

    /// Update replication configuration template associate default Application
    /// Migration Service Security group request.
    associate_default_security_group: ?bool = null,

    /// Update replication configuration template bandwidth throttling request.
    bandwidth_throttling: ?i64 = null,

    /// Update replication configuration template create Public IP request.
    create_public_ip: ?bool = null,

    /// Update replication configuration template data plane routing request.
    data_plane_routing: ?ReplicationConfigurationDataPlaneRouting = null,

    /// Update replication configuration template use default large Staging Disk
    /// type request.
    default_large_staging_disk_type: ?ReplicationConfigurationDefaultLargeStagingDiskType = null,

    /// Update replication configuration template EBS encryption request.
    ebs_encryption: ?ReplicationConfigurationEbsEncryption = null,

    /// Update replication configuration template EBS encryption key ARN request.
    ebs_encryption_key_arn: ?[]const u8 = null,

    /// Update replication configuration template internet protocol request.
    internet_protocol: ?InternetProtocol = null,

    /// Update replication configuration template template ID request.
    replication_configuration_template_id: []const u8,

    /// Update replication configuration template Replication Server instance type
    /// request.
    replication_server_instance_type: ?[]const u8 = null,

    /// Update replication configuration template Replication Server Security groups
    /// IDs request.
    replication_servers_security_groups_i_ds: ?[]const []const u8 = null,

    /// Update replication configuration template Staging Area subnet ID request.
    staging_area_subnet_id: ?[]const u8 = null,

    /// Update replication configuration template Staging Area Tags request.
    staging_area_tags: ?[]const aws.map.StringMapEntry = null,

    /// Update replication configuration template storage configuration request.
    storage_configuration: ?StorageConfiguration = null,

    /// Update replication configuration template store snapshot on local zone
    /// request.
    store_snapshot_on_local_zone: ?bool = null,

    /// Update replication configuration template use dedicated Replication Server
    /// request.
    use_dedicated_replication_server: ?bool = null,

    /// Update replication configuration template use Fips Endpoint request.
    use_fips_endpoint: ?bool = null,

    pub const json_field_names = .{
        .arn = "arn",
        .associate_default_security_group = "associateDefaultSecurityGroup",
        .bandwidth_throttling = "bandwidthThrottling",
        .create_public_ip = "createPublicIP",
        .data_plane_routing = "dataPlaneRouting",
        .default_large_staging_disk_type = "defaultLargeStagingDiskType",
        .ebs_encryption = "ebsEncryption",
        .ebs_encryption_key_arn = "ebsEncryptionKeyArn",
        .internet_protocol = "internetProtocol",
        .replication_configuration_template_id = "replicationConfigurationTemplateID",
        .replication_server_instance_type = "replicationServerInstanceType",
        .replication_servers_security_groups_i_ds = "replicationServersSecurityGroupsIDs",
        .staging_area_subnet_id = "stagingAreaSubnetId",
        .staging_area_tags = "stagingAreaTags",
        .storage_configuration = "storageConfiguration",
        .store_snapshot_on_local_zone = "storeSnapshotOnLocalZone",
        .use_dedicated_replication_server = "useDedicatedReplicationServer",
        .use_fips_endpoint = "useFipsEndpoint",
    };
};

pub const UpdateReplicationConfigurationTemplateOutput = @import("replication_configuration_template.zig").ReplicationConfigurationTemplate;

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateReplicationConfigurationTemplateInput, options: CallOptions) !UpdateReplicationConfigurationTemplateOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateReplicationConfigurationTemplateInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("mgn", "mgn", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/UpdateReplicationConfigurationTemplate";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.arn) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"arn\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.associate_default_security_group) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"associateDefaultSecurityGroup\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.bandwidth_throttling) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"bandwidthThrottling\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
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
    if (input.ebs_encryption) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ebsEncryption\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
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
    try body_buf.appendSlice(allocator, "\"replicationConfigurationTemplateID\":");
    try aws.json.writeValue(@TypeOf(input.replication_configuration_template_id), input.replication_configuration_template_id, allocator, &body_buf);
    has_prev = true;
    if (input.replication_server_instance_type) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"replicationServerInstanceType\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.replication_servers_security_groups_i_ds) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"replicationServersSecurityGroupsIDs\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.staging_area_subnet_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"stagingAreaSubnetId\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.staging_area_tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"stagingAreaTags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.storage_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"storageConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.store_snapshot_on_local_zone) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"storeSnapshotOnLocalZone\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.use_dedicated_replication_server) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"useDedicatedReplicationServer\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.use_fips_endpoint) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"useFipsEndpoint\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateReplicationConfigurationTemplateOutput {
    const result: UpdateReplicationConfigurationTemplateOutput = try aws.json.parseJsonObject(
        UpdateReplicationConfigurationTemplateOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
