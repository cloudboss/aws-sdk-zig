const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const IpDiscovery = @import("ip_discovery.zig").IpDiscovery;
const NetworkType = @import("network_type.zig").NetworkType;
const Tag = @import("tag.zig").Tag;
const Cluster = @import("cluster.zig").Cluster;

pub const CreateClusterInput = struct {
    /// The name of the Access Control List to associate with the cluster.
    acl_name: []const u8,

    /// When set to true, the cluster will automatically receive minor engine
    /// version upgrades after launch.
    auto_minor_version_upgrade: ?bool = null,

    /// The name of the cluster. This value must be unique as it also serves as the
    /// cluster identifier.
    cluster_name: []const u8,

    /// Enables data tiering. Data tiering is only supported for clusters using the
    /// r6gd node type.
    /// This parameter must be set when using r6gd nodes. For more information, see
    /// [Data
    /// tiering](https://docs.aws.amazon.com/memorydb/latest/devguide/data-tiering.html).
    data_tiering: ?bool = null,

    /// An optional description of the cluster.
    description: ?[]const u8 = null,

    /// The name of the engine to be used for the cluster.
    engine: ?[]const u8 = null,

    /// The version number of the Redis OSS engine to be used for the cluster.
    engine_version: ?[]const u8 = null,

    /// The mechanism for discovering IP addresses for the cluster discovery
    /// protocol. Valid values are 'ipv4' or 'ipv6'. When set to 'ipv4', cluster
    /// discovery functions such as cluster slots, cluster shards, and cluster nodes
    /// return IPv4 addresses for cluster nodes. When set to 'ipv6', the cluster
    /// discovery functions return IPv6 addresses for cluster nodes. The value must
    /// be compatible with the NetworkType parameter. If not specified, the default
    /// is 'ipv4'.
    ip_discovery: ?IpDiscovery = null,

    /// The ID of the KMS key used to encrypt the cluster.
    kms_key_id: ?[]const u8 = null,

    /// Specifies the weekly time range during which maintenance
    /// on the cluster is performed. It is specified as a range in
    /// the format ddd:hh24:mi-ddd:hh24:mi (24H Clock UTC). The minimum
    /// maintenance window is a 60 minute period.
    ///
    /// Valid values for `ddd` are:
    ///
    /// * `sun`
    ///
    /// * `mon`
    ///
    /// * `tue`
    ///
    /// * `wed`
    ///
    /// * `thu`
    ///
    /// * `fri`
    ///
    /// * `sat`
    ///
    /// Example: `sun:23:00-mon:01:30`
    maintenance_window: ?[]const u8 = null,

    /// The name of the multi-Region cluster to be created.
    multi_region_cluster_name: ?[]const u8 = null,

    /// Specifies the IP address type for the cluster. Valid values are 'ipv4',
    /// 'ipv6', or 'dual_stack'. When set to 'ipv4', the cluster will only be
    /// accessible via IPv4 addresses. When set to 'ipv6', the cluster will only be
    /// accessible via IPv6 addresses. When set to 'dual_stack', the cluster will be
    /// accessible via both IPv4 and IPv6 addresses. If not specified, the default
    /// is 'ipv4'.
    network_type: ?NetworkType = null,

    /// The compute and memory capacity of the nodes in the cluster.
    node_type: []const u8,

    /// The number of replicas to apply to each shard. The default value is 1. The
    /// maximum is 5.
    num_replicas_per_shard: ?i32 = null,

    /// The number of shards the cluster will contain. The default value is 1.
    num_shards: ?i32 = null,

    /// The name of the parameter group associated with the cluster.
    parameter_group_name: ?[]const u8 = null,

    /// The port number on which each of the nodes accepts connections.
    port: ?i32 = null,

    /// A list of security group names to associate with this cluster.
    security_group_ids: ?[]const []const u8 = null,

    /// A list of Amazon Resource Names (ARN) that uniquely identify the RDB
    /// snapshot files stored in Amazon S3. The snapshot files are used to populate
    /// the new cluster. The Amazon S3 object name in the ARN cannot contain any
    /// commas.
    snapshot_arns: ?[]const []const u8 = null,

    /// The name of a snapshot from which to restore data into the new cluster. The
    /// snapshot status changes to restoring while the new cluster is being created.
    snapshot_name: ?[]const u8 = null,

    /// The number of days for which MemoryDB retains automatic snapshots before
    /// deleting them. For example, if you set SnapshotRetentionLimit to 5, a
    /// snapshot that was taken today is retained for 5 days before being deleted.
    snapshot_retention_limit: ?i32 = null,

    /// The daily time range (in UTC) during which MemoryDB begins taking a daily
    /// snapshot of your shard.
    ///
    /// Example: 05:00-09:00
    ///
    /// If you do not specify this parameter, MemoryDB automatically chooses an
    /// appropriate time range.
    snapshot_window: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the Amazon Simple Notification Service
    /// (SNS) topic to which notifications are sent.
    sns_topic_arn: ?[]const u8 = null,

    /// The name of the subnet group to be used for the cluster.
    subnet_group_name: ?[]const u8 = null,

    /// A list of tags to be added to this resource. Tags are comma-separated
    /// key,value pairs (e.g. Key=myKey, Value=myKeyValue. You can include multiple
    /// tags as shown following: Key=myKey, Value=myKeyValue Key=mySecondKey,
    /// Value=mySecondKeyValue.
    tags: ?[]const Tag = null,

    /// A flag to enable in-transit encryption on the cluster.
    tls_enabled: ?bool = null,

    pub const json_field_names = .{
        .acl_name = "ACLName",
        .auto_minor_version_upgrade = "AutoMinorVersionUpgrade",
        .cluster_name = "ClusterName",
        .data_tiering = "DataTiering",
        .description = "Description",
        .engine = "Engine",
        .engine_version = "EngineVersion",
        .ip_discovery = "IpDiscovery",
        .kms_key_id = "KmsKeyId",
        .maintenance_window = "MaintenanceWindow",
        .multi_region_cluster_name = "MultiRegionClusterName",
        .network_type = "NetworkType",
        .node_type = "NodeType",
        .num_replicas_per_shard = "NumReplicasPerShard",
        .num_shards = "NumShards",
        .parameter_group_name = "ParameterGroupName",
        .port = "Port",
        .security_group_ids = "SecurityGroupIds",
        .snapshot_arns = "SnapshotArns",
        .snapshot_name = "SnapshotName",
        .snapshot_retention_limit = "SnapshotRetentionLimit",
        .snapshot_window = "SnapshotWindow",
        .sns_topic_arn = "SnsTopicArn",
        .subnet_group_name = "SubnetGroupName",
        .tags = "Tags",
        .tls_enabled = "TLSEnabled",
    };
};

pub const CreateClusterOutput = struct {
    /// The newly-created cluster.
    cluster: ?Cluster = null,

    pub const json_field_names = .{
        .cluster = "Cluster",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateClusterInput, options: CallOptions) !CreateClusterOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "memorydb");

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateClusterInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("memorydb", "MemoryDB", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AmazonMemoryDB.CreateCluster");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateClusterOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateClusterOutput, body, allocator);
}

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "ACLAlreadyExistsFault")) {
        return .{ .arena = arena, .kind = .{ .acl_already_exists_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ACLNotFoundFault")) {
        return .{ .arena = arena, .kind = .{ .acl_not_found_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ACLQuotaExceededFault")) {
        return .{ .arena = arena, .kind = .{ .acl_quota_exceeded_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "APICallRateForCustomerExceededFault")) {
        return .{ .arena = arena, .kind = .{ .api_call_rate_for_customer_exceeded_fault = .{
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
    if (std.mem.eql(u8, error_code, "ClusterQuotaForCustomerExceededFault")) {
        return .{ .arena = arena, .kind = .{ .cluster_quota_for_customer_exceeded_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DefaultUserRequired")) {
        return .{ .arena = arena, .kind = .{ .default_user_required = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DuplicateUserNameFault")) {
        return .{ .arena = arena, .kind = .{ .duplicate_user_name_fault = .{
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
    if (std.mem.eql(u8, error_code, "InvalidACLStateFault")) {
        return .{ .arena = arena, .kind = .{ .invalid_acl_state_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidARNFault")) {
        return .{ .arena = arena, .kind = .{ .invalid_arn_fault = .{
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
    if (std.mem.eql(u8, error_code, "InvalidCredentialsException")) {
        return .{ .arena = arena, .kind = .{ .invalid_credentials_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidKMSKeyFault")) {
        return .{ .arena = arena, .kind = .{ .invalid_kms_key_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidMultiRegionClusterStateFault")) {
        return .{ .arena = arena, .kind = .{ .invalid_multi_region_cluster_state_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidNodeStateFault")) {
        return .{ .arena = arena, .kind = .{ .invalid_node_state_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidParameterCombinationException")) {
        return .{ .arena = arena, .kind = .{ .invalid_parameter_combination_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidParameterGroupStateFault")) {
        return .{ .arena = arena, .kind = .{ .invalid_parameter_group_state_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidParameterValueException")) {
        return .{ .arena = arena, .kind = .{ .invalid_parameter_value_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidSnapshotStateFault")) {
        return .{ .arena = arena, .kind = .{ .invalid_snapshot_state_fault = .{
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
    if (std.mem.eql(u8, error_code, "InvalidUserStateFault")) {
        return .{ .arena = arena, .kind = .{ .invalid_user_state_fault = .{
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
    if (std.mem.eql(u8, error_code, "MultiRegionClusterAlreadyExistsFault")) {
        return .{ .arena = arena, .kind = .{ .multi_region_cluster_already_exists_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "MultiRegionClusterNotFoundFault")) {
        return .{ .arena = arena, .kind = .{ .multi_region_cluster_not_found_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "MultiRegionParameterGroupNotFoundFault")) {
        return .{ .arena = arena, .kind = .{ .multi_region_parameter_group_not_found_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NoOperationFault")) {
        return .{ .arena = arena, .kind = .{ .no_operation_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NodeQuotaForClusterExceededFault")) {
        return .{ .arena = arena, .kind = .{ .node_quota_for_cluster_exceeded_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NodeQuotaForCustomerExceededFault")) {
        return .{ .arena = arena, .kind = .{ .node_quota_for_customer_exceeded_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ParameterGroupAlreadyExistsFault")) {
        return .{ .arena = arena, .kind = .{ .parameter_group_already_exists_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ParameterGroupNotFoundFault")) {
        return .{ .arena = arena, .kind = .{ .parameter_group_not_found_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ParameterGroupQuotaExceededFault")) {
        return .{ .arena = arena, .kind = .{ .parameter_group_quota_exceeded_fault = .{
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
    if (std.mem.eql(u8, error_code, "ReservedNodeNotFoundFault")) {
        return .{ .arena = arena, .kind = .{ .reserved_node_not_found_fault = .{
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
    if (std.mem.eql(u8, error_code, "ReservedNodesOfferingNotFoundFault")) {
        return .{ .arena = arena, .kind = .{ .reserved_nodes_offering_not_found_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServiceLinkedRoleNotFoundFault")) {
        return .{ .arena = arena, .kind = .{ .service_linked_role_not_found_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServiceUpdateNotFoundFault")) {
        return .{ .arena = arena, .kind = .{ .service_update_not_found_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ShardNotFoundFault")) {
        return .{ .arena = arena, .kind = .{ .shard_not_found_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ShardsPerClusterQuotaExceededFault")) {
        return .{ .arena = arena, .kind = .{ .shards_per_cluster_quota_exceeded_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "SnapshotAlreadyExistsFault")) {
        return .{ .arena = arena, .kind = .{ .snapshot_already_exists_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "SnapshotNotFoundFault")) {
        return .{ .arena = arena, .kind = .{ .snapshot_not_found_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "SnapshotQuotaExceededFault")) {
        return .{ .arena = arena, .kind = .{ .snapshot_quota_exceeded_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "SubnetGroupAlreadyExistsFault")) {
        return .{ .arena = arena, .kind = .{ .subnet_group_already_exists_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "SubnetGroupInUseFault")) {
        return .{ .arena = arena, .kind = .{ .subnet_group_in_use_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "SubnetGroupNotFoundFault")) {
        return .{ .arena = arena, .kind = .{ .subnet_group_not_found_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "SubnetGroupQuotaExceededFault")) {
        return .{ .arena = arena, .kind = .{ .subnet_group_quota_exceeded_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "SubnetInUse")) {
        return .{ .arena = arena, .kind = .{ .subnet_in_use = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "SubnetNotAllowedFault")) {
        return .{ .arena = arena, .kind = .{ .subnet_not_allowed_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "SubnetQuotaExceededFault")) {
        return .{ .arena = arena, .kind = .{ .subnet_quota_exceeded_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TagNotFoundFault")) {
        return .{ .arena = arena, .kind = .{ .tag_not_found_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TagQuotaPerResourceExceeded")) {
        return .{ .arena = arena, .kind = .{ .tag_quota_per_resource_exceeded = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TestFailoverNotAvailableFault")) {
        return .{ .arena = arena, .kind = .{ .test_failover_not_available_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UserAlreadyExistsFault")) {
        return .{ .arena = arena, .kind = .{ .user_already_exists_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UserNotFoundFault")) {
        return .{ .arena = arena, .kind = .{ .user_not_found_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UserQuotaExceededFault")) {
        return .{ .arena = arena, .kind = .{ .user_quota_exceeded_fault = .{
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
