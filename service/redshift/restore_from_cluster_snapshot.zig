const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const AquaConfigurationStatus = @import("aqua_configuration_status.zig").AquaConfigurationStatus;
const Cluster = @import("cluster.zig").Cluster;
const serde = @import("serde.zig");

pub const RestoreFromClusterSnapshotInput = struct {
    /// Reserved.
    additional_info: ?[]const u8 = null,

    /// If `true`, major version upgrades can be applied during the maintenance
    /// window to the Amazon Redshift engine that is running on the cluster.
    ///
    /// Default: `true`
    allow_version_upgrade: ?bool = null,

    /// This parameter is retired. It does not set the AQUA configuration status.
    /// Amazon Redshift automatically determines whether to use AQUA (Advanced Query
    /// Accelerator).
    aqua_configuration_status: ?AquaConfigurationStatus = null,

    /// The number of days that automated snapshots are retained. If the value is 0,
    /// automated snapshots are disabled. Even if automated snapshots are disabled,
    /// you can
    /// still create manual snapshots when you want with CreateClusterSnapshot.
    ///
    /// You can't disable automated snapshots for RA3 node types. Set the automated
    /// retention period from 1-35 days.
    ///
    /// Default: The value selected for the cluster from which the snapshot was
    /// taken.
    ///
    /// Constraints: Must be a value from 0 to 35.
    automated_snapshot_retention_period: ?i32 = null,

    /// The Amazon EC2 Availability Zone in which to restore the cluster.
    ///
    /// Default: A random, system-chosen Availability Zone.
    ///
    /// Example: `us-east-2a`
    availability_zone: ?[]const u8 = null,

    /// The option to enable relocation for an Amazon Redshift cluster between
    /// Availability Zones after the cluster is restored.
    availability_zone_relocation: ?bool = null,

    /// The name of the Glue Data Catalog that will be associated with the cluster
    /// enabled with Amazon Redshift federated permissions.
    ///
    /// Constraints:
    ///
    /// * Must contain at least one lowercase letter.
    ///
    /// * Can only contain lowercase letters (a-z), numbers (0-9), underscores (_),
    ///   and hyphens (-).
    ///
    /// Pattern: `^[a-z0-9_-]*[a-z]+[a-z0-9_-]*$`
    ///
    /// Example: `my-catalog_01`
    catalog_name: ?[]const u8 = null,

    /// The identifier of the cluster that will be created from restoring the
    /// snapshot.
    ///
    /// Constraints:
    ///
    /// * Must contain from 1 to 63 alphanumeric characters or hyphens.
    ///
    /// * Alphabetic characters must be lowercase.
    ///
    /// * First character must be a letter.
    ///
    /// * Cannot end with a hyphen or contain two consecutive hyphens.
    ///
    /// * Must be unique for all clusters within an Amazon Web Services account.
    cluster_identifier: []const u8,

    /// The name of the parameter group to be associated with this cluster.
    ///
    /// Default: The default Amazon Redshift cluster parameter group. For
    /// information about the
    /// default parameter group, go to [Working with Amazon
    /// Redshift Parameter
    /// Groups](https://docs.aws.amazon.com/redshift/latest/mgmt/working-with-parameter-groups.html).
    ///
    /// Constraints:
    ///
    /// * Must be 1 to 255 alphanumeric characters or hyphens.
    ///
    /// * First character must be a letter.
    ///
    /// * Cannot end with a hyphen or contain two consecutive hyphens.
    cluster_parameter_group_name: ?[]const u8 = null,

    /// A list of security groups to be associated with this cluster.
    ///
    /// Default: The default cluster security group for Amazon Redshift.
    ///
    /// Cluster security groups only apply to clusters outside of VPCs.
    cluster_security_groups: ?[]const []const u8 = null,

    /// The name of the subnet group where you want to cluster restored.
    ///
    /// A snapshot of cluster in VPC can be restored only in VPC. Therefore, you
    /// must
    /// provide subnet group name where you want the cluster restored.
    cluster_subnet_group_name: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) for the IAM role that was set as default for
    /// the cluster when the cluster was last modified while it was restored from a
    /// snapshot.
    default_iam_role_arn: ?[]const u8 = null,

    /// The Elastic IP (EIP) address for the cluster. Don't specify the Elastic IP
    /// address for a publicly
    /// accessible cluster with availability zone relocation turned on.
    elastic_ip: ?[]const u8 = null,

    /// Enables support for restoring an unencrypted snapshot to a cluster encrypted
    /// with Key Management Service (KMS) and a customer managed key.
    encrypted: ?bool = null,

    /// An option that specifies whether to create the cluster with enhanced VPC
    /// routing
    /// enabled. To create a cluster that uses enhanced VPC routing, the cluster
    /// must be in a
    /// VPC. For more information, see [Enhanced VPC
    /// Routing](https://docs.aws.amazon.com/redshift/latest/mgmt/enhanced-vpc-routing.html) in
    /// the Amazon Redshift Cluster Management Guide.
    ///
    /// If this option is `true`, enhanced VPC routing is enabled.
    ///
    /// Default: false
    enhanced_vpc_routing: ?bool = null,

    /// Specifies the name of the HSM client certificate the Amazon Redshift cluster
    /// uses to
    /// retrieve the data encryption keys stored in an HSM.
    hsm_client_certificate_identifier: ?[]const u8 = null,

    /// Specifies the name of the HSM configuration that contains the information
    /// the
    /// Amazon Redshift cluster can use to retrieve and store keys in an HSM.
    hsm_configuration_identifier: ?[]const u8 = null,

    /// A list of Identity and Access Management (IAM) roles that can be used by the
    /// cluster to access other Amazon Web Services services. You must supply the
    /// IAM roles in their Amazon
    /// Resource Name (ARN) format.
    ///
    /// The maximum number of IAM roles that you can associate is subject to a
    /// quota.
    /// For more information, go to [Quotas and
    /// limits](https://docs.aws.amazon.com/redshift/latest/mgmt/amazon-redshift-limits.html)
    /// in the *Amazon Redshift Cluster Management Guide*.
    iam_roles: ?[]const []const u8 = null,

    /// The IP address type for the cluster. Possible values are `ipv4` and
    /// `dualstack`.
    ip_address_type: ?[]const u8 = null,

    /// The Key Management Service (KMS) key ID of the encryption key that encrypts
    /// data in the cluster
    /// restored from a shared snapshot. You can also provide
    /// the key ID when you restore from an unencrypted snapshot to an encrypted
    /// cluster in
    /// the same account. Additionally, you can specify a new KMS key ID when you
    /// restore from an encrypted
    /// snapshot in the same account in order to change it. In that case, the
    /// restored cluster is encrypted
    /// with the new KMS key ID.
    kms_key_id: ?[]const u8 = null,

    /// The name of the maintenance track for the restored cluster. When you take a
    /// snapshot,
    /// the snapshot inherits the `MaintenanceTrack` value from the cluster. The
    /// snapshot might be on a different track than the cluster that was the source
    /// for the
    /// snapshot. For example, suppose that you take a snapshot of a cluster that is
    /// on the
    /// current track and then change the cluster to be on the trailing track. In
    /// this case, the
    /// snapshot and the source cluster are on different tracks.
    maintenance_track_name: ?[]const u8 = null,

    /// If `true`, Amazon Redshift uses Secrets Manager to manage the restored
    /// cluster's admin credentials. If `ManageMasterPassword` is false or not set,
    /// Amazon Redshift uses the admin credentials the cluster had at the time the
    /// snapshot was taken.
    manage_master_password: ?bool = null,

    /// The default number of days to retain a manual snapshot. If the value is -1,
    /// the
    /// snapshot is retained indefinitely. This setting doesn't change the retention
    /// period
    /// of existing snapshots.
    ///
    /// The value must be either -1 or an integer between 1 and 3,653.
    manual_snapshot_retention_period: ?i32 = null,

    /// The ID of the Key Management Service (KMS) key used to encrypt and store the
    /// cluster's admin credentials secret.
    /// You can only use this parameter if `ManageMasterPassword` is true.
    master_password_secret_kms_key_id: ?[]const u8 = null,

    /// If true, the snapshot will be restored to a cluster deployed in two
    /// Availability Zones.
    multi_az: ?bool = null,

    /// The node type that the restored cluster will be provisioned with.
    ///
    /// If you have a DC instance type, you
    /// must restore into that same instance type and size. In other words, you can
    /// only restore
    /// a dc2.large node type into another dc2 type. For more information about node
    /// types, see
    /// [
    /// About Clusters and
    /// Nodes](https://docs.aws.amazon.com/redshift/latest/mgmt/working-with-clusters.html#rs-about-clusters-and-nodes) in the *Amazon Redshift Cluster Management Guide*.
    node_type: ?[]const u8 = null,

    /// The number of nodes specified when provisioning the restored cluster.
    number_of_nodes: ?i32 = null,

    /// The Amazon Web Services account used to create or copy the snapshot.
    /// Required if you are
    /// restoring a snapshot you do not own, optional if you own the snapshot.
    owner_account: ?[]const u8 = null,

    /// The port number on which the cluster accepts connections.
    ///
    /// Default: The same port as the original cluster.
    ///
    /// Valid values: For clusters with DC2 nodes, must be within the range
    /// `1150`-`65535`. For clusters with ra3 nodes, must be
    /// within the ranges `5431`-`5455` or `8191`-`8215`.
    port: ?i32 = null,

    /// The weekly time range (in UTC) during which automated cluster maintenance
    /// can
    /// occur.
    ///
    /// Format: `ddd:hh24:mi-ddd:hh24:mi`
    ///
    /// Default: The value selected for the cluster from which the snapshot was
    /// taken. For
    /// more information about the time blocks for each region, see [Maintenance
    /// Windows](https://docs.aws.amazon.com/redshift/latest/mgmt/working-with-clusters.html#rs-maintenance-windows) in Amazon Redshift Cluster Management Guide.
    ///
    /// Valid Days: Mon | Tue | Wed | Thu | Fri | Sat | Sun
    ///
    /// Constraints: Minimum 30-minute window.
    preferred_maintenance_window: ?[]const u8 = null,

    /// If `true`, the cluster can be accessed from a public network.
    ///
    /// Default: false
    publicly_accessible: ?bool = null,

    /// The Amazon Resource Name (ARN) of the IAM Identity Center application used
    /// for enabling Amazon Web Services IAM Identity Center trusted identity
    /// propagation on a cluster enabled with Amazon Redshift federated permissions.
    redshift_idc_application_arn: ?[]const u8 = null,

    /// The identifier of the target reserved node offering.
    reserved_node_id: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the snapshot associated with the message
    /// to restore from a cluster. You must specify
    /// this parameter or `snapshotIdentifier`, but not both.
    snapshot_arn: ?[]const u8 = null,

    /// The name of the cluster the source snapshot was created from. This parameter
    /// is
    /// required if your IAM user has a policy containing a snapshot resource
    /// element that
    /// specifies anything other than * for the cluster name.
    snapshot_cluster_identifier: ?[]const u8 = null,

    /// The name of the snapshot from which to create the new cluster. This
    /// parameter isn't
    /// case sensitive. You must specify this parameter or `snapshotArn`, but not
    /// both.
    ///
    /// Example: `my-snapshot-id`
    snapshot_identifier: ?[]const u8 = null,

    /// A unique identifier for the snapshot schedule.
    snapshot_schedule_identifier: ?[]const u8 = null,

    /// The identifier of the target reserved node offering.
    target_reserved_node_offering_id: ?[]const u8 = null,

    /// A list of Virtual Private Cloud (VPC) security groups to be associated with
    /// the
    /// cluster.
    ///
    /// Default: The default VPC security group is associated with the cluster.
    ///
    /// VPC security groups only apply to clusters in VPCs.
    vpc_security_group_ids: ?[]const []const u8 = null,
};

pub const RestoreFromClusterSnapshotOutput = struct {
    cluster: ?Cluster = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: RestoreFromClusterSnapshotInput, options: CallOptions) !RestoreFromClusterSnapshotOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "redshift");

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

fn serializeRequest(allocator: std.mem.Allocator, input: RestoreFromClusterSnapshotInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("redshift", "Redshift", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(allocator, "Action=RestoreFromClusterSnapshot&Version=2012-12-01");
    if (input.additional_info) |v| {
        try body_buf.appendSlice(allocator, "&AdditionalInfo=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.allow_version_upgrade) |v| {
        try body_buf.appendSlice(allocator, "&AllowVersionUpgrade=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.aqua_configuration_status) |v| {
        try body_buf.appendSlice(allocator, "&AquaConfigurationStatus=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, @tagName(v));
    }
    if (input.automated_snapshot_retention_period) |v| {
        try body_buf.appendSlice(allocator, "&AutomatedSnapshotRetentionPeriod=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.availability_zone) |v| {
        try body_buf.appendSlice(allocator, "&AvailabilityZone=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.availability_zone_relocation) |v| {
        try body_buf.appendSlice(allocator, "&AvailabilityZoneRelocation=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.catalog_name) |v| {
        try body_buf.appendSlice(allocator, "&CatalogName=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    try body_buf.appendSlice(allocator, "&ClusterIdentifier=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.cluster_identifier);
    if (input.cluster_parameter_group_name) |v| {
        try body_buf.appendSlice(allocator, "&ClusterParameterGroupName=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.cluster_security_groups) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&ClusterSecurityGroups.ClusterSecurityGroupName.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(allocator, field_prefix);
            try aws.url.appendUrlEncoded(allocator, &body_buf, item);
        }
    }
    if (input.cluster_subnet_group_name) |v| {
        try body_buf.appendSlice(allocator, "&ClusterSubnetGroupName=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.default_iam_role_arn) |v| {
        try body_buf.appendSlice(allocator, "&DefaultIamRoleArn=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.elastic_ip) |v| {
        try body_buf.appendSlice(allocator, "&ElasticIp=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.encrypted) |v| {
        try body_buf.appendSlice(allocator, "&Encrypted=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.enhanced_vpc_routing) |v| {
        try body_buf.appendSlice(allocator, "&EnhancedVpcRouting=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.hsm_client_certificate_identifier) |v| {
        try body_buf.appendSlice(allocator, "&HsmClientCertificateIdentifier=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.hsm_configuration_identifier) |v| {
        try body_buf.appendSlice(allocator, "&HsmConfigurationIdentifier=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.iam_roles) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&IamRoles.IamRoleArn.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(allocator, field_prefix);
            try aws.url.appendUrlEncoded(allocator, &body_buf, item);
        }
    }
    if (input.ip_address_type) |v| {
        try body_buf.appendSlice(allocator, "&IpAddressType=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.kms_key_id) |v| {
        try body_buf.appendSlice(allocator, "&KmsKeyId=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.maintenance_track_name) |v| {
        try body_buf.appendSlice(allocator, "&MaintenanceTrackName=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.manage_master_password) |v| {
        try body_buf.appendSlice(allocator, "&ManageMasterPassword=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.manual_snapshot_retention_period) |v| {
        try body_buf.appendSlice(allocator, "&ManualSnapshotRetentionPeriod=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.master_password_secret_kms_key_id) |v| {
        try body_buf.appendSlice(allocator, "&MasterPasswordSecretKmsKeyId=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.multi_az) |v| {
        try body_buf.appendSlice(allocator, "&MultiAZ=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.node_type) |v| {
        try body_buf.appendSlice(allocator, "&NodeType=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.number_of_nodes) |v| {
        try body_buf.appendSlice(allocator, "&NumberOfNodes=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.owner_account) |v| {
        try body_buf.appendSlice(allocator, "&OwnerAccount=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.port) |v| {
        try body_buf.appendSlice(allocator, "&Port=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.preferred_maintenance_window) |v| {
        try body_buf.appendSlice(allocator, "&PreferredMaintenanceWindow=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.publicly_accessible) |v| {
        try body_buf.appendSlice(allocator, "&PubliclyAccessible=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.redshift_idc_application_arn) |v| {
        try body_buf.appendSlice(allocator, "&RedshiftIdcApplicationArn=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.reserved_node_id) |v| {
        try body_buf.appendSlice(allocator, "&ReservedNodeId=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.snapshot_arn) |v| {
        try body_buf.appendSlice(allocator, "&SnapshotArn=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.snapshot_cluster_identifier) |v| {
        try body_buf.appendSlice(allocator, "&SnapshotClusterIdentifier=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.snapshot_identifier) |v| {
        try body_buf.appendSlice(allocator, "&SnapshotIdentifier=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.snapshot_schedule_identifier) |v| {
        try body_buf.appendSlice(allocator, "&SnapshotScheduleIdentifier=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.target_reserved_node_offering_id) |v| {
        try body_buf.appendSlice(allocator, "&TargetReservedNodeOfferingId=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.vpc_security_group_ids) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&VpcSecurityGroupIds.VpcSecurityGroupId.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(allocator, field_prefix);
            try aws.url.appendUrlEncoded(allocator, &body_buf, item);
        }
    }

    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-www-form-urlencoded");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !RestoreFromClusterSnapshotOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "RestoreFromClusterSnapshotResult")) break;
            },
            else => {},
        }
    }

    var result: RestoreFromClusterSnapshotOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Cluster")) {
                    result.cluster = try serde.deserializeCluster(allocator, &reader);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }

    return result;
}

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = aws.xml.findElement(body, "Code") orelse "Unknown";
    const error_message = aws.xml.findElement(body, "Message") orelse "";
    const request_id = aws.xml.findElement(body, "RequestId") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, request_id);

    if (std.mem.eql(u8, error_code, "AccessToClusterDeniedFault")) {
        return .{ .arena = arena, .kind = .{ .access_to_cluster_denied_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "AccessToSnapshotDeniedFault")) {
        return .{ .arena = arena, .kind = .{ .access_to_snapshot_denied_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "AuthenticationProfileAlreadyExistsFault")) {
        return .{ .arena = arena, .kind = .{ .authentication_profile_already_exists_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "AuthenticationProfileNotFoundFault")) {
        return .{ .arena = arena, .kind = .{ .authentication_profile_not_found_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "AuthenticationProfileQuotaExceededFault")) {
        return .{ .arena = arena, .kind = .{ .authentication_profile_quota_exceeded_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "AuthorizationAlreadyExistsFault")) {
        return .{ .arena = arena, .kind = .{ .authorization_already_exists_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "AuthorizationNotFoundFault")) {
        return .{ .arena = arena, .kind = .{ .authorization_not_found_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "AuthorizationQuotaExceededFault")) {
        return .{ .arena = arena, .kind = .{ .authorization_quota_exceeded_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "BatchDeleteRequestSizeExceededFault")) {
        return .{ .arena = arena, .kind = .{ .batch_delete_request_size_exceeded_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "BatchModifyClusterSnapshotsLimitExceededFault")) {
        return .{ .arena = arena, .kind = .{ .batch_modify_cluster_snapshots_limit_exceeded_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "BucketNotFoundFault")) {
        return .{ .arena = arena, .kind = .{ .bucket_not_found_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ClusterAlreadyExistsFault")) {
        return .{ .arena = arena, .kind = .{ .cluster_already_exists_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ClusterNotFoundFault")) {
        return .{ .arena = arena, .kind = .{ .cluster_not_found_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ClusterOnLatestRevisionFault")) {
        return .{ .arena = arena, .kind = .{ .cluster_on_latest_revision_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ClusterParameterGroupAlreadyExistsFault")) {
        return .{ .arena = arena, .kind = .{ .cluster_parameter_group_already_exists_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ClusterParameterGroupNotFoundFault")) {
        return .{ .arena = arena, .kind = .{ .cluster_parameter_group_not_found_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ClusterParameterGroupQuotaExceededFault")) {
        return .{ .arena = arena, .kind = .{ .cluster_parameter_group_quota_exceeded_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ClusterQuotaExceededFault")) {
        return .{ .arena = arena, .kind = .{ .cluster_quota_exceeded_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ClusterSecurityGroupAlreadyExistsFault")) {
        return .{ .arena = arena, .kind = .{ .cluster_security_group_already_exists_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ClusterSecurityGroupNotFoundFault")) {
        return .{ .arena = arena, .kind = .{ .cluster_security_group_not_found_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ClusterSecurityGroupQuotaExceededFault")) {
        return .{ .arena = arena, .kind = .{ .cluster_security_group_quota_exceeded_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ClusterSnapshotAlreadyExistsFault")) {
        return .{ .arena = arena, .kind = .{ .cluster_snapshot_already_exists_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ClusterSnapshotNotFoundFault")) {
        return .{ .arena = arena, .kind = .{ .cluster_snapshot_not_found_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ClusterSnapshotQuotaExceededFault")) {
        return .{ .arena = arena, .kind = .{ .cluster_snapshot_quota_exceeded_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ClusterSubnetGroupAlreadyExistsFault")) {
        return .{ .arena = arena, .kind = .{ .cluster_subnet_group_already_exists_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ClusterSubnetGroupNotFoundFault")) {
        return .{ .arena = arena, .kind = .{ .cluster_subnet_group_not_found_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ClusterSubnetGroupQuotaExceededFault")) {
        return .{ .arena = arena, .kind = .{ .cluster_subnet_group_quota_exceeded_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ClusterSubnetQuotaExceededFault")) {
        return .{ .arena = arena, .kind = .{ .cluster_subnet_quota_exceeded_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ConflictPolicyUpdateFault")) {
        return .{ .arena = arena, .kind = .{ .conflict_policy_update_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "CopyToRegionDisabledFault")) {
        return .{ .arena = arena, .kind = .{ .copy_to_region_disabled_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "CustomCnameAssociationFault")) {
        return .{ .arena = arena, .kind = .{ .custom_cname_association_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "CustomDomainAssociationNotFoundFault")) {
        return .{ .arena = arena, .kind = .{ .custom_domain_association_not_found_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DependentServiceAccessDeniedFault")) {
        return .{ .arena = arena, .kind = .{ .dependent_service_access_denied_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DependentServiceRequestThrottlingFault")) {
        return .{ .arena = arena, .kind = .{ .dependent_service_request_throttling_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DependentServiceUnavailableFault")) {
        return .{ .arena = arena, .kind = .{ .dependent_service_unavailable_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "EndpointAlreadyExistsFault")) {
        return .{ .arena = arena, .kind = .{ .endpoint_already_exists_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "EndpointAuthorizationAlreadyExistsFault")) {
        return .{ .arena = arena, .kind = .{ .endpoint_authorization_already_exists_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "EndpointAuthorizationNotFoundFault")) {
        return .{ .arena = arena, .kind = .{ .endpoint_authorization_not_found_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "EndpointAuthorizationsPerClusterLimitExceededFault")) {
        return .{ .arena = arena, .kind = .{ .endpoint_authorizations_per_cluster_limit_exceeded_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "EndpointNotFoundFault")) {
        return .{ .arena = arena, .kind = .{ .endpoint_not_found_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "EndpointsPerAuthorizationLimitExceededFault")) {
        return .{ .arena = arena, .kind = .{ .endpoints_per_authorization_limit_exceeded_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "EndpointsPerClusterLimitExceededFault")) {
        return .{ .arena = arena, .kind = .{ .endpoints_per_cluster_limit_exceeded_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "EventSubscriptionQuotaExceededFault")) {
        return .{ .arena = arena, .kind = .{ .event_subscription_quota_exceeded_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "HsmClientCertificateAlreadyExistsFault")) {
        return .{ .arena = arena, .kind = .{ .hsm_client_certificate_already_exists_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "HsmClientCertificateNotFoundFault")) {
        return .{ .arena = arena, .kind = .{ .hsm_client_certificate_not_found_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "HsmClientCertificateQuotaExceededFault")) {
        return .{ .arena = arena, .kind = .{ .hsm_client_certificate_quota_exceeded_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "HsmConfigurationAlreadyExistsFault")) {
        return .{ .arena = arena, .kind = .{ .hsm_configuration_already_exists_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "HsmConfigurationNotFoundFault")) {
        return .{ .arena = arena, .kind = .{ .hsm_configuration_not_found_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "HsmConfigurationQuotaExceededFault")) {
        return .{ .arena = arena, .kind = .{ .hsm_configuration_quota_exceeded_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InProgressTableRestoreQuotaExceededFault")) {
        return .{ .arena = arena, .kind = .{ .in_progress_table_restore_quota_exceeded_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "IncompatibleOrderableOptions")) {
        return .{ .arena = arena, .kind = .{ .incompatible_orderable_options = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InsufficientClusterCapacityFault")) {
        return .{ .arena = arena, .kind = .{ .insufficient_cluster_capacity_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InsufficientS3BucketPolicyFault")) {
        return .{ .arena = arena, .kind = .{ .insufficient_s3_bucket_policy_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "IntegrationAlreadyExistsFault")) {
        return .{ .arena = arena, .kind = .{ .integration_already_exists_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "IntegrationConflictOperationFault")) {
        return .{ .arena = arena, .kind = .{ .integration_conflict_operation_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "IntegrationConflictStateFault")) {
        return .{ .arena = arena, .kind = .{ .integration_conflict_state_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "IntegrationNotFoundFault")) {
        return .{ .arena = arena, .kind = .{ .integration_not_found_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "IntegrationQuotaExceededFault")) {
        return .{ .arena = arena, .kind = .{ .integration_quota_exceeded_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "IntegrationSourceNotFoundFault")) {
        return .{ .arena = arena, .kind = .{ .integration_source_not_found_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "IntegrationTargetNotFoundFault")) {
        return .{ .arena = arena, .kind = .{ .integration_target_not_found_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidAuthenticationProfileRequestFault")) {
        return .{ .arena = arena, .kind = .{ .invalid_authentication_profile_request_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidAuthorizationStateFault")) {
        return .{ .arena = arena, .kind = .{ .invalid_authorization_state_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidClusterParameterGroupStateFault")) {
        return .{ .arena = arena, .kind = .{ .invalid_cluster_parameter_group_state_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidClusterSecurityGroupStateFault")) {
        return .{ .arena = arena, .kind = .{ .invalid_cluster_security_group_state_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidClusterSnapshotScheduleStateFault")) {
        return .{ .arena = arena, .kind = .{ .invalid_cluster_snapshot_schedule_state_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidClusterSnapshotStateFault")) {
        return .{ .arena = arena, .kind = .{ .invalid_cluster_snapshot_state_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidClusterStateFault")) {
        return .{ .arena = arena, .kind = .{ .invalid_cluster_state_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidClusterSubnetGroupStateFault")) {
        return .{ .arena = arena, .kind = .{ .invalid_cluster_subnet_group_state_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidClusterSubnetStateFault")) {
        return .{ .arena = arena, .kind = .{ .invalid_cluster_subnet_state_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidClusterTrackFault")) {
        return .{ .arena = arena, .kind = .{ .invalid_cluster_track_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidDataShareFault")) {
        return .{ .arena = arena, .kind = .{ .invalid_data_share_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidElasticIpFault")) {
        return .{ .arena = arena, .kind = .{ .invalid_elastic_ip_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidEndpointStateFault")) {
        return .{ .arena = arena, .kind = .{ .invalid_endpoint_state_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidHsmClientCertificateStateFault")) {
        return .{ .arena = arena, .kind = .{ .invalid_hsm_client_certificate_state_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidHsmConfigurationStateFault")) {
        return .{ .arena = arena, .kind = .{ .invalid_hsm_configuration_state_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidNamespaceFault")) {
        return .{ .arena = arena, .kind = .{ .invalid_namespace_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidPolicyFault")) {
        return .{ .arena = arena, .kind = .{ .invalid_policy_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidReservedNodeStateFault")) {
        return .{ .arena = arena, .kind = .{ .invalid_reserved_node_state_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidRestoreFault")) {
        return .{ .arena = arena, .kind = .{ .invalid_restore_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidRetentionPeriodFault")) {
        return .{ .arena = arena, .kind = .{ .invalid_retention_period_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidS3BucketNameFault")) {
        return .{ .arena = arena, .kind = .{ .invalid_s3_bucket_name_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidS3KeyPrefixFault")) {
        return .{ .arena = arena, .kind = .{ .invalid_s3_key_prefix_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidScheduleFault")) {
        return .{ .arena = arena, .kind = .{ .invalid_schedule_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidScheduledActionFault")) {
        return .{ .arena = arena, .kind = .{ .invalid_scheduled_action_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidSnapshotCopyGrantStateFault")) {
        return .{ .arena = arena, .kind = .{ .invalid_snapshot_copy_grant_state_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidSubnet")) {
        return .{ .arena = arena, .kind = .{ .invalid_subnet = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidSubscriptionStateFault")) {
        return .{ .arena = arena, .kind = .{ .invalid_subscription_state_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidTableRestoreArgumentFault")) {
        return .{ .arena = arena, .kind = .{ .invalid_table_restore_argument_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidTagFault")) {
        return .{ .arena = arena, .kind = .{ .invalid_tag_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidUsageLimitFault")) {
        return .{ .arena = arena, .kind = .{ .invalid_usage_limit_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidVPCNetworkStateFault")) {
        return .{ .arena = arena, .kind = .{ .invalid_vpc_network_state_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "Ipv6CidrBlockNotFoundFault")) {
        return .{ .arena = arena, .kind = .{ .ipv_6_cidr_block_not_found_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "LimitExceededFault")) {
        return .{ .arena = arena, .kind = .{ .limit_exceeded_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NumberOfNodesPerClusterLimitExceededFault")) {
        return .{ .arena = arena, .kind = .{ .number_of_nodes_per_cluster_limit_exceeded_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NumberOfNodesQuotaExceededFault")) {
        return .{ .arena = arena, .kind = .{ .number_of_nodes_quota_exceeded_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "PartnerNotFoundFault")) {
        return .{ .arena = arena, .kind = .{ .partner_not_found_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "RedshiftIdcApplicationAlreadyExistsFault")) {
        return .{ .arena = arena, .kind = .{ .redshift_idc_application_already_exists_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "RedshiftIdcApplicationNotExistsFault")) {
        return .{ .arena = arena, .kind = .{ .redshift_idc_application_not_exists_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "RedshiftIdcApplicationQuotaExceededFault")) {
        return .{ .arena = arena, .kind = .{ .redshift_idc_application_quota_exceeded_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "RedshiftInvalidParameterFault")) {
        return .{ .arena = arena, .kind = .{ .redshift_invalid_parameter_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ReservedNodeAlreadyExistsFault")) {
        return .{ .arena = arena, .kind = .{ .reserved_node_already_exists_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ReservedNodeAlreadyMigratedFault")) {
        return .{ .arena = arena, .kind = .{ .reserved_node_already_migrated_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ReservedNodeExchangeNotFoundFault")) {
        return .{ .arena = arena, .kind = .{ .reserved_node_exchange_not_found_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ReservedNodeNotFoundFault")) {
        return .{ .arena = arena, .kind = .{ .reserved_node_not_found_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ReservedNodeOfferingNotFoundFault")) {
        return .{ .arena = arena, .kind = .{ .reserved_node_offering_not_found_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ReservedNodeQuotaExceededFault")) {
        return .{ .arena = arena, .kind = .{ .reserved_node_quota_exceeded_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResizeNotFoundFault")) {
        return .{ .arena = arena, .kind = .{ .resize_not_found_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFoundFault")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ScheduleDefinitionTypeUnsupportedFault")) {
        return .{ .arena = arena, .kind = .{ .schedule_definition_type_unsupported_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ScheduledActionAlreadyExistsFault")) {
        return .{ .arena = arena, .kind = .{ .scheduled_action_already_exists_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ScheduledActionNotFoundFault")) {
        return .{ .arena = arena, .kind = .{ .scheduled_action_not_found_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ScheduledActionQuotaExceededFault")) {
        return .{ .arena = arena, .kind = .{ .scheduled_action_quota_exceeded_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ScheduledActionTypeUnsupportedFault")) {
        return .{ .arena = arena, .kind = .{ .scheduled_action_type_unsupported_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "SnapshotCopyAlreadyDisabledFault")) {
        return .{ .arena = arena, .kind = .{ .snapshot_copy_already_disabled_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "SnapshotCopyAlreadyEnabledFault")) {
        return .{ .arena = arena, .kind = .{ .snapshot_copy_already_enabled_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "SnapshotCopyDisabledFault")) {
        return .{ .arena = arena, .kind = .{ .snapshot_copy_disabled_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "SnapshotCopyGrantAlreadyExistsFault")) {
        return .{ .arena = arena, .kind = .{ .snapshot_copy_grant_already_exists_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "SnapshotCopyGrantNotFoundFault")) {
        return .{ .arena = arena, .kind = .{ .snapshot_copy_grant_not_found_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "SnapshotCopyGrantQuotaExceededFault")) {
        return .{ .arena = arena, .kind = .{ .snapshot_copy_grant_quota_exceeded_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "SnapshotScheduleAlreadyExistsFault")) {
        return .{ .arena = arena, .kind = .{ .snapshot_schedule_already_exists_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "SnapshotScheduleNotFoundFault")) {
        return .{ .arena = arena, .kind = .{ .snapshot_schedule_not_found_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "SnapshotScheduleQuotaExceededFault")) {
        return .{ .arena = arena, .kind = .{ .snapshot_schedule_quota_exceeded_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "SnapshotScheduleUpdateInProgressFault")) {
        return .{ .arena = arena, .kind = .{ .snapshot_schedule_update_in_progress_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "SNSInvalidTopicFault")) {
        return .{ .arena = arena, .kind = .{ .sns_invalid_topic_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "SNSNoAuthorizationFault")) {
        return .{ .arena = arena, .kind = .{ .sns_no_authorization_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "SNSTopicArnNotFoundFault")) {
        return .{ .arena = arena, .kind = .{ .sns_topic_arn_not_found_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "SourceNotFoundFault")) {
        return .{ .arena = arena, .kind = .{ .source_not_found_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "SubnetAlreadyInUse")) {
        return .{ .arena = arena, .kind = .{ .subnet_already_in_use = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "SubscriptionAlreadyExistFault")) {
        return .{ .arena = arena, .kind = .{ .subscription_already_exist_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "SubscriptionCategoryNotFoundFault")) {
        return .{ .arena = arena, .kind = .{ .subscription_category_not_found_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "SubscriptionEventIdNotFoundFault")) {
        return .{ .arena = arena, .kind = .{ .subscription_event_id_not_found_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "SubscriptionNotFoundFault")) {
        return .{ .arena = arena, .kind = .{ .subscription_not_found_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "SubscriptionSeverityNotFoundFault")) {
        return .{ .arena = arena, .kind = .{ .subscription_severity_not_found_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TableLimitExceededFault")) {
        return .{ .arena = arena, .kind = .{ .table_limit_exceeded_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TableRestoreNotFoundFault")) {
        return .{ .arena = arena, .kind = .{ .table_restore_not_found_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TagLimitExceededFault")) {
        return .{ .arena = arena, .kind = .{ .tag_limit_exceeded_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UnauthorizedOperation")) {
        return .{ .arena = arena, .kind = .{ .unauthorized_operation = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UnauthorizedPartnerIntegrationFault")) {
        return .{ .arena = arena, .kind = .{ .unauthorized_partner_integration_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UnknownSnapshotCopyRegionFault")) {
        return .{ .arena = arena, .kind = .{ .unknown_snapshot_copy_region_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UnsupportedOperationFault")) {
        return .{ .arena = arena, .kind = .{ .unsupported_operation_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UnsupportedOptionFault")) {
        return .{ .arena = arena, .kind = .{ .unsupported_option_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UsageLimitAlreadyExistsFault")) {
        return .{ .arena = arena, .kind = .{ .usage_limit_already_exists_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UsageLimitNotFoundFault")) {
        return .{ .arena = arena, .kind = .{ .usage_limit_not_found_fault = .{
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
