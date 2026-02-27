const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const AquaConfigurationStatus = @import("aqua_configuration_status.zig").AquaConfigurationStatus;
const Tag = @import("tag.zig").Tag;
const Cluster = @import("cluster.zig").Cluster;
const serde = @import("serde.zig");

pub const CreateClusterInput = struct {
    /// Reserved.
    additional_info: ?[]const u8 = null,

    /// If `true`, major version upgrades can be applied during the maintenance
    /// window to the Amazon Redshift engine that is running on the cluster.
    ///
    /// When a new major version of the Amazon Redshift engine is released, you can
    /// request that
    /// the service automatically apply upgrades during the maintenance window to
    /// the Amazon Redshift
    /// engine that is running on your cluster.
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
    /// Default: `1`
    ///
    /// Constraints: Must be a value from 0 to 35.
    automated_snapshot_retention_period: ?i32 = null,

    /// The EC2 Availability Zone (AZ) in which you want Amazon Redshift to
    /// provision the
    /// cluster. For example, if you have several EC2 instances running in a
    /// specific
    /// Availability Zone, then you might want the cluster to be provisioned in the
    /// same zone in
    /// order to decrease network latency.
    ///
    /// Default: A random, system-chosen Availability Zone in the region that is
    /// specified
    /// by the endpoint.
    ///
    /// Example: `us-east-2d`
    ///
    /// Constraint: The specified Availability Zone must be in the same region as
    /// the
    /// current endpoint.
    availability_zone: ?[]const u8 = null,

    /// The option to enable relocation for an Amazon Redshift cluster between
    /// Availability Zones after the cluster is created.
    availability_zone_relocation: ?bool = null,

    /// The name of the Glue data catalog that will be associated with the cluster
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

    /// A unique identifier for the cluster. You use this identifier to refer to the
    /// cluster for any subsequent cluster operations such as deleting or modifying.
    /// The
    /// identifier also appears in the Amazon Redshift console.
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
    /// Example: `myexamplecluster`
    cluster_identifier: []const u8,

    /// The name of the parameter group to be associated with this cluster.
    ///
    /// Default: The default Amazon Redshift cluster parameter group. For
    /// information about the
    /// default parameter group, go to [Working with Amazon
    /// Redshift Parameter
    /// Groups](https://docs.aws.amazon.com/redshift/latest/mgmt/working-with-parameter-groups.html)
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
    cluster_security_groups: ?[]const []const u8 = null,

    /// The name of a cluster subnet group to be associated with this cluster.
    ///
    /// If this parameter is not provided the resulting cluster will be deployed
    /// outside
    /// virtual private cloud (VPC).
    cluster_subnet_group_name: ?[]const u8 = null,

    /// The type of the cluster. When cluster type is specified as
    ///
    /// * `single-node`, the **NumberOfNodes**
    /// parameter is not required.
    ///
    /// * `multi-node`, the **NumberOfNodes**
    /// parameter is required.
    ///
    /// Valid Values: `multi-node` | `single-node`
    ///
    /// Default: `multi-node`
    cluster_type: ?[]const u8 = null,

    /// The version of the Amazon Redshift engine software that you want to deploy
    /// on the
    /// cluster.
    ///
    /// The version selected runs on all the nodes in the cluster.
    ///
    /// Constraints: Only version 1.0 is currently available.
    ///
    /// Example: `1.0`
    cluster_version: ?[]const u8 = null,

    /// The name of the first database to be created when the cluster is created.
    ///
    /// To create additional databases after the cluster is created, connect to the
    /// cluster
    /// with a SQL client and use SQL commands to create a database. For more
    /// information, go to
    /// [Create
    /// a
    /// Database](https://docs.aws.amazon.com/redshift/latest/dg/t_creating_database.html) in the Amazon Redshift Database Developer Guide.
    ///
    /// Default: `dev`
    ///
    /// Constraints:
    ///
    /// * Must contain 1 to 64 alphanumeric characters.
    ///
    /// * Must contain only lowercase letters.
    ///
    /// * Cannot be a word that is reserved by the service. A list of reserved words
    /// can be found in [Reserved
    /// Words](https://docs.aws.amazon.com/redshift/latest/dg/r_pg_keywords.html) in
    /// the
    /// Amazon Redshift Database Developer Guide.
    db_name: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) for the IAM role that was set as default for
    /// the cluster when the cluster was created.
    default_iam_role_arn: ?[]const u8 = null,

    /// The Elastic IP (EIP) address for the cluster.
    ///
    /// Constraints: The cluster must be provisioned in EC2-VPC and
    /// publicly-accessible
    /// through an Internet gateway. Don't specify the Elastic IP address for a
    /// publicly accessible
    /// cluster with availability zone relocation turned on. For more information
    /// about provisioning clusters in
    /// EC2-VPC, go to [Supported
    /// Platforms to Launch Your
    /// Cluster](https://docs.aws.amazon.com/redshift/latest/mgmt/working-with-clusters.html#cluster-platforms) in the Amazon Redshift Cluster Management Guide.
    elastic_ip: ?[]const u8 = null,

    /// If `true`, the data in the cluster is encrypted at rest.
    /// If you set the value on this parameter to `false`, the request will fail.
    ///
    /// Default: true
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

    /// The IP address types that the cluster supports. Possible values are `ipv4`
    /// and `dualstack`.
    ip_address_type: ?[]const u8 = null,

    /// The Key Management Service (KMS) key ID of the encryption key that you want
    /// to
    /// use to encrypt data in the cluster.
    kms_key_id: ?[]const u8 = null,

    /// A flag that specifies whether to load sample data once the cluster is
    /// created.
    load_sample_data: ?[]const u8 = null,

    /// An optional parameter for the name of the maintenance track for the cluster.
    /// If you
    /// don't provide a maintenance track name, the cluster is assigned to the
    /// `current` track.
    maintenance_track_name: ?[]const u8 = null,

    /// If `true`, Amazon Redshift uses Secrets Manager to manage this cluster's
    /// admin credentials.
    /// You can't use `MasterUserPassword` if `ManageMasterPassword` is true.
    /// If `ManageMasterPassword` is false or not set, Amazon Redshift uses
    /// `MasterUserPassword` for the admin user account's password.
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

    /// The user name associated with the admin user account for the cluster that is
    /// being
    /// created.
    ///
    /// Constraints:
    ///
    /// * Must be 1 - 128 alphanumeric characters or hyphens. The user name can't be
    /// `PUBLIC`.
    ///
    /// * Must contain only lowercase letters, numbers, underscore, plus sign,
    ///   period (dot), at symbol (@), or hyphen.
    ///
    /// * The first character must be a letter.
    ///
    /// * Must not contain a colon (:) or a slash (/).
    ///
    /// * Cannot be a reserved word. A list of reserved words can be found in
    ///   [Reserved
    /// Words](https://docs.aws.amazon.com/redshift/latest/dg/r_pg_keywords.html) in
    /// the Amazon Redshift Database Developer Guide.
    master_username: []const u8,

    /// The password associated with the admin user account for the cluster that is
    /// being
    /// created.
    ///
    /// You can't use `MasterUserPassword` if `ManageMasterPassword` is `true`.
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

    /// If true, Amazon Redshift will deploy the cluster in two Availability Zones
    /// (AZ).
    multi_az: ?bool = null,

    /// The node type to be provisioned for the cluster. For information about node
    /// types,
    /// go to [ Working with
    /// Clusters](https://docs.aws.amazon.com/redshift/latest/mgmt/working-with-clusters.html#how-many-nodes) in the *Amazon Redshift Cluster Management Guide*.
    ///
    /// Valid Values:
    /// `dc2.large` | `dc2.8xlarge` |
    /// `ra3.large` | `ra3.xlplus` | `ra3.4xlarge` | `ra3.16xlarge`
    node_type: []const u8,

    /// The number of compute nodes in the cluster. This parameter is required when
    /// the
    /// **ClusterType** parameter is specified as
    /// `multi-node`.
    ///
    /// For information about determining how many nodes you need, go to [ Working
    /// with
    /// Clusters](https://docs.aws.amazon.com/redshift/latest/mgmt/working-with-clusters.html#how-many-nodes) in the *Amazon Redshift Cluster Management Guide*.
    ///
    /// If you don't specify this parameter, you get a single-node cluster. When
    /// requesting
    /// a multi-node cluster, you must specify the number of nodes that you want in
    /// the
    /// cluster.
    ///
    /// Default: `1`
    ///
    /// Constraints: Value must be at least 1 and no more than 100.
    number_of_nodes: ?i32 = null,

    /// The port number on which the cluster accepts incoming connections.
    ///
    /// The cluster is accessible only via the JDBC and ODBC connection strings.
    /// Part of
    /// the connection string requires the port on which the cluster will listen for
    /// incoming
    /// connections.
    ///
    /// Default: `5439`
    ///
    /// Valid Values:
    ///
    /// * For clusters with ra3 nodes - Select a port within the ranges `5431-5455`
    ///   or `8191-8215`. (If you have an existing cluster
    /// with ra3 nodes, it isn't required that you change the port to these ranges.)
    ///
    /// * For clusters with dc2 nodes - Select a port within the range `1150-65535`.
    port: ?i32 = null,

    /// The weekly time range (in UTC) during which automated cluster maintenance
    /// can
    /// occur.
    ///
    /// Format: `ddd:hh24:mi-ddd:hh24:mi`
    ///
    /// Default: A 30-minute window selected at random from an 8-hour block of time
    /// per
    /// region, occurring on a random day of the week. For more information about
    /// the time
    /// blocks for each region, see [Maintenance
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

    /// The Amazon resource name (ARN) of the Amazon Redshift IAM Identity Center
    /// application.
    redshift_idc_application_arn: ?[]const u8 = null,

    /// A unique identifier for the snapshot schedule.
    snapshot_schedule_identifier: ?[]const u8 = null,

    /// A list of tag instances.
    tags: ?[]const Tag = null,

    /// A list of Virtual Private Cloud (VPC) security groups to be associated with
    /// the
    /// cluster.
    ///
    /// Default: The default VPC security group is associated with the cluster.
    vpc_security_group_ids: ?[]const []const u8 = null,
};

pub const CreateClusterOutput = struct {
    cluster: ?Cluster = null,
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateClusterInput, options: Options) !CreateClusterOutput {
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
            d.* = parseErrorResponse(response.body, response.status, client.allocator) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(response.body, response.status, response.headers, allocator);
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: CreateClusterInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("redshift", "Redshift", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=CreateCluster&Version=2012-12-01");
    if (input.additional_info) |v| {
        try body_buf.appendSlice(alloc, "&AdditionalInfo=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.allow_version_upgrade) |v| {
        try body_buf.appendSlice(alloc, "&AllowVersionUpgrade=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    if (input.aqua_configuration_status) |v| {
        try body_buf.appendSlice(alloc, "&AquaConfigurationStatus=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(v));
    }
    if (input.automated_snapshot_retention_period) |v| {
        try body_buf.appendSlice(alloc, "&AutomatedSnapshotRetentionPeriod=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{v}) catch "");
    }
    if (input.availability_zone) |v| {
        try body_buf.appendSlice(alloc, "&AvailabilityZone=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.availability_zone_relocation) |v| {
        try body_buf.appendSlice(alloc, "&AvailabilityZoneRelocation=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    if (input.catalog_name) |v| {
        try body_buf.appendSlice(alloc, "&CatalogName=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    try body_buf.appendSlice(alloc, "&ClusterIdentifier=");
    try aws.url.appendUrlEncoded(alloc, &body_buf, input.cluster_identifier);
    if (input.cluster_parameter_group_name) |v| {
        try body_buf.appendSlice(alloc, "&ClusterParameterGroupName=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.cluster_security_groups) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&ClusterSecurityGroups.ClusterSecurityGroupName.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(alloc, field_prefix);
            try aws.url.appendUrlEncoded(alloc, &body_buf, item);
        }
    }
    if (input.cluster_subnet_group_name) |v| {
        try body_buf.appendSlice(alloc, "&ClusterSubnetGroupName=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.cluster_type) |v| {
        try body_buf.appendSlice(alloc, "&ClusterType=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.cluster_version) |v| {
        try body_buf.appendSlice(alloc, "&ClusterVersion=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.db_name) |v| {
        try body_buf.appendSlice(alloc, "&DBName=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.default_iam_role_arn) |v| {
        try body_buf.appendSlice(alloc, "&DefaultIamRoleArn=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.elastic_ip) |v| {
        try body_buf.appendSlice(alloc, "&ElasticIp=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.encrypted) |v| {
        try body_buf.appendSlice(alloc, "&Encrypted=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    if (input.enhanced_vpc_routing) |v| {
        try body_buf.appendSlice(alloc, "&EnhancedVpcRouting=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    if (input.extra_compute_for_automatic_optimization) |v| {
        try body_buf.appendSlice(alloc, "&ExtraComputeForAutomaticOptimization=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    if (input.hsm_client_certificate_identifier) |v| {
        try body_buf.appendSlice(alloc, "&HsmClientCertificateIdentifier=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.hsm_configuration_identifier) |v| {
        try body_buf.appendSlice(alloc, "&HsmConfigurationIdentifier=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.iam_roles) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&IamRoles.IamRoleArn.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(alloc, field_prefix);
            try aws.url.appendUrlEncoded(alloc, &body_buf, item);
        }
    }
    if (input.ip_address_type) |v| {
        try body_buf.appendSlice(alloc, "&IpAddressType=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.kms_key_id) |v| {
        try body_buf.appendSlice(alloc, "&KmsKeyId=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.load_sample_data) |v| {
        try body_buf.appendSlice(alloc, "&LoadSampleData=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.maintenance_track_name) |v| {
        try body_buf.appendSlice(alloc, "&MaintenanceTrackName=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.manage_master_password) |v| {
        try body_buf.appendSlice(alloc, "&ManageMasterPassword=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    if (input.manual_snapshot_retention_period) |v| {
        try body_buf.appendSlice(alloc, "&ManualSnapshotRetentionPeriod=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{v}) catch "");
    }
    if (input.master_password_secret_kms_key_id) |v| {
        try body_buf.appendSlice(alloc, "&MasterPasswordSecretKmsKeyId=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    try body_buf.appendSlice(alloc, "&MasterUsername=");
    try aws.url.appendUrlEncoded(alloc, &body_buf, input.master_username);
    if (input.master_user_password) |v| {
        try body_buf.appendSlice(alloc, "&MasterUserPassword=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.multi_az) |v| {
        try body_buf.appendSlice(alloc, "&MultiAZ=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    try body_buf.appendSlice(alloc, "&NodeType=");
    try aws.url.appendUrlEncoded(alloc, &body_buf, input.node_type);
    if (input.number_of_nodes) |v| {
        try body_buf.appendSlice(alloc, "&NumberOfNodes=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{v}) catch "");
    }
    if (input.port) |v| {
        try body_buf.appendSlice(alloc, "&Port=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{v}) catch "");
    }
    if (input.preferred_maintenance_window) |v| {
        try body_buf.appendSlice(alloc, "&PreferredMaintenanceWindow=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.publicly_accessible) |v| {
        try body_buf.appendSlice(alloc, "&PubliclyAccessible=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    if (input.redshift_idc_application_arn) |v| {
        try body_buf.appendSlice(alloc, "&RedshiftIdcApplicationArn=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.snapshot_schedule_identifier) |v| {
        try body_buf.appendSlice(alloc, "&SnapshotScheduleIdentifier=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.tags) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Tags.Tag.{d}.Key=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (item.key) |fv_1| {
                    try aws.url.appendUrlEncoded(alloc, &body_buf, fv_1);
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Tags.Tag.{d}.Value=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (item.value) |fv_1| {
                    try aws.url.appendUrlEncoded(alloc, &body_buf, fv_1);
                }
            }
        }
    }
    if (input.vpc_security_group_ids) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&VpcSecurityGroupIds.VpcSecurityGroupId.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(alloc, field_prefix);
            try aws.url.appendUrlEncoded(alloc, &body_buf, item);
        }
    }

    const body = try body_buf.toOwnedSlice(alloc);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/x-www-form-urlencoded");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !CreateClusterOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CreateClusterResult")) break;
            },
            else => {},
        }
    }

    var result: CreateClusterOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Cluster")) {
                    result.cluster = try serde.deserializeCluster(&reader, alloc);
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

fn parseErrorResponse(body: []const u8, status: u16, alloc: std.mem.Allocator) !ServiceError {
    const error_code = aws.xml.findElement(body, "Code") orelse "Unknown";
    const error_message = aws.xml.findElement(body, "Message") orelse "";
    const request_id = aws.xml.findElement(body, "RequestId") orelse "";
    var arena = std.heap.ArenaAllocator.init(alloc);
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
