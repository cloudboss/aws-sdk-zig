const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
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
    /// You can't disable automated snapshots for RA3 node types. Set the automated
    /// retention period from 1-35 days.
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
    /// `dc2.large` | `dc2.8xlarge` |
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
    /// * For clusters with ra3 nodes - Select a port within the ranges `5431-5455`
    ///   or `8191-8215`. (If you have an existing cluster
    /// with ra3 nodes, it isn't required that you change the port to these ranges.)
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

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ModifyClusterInput, options: Options) !ModifyClusterOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: ModifyClusterInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("redshift", "Redshift", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=ModifyCluster&Version=2012-12-01");
    if (input.allow_version_upgrade) |v| {
        try body_buf.appendSlice(alloc, "&AllowVersionUpgrade=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
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
    if (input.cluster_type) |v| {
        try body_buf.appendSlice(alloc, "&ClusterType=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.cluster_version) |v| {
        try body_buf.appendSlice(alloc, "&ClusterVersion=");
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
    if (input.ip_address_type) |v| {
        try body_buf.appendSlice(alloc, "&IpAddressType=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.kms_key_id) |v| {
        try body_buf.appendSlice(alloc, "&KmsKeyId=");
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
    if (input.master_user_password) |v| {
        try body_buf.appendSlice(alloc, "&MasterUserPassword=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.multi_az) |v| {
        try body_buf.appendSlice(alloc, "&MultiAZ=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    if (input.new_cluster_identifier) |v| {
        try body_buf.appendSlice(alloc, "&NewClusterIdentifier=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.node_type) |v| {
        try body_buf.appendSlice(alloc, "&NodeType=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
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

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !ModifyClusterOutput {
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
