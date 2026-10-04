const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ReplicationConfigurationDataPlaneRouting = @import("replication_configuration_data_plane_routing.zig").ReplicationConfigurationDataPlaneRouting;
const ReplicationConfigurationDefaultLargeStagingDiskType = @import("replication_configuration_default_large_staging_disk_type.zig").ReplicationConfigurationDefaultLargeStagingDiskType;
const ReplicationConfigurationEbsEncryption = @import("replication_configuration_ebs_encryption.zig").ReplicationConfigurationEbsEncryption;
const InternetProtocol = @import("internet_protocol.zig").InternetProtocol;

pub const CreateReplicationConfigurationTemplateInput = struct {
    /// Request to associate the default Application Migration Service Security
    /// group with the Replication Settings template.
    associate_default_security_group: bool,

    /// Request to configure bandwidth throttling during Replication Settings
    /// template creation.
    bandwidth_throttling: ?i64 = null,

    /// Request to create Public IP during Replication Settings template creation.
    create_public_ip: bool,

    /// Request to configure data plane routing during Replication Settings template
    /// creation.
    data_plane_routing: ReplicationConfigurationDataPlaneRouting,

    /// Request to configure the default large staging disk EBS volume type during
    /// Replication Settings template creation.
    default_large_staging_disk_type: ReplicationConfigurationDefaultLargeStagingDiskType,

    /// Request to configure EBS encryption during Replication Settings template
    /// creation.
    ebs_encryption: ReplicationConfigurationEbsEncryption,

    /// Request to configure an EBS encryption key during Replication Settings
    /// template creation.
    ebs_encryption_key_arn: ?[]const u8 = null,

    /// Request to configure the internet protocol to IPv4 or IPv6.
    internet_protocol: ?InternetProtocol = null,

    /// Request to configure the Replication Server instance type during Replication
    /// Settings template creation.
    replication_server_instance_type: []const u8,

    /// Request to configure the Replication Server Security group ID during
    /// Replication Settings template creation.
    replication_servers_security_groups_i_ds: []const []const u8,

    /// Request to configure the Staging Area subnet ID during Replication Settings
    /// template creation.
    staging_area_subnet_id: []const u8,

    /// Request to configure Staging Area tags during Replication Settings template
    /// creation.
    staging_area_tags: []const aws.map.StringMapEntry,

    /// Request to store snapshot on local zone during Replication Settings template
    /// creation.
    store_snapshot_on_local_zone: ?bool = null,

    /// Request to configure tags during Replication Settings template creation.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// Request to use Dedicated Replication Servers during Replication Settings
    /// template creation.
    use_dedicated_replication_server: bool,

    /// Request to use Fips Endpoint during Replication Settings template creation.
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
        .replication_server_instance_type = "replicationServerInstanceType",
        .replication_servers_security_groups_i_ds = "replicationServersSecurityGroupsIDs",
        .staging_area_subnet_id = "stagingAreaSubnetId",
        .staging_area_tags = "stagingAreaTags",
        .store_snapshot_on_local_zone = "storeSnapshotOnLocalZone",
        .tags = "tags",
        .use_dedicated_replication_server = "useDedicatedReplicationServer",
        .use_fips_endpoint = "useFipsEndpoint",
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateReplicationConfigurationTemplateInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("mgn", "mgn", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/CreateReplicationConfigurationTemplate";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"associateDefaultSecurityGroup\":");
    try aws.json.writeValue(@TypeOf(input.associate_default_security_group), input.associate_default_security_group, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"bandwidthThrottling\":");
    try aws.json.writeValue(@TypeOf(input.bandwidth_throttling), input.bandwidth_throttling, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"createPublicIP\":");
    try aws.json.writeValue(@TypeOf(input.create_public_ip), input.create_public_ip, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"dataPlaneRouting\":");
    try aws.json.writeValue(@TypeOf(input.data_plane_routing), input.data_plane_routing, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"defaultLargeStagingDiskType\":");
    try aws.json.writeValue(@TypeOf(input.default_large_staging_disk_type), input.default_large_staging_disk_type, allocator, &body_buf);
    has_prev = true;
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
    try body_buf.appendSlice(allocator, "\"replicationServerInstanceType\":");
    try aws.json.writeValue(@TypeOf(input.replication_server_instance_type), input.replication_server_instance_type, allocator, &body_buf);
    has_prev = true;
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
    if (input.store_snapshot_on_local_zone) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"storeSnapshotOnLocalZone\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"tags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"useDedicatedReplicationServer\":");
    try aws.json.writeValue(@TypeOf(input.use_dedicated_replication_server), input.use_dedicated_replication_server, allocator, &body_buf);
    has_prev = true;
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateReplicationConfigurationTemplateOutput {
    var result: CreateReplicationConfigurationTemplateOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateReplicationConfigurationTemplateOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
