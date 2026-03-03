const aws = @import("aws");
const std = @import("std");

const add_source_identifier_to_subscription = @import("add_source_identifier_to_subscription.zig");
const add_tags_to_resource = @import("add_tags_to_resource.zig");
const apply_pending_maintenance_action = @import("apply_pending_maintenance_action.zig");
const copy_db_cluster_parameter_group = @import("copy_db_cluster_parameter_group.zig");
const copy_db_cluster_snapshot = @import("copy_db_cluster_snapshot.zig");
const create_db_cluster = @import("create_db_cluster.zig");
const create_db_cluster_parameter_group = @import("create_db_cluster_parameter_group.zig");
const create_db_cluster_snapshot = @import("create_db_cluster_snapshot.zig");
const create_db_instance = @import("create_db_instance.zig");
const create_db_subnet_group = @import("create_db_subnet_group.zig");
const create_event_subscription = @import("create_event_subscription.zig");
const create_global_cluster = @import("create_global_cluster.zig");
const delete_db_cluster = @import("delete_db_cluster.zig");
const delete_db_cluster_parameter_group = @import("delete_db_cluster_parameter_group.zig");
const delete_db_cluster_snapshot = @import("delete_db_cluster_snapshot.zig");
const delete_db_instance = @import("delete_db_instance.zig");
const delete_db_subnet_group = @import("delete_db_subnet_group.zig");
const delete_event_subscription = @import("delete_event_subscription.zig");
const delete_global_cluster = @import("delete_global_cluster.zig");
const describe_certificates = @import("describe_certificates.zig");
const describe_db_cluster_parameter_groups = @import("describe_db_cluster_parameter_groups.zig");
const describe_db_cluster_parameters = @import("describe_db_cluster_parameters.zig");
const describe_db_cluster_snapshot_attributes = @import("describe_db_cluster_snapshot_attributes.zig");
const describe_db_cluster_snapshots = @import("describe_db_cluster_snapshots.zig");
const describe_db_clusters = @import("describe_db_clusters.zig");
const describe_db_engine_versions = @import("describe_db_engine_versions.zig");
const describe_db_instances = @import("describe_db_instances.zig");
const describe_db_subnet_groups = @import("describe_db_subnet_groups.zig");
const describe_engine_default_cluster_parameters = @import("describe_engine_default_cluster_parameters.zig");
const describe_event_categories = @import("describe_event_categories.zig");
const describe_event_subscriptions = @import("describe_event_subscriptions.zig");
const describe_events = @import("describe_events.zig");
const describe_global_clusters = @import("describe_global_clusters.zig");
const describe_orderable_db_instance_options = @import("describe_orderable_db_instance_options.zig");
const describe_pending_maintenance_actions = @import("describe_pending_maintenance_actions.zig");
const failover_db_cluster = @import("failover_db_cluster.zig");
const failover_global_cluster = @import("failover_global_cluster.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const modify_db_cluster = @import("modify_db_cluster.zig");
const modify_db_cluster_parameter_group = @import("modify_db_cluster_parameter_group.zig");
const modify_db_cluster_snapshot_attribute = @import("modify_db_cluster_snapshot_attribute.zig");
const modify_db_instance = @import("modify_db_instance.zig");
const modify_db_subnet_group = @import("modify_db_subnet_group.zig");
const modify_event_subscription = @import("modify_event_subscription.zig");
const modify_global_cluster = @import("modify_global_cluster.zig");
const reboot_db_instance = @import("reboot_db_instance.zig");
const remove_from_global_cluster = @import("remove_from_global_cluster.zig");
const remove_source_identifier_from_subscription = @import("remove_source_identifier_from_subscription.zig");
const remove_tags_from_resource = @import("remove_tags_from_resource.zig");
const reset_db_cluster_parameter_group = @import("reset_db_cluster_parameter_group.zig");
const restore_db_cluster_from_snapshot = @import("restore_db_cluster_from_snapshot.zig");
const restore_db_cluster_to_point_in_time = @import("restore_db_cluster_to_point_in_time.zig");
const start_db_cluster = @import("start_db_cluster.zig");
const stop_db_cluster = @import("stop_db_cluster.zig");
const switchover_global_cluster = @import("switchover_global_cluster.zig");
const paginator = @import("paginator.zig");
const waiters = @import("waiters.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "DocDB";

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

    /// Adds a source identifier to an existing event notification
    /// subscription.
    pub fn addSourceIdentifierToSubscription(self: *Self, allocator: std.mem.Allocator, input: add_source_identifier_to_subscription.AddSourceIdentifierToSubscriptionInput, options: add_source_identifier_to_subscription.Options) !add_source_identifier_to_subscription.AddSourceIdentifierToSubscriptionOutput {
        return add_source_identifier_to_subscription.execute(self, allocator, input, options);
    }

    /// Adds metadata tags to an Amazon DocumentDB resource. You can use these tags
    /// with cost allocation reporting to track costs that are associated
    /// with Amazon DocumentDB resources or in a `Condition` statement in
    /// an Identity and Access Management (IAM) policy for Amazon DocumentDB.
    pub fn addTagsToResource(self: *Self, allocator: std.mem.Allocator, input: add_tags_to_resource.AddTagsToResourceInput, options: add_tags_to_resource.Options) !add_tags_to_resource.AddTagsToResourceOutput {
        return add_tags_to_resource.execute(self, allocator, input, options);
    }

    /// Applies a pending maintenance action to a resource (for example,
    /// to an Amazon DocumentDB instance).
    pub fn applyPendingMaintenanceAction(self: *Self, allocator: std.mem.Allocator, input: apply_pending_maintenance_action.ApplyPendingMaintenanceActionInput, options: apply_pending_maintenance_action.Options) !apply_pending_maintenance_action.ApplyPendingMaintenanceActionOutput {
        return apply_pending_maintenance_action.execute(self, allocator, input, options);
    }

    /// Copies the specified cluster parameter group.
    pub fn copyDbClusterParameterGroup(self: *Self, allocator: std.mem.Allocator, input: copy_db_cluster_parameter_group.CopyDBClusterParameterGroupInput, options: copy_db_cluster_parameter_group.Options) !copy_db_cluster_parameter_group.CopyDBClusterParameterGroupOutput {
        return copy_db_cluster_parameter_group.execute(self, allocator, input, options);
    }

    /// Copies a snapshot of a cluster.
    ///
    /// To copy a cluster snapshot from a shared manual cluster snapshot,
    /// `SourceDBClusterSnapshotIdentifier` must be the Amazon
    /// Resource Name (ARN) of the shared cluster snapshot. You can only
    /// copy a shared DB cluster snapshot, whether encrypted or not, in the
    /// same Amazon Web Services Region.
    ///
    /// To cancel the copy operation after it is in progress, delete the
    /// target cluster snapshot identified by
    /// `TargetDBClusterSnapshotIdentifier` while that cluster
    /// snapshot is in the *copying* status.
    pub fn copyDbClusterSnapshot(self: *Self, allocator: std.mem.Allocator, input: copy_db_cluster_snapshot.CopyDBClusterSnapshotInput, options: copy_db_cluster_snapshot.Options) !copy_db_cluster_snapshot.CopyDBClusterSnapshotOutput {
        return copy_db_cluster_snapshot.execute(self, allocator, input, options);
    }

    /// Creates a new Amazon DocumentDB cluster.
    pub fn createDbCluster(self: *Self, allocator: std.mem.Allocator, input: create_db_cluster.CreateDBClusterInput, options: create_db_cluster.Options) !create_db_cluster.CreateDBClusterOutput {
        return create_db_cluster.execute(self, allocator, input, options);
    }

    /// Creates a new cluster parameter group.
    ///
    /// Parameters in a cluster parameter group apply to all of the
    /// instances in a cluster.
    ///
    /// A cluster parameter group is initially created with the default
    /// parameters for the database engine used by instances in the cluster.
    /// In Amazon DocumentDB, you cannot make modifications directly to the
    /// `default.docdb3.6` cluster parameter group. If your
    /// Amazon DocumentDB cluster is using the default cluster parameter group and
    /// you
    /// want to modify a value in it, you must first [
    /// create a new parameter
    /// group](https://docs.aws.amazon.com/documentdb/latest/developerguide/cluster_parameter_group-create.html)
    /// or [
    /// copy an existing parameter
    /// group](https://docs.aws.amazon.com/documentdb/latest/developerguide/cluster_parameter_group-copy.html),
    /// modify it, and then apply the modified parameter group to your
    /// cluster. For the new cluster parameter group and associated settings
    /// to take effect, you must then reboot the instances in the cluster
    /// without failover. For more information,
    /// see [
    /// Modifying Amazon DocumentDB Cluster Parameter
    /// Groups](https://docs.aws.amazon.com/documentdb/latest/developerguide/cluster_parameter_group-modify.html).
    pub fn createDbClusterParameterGroup(self: *Self, allocator: std.mem.Allocator, input: create_db_cluster_parameter_group.CreateDBClusterParameterGroupInput, options: create_db_cluster_parameter_group.Options) !create_db_cluster_parameter_group.CreateDBClusterParameterGroupOutput {
        return create_db_cluster_parameter_group.execute(self, allocator, input, options);
    }

    /// Creates a snapshot of a cluster.
    pub fn createDbClusterSnapshot(self: *Self, allocator: std.mem.Allocator, input: create_db_cluster_snapshot.CreateDBClusterSnapshotInput, options: create_db_cluster_snapshot.Options) !create_db_cluster_snapshot.CreateDBClusterSnapshotOutput {
        return create_db_cluster_snapshot.execute(self, allocator, input, options);
    }

    /// Creates a new instance.
    pub fn createDbInstance(self: *Self, allocator: std.mem.Allocator, input: create_db_instance.CreateDBInstanceInput, options: create_db_instance.Options) !create_db_instance.CreateDBInstanceOutput {
        return create_db_instance.execute(self, allocator, input, options);
    }

    /// Creates a new subnet group. subnet groups must contain at least one subnet
    /// in at
    /// least two Availability Zones in the Amazon Web Services Region.
    pub fn createDbSubnetGroup(self: *Self, allocator: std.mem.Allocator, input: create_db_subnet_group.CreateDBSubnetGroupInput, options: create_db_subnet_group.Options) !create_db_subnet_group.CreateDBSubnetGroupOutput {
        return create_db_subnet_group.execute(self, allocator, input, options);
    }

    /// Creates an Amazon DocumentDB event notification subscription. This action
    /// requires a topic Amazon Resource Name (ARN) created by using the Amazon
    /// DocumentDB console, the Amazon SNS console, or the Amazon SNS API. To obtain
    /// an ARN with Amazon SNS, you must create a topic in Amazon SNS and subscribe
    /// to the topic. The ARN is displayed in the Amazon SNS console.
    ///
    /// You can specify the type of source (`SourceType`) that you want to be
    /// notified of. You can also provide a list of Amazon DocumentDB sources
    /// (`SourceIds`) that trigger the events, and you can provide a list of event
    /// categories (`EventCategories`) for events that you want to be notified of.
    /// For example, you can specify `SourceType = db-instance`, `SourceIds =
    /// mydbinstance1, mydbinstance2` and `EventCategories = Availability, Backup`.
    ///
    /// If you specify both the `SourceType` and `SourceIds` (such as `SourceType =
    /// db-instance` and `SourceIdentifier = myDBInstance1`), you are notified of
    /// all the `db-instance` events for the specified source. If you specify a
    /// `SourceType` but do not specify a `SourceIdentifier`, you receive notice of
    /// the events for that source type for all your Amazon DocumentDB sources. If
    /// you do not specify either the `SourceType` or the `SourceIdentifier`, you
    /// are notified of events generated from all Amazon DocumentDB sources
    /// belonging to your customer account.
    pub fn createEventSubscription(self: *Self, allocator: std.mem.Allocator, input: create_event_subscription.CreateEventSubscriptionInput, options: create_event_subscription.Options) !create_event_subscription.CreateEventSubscriptionOutput {
        return create_event_subscription.execute(self, allocator, input, options);
    }

    /// Creates an Amazon DocumentDB global cluster that can span multiple multiple
    /// Amazon Web Services Regions.
    /// The global cluster contains one primary cluster with read-write capability,
    /// and up-to 10 read-only secondary clusters. Global clusters uses
    /// storage-based fast replication across regions with latencies less than one
    /// second, using dedicated infrastructure with no impact to your workload’s
    /// performance.
    ///
    /// You can create a global cluster that is initially empty, and then add a
    /// primary and a secondary to it.
    /// Or you can specify an existing cluster during the create operation, and this
    /// cluster becomes the primary of the global cluster.
    ///
    /// This action only applies to Amazon DocumentDB clusters.
    pub fn createGlobalCluster(self: *Self, allocator: std.mem.Allocator, input: create_global_cluster.CreateGlobalClusterInput, options: create_global_cluster.Options) !create_global_cluster.CreateGlobalClusterOutput {
        return create_global_cluster.execute(self, allocator, input, options);
    }

    /// Deletes a previously provisioned cluster. When you delete a cluster, all
    /// automated backups for that cluster are deleted and can't be recovered.
    /// Manual DB cluster snapshots of the specified cluster are not deleted.
    pub fn deleteDbCluster(self: *Self, allocator: std.mem.Allocator, input: delete_db_cluster.DeleteDBClusterInput, options: delete_db_cluster.Options) !delete_db_cluster.DeleteDBClusterOutput {
        return delete_db_cluster.execute(self, allocator, input, options);
    }

    /// Deletes a specified cluster parameter group. The cluster parameter group to
    /// be deleted can't be associated with any clusters.
    pub fn deleteDbClusterParameterGroup(self: *Self, allocator: std.mem.Allocator, input: delete_db_cluster_parameter_group.DeleteDBClusterParameterGroupInput, options: delete_db_cluster_parameter_group.Options) !delete_db_cluster_parameter_group.DeleteDBClusterParameterGroupOutput {
        return delete_db_cluster_parameter_group.execute(self, allocator, input, options);
    }

    /// Deletes a cluster snapshot. If the snapshot is being copied, the copy
    /// operation is terminated.
    ///
    /// The cluster snapshot must be in the `available` state to be deleted.
    pub fn deleteDbClusterSnapshot(self: *Self, allocator: std.mem.Allocator, input: delete_db_cluster_snapshot.DeleteDBClusterSnapshotInput, options: delete_db_cluster_snapshot.Options) !delete_db_cluster_snapshot.DeleteDBClusterSnapshotOutput {
        return delete_db_cluster_snapshot.execute(self, allocator, input, options);
    }

    /// Deletes a previously provisioned instance.
    pub fn deleteDbInstance(self: *Self, allocator: std.mem.Allocator, input: delete_db_instance.DeleteDBInstanceInput, options: delete_db_instance.Options) !delete_db_instance.DeleteDBInstanceOutput {
        return delete_db_instance.execute(self, allocator, input, options);
    }

    /// Deletes a subnet group.
    ///
    /// The specified database subnet group must not be associated with any DB
    /// instances.
    pub fn deleteDbSubnetGroup(self: *Self, allocator: std.mem.Allocator, input: delete_db_subnet_group.DeleteDBSubnetGroupInput, options: delete_db_subnet_group.Options) !delete_db_subnet_group.DeleteDBSubnetGroupOutput {
        return delete_db_subnet_group.execute(self, allocator, input, options);
    }

    /// Deletes an Amazon DocumentDB event notification subscription.
    pub fn deleteEventSubscription(self: *Self, allocator: std.mem.Allocator, input: delete_event_subscription.DeleteEventSubscriptionInput, options: delete_event_subscription.Options) !delete_event_subscription.DeleteEventSubscriptionOutput {
        return delete_event_subscription.execute(self, allocator, input, options);
    }

    /// Deletes a global cluster. The primary and secondary clusters must already be
    /// detached or deleted before attempting to delete a global cluster.
    ///
    /// This action only applies to Amazon DocumentDB clusters.
    pub fn deleteGlobalCluster(self: *Self, allocator: std.mem.Allocator, input: delete_global_cluster.DeleteGlobalClusterInput, options: delete_global_cluster.Options) !delete_global_cluster.DeleteGlobalClusterOutput {
        return delete_global_cluster.execute(self, allocator, input, options);
    }

    /// Returns a list of certificate authority (CA) certificates provided by Amazon
    /// DocumentDB for this Amazon Web Services account.
    pub fn describeCertificates(self: *Self, allocator: std.mem.Allocator, input: describe_certificates.DescribeCertificatesInput, options: describe_certificates.Options) !describe_certificates.DescribeCertificatesOutput {
        return describe_certificates.execute(self, allocator, input, options);
    }

    /// Returns a list of `DBClusterParameterGroup` descriptions. If a
    /// `DBClusterParameterGroupName` parameter is specified, the list contains only
    /// the description of the specified cluster parameter group.
    pub fn describeDbClusterParameterGroups(self: *Self, allocator: std.mem.Allocator, input: describe_db_cluster_parameter_groups.DescribeDBClusterParameterGroupsInput, options: describe_db_cluster_parameter_groups.Options) !describe_db_cluster_parameter_groups.DescribeDBClusterParameterGroupsOutput {
        return describe_db_cluster_parameter_groups.execute(self, allocator, input, options);
    }

    /// Returns the detailed parameter list for a particular cluster parameter
    /// group.
    pub fn describeDbClusterParameters(self: *Self, allocator: std.mem.Allocator, input: describe_db_cluster_parameters.DescribeDBClusterParametersInput, options: describe_db_cluster_parameters.Options) !describe_db_cluster_parameters.DescribeDBClusterParametersOutput {
        return describe_db_cluster_parameters.execute(self, allocator, input, options);
    }

    /// Returns a list of cluster snapshot attribute names and values for a manual
    /// DB
    /// cluster snapshot.
    ///
    /// When you share snapshots with other Amazon Web Services accounts,
    /// `DescribeDBClusterSnapshotAttributes` returns the `restore` attribute and a
    /// list of IDs for the Amazon Web Services accounts that are authorized to copy
    /// or restore the manual cluster snapshot. If `all` is included in the list of
    /// values for the `restore` attribute, then the manual cluster snapshot is
    /// public and can be copied or restored by all Amazon Web Services accounts.
    pub fn describeDbClusterSnapshotAttributes(self: *Self, allocator: std.mem.Allocator, input: describe_db_cluster_snapshot_attributes.DescribeDBClusterSnapshotAttributesInput, options: describe_db_cluster_snapshot_attributes.Options) !describe_db_cluster_snapshot_attributes.DescribeDBClusterSnapshotAttributesOutput {
        return describe_db_cluster_snapshot_attributes.execute(self, allocator, input, options);
    }

    /// Returns information about cluster snapshots. This API operation supports
    /// pagination.
    pub fn describeDbClusterSnapshots(self: *Self, allocator: std.mem.Allocator, input: describe_db_cluster_snapshots.DescribeDBClusterSnapshotsInput, options: describe_db_cluster_snapshots.Options) !describe_db_cluster_snapshots.DescribeDBClusterSnapshotsOutput {
        return describe_db_cluster_snapshots.execute(self, allocator, input, options);
    }

    /// Returns information about provisioned Amazon DocumentDB clusters. This API
    /// operation supports pagination. For certain management features
    /// such as cluster and instance lifecycle management, Amazon DocumentDB
    /// leverages
    /// operational technology that is shared with Amazon RDS and Amazon
    /// Neptune. Use the `filterName=engine,Values=docdb` filter
    /// parameter to return only Amazon DocumentDB clusters.
    pub fn describeDbClusters(self: *Self, allocator: std.mem.Allocator, input: describe_db_clusters.DescribeDBClustersInput, options: describe_db_clusters.Options) !describe_db_clusters.DescribeDBClustersOutput {
        return describe_db_clusters.execute(self, allocator, input, options);
    }

    /// Returns a list of the available engines.
    pub fn describeDbEngineVersions(self: *Self, allocator: std.mem.Allocator, input: describe_db_engine_versions.DescribeDBEngineVersionsInput, options: describe_db_engine_versions.Options) !describe_db_engine_versions.DescribeDBEngineVersionsOutput {
        return describe_db_engine_versions.execute(self, allocator, input, options);
    }

    /// Returns information about provisioned Amazon DocumentDB instances. This API
    /// supports pagination.
    pub fn describeDbInstances(self: *Self, allocator: std.mem.Allocator, input: describe_db_instances.DescribeDBInstancesInput, options: describe_db_instances.Options) !describe_db_instances.DescribeDBInstancesOutput {
        return describe_db_instances.execute(self, allocator, input, options);
    }

    /// Returns a list of `DBSubnetGroup` descriptions. If a
    /// `DBSubnetGroupName` is specified, the list will contain only the
    /// descriptions of the specified `DBSubnetGroup`.
    pub fn describeDbSubnetGroups(self: *Self, allocator: std.mem.Allocator, input: describe_db_subnet_groups.DescribeDBSubnetGroupsInput, options: describe_db_subnet_groups.Options) !describe_db_subnet_groups.DescribeDBSubnetGroupsOutput {
        return describe_db_subnet_groups.execute(self, allocator, input, options);
    }

    /// Returns the default engine and system parameter information for the cluster
    /// database
    /// engine.
    pub fn describeEngineDefaultClusterParameters(self: *Self, allocator: std.mem.Allocator, input: describe_engine_default_cluster_parameters.DescribeEngineDefaultClusterParametersInput, options: describe_engine_default_cluster_parameters.Options) !describe_engine_default_cluster_parameters.DescribeEngineDefaultClusterParametersOutput {
        return describe_engine_default_cluster_parameters.execute(self, allocator, input, options);
    }

    /// Displays a list of categories for all event source types, or, if specified,
    /// for a
    /// specified source type.
    pub fn describeEventCategories(self: *Self, allocator: std.mem.Allocator, input: describe_event_categories.DescribeEventCategoriesInput, options: describe_event_categories.Options) !describe_event_categories.DescribeEventCategoriesOutput {
        return describe_event_categories.execute(self, allocator, input, options);
    }

    /// Lists all the subscription descriptions for a customer account. The
    /// description for a subscription includes `SubscriptionName`, `SNSTopicARN`,
    /// `CustomerID`, `SourceType`, `SourceID`, `CreationTime`, and `Status`.
    ///
    /// If you specify a `SubscriptionName`, lists the description for that
    /// subscription.
    pub fn describeEventSubscriptions(self: *Self, allocator: std.mem.Allocator, input: describe_event_subscriptions.DescribeEventSubscriptionsInput, options: describe_event_subscriptions.Options) !describe_event_subscriptions.DescribeEventSubscriptionsOutput {
        return describe_event_subscriptions.execute(self, allocator, input, options);
    }

    /// Returns events related to instances, security groups, snapshots, and DB
    /// parameter groups for the past 14 days. You can obtain events specific to a
    /// particular DB instance, security group, snapshot, or parameter group by
    /// providing the name as a parameter. By default, the events of the past hour
    /// are returned.
    pub fn describeEvents(self: *Self, allocator: std.mem.Allocator, input: describe_events.DescribeEventsInput, options: describe_events.Options) !describe_events.DescribeEventsOutput {
        return describe_events.execute(self, allocator, input, options);
    }

    /// Returns information about Amazon DocumentDB global clusters. This API
    /// supports pagination.
    ///
    /// This action only applies to Amazon DocumentDB clusters.
    pub fn describeGlobalClusters(self: *Self, allocator: std.mem.Allocator, input: describe_global_clusters.DescribeGlobalClustersInput, options: describe_global_clusters.Options) !describe_global_clusters.DescribeGlobalClustersOutput {
        return describe_global_clusters.execute(self, allocator, input, options);
    }

    /// Returns a list of orderable instance options for the specified engine.
    pub fn describeOrderableDbInstanceOptions(self: *Self, allocator: std.mem.Allocator, input: describe_orderable_db_instance_options.DescribeOrderableDBInstanceOptionsInput, options: describe_orderable_db_instance_options.Options) !describe_orderable_db_instance_options.DescribeOrderableDBInstanceOptionsOutput {
        return describe_orderable_db_instance_options.execute(self, allocator, input, options);
    }

    /// Returns a list of resources (for example, instances) that have at least one
    /// pending
    /// maintenance action.
    pub fn describePendingMaintenanceActions(self: *Self, allocator: std.mem.Allocator, input: describe_pending_maintenance_actions.DescribePendingMaintenanceActionsInput, options: describe_pending_maintenance_actions.Options) !describe_pending_maintenance_actions.DescribePendingMaintenanceActionsOutput {
        return describe_pending_maintenance_actions.execute(self, allocator, input, options);
    }

    /// Forces a failover for a cluster.
    ///
    /// A failover for a cluster promotes one of the Amazon DocumentDB replicas
    /// (read-only instances) in the cluster to be the primary instance (the cluster
    /// writer).
    ///
    /// If the primary instance fails, Amazon DocumentDB automatically fails over to
    /// an Amazon DocumentDB replica, if one exists. You can force a failover when
    /// you want to simulate a failure of a primary instance for testing.
    pub fn failoverDbCluster(self: *Self, allocator: std.mem.Allocator, input: failover_db_cluster.FailoverDBClusterInput, options: failover_db_cluster.Options) !failover_db_cluster.FailoverDBClusterOutput {
        return failover_db_cluster.execute(self, allocator, input, options);
    }

    /// Promotes the specified secondary DB cluster to be the primary DB cluster in
    /// the global cluster when failing over a global cluster occurs.
    ///
    /// Use this operation to respond to an unplanned event, such as a regional
    /// disaster in the primary region.
    /// Failing over can result in a loss of write transaction data that wasn't
    /// replicated to the chosen secondary before the failover event occurred.
    /// However, the recovery process that promotes a DB instance on the chosen
    /// seconday DB cluster to be the primary writer DB instance guarantees that the
    /// data is in a transactionally consistent state.
    pub fn failoverGlobalCluster(self: *Self, allocator: std.mem.Allocator, input: failover_global_cluster.FailoverGlobalClusterInput, options: failover_global_cluster.Options) !failover_global_cluster.FailoverGlobalClusterOutput {
        return failover_global_cluster.execute(self, allocator, input, options);
    }

    /// Lists all tags on an Amazon DocumentDB resource.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: list_tags_for_resource.Options) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Modifies a setting for an Amazon DocumentDB cluster. You can change one or
    /// more database
    /// configuration parameters by specifying these parameters and the new values
    /// in the
    /// request.
    pub fn modifyDbCluster(self: *Self, allocator: std.mem.Allocator, input: modify_db_cluster.ModifyDBClusterInput, options: modify_db_cluster.Options) !modify_db_cluster.ModifyDBClusterOutput {
        return modify_db_cluster.execute(self, allocator, input, options);
    }

    /// Modifies the parameters of a cluster parameter group. To modify more than
    /// one
    /// parameter, submit a list of the following: `ParameterName`,
    /// `ParameterValue`, and `ApplyMethod`. A maximum of 20
    /// parameters can be modified in a single request.
    ///
    /// Changes to dynamic parameters are applied immediately. Changes to static
    /// parameters require a reboot or maintenance window
    ///
    /// before the change can take effect.
    ///
    /// After you create a cluster parameter group, you should wait at least 5
    /// minutes
    /// before creating your first cluster that uses that cluster parameter group as
    /// the default parameter group. This allows Amazon DocumentDB to fully complete
    /// the create action
    /// before the parameter group is used as the default for a new cluster. This
    /// step is
    /// especially important for parameters that are critical when creating the
    /// default
    /// database for a cluster, such as the character set for the default database
    /// defined by the `character_set_database` parameter.
    pub fn modifyDbClusterParameterGroup(self: *Self, allocator: std.mem.Allocator, input: modify_db_cluster_parameter_group.ModifyDBClusterParameterGroupInput, options: modify_db_cluster_parameter_group.Options) !modify_db_cluster_parameter_group.ModifyDBClusterParameterGroupOutput {
        return modify_db_cluster_parameter_group.execute(self, allocator, input, options);
    }

    /// Adds an attribute and values to, or removes an attribute and values from, a
    /// manual cluster snapshot.
    ///
    /// To share a manual cluster snapshot with other Amazon Web Services accounts,
    /// specify `restore` as the `AttributeName`, and use the `ValuesToAdd`
    /// parameter to add a list of IDs of the Amazon Web Services accounts that are
    /// authorized to restore the manual cluster snapshot. Use the value `all` to
    /// make the manual cluster snapshot public, which means that it can be copied
    /// or restored by all Amazon Web Services accounts. Do not add the `all` value
    /// for any manual cluster snapshots that contain private information that you
    /// don't want available to all Amazon Web Services accounts. If a manual
    /// cluster snapshot is encrypted, it can be shared, but only by specifying a
    /// list of authorized Amazon Web Services account IDs for the `ValuesToAdd`
    /// parameter. You can't use `all` as a value for that parameter in this case.
    pub fn modifyDbClusterSnapshotAttribute(self: *Self, allocator: std.mem.Allocator, input: modify_db_cluster_snapshot_attribute.ModifyDBClusterSnapshotAttributeInput, options: modify_db_cluster_snapshot_attribute.Options) !modify_db_cluster_snapshot_attribute.ModifyDBClusterSnapshotAttributeOutput {
        return modify_db_cluster_snapshot_attribute.execute(self, allocator, input, options);
    }

    /// Modifies settings for an instance. You can change one or more database
    /// configuration parameters by specifying these parameters and the new values
    /// in the request.
    pub fn modifyDbInstance(self: *Self, allocator: std.mem.Allocator, input: modify_db_instance.ModifyDBInstanceInput, options: modify_db_instance.Options) !modify_db_instance.ModifyDBInstanceOutput {
        return modify_db_instance.execute(self, allocator, input, options);
    }

    /// Modifies an existing subnet group. subnet groups must contain at least one
    /// subnet in at least two Availability Zones in the Amazon Web Services Region.
    pub fn modifyDbSubnetGroup(self: *Self, allocator: std.mem.Allocator, input: modify_db_subnet_group.ModifyDBSubnetGroupInput, options: modify_db_subnet_group.Options) !modify_db_subnet_group.ModifyDBSubnetGroupOutput {
        return modify_db_subnet_group.execute(self, allocator, input, options);
    }

    /// Modifies an existing Amazon DocumentDB event notification subscription.
    pub fn modifyEventSubscription(self: *Self, allocator: std.mem.Allocator, input: modify_event_subscription.ModifyEventSubscriptionInput, options: modify_event_subscription.Options) !modify_event_subscription.ModifyEventSubscriptionOutput {
        return modify_event_subscription.execute(self, allocator, input, options);
    }

    /// Modify a setting for an Amazon DocumentDB global cluster. You can change one
    /// or more configuration parameters (for example: deletion protection), or the
    /// global cluster identifier by specifying these parameters and the new values
    /// in the request.
    ///
    /// This action only applies to Amazon DocumentDB clusters.
    pub fn modifyGlobalCluster(self: *Self, allocator: std.mem.Allocator, input: modify_global_cluster.ModifyGlobalClusterInput, options: modify_global_cluster.Options) !modify_global_cluster.ModifyGlobalClusterOutput {
        return modify_global_cluster.execute(self, allocator, input, options);
    }

    /// You might need to reboot your instance, usually for maintenance reasons. For
    /// example, if you make certain changes, or if you change the cluster parameter
    /// group
    /// that is associated with the instance, you must reboot the instance for the
    /// changes to
    /// take effect.
    ///
    /// Rebooting an instance restarts the database engine service. Rebooting an
    /// instance
    /// results in a momentary outage, during which the instance status is set to
    /// *rebooting*.
    pub fn rebootDbInstance(self: *Self, allocator: std.mem.Allocator, input: reboot_db_instance.RebootDBInstanceInput, options: reboot_db_instance.Options) !reboot_db_instance.RebootDBInstanceOutput {
        return reboot_db_instance.execute(self, allocator, input, options);
    }

    /// Detaches an Amazon DocumentDB secondary cluster from a global cluster. The
    /// cluster becomes a standalone cluster with read-write capability instead of
    /// being read-only and receiving data from a primary in a different region.
    ///
    /// This action only applies to Amazon DocumentDB clusters.
    pub fn removeFromGlobalCluster(self: *Self, allocator: std.mem.Allocator, input: remove_from_global_cluster.RemoveFromGlobalClusterInput, options: remove_from_global_cluster.Options) !remove_from_global_cluster.RemoveFromGlobalClusterOutput {
        return remove_from_global_cluster.execute(self, allocator, input, options);
    }

    /// Removes a source identifier from an existing Amazon DocumentDB event
    /// notification
    /// subscription.
    pub fn removeSourceIdentifierFromSubscription(self: *Self, allocator: std.mem.Allocator, input: remove_source_identifier_from_subscription.RemoveSourceIdentifierFromSubscriptionInput, options: remove_source_identifier_from_subscription.Options) !remove_source_identifier_from_subscription.RemoveSourceIdentifierFromSubscriptionOutput {
        return remove_source_identifier_from_subscription.execute(self, allocator, input, options);
    }

    /// Removes metadata tags from an Amazon DocumentDB resource.
    pub fn removeTagsFromResource(self: *Self, allocator: std.mem.Allocator, input: remove_tags_from_resource.RemoveTagsFromResourceInput, options: remove_tags_from_resource.Options) !remove_tags_from_resource.RemoveTagsFromResourceOutput {
        return remove_tags_from_resource.execute(self, allocator, input, options);
    }

    /// Modifies the parameters of a cluster parameter group to the default value.
    /// To
    /// reset specific parameters, submit a list of the following: `ParameterName`
    /// and `ApplyMethod`. To reset the entire cluster parameter group, specify
    /// the `DBClusterParameterGroupName` and `ResetAllParameters`
    /// parameters.
    ///
    /// When you reset the entire group, dynamic parameters are updated immediately
    /// and
    /// static parameters are set to `pending-reboot` to take effect on the next DB
    /// instance reboot.
    pub fn resetDbClusterParameterGroup(self: *Self, allocator: std.mem.Allocator, input: reset_db_cluster_parameter_group.ResetDBClusterParameterGroupInput, options: reset_db_cluster_parameter_group.Options) !reset_db_cluster_parameter_group.ResetDBClusterParameterGroupOutput {
        return reset_db_cluster_parameter_group.execute(self, allocator, input, options);
    }

    /// Creates a new cluster from a snapshot or cluster snapshot.
    ///
    /// If a snapshot is specified, the target cluster is created from the source DB
    /// snapshot with a default configuration and default security group.
    ///
    /// If a cluster snapshot is specified, the target cluster is created from the
    /// source cluster restore point with the same configuration as the original
    /// source DB cluster, except that the new cluster is created with the default
    /// security group.
    pub fn restoreDbClusterFromSnapshot(self: *Self, allocator: std.mem.Allocator, input: restore_db_cluster_from_snapshot.RestoreDBClusterFromSnapshotInput, options: restore_db_cluster_from_snapshot.Options) !restore_db_cluster_from_snapshot.RestoreDBClusterFromSnapshotOutput {
        return restore_db_cluster_from_snapshot.execute(self, allocator, input, options);
    }

    /// Restores a cluster to an arbitrary point in time. Users can restore to any
    /// point in
    /// time before `LatestRestorableTime` for up to
    /// `BackupRetentionPeriod` days. The target cluster is created from the
    /// source cluster with the same configuration as the original cluster, except
    /// that
    /// the new cluster is created with the default security group.
    pub fn restoreDbClusterToPointInTime(self: *Self, allocator: std.mem.Allocator, input: restore_db_cluster_to_point_in_time.RestoreDBClusterToPointInTimeInput, options: restore_db_cluster_to_point_in_time.Options) !restore_db_cluster_to_point_in_time.RestoreDBClusterToPointInTimeOutput {
        return restore_db_cluster_to_point_in_time.execute(self, allocator, input, options);
    }

    /// Restarts the stopped cluster that is specified by `DBClusterIdentifier`.
    /// For more information, see [Stopping and
    /// Starting an Amazon DocumentDB
    /// Cluster](https://docs.aws.amazon.com/documentdb/latest/developerguide/db-cluster-stop-start.html).
    pub fn startDbCluster(self: *Self, allocator: std.mem.Allocator, input: start_db_cluster.StartDBClusterInput, options: start_db_cluster.Options) !start_db_cluster.StartDBClusterOutput {
        return start_db_cluster.execute(self, allocator, input, options);
    }

    /// Stops the running cluster that is specified by `DBClusterIdentifier`. The
    /// cluster must be in the *available* state. For more information, see
    /// [Stopping and
    /// Starting an Amazon DocumentDB
    /// Cluster](https://docs.aws.amazon.com/documentdb/latest/developerguide/db-cluster-stop-start.html).
    pub fn stopDbCluster(self: *Self, allocator: std.mem.Allocator, input: stop_db_cluster.StopDBClusterInput, options: stop_db_cluster.Options) !stop_db_cluster.StopDBClusterOutput {
        return stop_db_cluster.execute(self, allocator, input, options);
    }

    /// Switches over the specified secondary Amazon DocumentDB cluster to be the
    /// new primary Amazon DocumentDB cluster in the global database cluster.
    pub fn switchoverGlobalCluster(self: *Self, allocator: std.mem.Allocator, input: switchover_global_cluster.SwitchoverGlobalClusterInput, options: switchover_global_cluster.Options) !switchover_global_cluster.SwitchoverGlobalClusterOutput {
        return switchover_global_cluster.execute(self, allocator, input, options);
    }

    pub fn describeCertificatesPaginator(self: *Self, params: describe_certificates.DescribeCertificatesInput) paginator.DescribeCertificatesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeDbClusterParameterGroupsPaginator(self: *Self, params: describe_db_cluster_parameter_groups.DescribeDBClusterParameterGroupsInput) paginator.DescribeDBClusterParameterGroupsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeDbClusterParametersPaginator(self: *Self, params: describe_db_cluster_parameters.DescribeDBClusterParametersInput) paginator.DescribeDBClusterParametersPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeDbClusterSnapshotsPaginator(self: *Self, params: describe_db_cluster_snapshots.DescribeDBClusterSnapshotsInput) paginator.DescribeDBClusterSnapshotsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeDbClustersPaginator(self: *Self, params: describe_db_clusters.DescribeDBClustersInput) paginator.DescribeDBClustersPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeDbEngineVersionsPaginator(self: *Self, params: describe_db_engine_versions.DescribeDBEngineVersionsInput) paginator.DescribeDBEngineVersionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeDbInstancesPaginator(self: *Self, params: describe_db_instances.DescribeDBInstancesInput) paginator.DescribeDBInstancesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeDbSubnetGroupsPaginator(self: *Self, params: describe_db_subnet_groups.DescribeDBSubnetGroupsInput) paginator.DescribeDBSubnetGroupsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeEventSubscriptionsPaginator(self: *Self, params: describe_event_subscriptions.DescribeEventSubscriptionsInput) paginator.DescribeEventSubscriptionsPaginator {
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

    pub fn describeGlobalClustersPaginator(self: *Self, params: describe_global_clusters.DescribeGlobalClustersInput) paginator.DescribeGlobalClustersPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeOrderableDbInstanceOptionsPaginator(self: *Self, params: describe_orderable_db_instance_options.DescribeOrderableDBInstanceOptionsInput) paginator.DescribeOrderableDBInstanceOptionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describePendingMaintenanceActionsPaginator(self: *Self, params: describe_pending_maintenance_actions.DescribePendingMaintenanceActionsInput) paginator.DescribePendingMaintenanceActionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn waitUntilDBInstanceDeleted(self: *Self, params: describe_db_instances.DescribeDBInstancesInput) aws.waiter.WaiterError!void {
        var w = waiters.DBInstanceDeletedWaiter{ .client = self, .params = params };
        return w.wait();
    }
};
