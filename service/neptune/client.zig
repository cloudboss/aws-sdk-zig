const aws = @import("aws");
const std = @import("std");

const add_role_to_db_cluster = @import("add_role_to_db_cluster.zig");
const add_source_identifier_to_subscription = @import("add_source_identifier_to_subscription.zig");
const add_tags_to_resource = @import("add_tags_to_resource.zig");
const apply_pending_maintenance_action = @import("apply_pending_maintenance_action.zig");
const copy_db_cluster_parameter_group = @import("copy_db_cluster_parameter_group.zig");
const copy_db_cluster_snapshot = @import("copy_db_cluster_snapshot.zig");
const copy_db_parameter_group = @import("copy_db_parameter_group.zig");
const create_db_cluster = @import("create_db_cluster.zig");
const create_db_cluster_endpoint = @import("create_db_cluster_endpoint.zig");
const create_db_cluster_parameter_group = @import("create_db_cluster_parameter_group.zig");
const create_db_cluster_snapshot = @import("create_db_cluster_snapshot.zig");
const create_db_instance = @import("create_db_instance.zig");
const create_db_parameter_group = @import("create_db_parameter_group.zig");
const create_db_subnet_group = @import("create_db_subnet_group.zig");
const create_event_subscription = @import("create_event_subscription.zig");
const create_global_cluster = @import("create_global_cluster.zig");
const delete_db_cluster = @import("delete_db_cluster.zig");
const delete_db_cluster_endpoint = @import("delete_db_cluster_endpoint.zig");
const delete_db_cluster_parameter_group = @import("delete_db_cluster_parameter_group.zig");
const delete_db_cluster_snapshot = @import("delete_db_cluster_snapshot.zig");
const delete_db_instance = @import("delete_db_instance.zig");
const delete_db_parameter_group = @import("delete_db_parameter_group.zig");
const delete_db_subnet_group = @import("delete_db_subnet_group.zig");
const delete_event_subscription = @import("delete_event_subscription.zig");
const delete_global_cluster = @import("delete_global_cluster.zig");
const describe_db_cluster_endpoints = @import("describe_db_cluster_endpoints.zig");
const describe_db_cluster_parameter_groups = @import("describe_db_cluster_parameter_groups.zig");
const describe_db_cluster_parameters = @import("describe_db_cluster_parameters.zig");
const describe_db_cluster_snapshot_attributes = @import("describe_db_cluster_snapshot_attributes.zig");
const describe_db_cluster_snapshots = @import("describe_db_cluster_snapshots.zig");
const describe_db_clusters = @import("describe_db_clusters.zig");
const describe_db_engine_versions = @import("describe_db_engine_versions.zig");
const describe_db_instances = @import("describe_db_instances.zig");
const describe_db_parameter_groups = @import("describe_db_parameter_groups.zig");
const describe_db_parameters = @import("describe_db_parameters.zig");
const describe_db_subnet_groups = @import("describe_db_subnet_groups.zig");
const describe_engine_default_cluster_parameters = @import("describe_engine_default_cluster_parameters.zig");
const describe_engine_default_parameters = @import("describe_engine_default_parameters.zig");
const describe_event_categories = @import("describe_event_categories.zig");
const describe_event_subscriptions = @import("describe_event_subscriptions.zig");
const describe_events = @import("describe_events.zig");
const describe_global_clusters = @import("describe_global_clusters.zig");
const describe_orderable_db_instance_options = @import("describe_orderable_db_instance_options.zig");
const describe_pending_maintenance_actions = @import("describe_pending_maintenance_actions.zig");
const describe_valid_db_instance_modifications = @import("describe_valid_db_instance_modifications.zig");
const failover_db_cluster = @import("failover_db_cluster.zig");
const failover_global_cluster = @import("failover_global_cluster.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const modify_db_cluster = @import("modify_db_cluster.zig");
const modify_db_cluster_endpoint = @import("modify_db_cluster_endpoint.zig");
const modify_db_cluster_parameter_group = @import("modify_db_cluster_parameter_group.zig");
const modify_db_cluster_snapshot_attribute = @import("modify_db_cluster_snapshot_attribute.zig");
const modify_db_instance = @import("modify_db_instance.zig");
const modify_db_parameter_group = @import("modify_db_parameter_group.zig");
const modify_db_subnet_group = @import("modify_db_subnet_group.zig");
const modify_event_subscription = @import("modify_event_subscription.zig");
const modify_global_cluster = @import("modify_global_cluster.zig");
const promote_read_replica_db_cluster = @import("promote_read_replica_db_cluster.zig");
const reboot_db_instance = @import("reboot_db_instance.zig");
const remove_from_global_cluster = @import("remove_from_global_cluster.zig");
const remove_role_from_db_cluster = @import("remove_role_from_db_cluster.zig");
const remove_source_identifier_from_subscription = @import("remove_source_identifier_from_subscription.zig");
const remove_tags_from_resource = @import("remove_tags_from_resource.zig");
const reset_db_cluster_parameter_group = @import("reset_db_cluster_parameter_group.zig");
const reset_db_parameter_group = @import("reset_db_parameter_group.zig");
const restore_db_cluster_from_snapshot = @import("restore_db_cluster_from_snapshot.zig");
const restore_db_cluster_to_point_in_time = @import("restore_db_cluster_to_point_in_time.zig");
const start_db_cluster = @import("start_db_cluster.zig");
const stop_db_cluster = @import("stop_db_cluster.zig");
const switchover_global_cluster = @import("switchover_global_cluster.zig");
const CallOptions = @import("call_options.zig").CallOptions;
const paginator = @import("paginator.zig");
const waiters = @import("waiters.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "Neptune";

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

    /// Associates an Identity and Access Management (IAM) role with an
    /// Neptune DB cluster.
    pub fn addRoleToDbCluster(self: *Self, allocator: std.mem.Allocator, input: add_role_to_db_cluster.AddRoleToDBClusterInput, options: CallOptions) !add_role_to_db_cluster.AddRoleToDBClusterOutput {
        return add_role_to_db_cluster.execute(self, allocator, input, options);
    }

    /// Adds a source identifier to an existing event notification subscription.
    pub fn addSourceIdentifierToSubscription(self: *Self, allocator: std.mem.Allocator, input: add_source_identifier_to_subscription.AddSourceIdentifierToSubscriptionInput, options: CallOptions) !add_source_identifier_to_subscription.AddSourceIdentifierToSubscriptionOutput {
        return add_source_identifier_to_subscription.execute(self, allocator, input, options);
    }

    /// Adds metadata tags to an Amazon Neptune resource. These tags can also be
    /// used with cost
    /// allocation reporting to track cost associated with Amazon Neptune resources,
    /// or used in a
    /// Condition statement in an IAM policy for Amazon Neptune.
    pub fn addTagsToResource(self: *Self, allocator: std.mem.Allocator, input: add_tags_to_resource.AddTagsToResourceInput, options: CallOptions) !add_tags_to_resource.AddTagsToResourceOutput {
        return add_tags_to_resource.execute(self, allocator, input, options);
    }

    /// Applies a pending maintenance action to a resource (for example, to a DB
    /// instance).
    pub fn applyPendingMaintenanceAction(self: *Self, allocator: std.mem.Allocator, input: apply_pending_maintenance_action.ApplyPendingMaintenanceActionInput, options: CallOptions) !apply_pending_maintenance_action.ApplyPendingMaintenanceActionOutput {
        return apply_pending_maintenance_action.execute(self, allocator, input, options);
    }

    /// Copies the specified DB cluster parameter group.
    pub fn copyDbClusterParameterGroup(self: *Self, allocator: std.mem.Allocator, input: copy_db_cluster_parameter_group.CopyDBClusterParameterGroupInput, options: CallOptions) !copy_db_cluster_parameter_group.CopyDBClusterParameterGroupOutput {
        return copy_db_cluster_parameter_group.execute(self, allocator, input, options);
    }

    /// Copies a snapshot of a DB cluster.
    ///
    /// To copy a DB cluster snapshot from a shared manual DB cluster snapshot,
    /// `SourceDBClusterSnapshotIdentifier` must be the Amazon Resource Name (ARN)
    /// of the
    /// shared DB cluster snapshot.
    pub fn copyDbClusterSnapshot(self: *Self, allocator: std.mem.Allocator, input: copy_db_cluster_snapshot.CopyDBClusterSnapshotInput, options: CallOptions) !copy_db_cluster_snapshot.CopyDBClusterSnapshotOutput {
        return copy_db_cluster_snapshot.execute(self, allocator, input, options);
    }

    /// Copies the specified DB parameter group.
    pub fn copyDbParameterGroup(self: *Self, allocator: std.mem.Allocator, input: copy_db_parameter_group.CopyDBParameterGroupInput, options: CallOptions) !copy_db_parameter_group.CopyDBParameterGroupOutput {
        return copy_db_parameter_group.execute(self, allocator, input, options);
    }

    /// Creates a new Amazon Neptune DB cluster.
    ///
    /// You can use the `ReplicationSourceIdentifier` parameter to create the DB
    /// cluster as a Read Replica of another DB cluster or Amazon Neptune DB
    /// instance.
    ///
    /// Note that when you create a new cluster using `CreateDBCluster` directly,
    /// deletion protection is disabled by default (when you create a new production
    /// cluster in
    /// the console, deletion protection is enabled by default). You can only delete
    /// a DB
    /// cluster if its `DeletionProtection` field is set to `false`.
    pub fn createDbCluster(self: *Self, allocator: std.mem.Allocator, input: create_db_cluster.CreateDBClusterInput, options: CallOptions) !create_db_cluster.CreateDBClusterOutput {
        return create_db_cluster.execute(self, allocator, input, options);
    }

    /// Creates a new custom endpoint and associates it with an Amazon Neptune DB
    /// cluster.
    pub fn createDbClusterEndpoint(self: *Self, allocator: std.mem.Allocator, input: create_db_cluster_endpoint.CreateDBClusterEndpointInput, options: CallOptions) !create_db_cluster_endpoint.CreateDBClusterEndpointOutput {
        return create_db_cluster_endpoint.execute(self, allocator, input, options);
    }

    /// Creates a new DB cluster parameter group.
    ///
    /// Parameters in a DB cluster parameter group apply to all of the instances in
    /// a DB
    /// cluster.
    ///
    /// A DB cluster parameter group is initially created with the default
    /// parameters for the database engine used by instances in the DB cluster.
    /// To provide custom values for any of the parameters, you must modify the
    /// group after creating it using ModifyDBClusterParameterGroup.
    /// Once you've created a DB cluster parameter group, you need to associate it
    /// with your DB cluster using ModifyDBCluster.
    /// When you associate a new DB cluster parameter group with a running DB
    /// cluster,
    /// you need to reboot the DB instances in the DB cluster without failover for
    /// the
    /// new DB cluster parameter group and associated settings to take effect.
    ///
    /// After you create a DB cluster parameter group, you should wait at least
    /// 5 minutes before creating your first DB cluster that uses that DB cluster
    /// parameter group as the default parameter group. This allows Amazon Neptune
    /// to fully complete the create action before the DB cluster parameter group
    /// is used as the default for a new DB cluster. This is especially important
    /// for
    /// parameters that are critical when creating the default database for a DB
    /// cluster, such as the character set for the default database defined by the
    /// `character_set_database` parameter. You can use the *Parameter
    /// Groups* option of the [Amazon Neptune
    /// console](https://console.aws.amazon.com/rds/) or the
    /// DescribeDBClusterParameters
    /// command to verify that your DB cluster parameter group has been created or
    /// modified.
    pub fn createDbClusterParameterGroup(self: *Self, allocator: std.mem.Allocator, input: create_db_cluster_parameter_group.CreateDBClusterParameterGroupInput, options: CallOptions) !create_db_cluster_parameter_group.CreateDBClusterParameterGroupOutput {
        return create_db_cluster_parameter_group.execute(self, allocator, input, options);
    }

    /// Creates a snapshot of a DB cluster.
    pub fn createDbClusterSnapshot(self: *Self, allocator: std.mem.Allocator, input: create_db_cluster_snapshot.CreateDBClusterSnapshotInput, options: CallOptions) !create_db_cluster_snapshot.CreateDBClusterSnapshotOutput {
        return create_db_cluster_snapshot.execute(self, allocator, input, options);
    }

    /// Creates a new DB instance.
    pub fn createDbInstance(self: *Self, allocator: std.mem.Allocator, input: create_db_instance.CreateDBInstanceInput, options: CallOptions) !create_db_instance.CreateDBInstanceOutput {
        return create_db_instance.execute(self, allocator, input, options);
    }

    /// Creates a new DB parameter group.
    ///
    /// A DB parameter group is initially created with the default parameters for
    /// the database
    /// engine used by the DB instance. To provide custom values for any of the
    /// parameters, you must
    /// modify the group after creating it using *ModifyDBParameterGroup*. Once
    /// you've created a DB parameter group, you need to associate it with your DB
    /// instance using
    /// *ModifyDBInstance*. When you associate a new DB parameter group with a
    /// running DB instance, you need to reboot the DB instance without failover for
    /// the new DB
    /// parameter group and associated settings to take effect.
    ///
    /// After you create a DB parameter group, you should wait at least 5 minutes
    /// before
    /// creating your first DB instance that uses that DB parameter group as the
    /// default parameter
    /// group. This allows Amazon Neptune to fully complete the create action before
    /// the parameter
    /// group is used as the default for a new DB instance. This is especially
    /// important for
    /// parameters that are critical when creating the default database for a DB
    /// instance, such as
    /// the character set for the default database defined by the
    /// `character_set_database` parameter. You can use the *Parameter
    /// Groups* option of the Amazon Neptune console or the
    /// *DescribeDBParameters* command to verify that your DB parameter group has
    /// been created or modified.
    pub fn createDbParameterGroup(self: *Self, allocator: std.mem.Allocator, input: create_db_parameter_group.CreateDBParameterGroupInput, options: CallOptions) !create_db_parameter_group.CreateDBParameterGroupOutput {
        return create_db_parameter_group.execute(self, allocator, input, options);
    }

    /// Creates a new DB subnet group. DB subnet groups must contain at least one
    /// subnet in at
    /// least two AZs in the Amazon Region.
    pub fn createDbSubnetGroup(self: *Self, allocator: std.mem.Allocator, input: create_db_subnet_group.CreateDBSubnetGroupInput, options: CallOptions) !create_db_subnet_group.CreateDBSubnetGroupOutput {
        return create_db_subnet_group.execute(self, allocator, input, options);
    }

    /// Creates an event notification subscription. This action requires a topic ARN
    /// (Amazon
    /// Resource Name) created by either the Neptune console, the SNS console, or
    /// the SNS API. To
    /// obtain an ARN with SNS, you must create a topic in Amazon SNS and subscribe
    /// to the topic. The
    /// ARN is displayed in the SNS console.
    ///
    /// You can specify the type of source (SourceType) you want to be notified of,
    /// provide a list
    /// of Neptune sources (SourceIds) that triggers the events, and provide a list
    /// of event
    /// categories (EventCategories) for events you want to be notified of. For
    /// example, you can
    /// specify SourceType = db-instance, SourceIds = mydbinstance1, mydbinstance2
    /// and EventCategories
    /// = Availability, Backup.
    ///
    /// If you specify both the SourceType and SourceIds, such as SourceType =
    /// db-instance and
    /// SourceIdentifier = myDBInstance1, you are notified of all the db-instance
    /// events for the
    /// specified source. If you specify a SourceType but do not specify a
    /// SourceIdentifier, you
    /// receive notice of the events for that source type for all your Neptune
    /// sources. If you do not
    /// specify either the SourceType nor the SourceIdentifier, you are notified of
    /// events generated
    /// from all Neptune sources belonging to your customer account.
    pub fn createEventSubscription(self: *Self, allocator: std.mem.Allocator, input: create_event_subscription.CreateEventSubscriptionInput, options: CallOptions) !create_event_subscription.CreateEventSubscriptionOutput {
        return create_event_subscription.execute(self, allocator, input, options);
    }

    /// Creates a Neptune global database spread across multiple Amazon Regions.
    /// The global database contains a single primary cluster with read-write
    /// capability, and read-only secondary clusters that receive data from the
    /// primary cluster through high-speed replication performed by the Neptune
    /// storage subsystem.
    ///
    /// You can create a global database that is initially empty, and then
    /// add a primary cluster and secondary clusters to it, or you can specify
    /// an existing Neptune cluster during the create operation to become the
    /// primary cluster of the global database.
    pub fn createGlobalCluster(self: *Self, allocator: std.mem.Allocator, input: create_global_cluster.CreateGlobalClusterInput, options: CallOptions) !create_global_cluster.CreateGlobalClusterOutput {
        return create_global_cluster.execute(self, allocator, input, options);
    }

    /// The DeleteDBCluster action deletes a previously provisioned DB cluster. When
    /// you delete a
    /// DB cluster, all automated backups for that DB cluster are deleted and can't
    /// be recovered.
    /// Manual DB cluster snapshots of the specified DB cluster are not deleted.
    ///
    /// Note that the DB Cluster cannot be deleted if deletion protection is
    /// enabled. To
    /// delete it, you must first set its `DeletionProtection` field to
    /// `False`.
    pub fn deleteDbCluster(self: *Self, allocator: std.mem.Allocator, input: delete_db_cluster.DeleteDBClusterInput, options: CallOptions) !delete_db_cluster.DeleteDBClusterOutput {
        return delete_db_cluster.execute(self, allocator, input, options);
    }

    /// Deletes a custom endpoint and removes it from an Amazon Neptune DB cluster.
    pub fn deleteDbClusterEndpoint(self: *Self, allocator: std.mem.Allocator, input: delete_db_cluster_endpoint.DeleteDBClusterEndpointInput, options: CallOptions) !delete_db_cluster_endpoint.DeleteDBClusterEndpointOutput {
        return delete_db_cluster_endpoint.execute(self, allocator, input, options);
    }

    /// Deletes a specified DB cluster parameter group. The DB cluster parameter
    /// group to be
    /// deleted can't be associated with any DB clusters.
    pub fn deleteDbClusterParameterGroup(self: *Self, allocator: std.mem.Allocator, input: delete_db_cluster_parameter_group.DeleteDBClusterParameterGroupInput, options: CallOptions) !delete_db_cluster_parameter_group.DeleteDBClusterParameterGroupOutput {
        return delete_db_cluster_parameter_group.execute(self, allocator, input, options);
    }

    /// Deletes a DB cluster snapshot. If the snapshot is being copied, the copy
    /// operation is
    /// terminated.
    ///
    /// The DB cluster snapshot must be in the `available` state to be
    /// deleted.
    pub fn deleteDbClusterSnapshot(self: *Self, allocator: std.mem.Allocator, input: delete_db_cluster_snapshot.DeleteDBClusterSnapshotInput, options: CallOptions) !delete_db_cluster_snapshot.DeleteDBClusterSnapshotOutput {
        return delete_db_cluster_snapshot.execute(self, allocator, input, options);
    }

    /// The DeleteDBInstance action deletes a previously provisioned DB instance.
    /// When you delete
    /// a DB instance, all automated backups for that instance are deleted and can't
    /// be recovered.
    /// Manual DB snapshots of the DB instance to be deleted by `DeleteDBInstance`
    /// are not
    /// deleted.
    ///
    /// If you request a final DB snapshot the status of the Amazon Neptune DB
    /// instance is
    /// `deleting` until the DB snapshot is created. The API action
    /// `DescribeDBInstance` is used to monitor the status of this operation. The
    /// action
    /// can't be canceled or reverted once submitted.
    ///
    /// Note that when a DB instance is in a failure state and has a status of
    /// `failed`, `incompatible-restore`, or `incompatible-network`,
    /// you can only delete it when the `SkipFinalSnapshot` parameter is set to
    /// `true`.
    ///
    /// You can't delete a DB instance if it is the only instance in the DB cluster,
    /// or
    /// if it has deletion protection enabled.
    pub fn deleteDbInstance(self: *Self, allocator: std.mem.Allocator, input: delete_db_instance.DeleteDBInstanceInput, options: CallOptions) !delete_db_instance.DeleteDBInstanceOutput {
        return delete_db_instance.execute(self, allocator, input, options);
    }

    /// Deletes a specified DBParameterGroup. The DBParameterGroup to be deleted
    /// can't be
    /// associated with any DB instances.
    pub fn deleteDbParameterGroup(self: *Self, allocator: std.mem.Allocator, input: delete_db_parameter_group.DeleteDBParameterGroupInput, options: CallOptions) !delete_db_parameter_group.DeleteDBParameterGroupOutput {
        return delete_db_parameter_group.execute(self, allocator, input, options);
    }

    /// Deletes a DB subnet group.
    ///
    /// The specified database subnet group must not be associated with any DB
    /// instances.
    pub fn deleteDbSubnetGroup(self: *Self, allocator: std.mem.Allocator, input: delete_db_subnet_group.DeleteDBSubnetGroupInput, options: CallOptions) !delete_db_subnet_group.DeleteDBSubnetGroupOutput {
        return delete_db_subnet_group.execute(self, allocator, input, options);
    }

    /// Deletes an event notification subscription.
    pub fn deleteEventSubscription(self: *Self, allocator: std.mem.Allocator, input: delete_event_subscription.DeleteEventSubscriptionInput, options: CallOptions) !delete_event_subscription.DeleteEventSubscriptionOutput {
        return delete_event_subscription.execute(self, allocator, input, options);
    }

    /// Deletes a global database. The primary and all secondary clusters must
    /// already be detached or deleted first.
    pub fn deleteGlobalCluster(self: *Self, allocator: std.mem.Allocator, input: delete_global_cluster.DeleteGlobalClusterInput, options: CallOptions) !delete_global_cluster.DeleteGlobalClusterOutput {
        return delete_global_cluster.execute(self, allocator, input, options);
    }

    /// Returns information about endpoints for an Amazon Neptune DB cluster.
    ///
    /// This operation can also return information for Amazon RDS clusters
    /// and Amazon DocDB clusters.
    pub fn describeDbClusterEndpoints(self: *Self, allocator: std.mem.Allocator, input: describe_db_cluster_endpoints.DescribeDBClusterEndpointsInput, options: CallOptions) !describe_db_cluster_endpoints.DescribeDBClusterEndpointsOutput {
        return describe_db_cluster_endpoints.execute(self, allocator, input, options);
    }

    /// Returns a list of `DBClusterParameterGroup` descriptions. If a
    /// `DBClusterParameterGroupName` parameter is specified, the list will contain
    /// only
    /// the description of the specified DB cluster parameter group.
    pub fn describeDbClusterParameterGroups(self: *Self, allocator: std.mem.Allocator, input: describe_db_cluster_parameter_groups.DescribeDBClusterParameterGroupsInput, options: CallOptions) !describe_db_cluster_parameter_groups.DescribeDBClusterParameterGroupsOutput {
        return describe_db_cluster_parameter_groups.execute(self, allocator, input, options);
    }

    /// Returns the detailed parameter list for a particular DB cluster parameter
    /// group.
    pub fn describeDbClusterParameters(self: *Self, allocator: std.mem.Allocator, input: describe_db_cluster_parameters.DescribeDBClusterParametersInput, options: CallOptions) !describe_db_cluster_parameters.DescribeDBClusterParametersOutput {
        return describe_db_cluster_parameters.execute(self, allocator, input, options);
    }

    /// Returns a list of DB cluster snapshot attribute names and values for a
    /// manual DB cluster
    /// snapshot.
    ///
    /// When sharing snapshots with other Amazon accounts,
    /// `DescribeDBClusterSnapshotAttributes` returns the `restore` attribute
    /// and a list of IDs for the Amazon accounts that are authorized to copy or
    /// restore the manual DB
    /// cluster snapshot. If `all` is included in the list of values for the
    /// `restore` attribute, then the manual DB cluster snapshot is public and can
    /// be
    /// copied or restored by all Amazon accounts.
    ///
    /// To add or remove access for an Amazon account to copy or restore a manual DB
    /// cluster
    /// snapshot, or to make the manual DB cluster snapshot public or private, use
    /// the ModifyDBClusterSnapshotAttribute API action.
    pub fn describeDbClusterSnapshotAttributes(self: *Self, allocator: std.mem.Allocator, input: describe_db_cluster_snapshot_attributes.DescribeDBClusterSnapshotAttributesInput, options: CallOptions) !describe_db_cluster_snapshot_attributes.DescribeDBClusterSnapshotAttributesOutput {
        return describe_db_cluster_snapshot_attributes.execute(self, allocator, input, options);
    }

    /// Returns information about DB cluster snapshots. This API action supports
    /// pagination.
    pub fn describeDbClusterSnapshots(self: *Self, allocator: std.mem.Allocator, input: describe_db_cluster_snapshots.DescribeDBClusterSnapshotsInput, options: CallOptions) !describe_db_cluster_snapshots.DescribeDBClusterSnapshotsOutput {
        return describe_db_cluster_snapshots.execute(self, allocator, input, options);
    }

    /// Returns information about provisioned DB clusters, and supports
    /// pagination.
    ///
    /// This operation can also return information for Amazon RDS clusters
    /// and Amazon DocDB clusters.
    pub fn describeDbClusters(self: *Self, allocator: std.mem.Allocator, input: describe_db_clusters.DescribeDBClustersInput, options: CallOptions) !describe_db_clusters.DescribeDBClustersOutput {
        return describe_db_clusters.execute(self, allocator, input, options);
    }

    /// Returns a list of the available DB engines.
    pub fn describeDbEngineVersions(self: *Self, allocator: std.mem.Allocator, input: describe_db_engine_versions.DescribeDBEngineVersionsInput, options: CallOptions) !describe_db_engine_versions.DescribeDBEngineVersionsOutput {
        return describe_db_engine_versions.execute(self, allocator, input, options);
    }

    /// Returns information about provisioned instances, and supports pagination.
    ///
    /// This operation can also return information for Amazon RDS instances
    /// and Amazon DocDB instances.
    pub fn describeDbInstances(self: *Self, allocator: std.mem.Allocator, input: describe_db_instances.DescribeDBInstancesInput, options: CallOptions) !describe_db_instances.DescribeDBInstancesOutput {
        return describe_db_instances.execute(self, allocator, input, options);
    }

    /// Returns a list of `DBParameterGroup` descriptions. If a
    /// `DBParameterGroupName` is specified, the list will contain only the
    /// description of
    /// the specified DB parameter group.
    pub fn describeDbParameterGroups(self: *Self, allocator: std.mem.Allocator, input: describe_db_parameter_groups.DescribeDBParameterGroupsInput, options: CallOptions) !describe_db_parameter_groups.DescribeDBParameterGroupsOutput {
        return describe_db_parameter_groups.execute(self, allocator, input, options);
    }

    /// Returns the detailed parameter list for a particular DB parameter group.
    pub fn describeDbParameters(self: *Self, allocator: std.mem.Allocator, input: describe_db_parameters.DescribeDBParametersInput, options: CallOptions) !describe_db_parameters.DescribeDBParametersOutput {
        return describe_db_parameters.execute(self, allocator, input, options);
    }

    /// Returns a list of DBSubnetGroup descriptions. If a DBSubnetGroupName is
    /// specified, the
    /// list will contain only the descriptions of the specified DBSubnetGroup.
    ///
    /// For an overview of CIDR ranges, go to the [Wikipedia
    /// Tutorial](http://en.wikipedia.org/wiki/Classless_Inter-Domain_Routing).
    pub fn describeDbSubnetGroups(self: *Self, allocator: std.mem.Allocator, input: describe_db_subnet_groups.DescribeDBSubnetGroupsInput, options: CallOptions) !describe_db_subnet_groups.DescribeDBSubnetGroupsOutput {
        return describe_db_subnet_groups.execute(self, allocator, input, options);
    }

    /// Returns the default engine and system parameter information for the cluster
    /// database
    /// engine.
    pub fn describeEngineDefaultClusterParameters(self: *Self, allocator: std.mem.Allocator, input: describe_engine_default_cluster_parameters.DescribeEngineDefaultClusterParametersInput, options: CallOptions) !describe_engine_default_cluster_parameters.DescribeEngineDefaultClusterParametersOutput {
        return describe_engine_default_cluster_parameters.execute(self, allocator, input, options);
    }

    /// Returns the default engine and system parameter information for the
    /// specified database
    /// engine.
    pub fn describeEngineDefaultParameters(self: *Self, allocator: std.mem.Allocator, input: describe_engine_default_parameters.DescribeEngineDefaultParametersInput, options: CallOptions) !describe_engine_default_parameters.DescribeEngineDefaultParametersOutput {
        return describe_engine_default_parameters.execute(self, allocator, input, options);
    }

    /// Displays a list of categories for all event source types, or, if specified,
    /// for a
    /// specified source type.
    pub fn describeEventCategories(self: *Self, allocator: std.mem.Allocator, input: describe_event_categories.DescribeEventCategoriesInput, options: CallOptions) !describe_event_categories.DescribeEventCategoriesOutput {
        return describe_event_categories.execute(self, allocator, input, options);
    }

    /// Lists all the subscription descriptions for a customer account. The
    /// description for a
    /// subscription includes SubscriptionName, SNSTopicARN, CustomerID, SourceType,
    /// SourceID,
    /// CreationTime, and Status.
    ///
    /// If you specify a SubscriptionName, lists the description for that
    /// subscription.
    pub fn describeEventSubscriptions(self: *Self, allocator: std.mem.Allocator, input: describe_event_subscriptions.DescribeEventSubscriptionsInput, options: CallOptions) !describe_event_subscriptions.DescribeEventSubscriptionsOutput {
        return describe_event_subscriptions.execute(self, allocator, input, options);
    }

    /// Returns events related to DB instances, DB security groups, DB snapshots,
    /// and DB parameter
    /// groups for the past 14 days. Events specific to a particular DB instance, DB
    /// security group,
    /// database snapshot, or DB parameter group can be obtained by providing the
    /// name as a parameter.
    /// By default, the past hour of events are returned.
    pub fn describeEvents(self: *Self, allocator: std.mem.Allocator, input: describe_events.DescribeEventsInput, options: CallOptions) !describe_events.DescribeEventsOutput {
        return describe_events.execute(self, allocator, input, options);
    }

    /// Returns information about Neptune global database clusters. This API
    /// supports pagination.
    pub fn describeGlobalClusters(self: *Self, allocator: std.mem.Allocator, input: describe_global_clusters.DescribeGlobalClustersInput, options: CallOptions) !describe_global_clusters.DescribeGlobalClustersOutput {
        return describe_global_clusters.execute(self, allocator, input, options);
    }

    /// Returns a list of orderable DB instance options for the specified engine.
    pub fn describeOrderableDbInstanceOptions(self: *Self, allocator: std.mem.Allocator, input: describe_orderable_db_instance_options.DescribeOrderableDBInstanceOptionsInput, options: CallOptions) !describe_orderable_db_instance_options.DescribeOrderableDBInstanceOptionsOutput {
        return describe_orderable_db_instance_options.execute(self, allocator, input, options);
    }

    /// Returns a list of resources (for example, DB instances) that have at least
    /// one pending
    /// maintenance action.
    pub fn describePendingMaintenanceActions(self: *Self, allocator: std.mem.Allocator, input: describe_pending_maintenance_actions.DescribePendingMaintenanceActionsInput, options: CallOptions) !describe_pending_maintenance_actions.DescribePendingMaintenanceActionsOutput {
        return describe_pending_maintenance_actions.execute(self, allocator, input, options);
    }

    /// You can call DescribeValidDBInstanceModifications
    /// to learn what modifications you can make to your DB instance. You can use
    /// this
    /// information when you call ModifyDBInstance.
    pub fn describeValidDbInstanceModifications(self: *Self, allocator: std.mem.Allocator, input: describe_valid_db_instance_modifications.DescribeValidDBInstanceModificationsInput, options: CallOptions) !describe_valid_db_instance_modifications.DescribeValidDBInstanceModificationsOutput {
        return describe_valid_db_instance_modifications.execute(self, allocator, input, options);
    }

    /// Forces a failover for a DB cluster.
    ///
    /// A failover for a DB cluster promotes one of the Read Replicas (read-only
    /// instances) in the
    /// DB cluster to be the primary instance (the cluster writer).
    ///
    /// Amazon Neptune will automatically fail over to a Read Replica, if one
    /// exists, when the
    /// primary instance fails. You can force a failover when you want to simulate a
    /// failure of a
    /// primary instance for testing. Because each instance in a DB cluster has its
    /// own endpoint
    /// address, you will need to clean up and re-establish any existing connections
    /// that use those
    /// endpoint addresses when the failover is complete.
    pub fn failoverDbCluster(self: *Self, allocator: std.mem.Allocator, input: failover_db_cluster.FailoverDBClusterInput, options: CallOptions) !failover_db_cluster.FailoverDBClusterOutput {
        return failover_db_cluster.execute(self, allocator, input, options);
    }

    /// Initiates the failover process for a Neptune global database.
    ///
    /// A failover for a Neptune global database promotes one of secondary
    /// read-only DB clusters to be the primary DB cluster and demotes the
    /// primary DB cluster to being a secondary (read-only) DB cluster. In other
    /// words, the role of the current primary DB cluster and the selected
    /// target secondary DB cluster are switched. The selected secondary DB cluster
    /// assumes full read/write capabilities for the Neptune global database.
    ///
    /// This action applies **only** to
    /// Neptune global databases. This action is only intended for use on healthy
    /// Neptune global databases with healthy Neptune DB clusters and no region-wide
    /// outages, to test disaster recovery scenarios or to reconfigure the global
    /// database topology.
    pub fn failoverGlobalCluster(self: *Self, allocator: std.mem.Allocator, input: failover_global_cluster.FailoverGlobalClusterInput, options: CallOptions) !failover_global_cluster.FailoverGlobalClusterOutput {
        return failover_global_cluster.execute(self, allocator, input, options);
    }

    /// Lists all tags on an Amazon Neptune resource.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: CallOptions) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Modify a setting for a DB cluster. You can change one or more database
    /// configuration
    /// parameters by specifying these parameters and the new values in the request.
    pub fn modifyDbCluster(self: *Self, allocator: std.mem.Allocator, input: modify_db_cluster.ModifyDBClusterInput, options: CallOptions) !modify_db_cluster.ModifyDBClusterOutput {
        return modify_db_cluster.execute(self, allocator, input, options);
    }

    /// Modifies the properties of an endpoint in an Amazon Neptune DB cluster.
    pub fn modifyDbClusterEndpoint(self: *Self, allocator: std.mem.Allocator, input: modify_db_cluster_endpoint.ModifyDBClusterEndpointInput, options: CallOptions) !modify_db_cluster_endpoint.ModifyDBClusterEndpointOutput {
        return modify_db_cluster_endpoint.execute(self, allocator, input, options);
    }

    /// Modifies the parameters of a DB cluster parameter group. To modify more than
    /// one
    /// parameter, submit a list of the following: `ParameterName`,
    /// `ParameterValue`, and `ApplyMethod`. A maximum of 20 parameters can be
    /// modified in a single request.
    ///
    /// Changes to dynamic parameters are applied immediately. Changes to static
    /// parameters
    /// require a reboot without failover to the DB cluster associated with the
    /// parameter group
    /// before the change can take effect.
    ///
    /// After you create a DB cluster parameter group, you should wait at least 5
    /// minutes before
    /// creating your first DB cluster that uses that DB cluster parameter group as
    /// the default
    /// parameter group. This allows Amazon Neptune to fully complete the create
    /// action before the
    /// parameter group is used as the default for a new DB cluster. This is
    /// especially important
    /// for parameters that are critical when creating the default database for a DB
    /// cluster, such
    /// as the character set for the default database defined by the
    /// `character_set_database` parameter. You can use the *Parameter
    /// Groups* option of the Amazon Neptune console or the
    /// DescribeDBClusterParameters command to verify that your DB cluster parameter
    /// group has been created or modified.
    pub fn modifyDbClusterParameterGroup(self: *Self, allocator: std.mem.Allocator, input: modify_db_cluster_parameter_group.ModifyDBClusterParameterGroupInput, options: CallOptions) !modify_db_cluster_parameter_group.ModifyDBClusterParameterGroupOutput {
        return modify_db_cluster_parameter_group.execute(self, allocator, input, options);
    }

    /// Adds an attribute and values to, or removes an attribute and values from, a
    /// manual DB
    /// cluster snapshot.
    ///
    /// To share a manual DB cluster snapshot with other Amazon accounts, specify
    /// `restore` as the `AttributeName` and use the `ValuesToAdd`
    /// parameter to add a list of IDs of the Amazon accounts that are authorized to
    /// restore the manual
    /// DB cluster snapshot. Use the value `all` to make the manual DB cluster
    /// snapshot
    /// public, which means that it can be copied or restored by all Amazon
    /// accounts. Do not add the
    /// `all` value for any manual DB cluster snapshots that contain private
    /// information
    /// that you don't want available to all Amazon accounts. If a manual DB cluster
    /// snapshot is
    /// encrypted, it can be shared, but only by specifying a list of authorized
    /// Amazon account IDs for
    /// the `ValuesToAdd` parameter. You can't use `all` as a value for that
    /// parameter in this case.
    ///
    /// To view which Amazon accounts have access to copy or restore a manual DB
    /// cluster snapshot, or
    /// whether a manual DB cluster snapshot public or private, use the
    /// DescribeDBClusterSnapshotAttributes API action.
    pub fn modifyDbClusterSnapshotAttribute(self: *Self, allocator: std.mem.Allocator, input: modify_db_cluster_snapshot_attribute.ModifyDBClusterSnapshotAttributeInput, options: CallOptions) !modify_db_cluster_snapshot_attribute.ModifyDBClusterSnapshotAttributeOutput {
        return modify_db_cluster_snapshot_attribute.execute(self, allocator, input, options);
    }

    /// Modifies settings for a DB instance. You can change one or more database
    /// configuration
    /// parameters by specifying these parameters and the new values in the request.
    /// To learn what
    /// modifications you can make to your DB instance, call
    /// DescribeValidDBInstanceModifications before you call ModifyDBInstance.
    pub fn modifyDbInstance(self: *Self, allocator: std.mem.Allocator, input: modify_db_instance.ModifyDBInstanceInput, options: CallOptions) !modify_db_instance.ModifyDBInstanceOutput {
        return modify_db_instance.execute(self, allocator, input, options);
    }

    /// Modifies the parameters of a DB parameter group. To modify more than one
    /// parameter,
    /// submit a list of the following: `ParameterName`, `ParameterValue`, and
    /// `ApplyMethod`. A maximum of 20 parameters can be modified in a single
    /// request.
    ///
    /// Changes to dynamic parameters are applied immediately. Changes to static
    /// parameters
    /// require a reboot without failover to the DB instance associated with the
    /// parameter group
    /// before the change can take effect.
    ///
    /// After you modify a DB parameter group, you should wait at least 5 minutes
    /// before
    /// creating your first DB instance that uses that DB parameter group as the
    /// default parameter
    /// group. This allows Amazon Neptune to fully complete the modify action before
    /// the parameter
    /// group is used as the default for a new DB instance. This is especially
    /// important for
    /// parameters that are critical when creating the default database for a DB
    /// instance, such as
    /// the character set for the default database defined by the
    /// `character_set_database` parameter. You can use the *Parameter
    /// Groups* option of the Amazon Neptune console or the
    /// *DescribeDBParameters* command to verify that your DB parameter group has
    /// been created or modified.
    pub fn modifyDbParameterGroup(self: *Self, allocator: std.mem.Allocator, input: modify_db_parameter_group.ModifyDBParameterGroupInput, options: CallOptions) !modify_db_parameter_group.ModifyDBParameterGroupOutput {
        return modify_db_parameter_group.execute(self, allocator, input, options);
    }

    /// Modifies an existing DB subnet group. DB subnet groups must contain at least
    /// one subnet in
    /// at least two AZs in the Amazon Region.
    pub fn modifyDbSubnetGroup(self: *Self, allocator: std.mem.Allocator, input: modify_db_subnet_group.ModifyDBSubnetGroupInput, options: CallOptions) !modify_db_subnet_group.ModifyDBSubnetGroupOutput {
        return modify_db_subnet_group.execute(self, allocator, input, options);
    }

    /// Modifies an existing event notification subscription. Note that you can't
    /// modify the
    /// source identifiers using this call; to change source identifiers for a
    /// subscription, use the
    /// AddSourceIdentifierToSubscription and RemoveSourceIdentifierFromSubscription
    /// calls.
    ///
    /// You can see a list of the event categories for a given SourceType
    /// by using the **DescribeEventCategories** action.
    pub fn modifyEventSubscription(self: *Self, allocator: std.mem.Allocator, input: modify_event_subscription.ModifyEventSubscriptionInput, options: CallOptions) !modify_event_subscription.ModifyEventSubscriptionOutput {
        return modify_event_subscription.execute(self, allocator, input, options);
    }

    /// Modify a setting for an Amazon Neptune global cluster. You can change one
    /// or more database configuration parameters by specifying these parameters
    /// and their new values in the request.
    pub fn modifyGlobalCluster(self: *Self, allocator: std.mem.Allocator, input: modify_global_cluster.ModifyGlobalClusterInput, options: CallOptions) !modify_global_cluster.ModifyGlobalClusterOutput {
        return modify_global_cluster.execute(self, allocator, input, options);
    }

    /// Not supported.
    pub fn promoteReadReplicaDbCluster(self: *Self, allocator: std.mem.Allocator, input: promote_read_replica_db_cluster.PromoteReadReplicaDBClusterInput, options: CallOptions) !promote_read_replica_db_cluster.PromoteReadReplicaDBClusterOutput {
        return promote_read_replica_db_cluster.execute(self, allocator, input, options);
    }

    /// You might need to reboot your DB instance, usually for maintenance reasons.
    /// For example,
    /// if you make certain modifications, or if you change the DB parameter group
    /// associated with the
    /// DB instance, you must reboot the instance for the changes to take effect.
    ///
    /// Rebooting a DB instance restarts the database engine service. Rebooting a DB
    /// instance
    /// results in a momentary outage, during which the DB instance status is set to
    /// rebooting.
    pub fn rebootDbInstance(self: *Self, allocator: std.mem.Allocator, input: reboot_db_instance.RebootDBInstanceInput, options: CallOptions) !reboot_db_instance.RebootDBInstanceOutput {
        return reboot_db_instance.execute(self, allocator, input, options);
    }

    /// Detaches a Neptune DB cluster from a Neptune global database. A secondary
    /// cluster becomes a normal standalone cluster with read-write capability
    /// instead of being read-only, and no longer receives data from the
    /// primary cluster.
    pub fn removeFromGlobalCluster(self: *Self, allocator: std.mem.Allocator, input: remove_from_global_cluster.RemoveFromGlobalClusterInput, options: CallOptions) !remove_from_global_cluster.RemoveFromGlobalClusterOutput {
        return remove_from_global_cluster.execute(self, allocator, input, options);
    }

    /// Disassociates an Identity and Access Management (IAM) role from a DB
    /// cluster.
    pub fn removeRoleFromDbCluster(self: *Self, allocator: std.mem.Allocator, input: remove_role_from_db_cluster.RemoveRoleFromDBClusterInput, options: CallOptions) !remove_role_from_db_cluster.RemoveRoleFromDBClusterOutput {
        return remove_role_from_db_cluster.execute(self, allocator, input, options);
    }

    /// Removes a source identifier from an existing event notification
    /// subscription.
    pub fn removeSourceIdentifierFromSubscription(self: *Self, allocator: std.mem.Allocator, input: remove_source_identifier_from_subscription.RemoveSourceIdentifierFromSubscriptionInput, options: CallOptions) !remove_source_identifier_from_subscription.RemoveSourceIdentifierFromSubscriptionOutput {
        return remove_source_identifier_from_subscription.execute(self, allocator, input, options);
    }

    /// Removes metadata tags from an Amazon Neptune resource.
    pub fn removeTagsFromResource(self: *Self, allocator: std.mem.Allocator, input: remove_tags_from_resource.RemoveTagsFromResourceInput, options: CallOptions) !remove_tags_from_resource.RemoveTagsFromResourceOutput {
        return remove_tags_from_resource.execute(self, allocator, input, options);
    }

    /// Modifies the parameters of a DB cluster parameter group to the default
    /// value. To reset
    /// specific parameters submit a list of the following: `ParameterName` and
    /// `ApplyMethod`. To reset the entire DB cluster parameter group, specify the
    /// `DBClusterParameterGroupName` and `ResetAllParameters` parameters.
    ///
    /// When resetting the entire group, dynamic parameters are updated immediately
    /// and static
    /// parameters are set to `pending-reboot` to take effect on the next DB
    /// instance
    /// restart or RebootDBInstance request. You must call RebootDBInstance for
    /// every DB instance in your DB cluster
    /// that you want the updated static parameter to apply to.
    pub fn resetDbClusterParameterGroup(self: *Self, allocator: std.mem.Allocator, input: reset_db_cluster_parameter_group.ResetDBClusterParameterGroupInput, options: CallOptions) !reset_db_cluster_parameter_group.ResetDBClusterParameterGroupOutput {
        return reset_db_cluster_parameter_group.execute(self, allocator, input, options);
    }

    /// Modifies the parameters of a DB parameter group to the engine/system default
    /// value. To
    /// reset specific parameters, provide a list of the following: `ParameterName`
    /// and
    /// `ApplyMethod`. To reset the entire DB parameter group, specify the
    /// `DBParameterGroup` name and `ResetAllParameters` parameters. When
    /// resetting the entire group, dynamic parameters are updated immediately and
    /// static parameters
    /// are set to `pending-reboot` to take effect on the next DB instance restart
    /// or
    /// `RebootDBInstance` request.
    pub fn resetDbParameterGroup(self: *Self, allocator: std.mem.Allocator, input: reset_db_parameter_group.ResetDBParameterGroupInput, options: CallOptions) !reset_db_parameter_group.ResetDBParameterGroupOutput {
        return reset_db_parameter_group.execute(self, allocator, input, options);
    }

    /// Creates a new DB cluster from a DB snapshot or DB cluster snapshot.
    ///
    /// If a DB snapshot is specified, the target DB cluster is created from the
    /// source DB
    /// snapshot with a default configuration and default security group.
    ///
    /// If a DB cluster snapshot is specified, the target DB cluster is created from
    /// the source DB
    /// cluster restore point with the same configuration as the original source DB
    /// cluster, except
    /// that the new DB cluster is created with the default security group.
    pub fn restoreDbClusterFromSnapshot(self: *Self, allocator: std.mem.Allocator, input: restore_db_cluster_from_snapshot.RestoreDBClusterFromSnapshotInput, options: CallOptions) !restore_db_cluster_from_snapshot.RestoreDBClusterFromSnapshotOutput {
        return restore_db_cluster_from_snapshot.execute(self, allocator, input, options);
    }

    /// Restores a DB cluster to an arbitrary point in time. Users can restore to
    /// any point in
    /// time before `LatestRestorableTime` for up to `BackupRetentionPeriod`
    /// days. The target DB cluster is created from the source DB cluster with the
    /// same configuration
    /// as the original DB cluster, except that the new DB cluster is created with
    /// the default DB
    /// security group.
    ///
    /// This action only restores the DB cluster, not the DB instances for that DB
    /// cluster. You
    /// must invoke the CreateDBInstance action to create DB instances for the
    /// restored DB cluster, specifying the identifier of the restored DB cluster in
    /// `DBClusterIdentifier`. You can create DB instances only after the
    /// `RestoreDBClusterToPointInTime` action has completed and the DB cluster is
    /// available.
    pub fn restoreDbClusterToPointInTime(self: *Self, allocator: std.mem.Allocator, input: restore_db_cluster_to_point_in_time.RestoreDBClusterToPointInTimeInput, options: CallOptions) !restore_db_cluster_to_point_in_time.RestoreDBClusterToPointInTimeOutput {
        return restore_db_cluster_to_point_in_time.execute(self, allocator, input, options);
    }

    /// Starts an Amazon Neptune DB cluster that was stopped using the Amazon
    /// console, the Amazon CLI stop-db-cluster command, or the StopDBCluster API.
    pub fn startDbCluster(self: *Self, allocator: std.mem.Allocator, input: start_db_cluster.StartDBClusterInput, options: CallOptions) !start_db_cluster.StartDBClusterOutput {
        return start_db_cluster.execute(self, allocator, input, options);
    }

    /// Stops an Amazon Neptune DB cluster. When you stop a DB cluster, Neptune
    /// retains the DB cluster's metadata, including its endpoints and DB parameter
    /// groups.
    ///
    /// Neptune also retains the transaction logs so you can do a point-in-time
    /// restore if necessary.
    pub fn stopDbCluster(self: *Self, allocator: std.mem.Allocator, input: stop_db_cluster.StopDBClusterInput, options: CallOptions) !stop_db_cluster.StopDBClusterOutput {
        return stop_db_cluster.execute(self, allocator, input, options);
    }

    /// Switches over the specified secondary DB cluster to be the new primary DB
    /// cluster in the global
    /// database cluster. Switchover operations were previously called "managed
    /// planned failovers."
    ///
    /// Promotes the specified secondary cluster to assume full read/write
    /// capabilities and demotes the current
    /// primary cluster to a secondary (read-only) cluster, maintaining the original
    /// replication topology. All secondary
    /// clusters are synchronized with the primary at the beginning of the process
    /// so the new primary continues operations
    /// for the global database without losing any data. Your database is
    /// unavailable for a short time while the primary
    /// and selected secondary clusters are assuming their new roles.
    ///
    /// This operation is intended for controlled environments, for operations such
    /// as "regional rotation" or
    /// to fall back to the original primary after a global database failover.
    pub fn switchoverGlobalCluster(self: *Self, allocator: std.mem.Allocator, input: switchover_global_cluster.SwitchoverGlobalClusterInput, options: CallOptions) !switchover_global_cluster.SwitchoverGlobalClusterOutput {
        return switchover_global_cluster.execute(self, allocator, input, options);
    }

    pub fn describeDbClusterEndpointsPaginator(self: *Self, params: describe_db_cluster_endpoints.DescribeDBClusterEndpointsInput) paginator.DescribeDBClusterEndpointsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn describeDbClusterParameterGroupsPaginator(self: *Self, params: describe_db_cluster_parameter_groups.DescribeDBClusterParameterGroupsInput) paginator.DescribeDBClusterParameterGroupsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn describeDbClusterParametersPaginator(self: *Self, params: describe_db_cluster_parameters.DescribeDBClusterParametersInput) paginator.DescribeDBClusterParametersPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn describeDbClusterSnapshotsPaginator(self: *Self, params: describe_db_cluster_snapshots.DescribeDBClusterSnapshotsInput) paginator.DescribeDBClusterSnapshotsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn describeDbClustersPaginator(self: *Self, params: describe_db_clusters.DescribeDBClustersInput) paginator.DescribeDBClustersPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn describeDbEngineVersionsPaginator(self: *Self, params: describe_db_engine_versions.DescribeDBEngineVersionsInput) paginator.DescribeDBEngineVersionsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn describeDbInstancesPaginator(self: *Self, params: describe_db_instances.DescribeDBInstancesInput) paginator.DescribeDBInstancesPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn describeDbParameterGroupsPaginator(self: *Self, params: describe_db_parameter_groups.DescribeDBParameterGroupsInput) paginator.DescribeDBParameterGroupsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn describeDbParametersPaginator(self: *Self, params: describe_db_parameters.DescribeDBParametersInput) paginator.DescribeDBParametersPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn describeDbSubnetGroupsPaginator(self: *Self, params: describe_db_subnet_groups.DescribeDBSubnetGroupsInput) paginator.DescribeDBSubnetGroupsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn describeEngineDefaultParametersPaginator(self: *Self, params: describe_engine_default_parameters.DescribeEngineDefaultParametersInput) paginator.DescribeEngineDefaultParametersPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn describeEventSubscriptionsPaginator(self: *Self, params: describe_event_subscriptions.DescribeEventSubscriptionsInput) paginator.DescribeEventSubscriptionsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn describeEventsPaginator(self: *Self, params: describe_events.DescribeEventsInput) paginator.DescribeEventsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn describeGlobalClustersPaginator(self: *Self, params: describe_global_clusters.DescribeGlobalClustersInput) paginator.DescribeGlobalClustersPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn describeOrderableDbInstanceOptionsPaginator(self: *Self, params: describe_orderable_db_instance_options.DescribeOrderableDBInstanceOptionsInput) paginator.DescribeOrderableDBInstanceOptionsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn describePendingMaintenanceActionsPaginator(self: *Self, params: describe_pending_maintenance_actions.DescribePendingMaintenanceActionsInput) paginator.DescribePendingMaintenanceActionsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn waitUntilDBInstanceDeleted(self: *Self, params: describe_db_instances.DescribeDBInstancesInput) aws.waiter.WaiterError!void {
        var w = waiters.DBInstanceDeletedWaiter{ .client = self, .params = params };
        return w.wait();
    }
};
