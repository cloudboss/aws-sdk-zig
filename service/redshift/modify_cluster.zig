const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Cluster = @import("cluster.zig").Cluster;
const serde = @import("serde.zig");

pub const ModifyClusterInput = struct {
    /// If `true`, major version upgrades will be applied automatically to the
    /// cluster during the maintenance window.
    ///
    /// Default: `false`
    allow_version_upgrade: ?bool = null,

    /// The number of days that automated snapshots are retained. If the value is 0,
    /// automated snapshots are disabled. Even if automated snapshots are disabled,
    /// you can
    /// still create manual snapshots when you want with CreateClusterSnapshot.
    ///
    /// If you decrease the automated snapshot retention period from its current
    /// value,
    /// existing automated snapshots that fall outside of the new retention period
    /// will be
    /// immediately deleted.
    ///
    /// You can't disable automated snapshots for RG or RA3 node types. Set the
    /// automated retention period from 1-35 days.
    ///
    /// Default: Uses existing setting.
    ///
    /// Constraints: Must be a value from 0 to 35.
    automated_snapshot_retention_period: ?i32 = null,

    /// The option to initiate relocation for an Amazon Redshift cluster to the
    /// target Availability Zone.
    availability_zone: ?[]const u8 = null,

    /// The option to enable relocation for an Amazon Redshift cluster between
    /// Availability Zones after the cluster modification is complete.
    availability_zone_relocation: ?bool = null,

    /// The unique identifier of the cluster to be modified.
    ///
    /// Example: `examplecluster`
    cluster_identifier: []const u8,

    /// The name of the cluster parameter group to apply to this cluster. This
    /// change is
    /// applied only after the cluster is rebooted. To reboot a cluster use
    /// RebootCluster.
    ///
    /// Default: Uses existing setting.
    ///
    /// Constraints: The cluster parameter group must be in the same parameter group
    /// family
    /// that matches the cluster version.
    cluster_parameter_group_name: ?[]const u8 = null,

    /// A list of cluster security groups to be authorized on this cluster. This
    /// change is
    /// asynchronously applied as soon as possible.
    ///
    /// Security groups currently associated with the cluster, and not in the list
    /// of
    /// groups to apply, will be revoked from the cluster.
    ///
    /// Constraints:
    ///
    /// * Must be 1 to 255 alphanumeric characters or hyphens
    ///
    /// * First character must be a letter
    ///
    /// * Cannot end with a hyphen or contain two consecutive hyphens
    cluster_security_groups: ?[]const []const u8 = null,

    /// The new cluster type.
    ///
    /// When you submit your cluster resize request, your existing cluster goes into
    /// a
    /// read-only mode. After Amazon Redshift provisions a new cluster based on your
    /// resize
    /// requirements, there will be outage for a period while the old cluster is
    /// deleted and
    /// your connection is switched to the new cluster. You can use DescribeResize
    /// to track the progress of the resize request.
    ///
    /// Valid Values: ` multi-node | single-node `
    cluster_type: ?[]const u8 = null,

    /// The new version number of the Amazon Redshift engine to upgrade to.
    ///
    /// For major version upgrades, if a non-default cluster parameter group is
    /// currently
    /// in use, a new cluster parameter group in the cluster parameter group family
    /// for the new
    /// version must be specified. The new cluster parameter group can be the
    /// default for that
    /// cluster parameter group family.
    /// For more information about parameters and parameter groups, go to
    /// [Amazon Redshift Parameter
    /// Groups](https://docs.aws.amazon.com/redshift/latest/mgmt/working-with-parameter-groups.html)
    /// in the *Amazon Redshift Cluster Management Guide*.
    ///
    /// Example: `1.0`
    cluster_version: ?[]const u8 = null,

    /// The Elastic IP (EIP) address for the cluster.
    ///
    /// Constraints: The cluster must be provisioned in EC2-VPC and
    /// publicly-accessible
    /// through an Internet gateway. For more information about provisioning
    /// clusters in
    /// EC2-VPC, go to [Supported
    /// Platforms to Launch Your
    /// Cluster](https://docs.aws.amazon.com/redshift/latest/mgmt/working-with-clusters.html#cluster-platforms) in the Amazon Redshift Cluster Management Guide.
    elastic_ip: ?[]const u8 = null,

    /// Indicates whether the cluster is encrypted. If the value is encrypted (true)
    /// and you
    /// provide a value for the `KmsKeyId` parameter, we encrypt the cluster
    /// with the provided `KmsKeyId`. If you don't provide a `KmsKeyId`,
    /// we encrypt with the default key.
    ///
    /// If the value is not encrypted (false), then the cluster is decrypted.
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

    /// If `true`, allocates additional compute resources for running automatic
    /// optimization operations.
    ///
    /// Default: false
    extra_compute_for_automatic_optimization: ?bool = null,

    /// Specifies the name of the HSM client certificate the Amazon Redshift cluster
    /// uses to
    /// retrieve the data encryption keys stored in an HSM.
    hsm_client_certificate_identifier: ?[]const u8 = null,

    /// Specifies the name of the HSM configuration that contains the information
    /// the
    /// Amazon Redshift cluster can use to retrieve and store keys in an HSM.
    hsm_configuration_identifier: ?[]const u8 = null,

    /// The IP address types that the cluster supports. Possible values are `ipv4`
    /// and `dualstack`.
    ip_address_type: ?[]const u8 = null,

    /// The Key Management Service (KMS) key ID of the encryption key that you want
    /// to use
    /// to encrypt data in the cluster.
    kms_key_id: ?[]const u8 = null,

    /// The name for the maintenance track that you want to assign for the cluster.
    /// This name
    /// change is asynchronous. The new track name stays in the
    /// `PendingModifiedValues` for the cluster until the next maintenance
    /// window. When the maintenance track changes, the cluster is switched to the
    /// latest
    /// cluster release available for the maintenance track. At this point, the
    /// maintenance
    /// track name is applied.
    maintenance_track_name: ?[]const u8 = null,

    /// If `true`, Amazon Redshift uses Secrets Manager to manage this cluster's
    /// admin credentials.
    /// You can't use `MasterUserPassword` if `ManageMasterPassword` is true.
    /// If `ManageMasterPassword` is false or not set, Amazon Redshift uses
    /// `MasterUserPassword` for the admin user account's password.
    manage_master_password: ?bool = null,

    /// The default for number of days that a newly created manual snapshot is
    /// retained. If
    /// the value is -1, the manual snapshot is retained indefinitely. This value
    /// doesn't
    /// retroactively change the retention periods of existing manual snapshots.
    ///
    /// The value must be either -1 or an integer between 1 and 3,653.
    ///
    /// The default value is -1.
    manual_snapshot_retention_period: ?i32 = null,

    /// The ID of the Key Management Service (KMS) key used to encrypt and store the
    /// cluster's admin credentials secret.
    /// You can only use this parameter if `ManageMasterPassword` is true.
    master_password_secret_kms_key_id: ?[]const u8 = null,

    /// The new password for the cluster admin user. This change is asynchronously
    /// applied
    /// as soon as possible. Between the time of the request and the completion of
    /// the request,
    /// the `MasterUserPassword` element exists in the
    /// `PendingModifiedValues` element of the operation response.
    ///
    /// You can't use `MasterUserPassword` if `ManageMasterPassword` is `true`.
    ///
    /// Operations never return the password, so this operation provides a way to
    /// regain access to the admin user account for a cluster if the password is
    /// lost.
    ///
    /// Default: Uses existing setting.
    ///
    /// Constraints:
    ///
    /// * Must be between 8 and 64 characters in length.
    ///
    /// * Must contain at least one uppercase letter.
    ///
    /// * Must contain at least one lowercase letter.
    ///
    /// * Must contain one number.
    ///
    /// * Can be any printable ASCII character (ASCII code 33-126) except `'`
    /// (single quote), `"` (double quote), `\`, `/`, or `@`.
    master_user_password: ?[]const u8 = null,

    /// If true and the cluster is currently only deployed in a single Availability
    /// Zone, the cluster will be modified to be deployed in two Availability Zones.
    multi_az: ?bool = null,

    /// The new identifier for the cluster.
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
    ///
    /// Example: `examplecluster`
    new_cluster_identifier: ?[]const u8 = null,

    /// The new node type of the cluster. If you specify a new node type, you must
    /// also
    /// specify the number of nodes parameter.
    ///
    /// For more information about resizing clusters, go to
    /// [Resizing Clusters in Amazon
    /// Redshift](https://docs.aws.amazon.com/redshift/latest/mgmt/rs-resize-tutorial.html)
    /// in the *Amazon Redshift Cluster Management Guide*.
    ///
    /// Valid Values:
    /// `dc2.large` | `dc2.8xlarge` | `rg.large` | `rg.xlarge` | `rg.4xlarge` |
    /// `rg.12xlarge` |
    /// `ra3.large` | `ra3.xlplus` | `ra3.4xlarge` | `ra3.16xlarge`
    node_type: ?[]const u8 = null,

    /// The new number of nodes of the cluster. If you specify a new number of
    /// nodes, you
    /// must also specify the node type parameter.
    ///
    /// For more information about resizing clusters, go to
    /// [Resizing Clusters in Amazon
    /// Redshift](https://docs.aws.amazon.com/redshift/latest/mgmt/rs-resize-tutorial.html)
    /// in the *Amazon Redshift Cluster Management Guide*.
    ///
    /// Valid Values: Integer greater than `0`.
    number_of_nodes: ?i32 = null,

    /// The option to change the port of an Amazon Redshift cluster.
    ///
    /// Valid Values:
    ///
    /// * For clusters with RG or RA3 nodes - Select a port within the ranges
    ///   `5431-5455` or `8191-8215`. (If you have an existing cluster
    /// with RG or RA3 nodes, it isn't required that you change the port to these
    /// ranges.)
    ///
    /// * For clusters with dc2 nodes - Select a port within the range `1150-65535`.
    port: ?i32 = null,

    /// The weekly time range (in UTC) during which system maintenance can occur, if
    /// necessary. If system maintenance is necessary during the window, it may
    /// result in an
    /// outage.
    ///
    /// This maintenance window change is made immediately. If the new maintenance
    /// window
    /// indicates the current time, there must be at least 120 minutes between the
    /// current time
    /// and end of the window in order to ensure that pending changes are applied.
    ///
    /// Default: Uses existing setting.
    ///
    /// Format: ddd:hh24:mi-ddd:hh24:mi, for example
    /// `wed:07:30-wed:08:00`.
    ///
    /// Valid Days: Mon | Tue | Wed | Thu | Fri | Sat | Sun
    ///
    /// Constraints: Must be at least 30 minutes.
    preferred_maintenance_window: ?[]const u8 = null,

    /// If `true`, the cluster can be accessed from a public network. Only
    /// clusters in VPCs can be set to be publicly available.
    ///
    /// Default: false
    publicly_accessible: ?bool = null,

    /// A list of virtual private cloud (VPC) security groups to be associated with
    /// the
    /// cluster. This change is asynchronously applied as soon as possible.
    vpc_security_group_ids: ?[]const []const u8 = null,
};

pub const ModifyClusterOutput = struct {
    cluster: ?Cluster = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ModifyClusterInput, options: CallOptions) !ModifyClusterOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ModifyClusterInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("redshift", "Redshift", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=ModifyCluster&Version=2012-12-01");
    if (input.allow_version_upgrade) |v| {
        try body_buf.appendSlice(allocator, "&AllowVersionUpgrade=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
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
    if (input.cluster_type) |v| {
        try body_buf.appendSlice(allocator, "&ClusterType=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.cluster_version) |v| {
        try body_buf.appendSlice(allocator, "&ClusterVersion=");
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
    if (input.extra_compute_for_automatic_optimization) |v| {
        try body_buf.appendSlice(allocator, "&ExtraComputeForAutomaticOptimization=");
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
    if (input.master_user_password) |v| {
        try body_buf.appendSlice(allocator, "&MasterUserPassword=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.multi_az) |v| {
        try body_buf.appendSlice(allocator, "&MultiAZ=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.new_cluster_identifier) |v| {
        try body_buf.appendSlice(allocator, "&NewClusterIdentifier=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.node_type) |v| {
        try body_buf.appendSlice(allocator, "&NodeType=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.number_of_nodes) |v| {
        try body_buf.appendSlice(allocator, "&NumberOfNodes=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ModifyClusterOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ModifyClusterResult")) break;
            },
            else => {},
        }
    }

    var result: ModifyClusterOutput = .{};
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
