const aws = @import("aws");
const std = @import("std");

const add_tags_to_resource = @import("add_tags_to_resource.zig");
const authorize_cache_security_group_ingress = @import("authorize_cache_security_group_ingress.zig");
const batch_apply_update_action = @import("batch_apply_update_action.zig");
const batch_stop_update_action = @import("batch_stop_update_action.zig");
const complete_migration = @import("complete_migration.zig");
const copy_serverless_cache_snapshot = @import("copy_serverless_cache_snapshot.zig");
const copy_snapshot = @import("copy_snapshot.zig");
const create_cache_cluster = @import("create_cache_cluster.zig");
const create_cache_parameter_group = @import("create_cache_parameter_group.zig");
const create_cache_security_group = @import("create_cache_security_group.zig");
const create_cache_subnet_group = @import("create_cache_subnet_group.zig");
const create_global_replication_group = @import("create_global_replication_group.zig");
const create_replication_group = @import("create_replication_group.zig");
const create_serverless_cache = @import("create_serverless_cache.zig");
const create_serverless_cache_snapshot = @import("create_serverless_cache_snapshot.zig");
const create_snapshot = @import("create_snapshot.zig");
const create_user = @import("create_user.zig");
const create_user_group = @import("create_user_group.zig");
const decrease_node_groups_in_global_replication_group = @import("decrease_node_groups_in_global_replication_group.zig");
const decrease_replica_count = @import("decrease_replica_count.zig");
const delete_cache_cluster = @import("delete_cache_cluster.zig");
const delete_cache_parameter_group = @import("delete_cache_parameter_group.zig");
const delete_cache_security_group = @import("delete_cache_security_group.zig");
const delete_cache_subnet_group = @import("delete_cache_subnet_group.zig");
const delete_global_replication_group = @import("delete_global_replication_group.zig");
const delete_replication_group = @import("delete_replication_group.zig");
const delete_serverless_cache = @import("delete_serverless_cache.zig");
const delete_serverless_cache_snapshot = @import("delete_serverless_cache_snapshot.zig");
const delete_snapshot = @import("delete_snapshot.zig");
const delete_user = @import("delete_user.zig");
const delete_user_group = @import("delete_user_group.zig");
const describe_cache_clusters = @import("describe_cache_clusters.zig");
const describe_cache_engine_versions = @import("describe_cache_engine_versions.zig");
const describe_cache_parameter_groups = @import("describe_cache_parameter_groups.zig");
const describe_cache_parameters = @import("describe_cache_parameters.zig");
const describe_cache_security_groups = @import("describe_cache_security_groups.zig");
const describe_cache_subnet_groups = @import("describe_cache_subnet_groups.zig");
const describe_engine_default_parameters = @import("describe_engine_default_parameters.zig");
const describe_events = @import("describe_events.zig");
const describe_global_replication_groups = @import("describe_global_replication_groups.zig");
const describe_replication_groups = @import("describe_replication_groups.zig");
const describe_reserved_cache_nodes = @import("describe_reserved_cache_nodes.zig");
const describe_reserved_cache_nodes_offerings = @import("describe_reserved_cache_nodes_offerings.zig");
const describe_serverless_cache_snapshots = @import("describe_serverless_cache_snapshots.zig");
const describe_serverless_caches = @import("describe_serverless_caches.zig");
const describe_service_updates = @import("describe_service_updates.zig");
const describe_snapshots = @import("describe_snapshots.zig");
const describe_update_actions = @import("describe_update_actions.zig");
const describe_user_groups = @import("describe_user_groups.zig");
const describe_users = @import("describe_users.zig");
const disassociate_global_replication_group = @import("disassociate_global_replication_group.zig");
const export_serverless_cache_snapshot = @import("export_serverless_cache_snapshot.zig");
const failover_global_replication_group = @import("failover_global_replication_group.zig");
const increase_node_groups_in_global_replication_group = @import("increase_node_groups_in_global_replication_group.zig");
const increase_replica_count = @import("increase_replica_count.zig");
const list_allowed_node_type_modifications = @import("list_allowed_node_type_modifications.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const modify_cache_cluster = @import("modify_cache_cluster.zig");
const modify_cache_parameter_group = @import("modify_cache_parameter_group.zig");
const modify_cache_subnet_group = @import("modify_cache_subnet_group.zig");
const modify_global_replication_group = @import("modify_global_replication_group.zig");
const modify_replication_group = @import("modify_replication_group.zig");
const modify_replication_group_shard_configuration = @import("modify_replication_group_shard_configuration.zig");
const modify_serverless_cache = @import("modify_serverless_cache.zig");
const modify_user = @import("modify_user.zig");
const modify_user_group = @import("modify_user_group.zig");
const purchase_reserved_cache_nodes_offering = @import("purchase_reserved_cache_nodes_offering.zig");
const rebalance_slots_in_global_replication_group = @import("rebalance_slots_in_global_replication_group.zig");
const reboot_cache_cluster = @import("reboot_cache_cluster.zig");
const remove_tags_from_resource = @import("remove_tags_from_resource.zig");
const reset_cache_parameter_group = @import("reset_cache_parameter_group.zig");
const revoke_cache_security_group_ingress = @import("revoke_cache_security_group_ingress.zig");
const start_migration = @import("start_migration.zig");
const test_failover = @import("test_failover.zig");
const test_migration = @import("test_migration.zig");
const CallOptions = @import("call_options.zig").CallOptions;
const paginator = @import("paginator.zig");
const waiters = @import("waiters.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "ElastiCache";

    pub fn init(allocator: std.mem.Allocator, config: *aws.Config) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.init(allocator, .{ .retry_mode = config.retry_mode }),
        };
    }

    pub fn initWithOptions(allocator: std.mem.Allocator, config: *aws.Config, options: aws.http.RequestOptions) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.init(allocator, .{ .retry_mode = config.retry_mode, .request_options = options }),
        };
    }

    pub fn deinit(self: *Self) void {
        self.http_client.deinit();
    }

    /// A tag is a key-value pair where the key and value are case-sensitive. You
    /// can use tags
    /// to categorize and track all your ElastiCache resources, with the exception
    /// of global
    /// replication group. When you add or remove tags on replication groups, those
    /// actions will
    /// be replicated to all nodes in the replication group. For more information,
    /// see [Resource-level
    /// permissions](http://docs.aws.amazon.com/AmazonElastiCache/latest/dg/IAM.ResourceLevelPermissions.html).
    ///
    /// For example, you can use cost-allocation tags to your ElastiCache resources,
    /// Amazon
    /// generates a cost allocation report as a comma-separated value (CSV) file
    /// with your usage
    /// and costs aggregated by your tags. You can apply tags that represent
    /// business categories
    /// (such as cost centers, application names, or owners) to organize your costs
    /// across
    /// multiple services.
    ///
    /// For more information, see [Using Cost Allocation Tags in
    /// Amazon
    /// ElastiCache](https://docs.aws.amazon.com/AmazonElastiCache/latest/dg/Tagging.html) in the *ElastiCache User
    /// Guide*.
    pub fn addTagsToResource(self: *Self, allocator: std.mem.Allocator, input: add_tags_to_resource.AddTagsToResourceInput, options: CallOptions) !add_tags_to_resource.AddTagsToResourceOutput {
        return add_tags_to_resource.execute(self, allocator, input, options);
    }

    /// Allows network ingress to a cache security group. Applications using
    /// ElastiCache must
    /// be running on Amazon EC2, and Amazon EC2 security groups are used as the
    /// authorization
    /// mechanism.
    ///
    /// You cannot authorize ingress from an Amazon EC2 security group in one region
    /// to an
    /// ElastiCache cluster in another region.
    pub fn authorizeCacheSecurityGroupIngress(self: *Self, allocator: std.mem.Allocator, input: authorize_cache_security_group_ingress.AuthorizeCacheSecurityGroupIngressInput, options: CallOptions) !authorize_cache_security_group_ingress.AuthorizeCacheSecurityGroupIngressOutput {
        return authorize_cache_security_group_ingress.execute(self, allocator, input, options);
    }

    /// Apply the service update. For more information on service updates and
    /// applying them,
    /// see [Applying Service
    /// Updates](https://docs.aws.amazon.com/AmazonElastiCache/latest/dg/applying-updates.html).
    pub fn batchApplyUpdateAction(self: *Self, allocator: std.mem.Allocator, input: batch_apply_update_action.BatchApplyUpdateActionInput, options: CallOptions) !batch_apply_update_action.BatchApplyUpdateActionOutput {
        return batch_apply_update_action.execute(self, allocator, input, options);
    }

    /// Stop the service update. For more information on service updates and
    /// stopping them,
    /// see [Stopping
    /// Service
    /// Updates](https://docs.aws.amazon.com/AmazonElastiCache/latest/dg/stopping-self-service-updates.html).
    pub fn batchStopUpdateAction(self: *Self, allocator: std.mem.Allocator, input: batch_stop_update_action.BatchStopUpdateActionInput, options: CallOptions) !batch_stop_update_action.BatchStopUpdateActionOutput {
        return batch_stop_update_action.execute(self, allocator, input, options);
    }

    /// Complete the migration of data.
    pub fn completeMigration(self: *Self, allocator: std.mem.Allocator, input: complete_migration.CompleteMigrationInput, options: CallOptions) !complete_migration.CompleteMigrationOutput {
        return complete_migration.execute(self, allocator, input, options);
    }

    /// Creates a copy of an existing serverless cache’s snapshot. Available for
    /// Valkey, Redis OSS and Serverless Memcached only.
    pub fn copyServerlessCacheSnapshot(self: *Self, allocator: std.mem.Allocator, input: copy_serverless_cache_snapshot.CopyServerlessCacheSnapshotInput, options: CallOptions) !copy_serverless_cache_snapshot.CopyServerlessCacheSnapshotOutput {
        return copy_serverless_cache_snapshot.execute(self, allocator, input, options);
    }

    /// Makes a copy of an existing snapshot.
    ///
    /// This operation is valid for Valkey or Redis OSS only.
    ///
    /// Users or groups that have permissions to use the `CopySnapshot`
    /// operation can create their own Amazon S3 buckets and copy snapshots to it.
    /// To
    /// control access to your snapshots, use an IAM policy to control who has the
    /// ability
    /// to use the `CopySnapshot` operation. For more information about using IAM
    /// to control the use of ElastiCache operations, see [Exporting
    /// Snapshots](https://docs.aws.amazon.com/AmazonElastiCache/latest/dg/backups-exporting.html) and [Authentication & Access
    /// Control](https://docs.aws.amazon.com/AmazonElastiCache/latest/dg/IAM.html).
    ///
    /// You could receive the following error messages.
    ///
    /// **Error Messages**
    ///
    /// * **Error Message:** The S3 bucket %s is outside of
    /// the region.
    ///
    /// **Solution:** Create an Amazon S3 bucket in the
    /// same region as your snapshot. For more information, see [Step 1: Create an
    /// Amazon S3
    /// Bucket](https://docs.aws.amazon.com/AmazonElastiCache/latest/dg/backups-exporting.html#backups-exporting-create-s3-bucket) in the ElastiCache User
    /// Guide.
    ///
    /// * **Error Message:** The S3 bucket %s does not
    /// exist.
    ///
    /// **Solution:** Create an Amazon S3 bucket in the
    /// same region as your snapshot. For more information, see [Step 1: Create an
    /// Amazon S3
    /// Bucket](https://docs.aws.amazon.com/AmazonElastiCache/latest/dg/backups-exporting.html#backups-exporting-create-s3-bucket) in the ElastiCache User
    /// Guide.
    ///
    /// * **Error Message:** The S3 bucket %s is not owned
    /// by the authenticated user.
    ///
    /// **Solution:** Create an Amazon S3 bucket in the
    /// same region as your snapshot. For more information, see [Step 1: Create an
    /// Amazon S3
    /// Bucket](https://docs.aws.amazon.com/AmazonElastiCache/latest/dg/backups-exporting.html#backups-exporting-create-s3-bucket) in the ElastiCache User
    /// Guide.
    ///
    /// * **Error Message:** The authenticated user does
    /// not have sufficient permissions to perform the desired activity.
    ///
    /// **Solution:** Contact your system administrator
    /// to get the needed permissions.
    ///
    /// * **Error Message:** The S3 bucket %s already
    /// contains an object with key %s.
    ///
    /// **Solution:** Give the
    /// `TargetSnapshotName` a new and unique value. If exporting a
    /// snapshot, you could alternatively create a new Amazon S3 bucket and use this
    /// same value for `TargetSnapshotName`.
    ///
    /// * **Error Message: ** ElastiCache has not been
    /// granted READ permissions %s on the S3 Bucket.
    ///
    /// **Solution:** Add List and Read permissions on
    /// the bucket. For more information, see [Step 2: Grant ElastiCache Access to
    /// Your Amazon S3
    /// Bucket](https://docs.aws.amazon.com/AmazonElastiCache/latest/dg/backups-exporting.html#backups-exporting-grant-access) in the
    /// ElastiCache User Guide.
    ///
    /// * **Error Message: ** ElastiCache has not been
    /// granted WRITE permissions %s on the S3 Bucket.
    ///
    /// **Solution:** Add Upload/Delete permissions on
    /// the bucket. For more information, see [Step 2: Grant ElastiCache Access to
    /// Your Amazon S3
    /// Bucket](https://docs.aws.amazon.com/AmazonElastiCache/latest/dg/backups-exporting.html#backups-exporting-grant-access) in the
    /// ElastiCache User Guide.
    ///
    /// * **Error Message: ** ElastiCache has not been
    /// granted READ_ACP permissions %s on the S3 Bucket.
    ///
    /// **Solution:** Add View Permissions on the bucket.
    /// For more information, see [Step 2: Grant ElastiCache Access to Your Amazon
    /// S3
    /// Bucket](https://docs.aws.amazon.com/AmazonElastiCache/latest/dg/backups-exporting.html#backups-exporting-grant-access) in the
    /// ElastiCache User Guide.
    pub fn copySnapshot(self: *Self, allocator: std.mem.Allocator, input: copy_snapshot.CopySnapshotInput, options: CallOptions) !copy_snapshot.CopySnapshotOutput {
        return copy_snapshot.execute(self, allocator, input, options);
    }

    /// Creates a cluster. All nodes in the cluster run the same protocol-compliant
    /// cache
    /// engine software, either Memcached, Valkey or Redis OSS.
    ///
    /// This operation is not supported for Valkey or Redis OSS (cluster mode
    /// enabled) clusters.
    pub fn createCacheCluster(self: *Self, allocator: std.mem.Allocator, input: create_cache_cluster.CreateCacheClusterInput, options: CallOptions) !create_cache_cluster.CreateCacheClusterOutput {
        return create_cache_cluster.execute(self, allocator, input, options);
    }

    /// Creates a new Amazon ElastiCache cache parameter group. An ElastiCache cache
    /// parameter
    /// group is a collection of parameters and their values that are applied to all
    /// of the
    /// nodes in any cluster or replication group using the CacheParameterGroup.
    ///
    /// A newly created CacheParameterGroup is an exact duplicate of the default
    /// parameter
    /// group for the CacheParameterGroupFamily. To customize the newly created
    /// CacheParameterGroup you can change the values of specific parameters. For
    /// more
    /// information, see:
    ///
    /// *
    ///   [ModifyCacheParameterGroup](https://docs.aws.amazon.com/AmazonElastiCache/latest/APIReference/API_ModifyCacheParameterGroup.html) in the ElastiCache API Reference.
    ///
    /// * [Parameters and
    /// Parameter
    /// Groups](https://docs.aws.amazon.com/AmazonElastiCache/latest/dg/ParameterGroups.html) in the ElastiCache User Guide.
    pub fn createCacheParameterGroup(self: *Self, allocator: std.mem.Allocator, input: create_cache_parameter_group.CreateCacheParameterGroupInput, options: CallOptions) !create_cache_parameter_group.CreateCacheParameterGroupOutput {
        return create_cache_parameter_group.execute(self, allocator, input, options);
    }

    /// Creates a new cache security group. Use a cache security group to control
    /// access to
    /// one or more clusters.
    ///
    /// Cache security groups are only used when you are creating a cluster outside
    /// of an
    /// Amazon Virtual Private Cloud (Amazon VPC). If you are creating a cluster
    /// inside of a
    /// VPC, use a cache subnet group instead. For more information, see
    /// [CreateCacheSubnetGroup](https://docs.aws.amazon.com/AmazonElastiCache/latest/APIReference/API_CreateCacheSubnetGroup.html).
    pub fn createCacheSecurityGroup(self: *Self, allocator: std.mem.Allocator, input: create_cache_security_group.CreateCacheSecurityGroupInput, options: CallOptions) !create_cache_security_group.CreateCacheSecurityGroupOutput {
        return create_cache_security_group.execute(self, allocator, input, options);
    }

    /// Creates a new cache subnet group.
    ///
    /// Use this parameter only when you are creating a cluster in an Amazon Virtual
    /// Private
    /// Cloud (Amazon VPC).
    pub fn createCacheSubnetGroup(self: *Self, allocator: std.mem.Allocator, input: create_cache_subnet_group.CreateCacheSubnetGroupInput, options: CallOptions) !create_cache_subnet_group.CreateCacheSubnetGroupOutput {
        return create_cache_subnet_group.execute(self, allocator, input, options);
    }

    /// Global Datastore offers fully managed, fast, reliable and secure
    /// cross-region replication. Using Global Datastore with Valkey or Redis OSS,
    /// you can create cross-region
    /// read replica clusters for ElastiCache to enable low-latency reads and
    /// disaster
    /// recovery across regions. For more information, see [Replication
    /// Across Regions Using Global
    /// Datastore](https://docs.aws.amazon.com/AmazonElastiCache/latest/dg/Redis-Global-Datastore.html).
    ///
    /// * The **GlobalReplicationGroupIdSuffix** is the
    /// name of the Global datastore.
    ///
    /// * The **PrimaryReplicationGroupId** represents the
    /// name of the primary cluster that accepts writes and will replicate updates
    /// to
    /// the secondary cluster.
    pub fn createGlobalReplicationGroup(self: *Self, allocator: std.mem.Allocator, input: create_global_replication_group.CreateGlobalReplicationGroupInput, options: CallOptions) !create_global_replication_group.CreateGlobalReplicationGroupOutput {
        return create_global_replication_group.execute(self, allocator, input, options);
    }

    /// Creates a Valkey or Redis OSS (cluster mode disabled) or a Valkey or Redis
    /// OSS (cluster mode enabled) replication
    /// group.
    ///
    /// This API can be used to create a standalone regional replication group or a
    /// secondary
    /// replication group associated with a Global datastore.
    ///
    /// A Valkey or Redis OSS (cluster mode disabled) replication group is a
    /// collection of nodes, where
    /// one of the nodes is a read/write primary and the others are read-only
    /// replicas.
    /// Writes to the primary are asynchronously propagated to the replicas.
    ///
    /// A Valkey or Redis OSS cluster-mode enabled cluster is comprised of from 1 to
    /// 90 shards (API/CLI:
    /// node groups). Each shard has a primary node and up to 5 read-only replica
    /// nodes. The
    /// configuration can range from 90 shards and 0 replicas to 15 shards and 5
    /// replicas, which
    /// is the maximum number or replicas allowed.
    ///
    /// The node or shard limit can be increased to a maximum of 500 per cluster if
    /// the Valkey or Redis OSS
    /// engine version is 5.0.6 or higher. For example, you can choose to configure
    /// a 500 node
    /// cluster that ranges between 83 shards (one primary and 5 replicas per shard)
    /// and 500
    /// shards (single primary and no replicas). Make sure there are enough
    /// available IP
    /// addresses to accommodate the increase. Common pitfalls include the subnets
    /// in the subnet
    /// group have too small a CIDR range or the subnets are shared and heavily used
    /// by other
    /// clusters. For more information, see [Creating a Subnet
    /// Group](https://docs.aws.amazon.com/AmazonElastiCache/latest/dg/SubnetGroups.Creating.html). For versions below 5.0.6, the limit is 250 per cluster.
    ///
    /// To request a limit increase, see [Amazon Service
    /// Limits](https://docs.aws.amazon.com/general/latest/gr/aws_service_limits.html) and
    /// choose the limit type **Nodes per cluster per instance
    /// type**.
    ///
    /// When a Valkey or Redis OSS (cluster mode disabled) replication group has
    /// been successfully created,
    /// you can add one or more read replicas to it, up to a total of 5 read
    /// replicas. If you
    /// need to increase or decrease the number of node groups (console: shards),
    /// you can use scaling.
    /// For more information, see [Scaling self-designed
    /// clusters](https://docs.aws.amazon.com/AmazonElastiCache/latest/dg/Scaling.html) in the *ElastiCache User
    /// Guide*.
    ///
    /// This operation is valid for Valkey and Redis OSS only.
    pub fn createReplicationGroup(self: *Self, allocator: std.mem.Allocator, input: create_replication_group.CreateReplicationGroupInput, options: CallOptions) !create_replication_group.CreateReplicationGroupOutput {
        return create_replication_group.execute(self, allocator, input, options);
    }

    /// Creates a serverless cache.
    pub fn createServerlessCache(self: *Self, allocator: std.mem.Allocator, input: create_serverless_cache.CreateServerlessCacheInput, options: CallOptions) !create_serverless_cache.CreateServerlessCacheOutput {
        return create_serverless_cache.execute(self, allocator, input, options);
    }

    /// This API creates a copy of an entire ServerlessCache at a specific moment in
    /// time. Available for Valkey, Redis OSS and Serverless Memcached only.
    pub fn createServerlessCacheSnapshot(self: *Self, allocator: std.mem.Allocator, input: create_serverless_cache_snapshot.CreateServerlessCacheSnapshotInput, options: CallOptions) !create_serverless_cache_snapshot.CreateServerlessCacheSnapshotOutput {
        return create_serverless_cache_snapshot.execute(self, allocator, input, options);
    }

    /// Creates a copy of an entire cluster or replication group at a specific
    /// moment in
    /// time.
    ///
    /// This operation is valid for Valkey or Redis OSS only.
    pub fn createSnapshot(self: *Self, allocator: std.mem.Allocator, input: create_snapshot.CreateSnapshotInput, options: CallOptions) !create_snapshot.CreateSnapshotOutput {
        return create_snapshot.execute(self, allocator, input, options);
    }

    /// For Valkey engine version 7.2 onwards and Redis OSS 6.0 to 7.1: Creates a
    /// user. For more information, see
    /// [Using Role Based Access Control
    /// (RBAC)](http://docs.aws.amazon.com/AmazonElastiCache/latest/dg/Clusters.RBAC.html).
    pub fn createUser(self: *Self, allocator: std.mem.Allocator, input: create_user.CreateUserInput, options: CallOptions) !create_user.CreateUserOutput {
        return create_user.execute(self, allocator, input, options);
    }

    /// For Valkey engine version 7.2 onwards and Redis OSS 6.0 to 7.1: Creates a
    /// user group. For more
    /// information, see [Using Role Based Access Control
    /// (RBAC)](http://docs.aws.amazon.com/AmazonElastiCache/latest/dg/Clusters.RBAC.html)
    pub fn createUserGroup(self: *Self, allocator: std.mem.Allocator, input: create_user_group.CreateUserGroupInput, options: CallOptions) !create_user_group.CreateUserGroupOutput {
        return create_user_group.execute(self, allocator, input, options);
    }

    /// Decreases the number of node groups in a Global datastore
    pub fn decreaseNodeGroupsInGlobalReplicationGroup(self: *Self, allocator: std.mem.Allocator, input: decrease_node_groups_in_global_replication_group.DecreaseNodeGroupsInGlobalReplicationGroupInput, options: CallOptions) !decrease_node_groups_in_global_replication_group.DecreaseNodeGroupsInGlobalReplicationGroupOutput {
        return decrease_node_groups_in_global_replication_group.execute(self, allocator, input, options);
    }

    /// Dynamically decreases the number of replicas in a Valkey or Redis OSS
    /// (cluster mode disabled)
    /// replication group or the number of replica nodes in one or more node groups
    /// (shards) of
    /// a Valkey or Redis OSS (cluster mode enabled) replication group. This
    /// operation is performed with no
    /// cluster down time.
    pub fn decreaseReplicaCount(self: *Self, allocator: std.mem.Allocator, input: decrease_replica_count.DecreaseReplicaCountInput, options: CallOptions) !decrease_replica_count.DecreaseReplicaCountOutput {
        return decrease_replica_count.execute(self, allocator, input, options);
    }

    /// Deletes a previously provisioned cluster. `DeleteCacheCluster` deletes all
    /// associated cache nodes, node endpoints and the cluster itself. When you
    /// receive a
    /// successful response from this operation, Amazon ElastiCache immediately
    /// begins deleting
    /// the cluster; you cannot cancel or revert this operation.
    ///
    /// This operation is not valid for:
    ///
    /// * Valkey or Redis OSS (cluster mode enabled) clusters
    ///
    /// * Valkey or Redis OSS (cluster mode disabled) clusters
    ///
    /// * A cluster that is the last read replica of a replication group
    ///
    /// * A cluster that is the primary node of a replication group
    ///
    /// * A node group (shard) that has Multi-AZ mode enabled
    ///
    /// * A cluster from a Valkey or Redis OSS (cluster mode enabled) replication
    ///   group
    ///
    /// * A cluster that is not in the `available` state
    pub fn deleteCacheCluster(self: *Self, allocator: std.mem.Allocator, input: delete_cache_cluster.DeleteCacheClusterInput, options: CallOptions) !delete_cache_cluster.DeleteCacheClusterOutput {
        return delete_cache_cluster.execute(self, allocator, input, options);
    }

    /// Deletes the specified cache parameter group. You cannot delete a cache
    /// parameter group
    /// if it is associated with any cache clusters. You cannot delete the default
    /// cache
    /// parameter groups in your account.
    pub fn deleteCacheParameterGroup(self: *Self, allocator: std.mem.Allocator, input: delete_cache_parameter_group.DeleteCacheParameterGroupInput, options: CallOptions) !delete_cache_parameter_group.DeleteCacheParameterGroupOutput {
        return delete_cache_parameter_group.execute(self, allocator, input, options);
    }

    /// Deletes a cache security group.
    ///
    /// You cannot delete a cache security group if it is associated with any
    /// clusters.
    pub fn deleteCacheSecurityGroup(self: *Self, allocator: std.mem.Allocator, input: delete_cache_security_group.DeleteCacheSecurityGroupInput, options: CallOptions) !delete_cache_security_group.DeleteCacheSecurityGroupOutput {
        return delete_cache_security_group.execute(self, allocator, input, options);
    }

    /// Deletes a cache subnet group.
    ///
    /// You cannot delete a default cache subnet group or one that is associated
    /// with any
    /// clusters.
    pub fn deleteCacheSubnetGroup(self: *Self, allocator: std.mem.Allocator, input: delete_cache_subnet_group.DeleteCacheSubnetGroupInput, options: CallOptions) !delete_cache_subnet_group.DeleteCacheSubnetGroupOutput {
        return delete_cache_subnet_group.execute(self, allocator, input, options);
    }

    /// Deleting a Global datastore is a two-step process:
    ///
    /// * First, you must DisassociateGlobalReplicationGroup to remove
    /// the secondary clusters in the Global datastore.
    ///
    /// * Once the Global datastore contains only the primary cluster, you can use
    ///   the
    /// `DeleteGlobalReplicationGroup` API to delete the Global datastore
    /// while retainining the primary cluster using
    /// `RetainPrimaryReplicationGroup=true`.
    ///
    /// Since the Global Datastore has only a primary cluster, you can delete the
    /// Global
    /// Datastore while retaining the primary by setting
    /// `RetainPrimaryReplicationGroup=true`. The primary cluster is never
    /// deleted when deleting a Global Datastore. It can only be deleted when it no
    /// longer is
    /// associated with any Global Datastore.
    ///
    /// When you receive a successful response from this operation, Amazon
    /// ElastiCache
    /// immediately begins deleting the selected resources; you cannot cancel or
    /// revert this
    /// operation.
    pub fn deleteGlobalReplicationGroup(self: *Self, allocator: std.mem.Allocator, input: delete_global_replication_group.DeleteGlobalReplicationGroupInput, options: CallOptions) !delete_global_replication_group.DeleteGlobalReplicationGroupOutput {
        return delete_global_replication_group.execute(self, allocator, input, options);
    }

    /// Deletes an existing replication group. By default, this operation deletes
    /// the entire
    /// replication group, including the primary/primaries and all of the read
    /// replicas. If the
    /// replication group has only one primary, you can optionally delete only the
    /// read
    /// replicas, while retaining the primary by setting
    /// `RetainPrimaryCluster=true`.
    ///
    /// When you receive a successful response from this operation, Amazon
    /// ElastiCache
    /// immediately begins deleting the selected resources; you cannot cancel or
    /// revert this
    /// operation.
    ///
    /// * `CreateSnapshot` permission is required to create a final snapshot.
    /// Without this permission, the API call will fail with an `Access Denied`
    /// exception.
    ///
    /// * This operation is valid for Redis OSS only.
    pub fn deleteReplicationGroup(self: *Self, allocator: std.mem.Allocator, input: delete_replication_group.DeleteReplicationGroupInput, options: CallOptions) !delete_replication_group.DeleteReplicationGroupOutput {
        return delete_replication_group.execute(self, allocator, input, options);
    }

    /// Deletes a specified existing serverless cache.
    ///
    /// `CreateServerlessCacheSnapshot` permission is required to create a final
    /// snapshot.
    /// Without this permission, the API call will fail with an `Access Denied`
    /// exception.
    pub fn deleteServerlessCache(self: *Self, allocator: std.mem.Allocator, input: delete_serverless_cache.DeleteServerlessCacheInput, options: CallOptions) !delete_serverless_cache.DeleteServerlessCacheOutput {
        return delete_serverless_cache.execute(self, allocator, input, options);
    }

    /// Deletes an existing serverless cache snapshot. Available for Valkey, Redis
    /// OSS and Serverless Memcached only.
    pub fn deleteServerlessCacheSnapshot(self: *Self, allocator: std.mem.Allocator, input: delete_serverless_cache_snapshot.DeleteServerlessCacheSnapshotInput, options: CallOptions) !delete_serverless_cache_snapshot.DeleteServerlessCacheSnapshotOutput {
        return delete_serverless_cache_snapshot.execute(self, allocator, input, options);
    }

    /// Deletes an existing snapshot. When you receive a successful response from
    /// this
    /// operation, ElastiCache immediately begins deleting the snapshot; you cannot
    /// cancel or
    /// revert this operation.
    ///
    /// This operation is valid for Valkey or Redis OSS only.
    pub fn deleteSnapshot(self: *Self, allocator: std.mem.Allocator, input: delete_snapshot.DeleteSnapshotInput, options: CallOptions) !delete_snapshot.DeleteSnapshotOutput {
        return delete_snapshot.execute(self, allocator, input, options);
    }

    /// For Valkey engine version 7.2 onwards and Redis OSS 6.0 onwards: Deletes a
    /// user. The user will be removed from
    /// all user groups and in turn removed from all replication groups. For more
    /// information,
    /// see [Using Role Based Access Control
    /// (RBAC)](http://docs.aws.amazon.com/AmazonElastiCache/latest/dg/Clusters.RBAC.html).
    pub fn deleteUser(self: *Self, allocator: std.mem.Allocator, input: delete_user.DeleteUserInput, options: CallOptions) !delete_user.DeleteUserOutput {
        return delete_user.execute(self, allocator, input, options);
    }

    /// For Valkey engine version 7.2 onwards and Redis OSS 6.0 onwards: Deletes a
    /// user group. The user group must first
    /// be disassociated from the replication group before it can be deleted. For
    /// more
    /// information, see [Using Role Based Access Control
    /// (RBAC)](http://docs.aws.amazon.com/AmazonElastiCache/latest/dg/Clusters.RBAC.html).
    pub fn deleteUserGroup(self: *Self, allocator: std.mem.Allocator, input: delete_user_group.DeleteUserGroupInput, options: CallOptions) !delete_user_group.DeleteUserGroupOutput {
        return delete_user_group.execute(self, allocator, input, options);
    }

    /// Returns information about all provisioned clusters if no cluster identifier
    /// is
    /// specified, or about a specific cache cluster if a cluster identifier is
    /// supplied.
    ///
    /// By default, abbreviated information about the clusters is returned. You can
    /// use the
    /// optional *ShowCacheNodeInfo* flag to retrieve detailed information
    /// about the cache nodes associated with the clusters. These details include
    /// the DNS
    /// address and port for the cache node endpoint.
    ///
    /// If the cluster is in the *creating* state, only cluster-level
    /// information is displayed until all of the nodes are successfully
    /// provisioned.
    ///
    /// If the cluster is in the *deleting* state, only cluster-level
    /// information is displayed.
    ///
    /// If cache nodes are currently being added to the cluster, node endpoint
    /// information and
    /// creation time for the additional nodes are not displayed until they are
    /// completely
    /// provisioned. When the cluster state is *available*, the cluster is
    /// ready for use.
    ///
    /// If cache nodes are currently being removed from the cluster, no endpoint
    /// information
    /// for the removed nodes is displayed.
    pub fn describeCacheClusters(self: *Self, allocator: std.mem.Allocator, input: describe_cache_clusters.DescribeCacheClustersInput, options: CallOptions) !describe_cache_clusters.DescribeCacheClustersOutput {
        return describe_cache_clusters.execute(self, allocator, input, options);
    }

    /// Returns a list of the available cache engines and their versions.
    pub fn describeCacheEngineVersions(self: *Self, allocator: std.mem.Allocator, input: describe_cache_engine_versions.DescribeCacheEngineVersionsInput, options: CallOptions) !describe_cache_engine_versions.DescribeCacheEngineVersionsOutput {
        return describe_cache_engine_versions.execute(self, allocator, input, options);
    }

    /// Returns a list of cache parameter group descriptions. If a cache parameter
    /// group name
    /// is specified, the list contains only the descriptions for that group.
    pub fn describeCacheParameterGroups(self: *Self, allocator: std.mem.Allocator, input: describe_cache_parameter_groups.DescribeCacheParameterGroupsInput, options: CallOptions) !describe_cache_parameter_groups.DescribeCacheParameterGroupsOutput {
        return describe_cache_parameter_groups.execute(self, allocator, input, options);
    }

    /// Returns the detailed parameter list for a particular cache parameter group.
    pub fn describeCacheParameters(self: *Self, allocator: std.mem.Allocator, input: describe_cache_parameters.DescribeCacheParametersInput, options: CallOptions) !describe_cache_parameters.DescribeCacheParametersOutput {
        return describe_cache_parameters.execute(self, allocator, input, options);
    }

    /// Returns a list of cache security group descriptions. If a cache security
    /// group name is
    /// specified, the list contains only the description of that group. This
    /// applicable only
    /// when you have ElastiCache in Classic setup
    pub fn describeCacheSecurityGroups(self: *Self, allocator: std.mem.Allocator, input: describe_cache_security_groups.DescribeCacheSecurityGroupsInput, options: CallOptions) !describe_cache_security_groups.DescribeCacheSecurityGroupsOutput {
        return describe_cache_security_groups.execute(self, allocator, input, options);
    }

    /// Returns a list of cache subnet group descriptions. If a subnet group name is
    /// specified, the list contains only the description of that group. This is
    /// applicable only
    /// when you have ElastiCache in VPC setup. All ElastiCache clusters now launch
    /// in VPC by
    /// default.
    pub fn describeCacheSubnetGroups(self: *Self, allocator: std.mem.Allocator, input: describe_cache_subnet_groups.DescribeCacheSubnetGroupsInput, options: CallOptions) !describe_cache_subnet_groups.DescribeCacheSubnetGroupsOutput {
        return describe_cache_subnet_groups.execute(self, allocator, input, options);
    }

    /// Returns the default engine and system parameter information for the
    /// specified cache
    /// engine.
    pub fn describeEngineDefaultParameters(self: *Self, allocator: std.mem.Allocator, input: describe_engine_default_parameters.DescribeEngineDefaultParametersInput, options: CallOptions) !describe_engine_default_parameters.DescribeEngineDefaultParametersOutput {
        return describe_engine_default_parameters.execute(self, allocator, input, options);
    }

    /// Returns events related to clusters, cache security groups, and cache
    /// parameter groups.
    /// You can obtain events specific to a particular cluster, cache security
    /// group, or cache
    /// parameter group by providing the name as a parameter.
    ///
    /// By default, only the events occurring within the last hour are returned;
    /// however, you
    /// can retrieve up to 14 days' worth of events if necessary.
    pub fn describeEvents(self: *Self, allocator: std.mem.Allocator, input: describe_events.DescribeEventsInput, options: CallOptions) !describe_events.DescribeEventsOutput {
        return describe_events.execute(self, allocator, input, options);
    }

    /// Returns information about a particular global replication group. If no
    /// identifier is
    /// specified, returns information about all Global datastores.
    pub fn describeGlobalReplicationGroups(self: *Self, allocator: std.mem.Allocator, input: describe_global_replication_groups.DescribeGlobalReplicationGroupsInput, options: CallOptions) !describe_global_replication_groups.DescribeGlobalReplicationGroupsOutput {
        return describe_global_replication_groups.execute(self, allocator, input, options);
    }

    /// Returns information about a particular replication group. If no identifier
    /// is
    /// specified, `DescribeReplicationGroups` returns information about all
    /// replication groups.
    ///
    /// This operation is valid for Valkey or Redis OSS only.
    pub fn describeReplicationGroups(self: *Self, allocator: std.mem.Allocator, input: describe_replication_groups.DescribeReplicationGroupsInput, options: CallOptions) !describe_replication_groups.DescribeReplicationGroupsOutput {
        return describe_replication_groups.execute(self, allocator, input, options);
    }

    /// Returns information about reserved cache nodes for this account, or about a
    /// specified
    /// reserved cache node.
    pub fn describeReservedCacheNodes(self: *Self, allocator: std.mem.Allocator, input: describe_reserved_cache_nodes.DescribeReservedCacheNodesInput, options: CallOptions) !describe_reserved_cache_nodes.DescribeReservedCacheNodesOutput {
        return describe_reserved_cache_nodes.execute(self, allocator, input, options);
    }

    /// Lists available reserved cache node offerings.
    pub fn describeReservedCacheNodesOfferings(self: *Self, allocator: std.mem.Allocator, input: describe_reserved_cache_nodes_offerings.DescribeReservedCacheNodesOfferingsInput, options: CallOptions) !describe_reserved_cache_nodes_offerings.DescribeReservedCacheNodesOfferingsOutput {
        return describe_reserved_cache_nodes_offerings.execute(self, allocator, input, options);
    }

    /// Returns information about serverless cache snapshots.
    /// By default, this API lists all of the customer’s serverless cache snapshots.
    /// It can also describe a single serverless cache snapshot, or the snapshots
    /// associated with
    /// a particular serverless cache. Available for Valkey, Redis OSS and
    /// Serverless Memcached only.
    pub fn describeServerlessCacheSnapshots(self: *Self, allocator: std.mem.Allocator, input: describe_serverless_cache_snapshots.DescribeServerlessCacheSnapshotsInput, options: CallOptions) !describe_serverless_cache_snapshots.DescribeServerlessCacheSnapshotsOutput {
        return describe_serverless_cache_snapshots.execute(self, allocator, input, options);
    }

    /// Returns information about a specific serverless cache.
    /// If no identifier is specified, then the API returns information on all the
    /// serverless caches belonging to
    /// this Amazon Web Services account.
    pub fn describeServerlessCaches(self: *Self, allocator: std.mem.Allocator, input: describe_serverless_caches.DescribeServerlessCachesInput, options: CallOptions) !describe_serverless_caches.DescribeServerlessCachesOutput {
        return describe_serverless_caches.execute(self, allocator, input, options);
    }

    /// Returns details of the service updates
    pub fn describeServiceUpdates(self: *Self, allocator: std.mem.Allocator, input: describe_service_updates.DescribeServiceUpdatesInput, options: CallOptions) !describe_service_updates.DescribeServiceUpdatesOutput {
        return describe_service_updates.execute(self, allocator, input, options);
    }

    /// Returns information about cluster or replication group snapshots. By
    /// default,
    /// `DescribeSnapshots` lists all of your snapshots; it can optionally
    /// describe a single snapshot, or just the snapshots associated with a
    /// particular cache
    /// cluster.
    ///
    /// This operation is valid for Valkey or Redis OSS only.
    pub fn describeSnapshots(self: *Self, allocator: std.mem.Allocator, input: describe_snapshots.DescribeSnapshotsInput, options: CallOptions) !describe_snapshots.DescribeSnapshotsOutput {
        return describe_snapshots.execute(self, allocator, input, options);
    }

    /// Returns details of the update actions
    pub fn describeUpdateActions(self: *Self, allocator: std.mem.Allocator, input: describe_update_actions.DescribeUpdateActionsInput, options: CallOptions) !describe_update_actions.DescribeUpdateActionsOutput {
        return describe_update_actions.execute(self, allocator, input, options);
    }

    /// Returns a list of user groups.
    pub fn describeUserGroups(self: *Self, allocator: std.mem.Allocator, input: describe_user_groups.DescribeUserGroupsInput, options: CallOptions) !describe_user_groups.DescribeUserGroupsOutput {
        return describe_user_groups.execute(self, allocator, input, options);
    }

    /// Returns a list of users.
    pub fn describeUsers(self: *Self, allocator: std.mem.Allocator, input: describe_users.DescribeUsersInput, options: CallOptions) !describe_users.DescribeUsersOutput {
        return describe_users.execute(self, allocator, input, options);
    }

    /// Remove a secondary cluster from the Global datastore using the Global
    /// datastore name.
    /// The secondary cluster will no longer receive updates from the primary
    /// cluster, but will
    /// remain as a standalone cluster in that Amazon region.
    pub fn disassociateGlobalReplicationGroup(self: *Self, allocator: std.mem.Allocator, input: disassociate_global_replication_group.DisassociateGlobalReplicationGroupInput, options: CallOptions) !disassociate_global_replication_group.DisassociateGlobalReplicationGroupOutput {
        return disassociate_global_replication_group.execute(self, allocator, input, options);
    }

    /// Provides the functionality to export the serverless cache snapshot data to
    /// Amazon S3. Available for Valkey and Redis OSS only.
    pub fn exportServerlessCacheSnapshot(self: *Self, allocator: std.mem.Allocator, input: export_serverless_cache_snapshot.ExportServerlessCacheSnapshotInput, options: CallOptions) !export_serverless_cache_snapshot.ExportServerlessCacheSnapshotOutput {
        return export_serverless_cache_snapshot.execute(self, allocator, input, options);
    }

    /// Used to failover the primary region to a secondary region. The secondary
    /// region will
    /// become primary, and all other clusters will become secondary.
    pub fn failoverGlobalReplicationGroup(self: *Self, allocator: std.mem.Allocator, input: failover_global_replication_group.FailoverGlobalReplicationGroupInput, options: CallOptions) !failover_global_replication_group.FailoverGlobalReplicationGroupOutput {
        return failover_global_replication_group.execute(self, allocator, input, options);
    }

    /// Increase the number of node groups in the Global datastore
    pub fn increaseNodeGroupsInGlobalReplicationGroup(self: *Self, allocator: std.mem.Allocator, input: increase_node_groups_in_global_replication_group.IncreaseNodeGroupsInGlobalReplicationGroupInput, options: CallOptions) !increase_node_groups_in_global_replication_group.IncreaseNodeGroupsInGlobalReplicationGroupOutput {
        return increase_node_groups_in_global_replication_group.execute(self, allocator, input, options);
    }

    /// Dynamically increases the number of replicas in a Valkey or Redis OSS
    /// (cluster mode disabled)
    /// replication group or the number of replica nodes in one or more node groups
    /// (shards) of
    /// a Valkey or Redis OSS (cluster mode enabled) replication group. This
    /// operation is performed with no
    /// cluster down time.
    pub fn increaseReplicaCount(self: *Self, allocator: std.mem.Allocator, input: increase_replica_count.IncreaseReplicaCountInput, options: CallOptions) !increase_replica_count.IncreaseReplicaCountOutput {
        return increase_replica_count.execute(self, allocator, input, options);
    }

    /// Lists all available node types that you can scale with your cluster's
    /// replication
    /// group's current node type.
    ///
    /// When you use the `ModifyCacheCluster` or
    /// `ModifyReplicationGroup` operations to scale your cluster or replication
    /// group, the value of the `CacheNodeType` parameter must be one of the node
    /// types returned by this operation.
    pub fn listAllowedNodeTypeModifications(self: *Self, allocator: std.mem.Allocator, input: list_allowed_node_type_modifications.ListAllowedNodeTypeModificationsInput, options: CallOptions) !list_allowed_node_type_modifications.ListAllowedNodeTypeModificationsOutput {
        return list_allowed_node_type_modifications.execute(self, allocator, input, options);
    }

    /// Lists all tags currently on a named resource.
    ///
    /// A tag is a key-value pair where the key and value are case-sensitive. You
    /// can use
    /// tags to categorize and track all your ElastiCache resources, with the
    /// exception of
    /// global replication group. When you add or remove tags on replication groups,
    /// those
    /// actions will be replicated to all nodes in the replication group. For more
    /// information,
    /// see [Resource-level
    /// permissions](http://docs.aws.amazon.com/AmazonElastiCache/latest/dg/IAM.ResourceLevelPermissions.html).
    ///
    /// If the cluster is not in the *available* state,
    /// `ListTagsForResource` returns an error.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: CallOptions) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Modifies the settings for a cluster. You can use this operation to change
    /// one or more
    /// cluster configuration parameters by specifying the parameters and the new
    /// values.
    pub fn modifyCacheCluster(self: *Self, allocator: std.mem.Allocator, input: modify_cache_cluster.ModifyCacheClusterInput, options: CallOptions) !modify_cache_cluster.ModifyCacheClusterOutput {
        return modify_cache_cluster.execute(self, allocator, input, options);
    }

    /// Modifies the parameters of a cache parameter group. You can modify up to 20
    /// parameters
    /// in a single request by submitting a list parameter name and value pairs.
    pub fn modifyCacheParameterGroup(self: *Self, allocator: std.mem.Allocator, input: modify_cache_parameter_group.ModifyCacheParameterGroupInput, options: CallOptions) !modify_cache_parameter_group.ModifyCacheParameterGroupOutput {
        return modify_cache_parameter_group.execute(self, allocator, input, options);
    }

    /// Modifies an existing cache subnet group.
    pub fn modifyCacheSubnetGroup(self: *Self, allocator: std.mem.Allocator, input: modify_cache_subnet_group.ModifyCacheSubnetGroupInput, options: CallOptions) !modify_cache_subnet_group.ModifyCacheSubnetGroupOutput {
        return modify_cache_subnet_group.execute(self, allocator, input, options);
    }

    /// Modifies the settings for a Global datastore.
    pub fn modifyGlobalReplicationGroup(self: *Self, allocator: std.mem.Allocator, input: modify_global_replication_group.ModifyGlobalReplicationGroupInput, options: CallOptions) !modify_global_replication_group.ModifyGlobalReplicationGroupOutput {
        return modify_global_replication_group.execute(self, allocator, input, options);
    }

    /// Modifies the settings for a replication group. This is limited to Valkey and
    /// Redis OSS 7 and above.
    ///
    /// * [Scaling for Valkey or Redis OSS (cluster mode
    ///   enabled)](https://docs.aws.amazon.com/AmazonElastiCache/latest/dg/scaling-redis-cluster-mode-enabled.html) in
    /// the ElastiCache User Guide
    ///
    /// *
    ///   [ModifyReplicationGroupShardConfiguration](https://docs.aws.amazon.com/AmazonElastiCache/latest/APIReference/API_ModifyReplicationGroupShardConfiguration.html) in the ElastiCache API
    /// Reference
    ///
    /// This operation is valid for Valkey or Redis OSS only.
    pub fn modifyReplicationGroup(self: *Self, allocator: std.mem.Allocator, input: modify_replication_group.ModifyReplicationGroupInput, options: CallOptions) !modify_replication_group.ModifyReplicationGroupOutput {
        return modify_replication_group.execute(self, allocator, input, options);
    }

    /// Modifies a replication group's shards (node groups) by allowing you to add
    /// shards,
    /// remove shards, or rebalance the keyspaces among existing shards.
    pub fn modifyReplicationGroupShardConfiguration(self: *Self, allocator: std.mem.Allocator, input: modify_replication_group_shard_configuration.ModifyReplicationGroupShardConfigurationInput, options: CallOptions) !modify_replication_group_shard_configuration.ModifyReplicationGroupShardConfigurationOutput {
        return modify_replication_group_shard_configuration.execute(self, allocator, input, options);
    }

    /// This API modifies the attributes of a serverless cache.
    pub fn modifyServerlessCache(self: *Self, allocator: std.mem.Allocator, input: modify_serverless_cache.ModifyServerlessCacheInput, options: CallOptions) !modify_serverless_cache.ModifyServerlessCacheOutput {
        return modify_serverless_cache.execute(self, allocator, input, options);
    }

    /// Changes user password(s) and/or access string.
    pub fn modifyUser(self: *Self, allocator: std.mem.Allocator, input: modify_user.ModifyUserInput, options: CallOptions) !modify_user.ModifyUserOutput {
        return modify_user.execute(self, allocator, input, options);
    }

    /// Changes the list of users that belong to the user group.
    pub fn modifyUserGroup(self: *Self, allocator: std.mem.Allocator, input: modify_user_group.ModifyUserGroupInput, options: CallOptions) !modify_user_group.ModifyUserGroupOutput {
        return modify_user_group.execute(self, allocator, input, options);
    }

    /// Allows you to purchase a reserved cache node offering. Reserved nodes are
    /// not eligible
    /// for cancellation and are non-refundable. For more information, see [Managing
    /// Costs with Reserved
    /// Nodes](https://docs.aws.amazon.com/AmazonElastiCache/latest/dg/reserved-nodes.html).
    pub fn purchaseReservedCacheNodesOffering(self: *Self, allocator: std.mem.Allocator, input: purchase_reserved_cache_nodes_offering.PurchaseReservedCacheNodesOfferingInput, options: CallOptions) !purchase_reserved_cache_nodes_offering.PurchaseReservedCacheNodesOfferingOutput {
        return purchase_reserved_cache_nodes_offering.execute(self, allocator, input, options);
    }

    /// Redistribute slots to ensure uniform distribution across existing shards in
    /// the
    /// cluster.
    pub fn rebalanceSlotsInGlobalReplicationGroup(self: *Self, allocator: std.mem.Allocator, input: rebalance_slots_in_global_replication_group.RebalanceSlotsInGlobalReplicationGroupInput, options: CallOptions) !rebalance_slots_in_global_replication_group.RebalanceSlotsInGlobalReplicationGroupOutput {
        return rebalance_slots_in_global_replication_group.execute(self, allocator, input, options);
    }

    /// Reboots some, or all, of the cache nodes within a provisioned cluster. This
    /// operation
    /// applies any modified cache parameter groups to the cluster. The reboot
    /// operation takes
    /// place as soon as possible, and results in a momentary outage to the cluster.
    /// During the
    /// reboot, the cluster status is set to REBOOTING.
    ///
    /// The reboot causes the contents of the cache (for each cache node being
    /// rebooted) to be
    /// lost.
    ///
    /// When the reboot is complete, a cluster event is created.
    ///
    /// Rebooting a cluster is currently supported on Memcached, Valkey and Redis
    /// OSS (cluster mode
    /// disabled) clusters. Rebooting is not supported on Valkey or Redis OSS
    /// (cluster mode enabled)
    /// clusters.
    ///
    /// If you make changes to parameters that require a Valkey or Redis OSS
    /// (cluster mode enabled) cluster
    /// reboot for the changes to be applied, see [Rebooting a
    /// Cluster](http://docs.aws.amazon.com/AmazonElastiCache/latest/dg/nodes.rebooting.html) for an alternate process.
    pub fn rebootCacheCluster(self: *Self, allocator: std.mem.Allocator, input: reboot_cache_cluster.RebootCacheClusterInput, options: CallOptions) !reboot_cache_cluster.RebootCacheClusterOutput {
        return reboot_cache_cluster.execute(self, allocator, input, options);
    }

    /// Removes the tags identified by the `TagKeys` list from the named resource.
    /// A tag is a key-value pair where the key and value are case-sensitive. You
    /// can use tags
    /// to categorize and track all your ElastiCache resources, with the exception
    /// of global
    /// replication group. When you add or remove tags on replication groups, those
    /// actions will
    /// be replicated to all nodes in the replication group. For more information,
    /// see [Resource-level
    /// permissions](http://docs.aws.amazon.com/AmazonElastiCache/latest/dg/IAM.ResourceLevelPermissions.html).
    pub fn removeTagsFromResource(self: *Self, allocator: std.mem.Allocator, input: remove_tags_from_resource.RemoveTagsFromResourceInput, options: CallOptions) !remove_tags_from_resource.RemoveTagsFromResourceOutput {
        return remove_tags_from_resource.execute(self, allocator, input, options);
    }

    /// Modifies the parameters of a cache parameter group to the engine or system
    /// default
    /// value. You can reset specific parameters by submitting a list of parameter
    /// names. To
    /// reset the entire cache parameter group, specify the `ResetAllParameters` and
    /// `CacheParameterGroupName` parameters.
    pub fn resetCacheParameterGroup(self: *Self, allocator: std.mem.Allocator, input: reset_cache_parameter_group.ResetCacheParameterGroupInput, options: CallOptions) !reset_cache_parameter_group.ResetCacheParameterGroupOutput {
        return reset_cache_parameter_group.execute(self, allocator, input, options);
    }

    /// Revokes ingress from a cache security group. Use this operation to disallow
    /// access
    /// from an Amazon EC2 security group that had been previously authorized.
    pub fn revokeCacheSecurityGroupIngress(self: *Self, allocator: std.mem.Allocator, input: revoke_cache_security_group_ingress.RevokeCacheSecurityGroupIngressInput, options: CallOptions) !revoke_cache_security_group_ingress.RevokeCacheSecurityGroupIngressOutput {
        return revoke_cache_security_group_ingress.execute(self, allocator, input, options);
    }

    /// Start the migration of data.
    pub fn startMigration(self: *Self, allocator: std.mem.Allocator, input: start_migration.StartMigrationInput, options: CallOptions) !start_migration.StartMigrationOutput {
        return start_migration.execute(self, allocator, input, options);
    }

    /// Represents the input of a `TestFailover` operation which tests automatic
    /// failover on a specified node group (called shard in the console) in a
    /// replication group
    /// (called cluster in the console).
    ///
    /// This API is designed for testing the behavior of your application in case of
    /// ElastiCache failover. It is not designed to be an operational tool for
    /// initiating a
    /// failover to overcome a problem you may have with the cluster. Moreover, in
    /// certain
    /// conditions such as large-scale operational events, Amazon may block this
    /// API.
    ///
    /// **Note the following**
    ///
    /// * A customer can use this operation to test automatic failover on up to 15
    ///   shards
    /// (called node groups in the ElastiCache API and Amazon CLI) in any rolling
    /// 24-hour period.
    ///
    /// * If calling this operation on shards in different clusters (called
    ///   replication
    /// groups in the API and CLI), the calls can be made concurrently.
    ///
    /// * If calling this operation multiple times on different shards in the same
    ///   Valkey or Redis OSS (cluster mode enabled) replication group, the first
    ///   node replacement must
    /// complete before a subsequent call can be made.
    ///
    /// * To determine whether the node replacement is complete you can check Events
    /// using the Amazon ElastiCache console, the Amazon CLI, or the ElastiCache
    /// API.
    /// Look for the following automatic failover related events, listed here in
    /// order
    /// of occurrance:
    ///
    /// * Replication group message: `Test Failover API called for node
    /// group `
    ///
    /// * Cache cluster message: `Failover from primary node
    /// to replica node
    /// completed`
    ///
    /// * Replication group message: `Failover from primary node
    /// to replica node
    /// completed`
    ///
    /// * Cache cluster message: `Recovering cache nodes
    /// `
    ///
    /// * Cache cluster message: `Finished recovery for cache nodes
    /// `
    ///
    /// For more information see:
    ///
    /// * [Viewing
    /// ElastiCache
    /// Events](https://docs.aws.amazon.com/AmazonElastiCache/latest/dg/ECEvents.Viewing.html) in the *ElastiCache User
    /// Guide*
    ///
    /// *
    ///   [DescribeEvents](https://docs.aws.amazon.com/AmazonElastiCache/latest/APIReference/API_DescribeEvents.html) in the ElastiCache API Reference
    ///
    /// Also see, [Testing
    /// Multi-AZ
    /// ](https://docs.aws.amazon.com/AmazonElastiCache/latest/dg/AutoFailover.html#auto-failover-test) in the *ElastiCache User Guide*.
    pub fn testFailover(self: *Self, allocator: std.mem.Allocator, input: test_failover.TestFailoverInput, options: CallOptions) !test_failover.TestFailoverOutput {
        return test_failover.execute(self, allocator, input, options);
    }

    /// Async API to test connection between source and target replication group.
    pub fn testMigration(self: *Self, allocator: std.mem.Allocator, input: test_migration.TestMigrationInput, options: CallOptions) !test_migration.TestMigrationOutput {
        return test_migration.execute(self, allocator, input, options);
    }

    pub fn describeCacheClustersPaginator(self: *Self, params: describe_cache_clusters.DescribeCacheClustersInput) paginator.DescribeCacheClustersPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeCacheEngineVersionsPaginator(self: *Self, params: describe_cache_engine_versions.DescribeCacheEngineVersionsInput) paginator.DescribeCacheEngineVersionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeCacheParameterGroupsPaginator(self: *Self, params: describe_cache_parameter_groups.DescribeCacheParameterGroupsInput) paginator.DescribeCacheParameterGroupsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeCacheParametersPaginator(self: *Self, params: describe_cache_parameters.DescribeCacheParametersInput) paginator.DescribeCacheParametersPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeCacheSecurityGroupsPaginator(self: *Self, params: describe_cache_security_groups.DescribeCacheSecurityGroupsInput) paginator.DescribeCacheSecurityGroupsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeCacheSubnetGroupsPaginator(self: *Self, params: describe_cache_subnet_groups.DescribeCacheSubnetGroupsInput) paginator.DescribeCacheSubnetGroupsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeEngineDefaultParametersPaginator(self: *Self, params: describe_engine_default_parameters.DescribeEngineDefaultParametersInput) paginator.DescribeEngineDefaultParametersPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeEventsPaginator(self: *Self, params: describe_events.DescribeEventsInput) paginator.DescribeEventsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeGlobalReplicationGroupsPaginator(self: *Self, params: describe_global_replication_groups.DescribeGlobalReplicationGroupsInput) paginator.DescribeGlobalReplicationGroupsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeReplicationGroupsPaginator(self: *Self, params: describe_replication_groups.DescribeReplicationGroupsInput) paginator.DescribeReplicationGroupsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeReservedCacheNodesPaginator(self: *Self, params: describe_reserved_cache_nodes.DescribeReservedCacheNodesInput) paginator.DescribeReservedCacheNodesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeReservedCacheNodesOfferingsPaginator(self: *Self, params: describe_reserved_cache_nodes_offerings.DescribeReservedCacheNodesOfferingsInput) paginator.DescribeReservedCacheNodesOfferingsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeServerlessCacheSnapshotsPaginator(self: *Self, params: describe_serverless_cache_snapshots.DescribeServerlessCacheSnapshotsInput) paginator.DescribeServerlessCacheSnapshotsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeServerlessCachesPaginator(self: *Self, params: describe_serverless_caches.DescribeServerlessCachesInput) paginator.DescribeServerlessCachesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeServiceUpdatesPaginator(self: *Self, params: describe_service_updates.DescribeServiceUpdatesInput) paginator.DescribeServiceUpdatesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeSnapshotsPaginator(self: *Self, params: describe_snapshots.DescribeSnapshotsInput) paginator.DescribeSnapshotsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeUpdateActionsPaginator(self: *Self, params: describe_update_actions.DescribeUpdateActionsInput) paginator.DescribeUpdateActionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeUserGroupsPaginator(self: *Self, params: describe_user_groups.DescribeUserGroupsInput) paginator.DescribeUserGroupsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeUsersPaginator(self: *Self, params: describe_users.DescribeUsersInput) paginator.DescribeUsersPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn waitUntilCacheClusterDeleted(self: *Self, params: describe_cache_clusters.DescribeCacheClustersInput) aws.waiter.WaiterError!void {
        var w = waiters.CacheClusterDeletedWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilReplicationGroupDeleted(self: *Self, params: describe_replication_groups.DescribeReplicationGroupsInput) aws.waiter.WaiterError!void {
        var w = waiters.ReplicationGroupDeletedWaiter{ .client = self, .params = params };
        return w.wait();
    }
};
