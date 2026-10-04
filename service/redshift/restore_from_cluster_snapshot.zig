const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
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

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "redshift", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: RestoreFromClusterSnapshotInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("redshift", "Redshift", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

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
        try aws.url.appendUrlEncoded(allocator, &body_buf, v.wireName());
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

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
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
