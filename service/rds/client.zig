const aws = @import("aws");
const std = @import("std");

const add_role_to_db_cluster = @import("add_role_to_db_cluster.zig");
const add_role_to_db_instance = @import("add_role_to_db_instance.zig");
const add_source_identifier_to_subscription = @import("add_source_identifier_to_subscription.zig");
const add_tags_to_resource = @import("add_tags_to_resource.zig");
const apply_pending_maintenance_action = @import("apply_pending_maintenance_action.zig");
const authorize_db_security_group_ingress = @import("authorize_db_security_group_ingress.zig");
const backtrack_db_cluster = @import("backtrack_db_cluster.zig");
const cancel_export_task = @import("cancel_export_task.zig");
const copy_db_cluster_parameter_group = @import("copy_db_cluster_parameter_group.zig");
const copy_db_cluster_snapshot = @import("copy_db_cluster_snapshot.zig");
const copy_db_parameter_group = @import("copy_db_parameter_group.zig");
const copy_db_snapshot = @import("copy_db_snapshot.zig");
const copy_option_group = @import("copy_option_group.zig");
const create_blue_green_deployment = @import("create_blue_green_deployment.zig");
const create_custom_db_engine_version = @import("create_custom_db_engine_version.zig");
const create_db_cluster = @import("create_db_cluster.zig");
const create_db_cluster_endpoint = @import("create_db_cluster_endpoint.zig");
const create_db_cluster_parameter_group = @import("create_db_cluster_parameter_group.zig");
const create_db_cluster_snapshot = @import("create_db_cluster_snapshot.zig");
const create_db_instance = @import("create_db_instance.zig");
const create_db_instance_read_replica = @import("create_db_instance_read_replica.zig");
const create_db_parameter_group = @import("create_db_parameter_group.zig");
const create_db_proxy = @import("create_db_proxy.zig");
const create_db_proxy_endpoint = @import("create_db_proxy_endpoint.zig");
const create_db_security_group = @import("create_db_security_group.zig");
const create_db_shard_group = @import("create_db_shard_group.zig");
const create_db_snapshot = @import("create_db_snapshot.zig");
const create_db_subnet_group = @import("create_db_subnet_group.zig");
const create_event_subscription = @import("create_event_subscription.zig");
const create_global_cluster = @import("create_global_cluster.zig");
const create_integration = @import("create_integration.zig");
const create_option_group = @import("create_option_group.zig");
const create_tenant_database = @import("create_tenant_database.zig");
const delete_blue_green_deployment = @import("delete_blue_green_deployment.zig");
const delete_custom_db_engine_version = @import("delete_custom_db_engine_version.zig");
const delete_db_cluster = @import("delete_db_cluster.zig");
const delete_db_cluster_automated_backup = @import("delete_db_cluster_automated_backup.zig");
const delete_db_cluster_endpoint = @import("delete_db_cluster_endpoint.zig");
const delete_db_cluster_parameter_group = @import("delete_db_cluster_parameter_group.zig");
const delete_db_cluster_snapshot = @import("delete_db_cluster_snapshot.zig");
const delete_db_instance = @import("delete_db_instance.zig");
const delete_db_instance_automated_backup = @import("delete_db_instance_automated_backup.zig");
const delete_db_parameter_group = @import("delete_db_parameter_group.zig");
const delete_db_proxy = @import("delete_db_proxy.zig");
const delete_db_proxy_endpoint = @import("delete_db_proxy_endpoint.zig");
const delete_db_security_group = @import("delete_db_security_group.zig");
const delete_db_shard_group = @import("delete_db_shard_group.zig");
const delete_db_snapshot = @import("delete_db_snapshot.zig");
const delete_db_subnet_group = @import("delete_db_subnet_group.zig");
const delete_event_subscription = @import("delete_event_subscription.zig");
const delete_global_cluster = @import("delete_global_cluster.zig");
const delete_integration = @import("delete_integration.zig");
const delete_option_group = @import("delete_option_group.zig");
const delete_tenant_database = @import("delete_tenant_database.zig");
const deregister_db_proxy_targets = @import("deregister_db_proxy_targets.zig");
const describe_account_attributes = @import("describe_account_attributes.zig");
const describe_blue_green_deployments = @import("describe_blue_green_deployments.zig");
const describe_certificates = @import("describe_certificates.zig");
const describe_db_cluster_automated_backups = @import("describe_db_cluster_automated_backups.zig");
const describe_db_cluster_backtracks = @import("describe_db_cluster_backtracks.zig");
const describe_db_cluster_endpoints = @import("describe_db_cluster_endpoints.zig");
const describe_db_cluster_parameter_groups = @import("describe_db_cluster_parameter_groups.zig");
const describe_db_cluster_parameters = @import("describe_db_cluster_parameters.zig");
const describe_db_cluster_snapshot_attributes = @import("describe_db_cluster_snapshot_attributes.zig");
const describe_db_cluster_snapshots = @import("describe_db_cluster_snapshots.zig");
const describe_db_clusters = @import("describe_db_clusters.zig");
const describe_db_engine_versions = @import("describe_db_engine_versions.zig");
const describe_db_instance_automated_backups = @import("describe_db_instance_automated_backups.zig");
const describe_db_instances = @import("describe_db_instances.zig");
const describe_db_log_files = @import("describe_db_log_files.zig");
const describe_db_major_engine_versions = @import("describe_db_major_engine_versions.zig");
const describe_db_parameter_groups = @import("describe_db_parameter_groups.zig");
const describe_db_parameters = @import("describe_db_parameters.zig");
const describe_db_proxies = @import("describe_db_proxies.zig");
const describe_db_proxy_endpoints = @import("describe_db_proxy_endpoints.zig");
const describe_db_proxy_target_groups = @import("describe_db_proxy_target_groups.zig");
const describe_db_proxy_targets = @import("describe_db_proxy_targets.zig");
const describe_db_recommendations = @import("describe_db_recommendations.zig");
const describe_db_security_groups = @import("describe_db_security_groups.zig");
const describe_db_shard_groups = @import("describe_db_shard_groups.zig");
const describe_db_snapshot_attributes = @import("describe_db_snapshot_attributes.zig");
const describe_db_snapshot_tenant_databases = @import("describe_db_snapshot_tenant_databases.zig");
const describe_db_snapshots = @import("describe_db_snapshots.zig");
const describe_db_subnet_groups = @import("describe_db_subnet_groups.zig");
const describe_engine_default_cluster_parameters = @import("describe_engine_default_cluster_parameters.zig");
const describe_engine_default_parameters = @import("describe_engine_default_parameters.zig");
const describe_event_categories = @import("describe_event_categories.zig");
const describe_event_subscriptions = @import("describe_event_subscriptions.zig");
const describe_events = @import("describe_events.zig");
const describe_export_tasks = @import("describe_export_tasks.zig");
const describe_global_clusters = @import("describe_global_clusters.zig");
const describe_integrations = @import("describe_integrations.zig");
const describe_option_group_options = @import("describe_option_group_options.zig");
const describe_option_groups = @import("describe_option_groups.zig");
const describe_orderable_db_instance_options = @import("describe_orderable_db_instance_options.zig");
const describe_pending_maintenance_actions = @import("describe_pending_maintenance_actions.zig");
const describe_reserved_db_instances = @import("describe_reserved_db_instances.zig");
const describe_reserved_db_instances_offerings = @import("describe_reserved_db_instances_offerings.zig");
const describe_source_regions = @import("describe_source_regions.zig");
const describe_tenant_databases = @import("describe_tenant_databases.zig");
const describe_valid_db_instance_modifications = @import("describe_valid_db_instance_modifications.zig");
const disable_http_endpoint = @import("disable_http_endpoint.zig");
const download_db_log_file_portion = @import("download_db_log_file_portion.zig");
const enable_http_endpoint = @import("enable_http_endpoint.zig");
const failover_db_cluster = @import("failover_db_cluster.zig");
const failover_global_cluster = @import("failover_global_cluster.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const modify_activity_stream = @import("modify_activity_stream.zig");
const modify_certificates = @import("modify_certificates.zig");
const modify_current_db_cluster_capacity = @import("modify_current_db_cluster_capacity.zig");
const modify_custom_db_engine_version = @import("modify_custom_db_engine_version.zig");
const modify_db_cluster = @import("modify_db_cluster.zig");
const modify_db_cluster_endpoint = @import("modify_db_cluster_endpoint.zig");
const modify_db_cluster_parameter_group = @import("modify_db_cluster_parameter_group.zig");
const modify_db_cluster_snapshot_attribute = @import("modify_db_cluster_snapshot_attribute.zig");
const modify_db_instance = @import("modify_db_instance.zig");
const modify_db_parameter_group = @import("modify_db_parameter_group.zig");
const modify_db_proxy = @import("modify_db_proxy.zig");
const modify_db_proxy_endpoint = @import("modify_db_proxy_endpoint.zig");
const modify_db_proxy_target_group = @import("modify_db_proxy_target_group.zig");
const modify_db_recommendation = @import("modify_db_recommendation.zig");
const modify_db_shard_group = @import("modify_db_shard_group.zig");
const modify_db_snapshot = @import("modify_db_snapshot.zig");
const modify_db_snapshot_attribute = @import("modify_db_snapshot_attribute.zig");
const modify_db_subnet_group = @import("modify_db_subnet_group.zig");
const modify_event_subscription = @import("modify_event_subscription.zig");
const modify_global_cluster = @import("modify_global_cluster.zig");
const modify_integration = @import("modify_integration.zig");
const modify_option_group = @import("modify_option_group.zig");
const modify_tenant_database = @import("modify_tenant_database.zig");
const promote_read_replica = @import("promote_read_replica.zig");
const promote_read_replica_db_cluster = @import("promote_read_replica_db_cluster.zig");
const purchase_reserved_db_instances_offering = @import("purchase_reserved_db_instances_offering.zig");
const reboot_db_cluster = @import("reboot_db_cluster.zig");
const reboot_db_instance = @import("reboot_db_instance.zig");
const reboot_db_shard_group = @import("reboot_db_shard_group.zig");
const register_db_proxy_targets = @import("register_db_proxy_targets.zig");
const remove_from_global_cluster = @import("remove_from_global_cluster.zig");
const remove_role_from_db_cluster = @import("remove_role_from_db_cluster.zig");
const remove_role_from_db_instance = @import("remove_role_from_db_instance.zig");
const remove_source_identifier_from_subscription = @import("remove_source_identifier_from_subscription.zig");
const remove_tags_from_resource = @import("remove_tags_from_resource.zig");
const reset_db_cluster_parameter_group = @import("reset_db_cluster_parameter_group.zig");
const reset_db_parameter_group = @import("reset_db_parameter_group.zig");
const restore_db_cluster_from_s3 = @import("restore_db_cluster_from_s3.zig");
const restore_db_cluster_from_snapshot = @import("restore_db_cluster_from_snapshot.zig");
const restore_db_cluster_to_point_in_time = @import("restore_db_cluster_to_point_in_time.zig");
const restore_db_instance_from_db_snapshot = @import("restore_db_instance_from_db_snapshot.zig");
const restore_db_instance_from_s3 = @import("restore_db_instance_from_s3.zig");
const restore_db_instance_to_point_in_time = @import("restore_db_instance_to_point_in_time.zig");
const revoke_db_security_group_ingress = @import("revoke_db_security_group_ingress.zig");
const start_activity_stream = @import("start_activity_stream.zig");
const start_db_cluster = @import("start_db_cluster.zig");
const start_db_instance = @import("start_db_instance.zig");
const start_db_instance_automated_backups_replication = @import("start_db_instance_automated_backups_replication.zig");
const start_export_task = @import("start_export_task.zig");
const stop_activity_stream = @import("stop_activity_stream.zig");
const stop_db_cluster = @import("stop_db_cluster.zig");
const stop_db_instance = @import("stop_db_instance.zig");
const stop_db_instance_automated_backups_replication = @import("stop_db_instance_automated_backups_replication.zig");
const switchover_blue_green_deployment = @import("switchover_blue_green_deployment.zig");
const switchover_global_cluster = @import("switchover_global_cluster.zig");
const switchover_read_replica = @import("switchover_read_replica.zig");
const paginator = @import("paginator.zig");
const waiters = @import("waiters.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "RDS";

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

    /// Associates an Identity and Access Management (IAM) role with a DB cluster.
    pub fn addRoleToDbCluster(self: *Self, allocator: std.mem.Allocator, input: add_role_to_db_cluster.AddRoleToDBClusterInput, options: add_role_to_db_cluster.Options) !add_role_to_db_cluster.AddRoleToDBClusterOutput {
        return add_role_to_db_cluster.execute(self, allocator, input, options);
    }

    /// Associates an Amazon Web Services Identity and Access Management (IAM) role
    /// with a DB instance.
    ///
    /// To add a role to a DB instance, the status of the DB instance must be
    /// `available`.
    ///
    /// This command doesn't apply to RDS Custom.
    pub fn addRoleToDbInstance(self: *Self, allocator: std.mem.Allocator, input: add_role_to_db_instance.AddRoleToDBInstanceInput, options: add_role_to_db_instance.Options) !add_role_to_db_instance.AddRoleToDBInstanceOutput {
        return add_role_to_db_instance.execute(self, allocator, input, options);
    }

    /// Adds a source identifier to an existing RDS event notification subscription.
    pub fn addSourceIdentifierToSubscription(self: *Self, allocator: std.mem.Allocator, input: add_source_identifier_to_subscription.AddSourceIdentifierToSubscriptionInput, options: add_source_identifier_to_subscription.Options) !add_source_identifier_to_subscription.AddSourceIdentifierToSubscriptionOutput {
        return add_source_identifier_to_subscription.execute(self, allocator, input, options);
    }

    /// Adds metadata tags to an Amazon RDS resource. These tags can also be used
    /// with cost allocation reporting to track cost associated with Amazon RDS
    /// resources, or used in a Condition statement in an IAM policy for Amazon RDS.
    ///
    /// For an overview on tagging your relational database resources, see [Tagging
    /// Amazon RDS
    /// Resources](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_Tagging.html) or [Tagging Amazon Aurora and Amazon RDS Resources](https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/USER_Tagging.html).
    pub fn addTagsToResource(self: *Self, allocator: std.mem.Allocator, input: add_tags_to_resource.AddTagsToResourceInput, options: add_tags_to_resource.Options) !add_tags_to_resource.AddTagsToResourceOutput {
        return add_tags_to_resource.execute(self, allocator, input, options);
    }

    /// Applies a pending maintenance action to a resource (for example, to a DB
    /// instance).
    pub fn applyPendingMaintenanceAction(self: *Self, allocator: std.mem.Allocator, input: apply_pending_maintenance_action.ApplyPendingMaintenanceActionInput, options: apply_pending_maintenance_action.Options) !apply_pending_maintenance_action.ApplyPendingMaintenanceActionOutput {
        return apply_pending_maintenance_action.execute(self, allocator, input, options);
    }

    /// Enables ingress to a DBSecurityGroup using one of two forms of
    /// authorization. First, EC2 or VPC security groups can be added to the
    /// DBSecurityGroup if the application using the database is running on EC2 or
    /// VPC instances. Second, IP ranges are available if the application accessing
    /// your database is running on the internet. Required parameters for this API
    /// are one of CIDR range, EC2SecurityGroupId for VPC, or
    /// (EC2SecurityGroupOwnerId and either EC2SecurityGroupName or
    /// EC2SecurityGroupId for non-VPC).
    ///
    /// You can't authorize ingress from an EC2 security group in one Amazon Web
    /// Services Region to an Amazon RDS DB instance in another. You can't authorize
    /// ingress from a VPC security group in one VPC to an Amazon RDS DB instance in
    /// another.
    ///
    /// For an overview of CIDR ranges, go to the [Wikipedia
    /// Tutorial](http://en.wikipedia.org/wiki/Classless_Inter-Domain_Routing).
    ///
    /// EC2-Classic was retired on August 15, 2022. If you haven't migrated from
    /// EC2-Classic to a VPC, we recommend that you migrate as soon as possible. For
    /// more information, see [Migrate from EC2-Classic to a
    /// VPC](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/vpc-migrate.html)
    /// in the *Amazon EC2 User Guide*, the blog [EC2-Classic Networking is Retiring
    /// – Here’s How to
    /// Prepare](http://aws.amazon.com/blogs/aws/ec2-classic-is-retiring-heres-how-to-prepare/), and [Moving a DB instance not in a VPC into a VPC](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_VPC.Non-VPC2VPC.html) in the *Amazon RDS User Guide*.
    pub fn authorizeDbSecurityGroupIngress(self: *Self, allocator: std.mem.Allocator, input: authorize_db_security_group_ingress.AuthorizeDBSecurityGroupIngressInput, options: authorize_db_security_group_ingress.Options) !authorize_db_security_group_ingress.AuthorizeDBSecurityGroupIngressOutput {
        return authorize_db_security_group_ingress.execute(self, allocator, input, options);
    }

    /// Backtracks a DB cluster to a specific time, without creating a new DB
    /// cluster.
    ///
    /// For more information on backtracking, see [ Backtracking an Aurora DB
    /// Cluster](https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/AuroraMySQL.Managing.Backtrack.html) in the *Amazon Aurora User Guide*.
    ///
    /// This action applies only to Aurora MySQL DB clusters.
    pub fn backtrackDbCluster(self: *Self, allocator: std.mem.Allocator, input: backtrack_db_cluster.BacktrackDBClusterInput, options: backtrack_db_cluster.Options) !backtrack_db_cluster.BacktrackDBClusterOutput {
        return backtrack_db_cluster.execute(self, allocator, input, options);
    }

    /// Cancels an export task in progress that is exporting a snapshot or cluster
    /// to Amazon S3. Any data that has already been written to the S3 bucket isn't
    /// removed.
    pub fn cancelExportTask(self: *Self, allocator: std.mem.Allocator, input: cancel_export_task.CancelExportTaskInput, options: cancel_export_task.Options) !cancel_export_task.CancelExportTaskOutput {
        return cancel_export_task.execute(self, allocator, input, options);
    }

    /// Copies the specified DB cluster parameter group.
    ///
    /// You can't copy a default DB cluster parameter group. Instead, create a new
    /// custom DB cluster parameter group, which copies the default parameters and
    /// values for the specified DB cluster parameter group family.
    pub fn copyDbClusterParameterGroup(self: *Self, allocator: std.mem.Allocator, input: copy_db_cluster_parameter_group.CopyDBClusterParameterGroupInput, options: copy_db_cluster_parameter_group.Options) !copy_db_cluster_parameter_group.CopyDBClusterParameterGroupOutput {
        return copy_db_cluster_parameter_group.execute(self, allocator, input, options);
    }

    /// Copies a snapshot of a DB cluster.
    ///
    /// To copy a DB cluster snapshot from a shared manual DB cluster snapshot,
    /// `SourceDBClusterSnapshotIdentifier` must be the Amazon Resource Name (ARN)
    /// of the shared DB cluster snapshot.
    ///
    /// You can copy an encrypted DB cluster snapshot from another Amazon Web
    /// Services Region. In that case, the Amazon Web Services Region where you call
    /// the `CopyDBClusterSnapshot` operation is the destination Amazon Web Services
    /// Region for the encrypted DB cluster snapshot to be copied to. To copy an
    /// encrypted DB cluster snapshot from another Amazon Web Services Region, you
    /// must provide the following values:
    ///
    /// * `KmsKeyId` - The Amazon Web Services Key Management System (Amazon Web
    ///   Services KMS) key identifier for the key to use to encrypt the copy of the
    ///   DB cluster snapshot in the destination Amazon Web Services Region.
    /// * `TargetDBClusterSnapshotIdentifier` - The identifier for the new copy of
    ///   the DB cluster snapshot in the destination Amazon Web Services Region.
    /// * `SourceDBClusterSnapshotIdentifier` - The DB cluster snapshot identifier
    ///   for the encrypted DB cluster snapshot to be copied. This identifier must
    ///   be in the ARN format for the source Amazon Web Services Region and is the
    ///   same value as the `SourceDBClusterSnapshotIdentifier` in the presigned
    ///   URL.
    ///
    /// To cancel the copy operation once it is in progress, delete the target DB
    /// cluster snapshot identified by `TargetDBClusterSnapshotIdentifier` while
    /// that DB cluster snapshot is in "copying" status.
    ///
    /// For more information on copying encrypted Amazon Aurora DB cluster snapshots
    /// from one Amazon Web Services Region to another, see [ Copying a
    /// Snapshot](https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/USER_CopySnapshot.html) in the *Amazon Aurora User Guide*.
    ///
    /// For more information on Amazon Aurora DB clusters, see [ What is Amazon
    /// Aurora?](https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/CHAP_AuroraOverview.html) in the *Amazon Aurora User Guide*.
    ///
    /// For more information on Multi-AZ DB clusters, see [ Multi-AZ DB cluster
    /// deployments](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/multi-az-db-clusters-concepts.html) in the *Amazon RDS User Guide*.
    pub fn copyDbClusterSnapshot(self: *Self, allocator: std.mem.Allocator, input: copy_db_cluster_snapshot.CopyDBClusterSnapshotInput, options: copy_db_cluster_snapshot.Options) !copy_db_cluster_snapshot.CopyDBClusterSnapshotOutput {
        return copy_db_cluster_snapshot.execute(self, allocator, input, options);
    }

    /// Copies the specified DB parameter group.
    ///
    /// You can't copy a default DB parameter group. Instead, create a new custom DB
    /// parameter group, which copies the default parameters and values for the
    /// specified DB parameter group family.
    pub fn copyDbParameterGroup(self: *Self, allocator: std.mem.Allocator, input: copy_db_parameter_group.CopyDBParameterGroupInput, options: copy_db_parameter_group.Options) !copy_db_parameter_group.CopyDBParameterGroupOutput {
        return copy_db_parameter_group.execute(self, allocator, input, options);
    }

    /// Copies the specified DB snapshot. The source DB snapshot must be in the
    /// `available` state.
    ///
    /// You can copy a snapshot from one Amazon Web Services Region to another. In
    /// that case, the Amazon Web Services Region where you call the
    /// `CopyDBSnapshot` operation is the destination Amazon Web Services Region for
    /// the DB snapshot copy.
    ///
    /// This command doesn't apply to RDS Custom.
    ///
    /// For more information about copying snapshots, see [Copying a DB
    /// Snapshot](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_CopySnapshot.html#USER_CopyDBSnapshot) in the *Amazon RDS User Guide*.
    pub fn copyDbSnapshot(self: *Self, allocator: std.mem.Allocator, input: copy_db_snapshot.CopyDBSnapshotInput, options: copy_db_snapshot.Options) !copy_db_snapshot.CopyDBSnapshotOutput {
        return copy_db_snapshot.execute(self, allocator, input, options);
    }

    /// Copies the specified option group.
    pub fn copyOptionGroup(self: *Self, allocator: std.mem.Allocator, input: copy_option_group.CopyOptionGroupInput, options: copy_option_group.Options) !copy_option_group.CopyOptionGroupOutput {
        return copy_option_group.execute(self, allocator, input, options);
    }

    /// Creates a blue/green deployment.
    ///
    /// A blue/green deployment creates a staging environment that copies the
    /// production environment. In a blue/green deployment, the blue environment is
    /// the current production environment. The green environment is the staging
    /// environment, and it stays in sync with the current production environment.
    ///
    /// You can make changes to the databases in the green environment without
    /// affecting production workloads. For example, you can upgrade the major or
    /// minor DB engine version, change database parameters, or make schema changes
    /// in the staging environment. You can thoroughly test changes in the green
    /// environment. When ready, you can switch over the environments to promote the
    /// green environment to be the new production environment. The switchover
    /// typically takes under a minute.
    ///
    /// For more information, see [Using Amazon RDS Blue/Green Deployments for
    /// database
    /// updates](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/blue-green-deployments.html) in the *Amazon RDS User Guide* and [ Using Amazon RDS Blue/Green Deployments for database updates](https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/blue-green-deployments.html) in the *Amazon Aurora User Guide*.
    pub fn createBlueGreenDeployment(self: *Self, allocator: std.mem.Allocator, input: create_blue_green_deployment.CreateBlueGreenDeploymentInput, options: create_blue_green_deployment.Options) !create_blue_green_deployment.CreateBlueGreenDeploymentOutput {
        return create_blue_green_deployment.execute(self, allocator, input, options);
    }

    /// Creates a custom DB engine version (CEV).
    pub fn createCustomDbEngineVersion(self: *Self, allocator: std.mem.Allocator, input: create_custom_db_engine_version.CreateCustomDBEngineVersionInput, options: create_custom_db_engine_version.Options) !create_custom_db_engine_version.CreateCustomDBEngineVersionOutput {
        return create_custom_db_engine_version.execute(self, allocator, input, options);
    }

    /// Creates a new Amazon Aurora DB cluster or Multi-AZ DB cluster.
    ///
    /// If you create an Aurora DB cluster, the request creates an empty cluster.
    /// You must explicitly create the writer instance for your DB cluster using the
    /// [CreateDBInstance](https://docs.aws.amazon.com/AmazonRDS/latest/APIReference/API_CreateDBInstance.html) operation. If you create a Multi-AZ DB cluster, the request creates a writer and two reader DB instances for you, each in a different Availability Zone.
    ///
    /// You can use the `ReplicationSourceIdentifier` parameter to create an Amazon
    /// Aurora DB cluster as a read replica of another DB cluster or Amazon RDS for
    /// MySQL or PostgreSQL DB instance. For more information about Amazon Aurora,
    /// see [What is Amazon
    /// Aurora?](https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/CHAP_AuroraOverview.html) in the *Amazon Aurora User Guide*.
    ///
    /// You can also use the `ReplicationSourceIdentifier` parameter to create a
    /// Multi-AZ DB cluster read replica with an RDS for MySQL or PostgreSQL DB
    /// instance as the source. For more information about Multi-AZ DB clusters, see
    /// [Multi-AZ DB cluster
    /// deployments](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/multi-az-db-clusters-concepts.html) in the *Amazon RDS User Guide*.
    pub fn createDbCluster(self: *Self, allocator: std.mem.Allocator, input: create_db_cluster.CreateDBClusterInput, options: create_db_cluster.Options) !create_db_cluster.CreateDBClusterOutput {
        return create_db_cluster.execute(self, allocator, input, options);
    }

    /// Creates a new custom endpoint and associates it with an Amazon Aurora DB
    /// cluster.
    ///
    /// This action applies only to Aurora DB clusters.
    pub fn createDbClusterEndpoint(self: *Self, allocator: std.mem.Allocator, input: create_db_cluster_endpoint.CreateDBClusterEndpointInput, options: create_db_cluster_endpoint.Options) !create_db_cluster_endpoint.CreateDBClusterEndpointOutput {
        return create_db_cluster_endpoint.execute(self, allocator, input, options);
    }

    /// Creates a new DB cluster parameter group.
    ///
    /// Parameters in a DB cluster parameter group apply to all of the instances in
    /// a DB cluster.
    ///
    /// A DB cluster parameter group is initially created with the default
    /// parameters for the database engine used by instances in the DB cluster. To
    /// provide custom values for any of the parameters, you must modify the group
    /// after creating it using `ModifyDBClusterParameterGroup`. Once you've created
    /// a DB cluster parameter group, you need to associate it with your DB cluster
    /// using `ModifyDBCluster`.
    ///
    /// When you associate a new DB cluster parameter group with a running Aurora DB
    /// cluster, reboot the DB instances in the DB cluster without failover for the
    /// new DB cluster parameter group and associated settings to take effect.
    ///
    /// When you associate a new DB cluster parameter group with a running Multi-AZ
    /// DB cluster, reboot the DB cluster without failover for the new DB cluster
    /// parameter group and associated settings to take effect.
    ///
    /// After you create a DB cluster parameter group, you should wait at least 5
    /// minutes before creating your first DB cluster that uses that DB cluster
    /// parameter group as the default parameter group. This allows Amazon RDS to
    /// fully complete the create action before the DB cluster parameter group is
    /// used as the default for a new DB cluster. This is especially important for
    /// parameters that are critical when creating the default database for a DB
    /// cluster, such as the character set for the default database defined by the
    /// `character_set_database` parameter. You can use the *Parameter Groups*
    /// option of the [Amazon RDS console](https://console.aws.amazon.com/rds/) or
    /// the `DescribeDBClusterParameters` operation to verify that your DB cluster
    /// parameter group has been created or modified.
    ///
    /// For more information on Amazon Aurora, see [ What is Amazon
    /// Aurora?](https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/CHAP_AuroraOverview.html) in the *Amazon Aurora User Guide*.
    ///
    /// For more information on Multi-AZ DB clusters, see [ Multi-AZ DB cluster
    /// deployments](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/multi-az-db-clusters-concepts.html) in the *Amazon RDS User Guide*.
    pub fn createDbClusterParameterGroup(self: *Self, allocator: std.mem.Allocator, input: create_db_cluster_parameter_group.CreateDBClusterParameterGroupInput, options: create_db_cluster_parameter_group.Options) !create_db_cluster_parameter_group.CreateDBClusterParameterGroupOutput {
        return create_db_cluster_parameter_group.execute(self, allocator, input, options);
    }

    /// Creates a snapshot of a DB cluster.
    ///
    /// For more information on Amazon Aurora, see [ What is Amazon
    /// Aurora?](https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/CHAP_AuroraOverview.html) in the *Amazon Aurora User Guide*.
    ///
    /// For more information on Multi-AZ DB clusters, see [ Multi-AZ DB cluster
    /// deployments](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/multi-az-db-clusters-concepts.html) in the *Amazon RDS User Guide*.
    pub fn createDbClusterSnapshot(self: *Self, allocator: std.mem.Allocator, input: create_db_cluster_snapshot.CreateDBClusterSnapshotInput, options: create_db_cluster_snapshot.Options) !create_db_cluster_snapshot.CreateDBClusterSnapshotOutput {
        return create_db_cluster_snapshot.execute(self, allocator, input, options);
    }

    /// Creates a new DB instance.
    ///
    /// The new DB instance can be an RDS DB instance, or it can be a DB instance in
    /// an Aurora DB cluster. For an Aurora DB cluster, you can call this operation
    /// multiple times to add more than one DB instance to the cluster.
    ///
    /// For more information about creating an RDS DB instance, see [ Creating an
    /// Amazon RDS DB
    /// instance](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_CreateDBInstance.html) in the *Amazon RDS User Guide*.
    ///
    /// For more information about creating a DB instance in an Aurora DB cluster,
    /// see [ Creating an Amazon Aurora DB
    /// cluster](https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/Aurora.CreateInstance.html) in the *Amazon Aurora User Guide*.
    pub fn createDbInstance(self: *Self, allocator: std.mem.Allocator, input: create_db_instance.CreateDBInstanceInput, options: create_db_instance.Options) !create_db_instance.CreateDBInstanceOutput {
        return create_db_instance.execute(self, allocator, input, options);
    }

    /// Creates a new DB instance that acts as a read replica for an existing source
    /// DB instance or Multi-AZ DB cluster. You can create a read replica for a DB
    /// instance running Db2, MariaDB, MySQL, Oracle, PostgreSQL, or SQL Server. You
    /// can create a read replica for a Multi-AZ DB cluster running MySQL or
    /// PostgreSQL. For more information, see [Working with read
    /// replicas](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_ReadRepl.html) and [Migrating from a Multi-AZ DB cluster to a DB instance using a read replica](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/multi-az-db-clusters-concepts.html#multi-az-db-clusters-migrating-to-instance-with-read-replica) in the *Amazon RDS User Guide*.
    ///
    /// Amazon Aurora doesn't support this operation. To create a DB instance for an
    /// Aurora DB cluster, use the `CreateDBInstance` operation.
    ///
    /// RDS creates read replicas with backups disabled. All other attributes
    /// (including DB security groups and DB parameter groups) are inherited from
    /// the source DB instance or cluster, except as specified.
    ///
    /// Your source DB instance or cluster must have backup retention enabled.
    pub fn createDbInstanceReadReplica(self: *Self, allocator: std.mem.Allocator, input: create_db_instance_read_replica.CreateDBInstanceReadReplicaInput, options: create_db_instance_read_replica.Options) !create_db_instance_read_replica.CreateDBInstanceReadReplicaOutput {
        return create_db_instance_read_replica.execute(self, allocator, input, options);
    }

    /// Creates a new DB parameter group.
    ///
    /// A DB parameter group is initially created with the default parameters for
    /// the database engine used by the DB instance. To provide custom values for
    /// any of the parameters, you must modify the group after creating it using
    /// `ModifyDBParameterGroup`. Once you've created a DB parameter group, you need
    /// to associate it with your DB instance using `ModifyDBInstance`. When you
    /// associate a new DB parameter group with a running DB instance, you need to
    /// reboot the DB instance without failover for the new DB parameter group and
    /// associated settings to take effect.
    ///
    /// This command doesn't apply to RDS Custom.
    pub fn createDbParameterGroup(self: *Self, allocator: std.mem.Allocator, input: create_db_parameter_group.CreateDBParameterGroupInput, options: create_db_parameter_group.Options) !create_db_parameter_group.CreateDBParameterGroupOutput {
        return create_db_parameter_group.execute(self, allocator, input, options);
    }

    /// Creates a new DB proxy.
    pub fn createDbProxy(self: *Self, allocator: std.mem.Allocator, input: create_db_proxy.CreateDBProxyInput, options: create_db_proxy.Options) !create_db_proxy.CreateDBProxyOutput {
        return create_db_proxy.execute(self, allocator, input, options);
    }

    /// Creates a `DBProxyEndpoint`. Only applies to proxies that are associated
    /// with Aurora DB clusters. You can use DB proxy endpoints to specify
    /// read/write or read-only access to the DB cluster. You can also use DB proxy
    /// endpoints to access a DB proxy through a different VPC than the proxy's
    /// default VPC.
    pub fn createDbProxyEndpoint(self: *Self, allocator: std.mem.Allocator, input: create_db_proxy_endpoint.CreateDBProxyEndpointInput, options: create_db_proxy_endpoint.Options) !create_db_proxy_endpoint.CreateDBProxyEndpointOutput {
        return create_db_proxy_endpoint.execute(self, allocator, input, options);
    }

    /// Creates a new DB security group. DB security groups control access to a DB
    /// instance.
    ///
    /// A DB security group controls access to EC2-Classic DB instances that are not
    /// in a VPC.
    ///
    /// EC2-Classic was retired on August 15, 2022. If you haven't migrated from
    /// EC2-Classic to a VPC, we recommend that you migrate as soon as possible. For
    /// more information, see [Migrate from EC2-Classic to a
    /// VPC](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/vpc-migrate.html)
    /// in the *Amazon EC2 User Guide*, the blog [EC2-Classic Networking is Retiring
    /// – Here’s How to
    /// Prepare](http://aws.amazon.com/blogs/aws/ec2-classic-is-retiring-heres-how-to-prepare/), and [Moving a DB instance not in a VPC into a VPC](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_VPC.Non-VPC2VPC.html) in the *Amazon RDS User Guide*.
    pub fn createDbSecurityGroup(self: *Self, allocator: std.mem.Allocator, input: create_db_security_group.CreateDBSecurityGroupInput, options: create_db_security_group.Options) !create_db_security_group.CreateDBSecurityGroupOutput {
        return create_db_security_group.execute(self, allocator, input, options);
    }

    /// Creates a new DB shard group for Aurora Limitless Database. You must enable
    /// Aurora Limitless Database to create a DB shard group.
    ///
    /// Valid for: Aurora DB clusters only
    pub fn createDbShardGroup(self: *Self, allocator: std.mem.Allocator, input: create_db_shard_group.CreateDBShardGroupInput, options: create_db_shard_group.Options) !create_db_shard_group.CreateDBShardGroupOutput {
        return create_db_shard_group.execute(self, allocator, input, options);
    }

    /// Creates a snapshot of a DB instance. The source DB instance must be in the
    /// `available` or `storage-optimization` state.
    pub fn createDbSnapshot(self: *Self, allocator: std.mem.Allocator, input: create_db_snapshot.CreateDBSnapshotInput, options: create_db_snapshot.Options) !create_db_snapshot.CreateDBSnapshotOutput {
        return create_db_snapshot.execute(self, allocator, input, options);
    }

    /// Creates a new DB subnet group. DB subnet groups must contain at least one
    /// subnet in at least two AZs in the Amazon Web Services Region.
    pub fn createDbSubnetGroup(self: *Self, allocator: std.mem.Allocator, input: create_db_subnet_group.CreateDBSubnetGroupInput, options: create_db_subnet_group.Options) !create_db_subnet_group.CreateDBSubnetGroupOutput {
        return create_db_subnet_group.execute(self, allocator, input, options);
    }

    /// Creates an RDS event notification subscription. This operation requires a
    /// topic Amazon Resource Name (ARN) created by either the RDS console, the SNS
    /// console, or the SNS API. To obtain an ARN with SNS, you must create a topic
    /// in Amazon SNS and subscribe to the topic. The ARN is displayed in the SNS
    /// console.
    ///
    /// You can specify the type of source (`SourceType`) that you want to be
    /// notified of and provide a list of RDS sources (`SourceIds`) that triggers
    /// the events. You can also provide a list of event categories
    /// (`EventCategories`) for events that you want to be notified of. For example,
    /// you can specify `SourceType` = `db-instance`, `SourceIds` = `mydbinstance1`,
    /// `mydbinstance2` and `EventCategories` = `Availability`, `Backup`.
    ///
    /// If you specify both the `SourceType` and `SourceIds`, such as `SourceType` =
    /// `db-instance` and `SourceIds` = `myDBInstance1`, you are notified of all the
    /// `db-instance` events for the specified source. If you specify a `SourceType`
    /// but do not specify `SourceIds`, you receive notice of the events for that
    /// source type for all your RDS sources. If you don't specify either the
    /// SourceType or the `SourceIds`, you are notified of events generated from all
    /// RDS sources belonging to your customer account.
    ///
    /// For more information about subscribing to an event for RDS DB engines, see [
    /// Subscribing to Amazon RDS event
    /// notification](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_Events.Subscribing.html) in the *Amazon RDS User Guide*.
    ///
    /// For more information about subscribing to an event for Aurora DB engines,
    /// see [ Subscribing to Amazon RDS event
    /// notification](https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/USER_Events.Subscribing.html) in the *Amazon Aurora User Guide*.
    pub fn createEventSubscription(self: *Self, allocator: std.mem.Allocator, input: create_event_subscription.CreateEventSubscriptionInput, options: create_event_subscription.Options) !create_event_subscription.CreateEventSubscriptionOutput {
        return create_event_subscription.execute(self, allocator, input, options);
    }

    /// Creates an Aurora global database spread across multiple Amazon Web Services
    /// Regions. The global database contains a single primary cluster with
    /// read-write capability, and a read-only secondary cluster that receives data
    /// from the primary cluster through high-speed replication performed by the
    /// Aurora storage subsystem.
    ///
    /// You can create a global database that is initially empty, and then create
    /// the primary and secondary DB clusters in the global database. Or you can
    /// specify an existing Aurora cluster during the create operation, and this
    /// cluster becomes the primary cluster of the global database.
    ///
    /// This operation applies only to Aurora DB clusters.
    pub fn createGlobalCluster(self: *Self, allocator: std.mem.Allocator, input: create_global_cluster.CreateGlobalClusterInput, options: create_global_cluster.Options) !create_global_cluster.CreateGlobalClusterOutput {
        return create_global_cluster.execute(self, allocator, input, options);
    }

    /// Creates a zero-ETL integration with Amazon Redshift.
    pub fn createIntegration(self: *Self, allocator: std.mem.Allocator, input: create_integration.CreateIntegrationInput, options: create_integration.Options) !create_integration.CreateIntegrationOutput {
        return create_integration.execute(self, allocator, input, options);
    }

    /// Creates a new option group. You can create up to 20 option groups.
    ///
    /// This command doesn't apply to RDS Custom.
    pub fn createOptionGroup(self: *Self, allocator: std.mem.Allocator, input: create_option_group.CreateOptionGroupInput, options: create_option_group.Options) !create_option_group.CreateOptionGroupOutput {
        return create_option_group.execute(self, allocator, input, options);
    }

    /// Creates a tenant database in a DB instance that uses the multi-tenant
    /// configuration. Only RDS for Oracle container database (CDB) instances are
    /// supported.
    pub fn createTenantDatabase(self: *Self, allocator: std.mem.Allocator, input: create_tenant_database.CreateTenantDatabaseInput, options: create_tenant_database.Options) !create_tenant_database.CreateTenantDatabaseOutput {
        return create_tenant_database.execute(self, allocator, input, options);
    }

    /// Deletes a blue/green deployment.
    ///
    /// For more information, see [Using Amazon RDS Blue/Green Deployments for
    /// database
    /// updates](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/blue-green-deployments.html) in the *Amazon RDS User Guide* and [Using Amazon RDS Blue/Green Deployments for database updates](https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/blue-green-deployments.html) in the *Amazon Aurora User Guide*.
    pub fn deleteBlueGreenDeployment(self: *Self, allocator: std.mem.Allocator, input: delete_blue_green_deployment.DeleteBlueGreenDeploymentInput, options: delete_blue_green_deployment.Options) !delete_blue_green_deployment.DeleteBlueGreenDeploymentOutput {
        return delete_blue_green_deployment.execute(self, allocator, input, options);
    }

    /// Deletes a custom engine version. To run this command, make sure you meet the
    /// following prerequisites:
    ///
    /// * The CEV must not be the default for RDS Custom. If it is, change the
    ///   default before running this command.
    /// * The CEV must not be associated with an RDS Custom DB instance, RDS Custom
    ///   instance snapshot, or automated backup of your RDS Custom instance.
    ///
    /// Typically, deletion takes a few minutes.
    ///
    /// The MediaImport service that imports files from Amazon S3 to create CEVs
    /// isn't integrated with Amazon Web Services CloudTrail. If you turn on data
    /// logging for Amazon RDS in CloudTrail, calls to the
    /// `DeleteCustomDbEngineVersion` event aren't logged. However, you might see
    /// calls from the API gateway that accesses your Amazon S3 bucket. These calls
    /// originate from the MediaImport service for the `DeleteCustomDbEngineVersion`
    /// event.
    ///
    /// For more information, see [Deleting a
    /// CEV](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/custom-cev.html#custom-cev.delete) in the *Amazon RDS User Guide*.
    pub fn deleteCustomDbEngineVersion(self: *Self, allocator: std.mem.Allocator, input: delete_custom_db_engine_version.DeleteCustomDBEngineVersionInput, options: delete_custom_db_engine_version.Options) !delete_custom_db_engine_version.DeleteCustomDBEngineVersionOutput {
        return delete_custom_db_engine_version.execute(self, allocator, input, options);
    }

    /// The DeleteDBCluster action deletes a previously provisioned DB cluster. When
    /// you delete a DB cluster, all automated backups for that DB cluster are
    /// deleted and can't be recovered. Manual DB cluster snapshots of the specified
    /// DB cluster are not deleted.
    ///
    /// If you're deleting a Multi-AZ DB cluster with read replicas, all cluster
    /// members are terminated and read replicas are promoted to standalone
    /// instances.
    ///
    /// For more information on Amazon Aurora, see [ What is Amazon
    /// Aurora?](https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/CHAP_AuroraOverview.html) in the *Amazon Aurora User Guide*.
    ///
    /// For more information on Multi-AZ DB clusters, see [ Multi-AZ DB cluster
    /// deployments](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/multi-az-db-clusters-concepts.html) in the *Amazon RDS User Guide*.
    pub fn deleteDbCluster(self: *Self, allocator: std.mem.Allocator, input: delete_db_cluster.DeleteDBClusterInput, options: delete_db_cluster.Options) !delete_db_cluster.DeleteDBClusterOutput {
        return delete_db_cluster.execute(self, allocator, input, options);
    }

    /// Deletes automated backups using the `DbClusterResourceId` value of the
    /// source DB cluster or the Amazon Resource Name (ARN) of the automated
    /// backups.
    pub fn deleteDbClusterAutomatedBackup(self: *Self, allocator: std.mem.Allocator, input: delete_db_cluster_automated_backup.DeleteDBClusterAutomatedBackupInput, options: delete_db_cluster_automated_backup.Options) !delete_db_cluster_automated_backup.DeleteDBClusterAutomatedBackupOutput {
        return delete_db_cluster_automated_backup.execute(self, allocator, input, options);
    }

    /// Deletes a custom endpoint and removes it from an Amazon Aurora DB cluster.
    ///
    /// This action only applies to Aurora DB clusters.
    pub fn deleteDbClusterEndpoint(self: *Self, allocator: std.mem.Allocator, input: delete_db_cluster_endpoint.DeleteDBClusterEndpointInput, options: delete_db_cluster_endpoint.Options) !delete_db_cluster_endpoint.DeleteDBClusterEndpointOutput {
        return delete_db_cluster_endpoint.execute(self, allocator, input, options);
    }

    /// Deletes a specified DB cluster parameter group. The DB cluster parameter
    /// group to be deleted can't be associated with any DB clusters.
    ///
    /// For more information on Amazon Aurora, see [ What is Amazon
    /// Aurora?](https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/CHAP_AuroraOverview.html) in the *Amazon Aurora User Guide*.
    ///
    /// For more information on Multi-AZ DB clusters, see [ Multi-AZ DB cluster
    /// deployments](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/multi-az-db-clusters-concepts.html) in the *Amazon RDS User Guide*.
    pub fn deleteDbClusterParameterGroup(self: *Self, allocator: std.mem.Allocator, input: delete_db_cluster_parameter_group.DeleteDBClusterParameterGroupInput, options: delete_db_cluster_parameter_group.Options) !delete_db_cluster_parameter_group.DeleteDBClusterParameterGroupOutput {
        return delete_db_cluster_parameter_group.execute(self, allocator, input, options);
    }

    /// Deletes a DB cluster snapshot. If the snapshot is being copied, the copy
    /// operation is terminated.
    ///
    /// The DB cluster snapshot must be in the `available` state to be deleted.
    ///
    /// For more information on Amazon Aurora, see [ What is Amazon
    /// Aurora?](https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/CHAP_AuroraOverview.html) in the *Amazon Aurora User Guide*.
    ///
    /// For more information on Multi-AZ DB clusters, see [ Multi-AZ DB cluster
    /// deployments](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/multi-az-db-clusters-concepts.html) in the *Amazon RDS User Guide*.
    pub fn deleteDbClusterSnapshot(self: *Self, allocator: std.mem.Allocator, input: delete_db_cluster_snapshot.DeleteDBClusterSnapshotInput, options: delete_db_cluster_snapshot.Options) !delete_db_cluster_snapshot.DeleteDBClusterSnapshotOutput {
        return delete_db_cluster_snapshot.execute(self, allocator, input, options);
    }

    /// Deletes a previously provisioned DB instance. When you delete a DB instance,
    /// all automated backups for that instance are deleted and can't be recovered.
    /// However, manual DB snapshots of the DB instance aren't deleted.
    ///
    /// If you request a final DB snapshot, the status of the Amazon RDS DB instance
    /// is `deleting` until the DB snapshot is created. This operation can't be
    /// canceled or reverted after it begins. To monitor the status of this
    /// operation, use `DescribeDBInstance`.
    ///
    /// When a DB instance is in a failure state and has a status of `failed`,
    /// `incompatible-restore`, or `incompatible-network`, you can only delete it
    /// when you skip creation of the final snapshot with the `SkipFinalSnapshot`
    /// parameter.
    ///
    /// If the specified DB instance is part of an Amazon Aurora DB cluster, you
    /// can't delete the DB instance if both of the following conditions are true:
    ///
    /// * The DB cluster is a read replica of another Amazon Aurora DB cluster.
    /// * The DB instance is the only instance in the DB cluster.
    ///
    /// To delete a DB instance in this case, first use the
    /// `PromoteReadReplicaDBCluster` operation to promote the DB cluster so that
    /// it's no longer a read replica. After the promotion completes, use the
    /// `DeleteDBInstance` operation to delete the final instance in the DB cluster.
    ///
    /// For RDS Custom DB instances, deleting the DB instance permanently deletes
    /// the EC2 instance and the associated EBS volumes. Make sure that you don't
    /// terminate or delete these resources before you delete the DB instance.
    /// Otherwise, deleting the DB instance and creation of the final snapshot might
    /// fail.
    pub fn deleteDbInstance(self: *Self, allocator: std.mem.Allocator, input: delete_db_instance.DeleteDBInstanceInput, options: delete_db_instance.Options) !delete_db_instance.DeleteDBInstanceOutput {
        return delete_db_instance.execute(self, allocator, input, options);
    }

    /// Deletes automated backups using the `DbiResourceId` value of the source DB
    /// instance or the Amazon Resource Name (ARN) of the automated backups.
    pub fn deleteDbInstanceAutomatedBackup(self: *Self, allocator: std.mem.Allocator, input: delete_db_instance_automated_backup.DeleteDBInstanceAutomatedBackupInput, options: delete_db_instance_automated_backup.Options) !delete_db_instance_automated_backup.DeleteDBInstanceAutomatedBackupOutput {
        return delete_db_instance_automated_backup.execute(self, allocator, input, options);
    }

    /// Deletes a specified DB parameter group. The DB parameter group to be deleted
    /// can't be associated with any DB instances.
    pub fn deleteDbParameterGroup(self: *Self, allocator: std.mem.Allocator, input: delete_db_parameter_group.DeleteDBParameterGroupInput, options: delete_db_parameter_group.Options) !delete_db_parameter_group.DeleteDBParameterGroupOutput {
        return delete_db_parameter_group.execute(self, allocator, input, options);
    }

    /// Deletes an existing DB proxy.
    pub fn deleteDbProxy(self: *Self, allocator: std.mem.Allocator, input: delete_db_proxy.DeleteDBProxyInput, options: delete_db_proxy.Options) !delete_db_proxy.DeleteDBProxyOutput {
        return delete_db_proxy.execute(self, allocator, input, options);
    }

    /// Deletes a `DBProxyEndpoint`. Doing so removes the ability to access the DB
    /// proxy using the endpoint that you defined. The endpoint that you delete
    /// might have provided capabilities such as read/write or read-only operations,
    /// or using a different VPC than the DB proxy's default VPC.
    pub fn deleteDbProxyEndpoint(self: *Self, allocator: std.mem.Allocator, input: delete_db_proxy_endpoint.DeleteDBProxyEndpointInput, options: delete_db_proxy_endpoint.Options) !delete_db_proxy_endpoint.DeleteDBProxyEndpointOutput {
        return delete_db_proxy_endpoint.execute(self, allocator, input, options);
    }

    /// Deletes a DB security group.
    ///
    /// The specified DB security group must not be associated with any DB
    /// instances.
    ///
    /// EC2-Classic was retired on August 15, 2022. If you haven't migrated from
    /// EC2-Classic to a VPC, we recommend that you migrate as soon as possible. For
    /// more information, see [Migrate from EC2-Classic to a
    /// VPC](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/vpc-migrate.html)
    /// in the *Amazon EC2 User Guide*, the blog [EC2-Classic Networking is Retiring
    /// – Here’s How to
    /// Prepare](http://aws.amazon.com/blogs/aws/ec2-classic-is-retiring-heres-how-to-prepare/), and [Moving a DB instance not in a VPC into a VPC](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_VPC.Non-VPC2VPC.html) in the *Amazon RDS User Guide*.
    pub fn deleteDbSecurityGroup(self: *Self, allocator: std.mem.Allocator, input: delete_db_security_group.DeleteDBSecurityGroupInput, options: delete_db_security_group.Options) !delete_db_security_group.DeleteDBSecurityGroupOutput {
        return delete_db_security_group.execute(self, allocator, input, options);
    }

    /// Deletes an Aurora Limitless Database DB shard group.
    pub fn deleteDbShardGroup(self: *Self, allocator: std.mem.Allocator, input: delete_db_shard_group.DeleteDBShardGroupInput, options: delete_db_shard_group.Options) !delete_db_shard_group.DeleteDBShardGroupOutput {
        return delete_db_shard_group.execute(self, allocator, input, options);
    }

    /// Deletes a DB snapshot. If the snapshot is being copied, the copy operation
    /// is terminated.
    ///
    /// The DB snapshot must be in the `available` state to be deleted.
    pub fn deleteDbSnapshot(self: *Self, allocator: std.mem.Allocator, input: delete_db_snapshot.DeleteDBSnapshotInput, options: delete_db_snapshot.Options) !delete_db_snapshot.DeleteDBSnapshotOutput {
        return delete_db_snapshot.execute(self, allocator, input, options);
    }

    /// Deletes a DB subnet group.
    ///
    /// The specified database subnet group must not be associated with any DB
    /// instances.
    pub fn deleteDbSubnetGroup(self: *Self, allocator: std.mem.Allocator, input: delete_db_subnet_group.DeleteDBSubnetGroupInput, options: delete_db_subnet_group.Options) !delete_db_subnet_group.DeleteDBSubnetGroupOutput {
        return delete_db_subnet_group.execute(self, allocator, input, options);
    }

    /// Deletes an RDS event notification subscription.
    pub fn deleteEventSubscription(self: *Self, allocator: std.mem.Allocator, input: delete_event_subscription.DeleteEventSubscriptionInput, options: delete_event_subscription.Options) !delete_event_subscription.DeleteEventSubscriptionOutput {
        return delete_event_subscription.execute(self, allocator, input, options);
    }

    /// Deletes a global database cluster. The primary and secondary clusters must
    /// already be detached or destroyed first.
    ///
    /// This action only applies to Aurora DB clusters.
    pub fn deleteGlobalCluster(self: *Self, allocator: std.mem.Allocator, input: delete_global_cluster.DeleteGlobalClusterInput, options: delete_global_cluster.Options) !delete_global_cluster.DeleteGlobalClusterOutput {
        return delete_global_cluster.execute(self, allocator, input, options);
    }

    /// Deletes a zero-ETL integration with Amazon Redshift.
    pub fn deleteIntegration(self: *Self, allocator: std.mem.Allocator, input: delete_integration.DeleteIntegrationInput, options: delete_integration.Options) !delete_integration.DeleteIntegrationOutput {
        return delete_integration.execute(self, allocator, input, options);
    }

    /// Deletes an existing option group.
    pub fn deleteOptionGroup(self: *Self, allocator: std.mem.Allocator, input: delete_option_group.DeleteOptionGroupInput, options: delete_option_group.Options) !delete_option_group.DeleteOptionGroupOutput {
        return delete_option_group.execute(self, allocator, input, options);
    }

    /// Deletes a tenant database from your DB instance. This command only applies
    /// to RDS for Oracle container database (CDB) instances.
    ///
    /// You can't delete a tenant database when it is the only tenant in the DB
    /// instance.
    pub fn deleteTenantDatabase(self: *Self, allocator: std.mem.Allocator, input: delete_tenant_database.DeleteTenantDatabaseInput, options: delete_tenant_database.Options) !delete_tenant_database.DeleteTenantDatabaseOutput {
        return delete_tenant_database.execute(self, allocator, input, options);
    }

    /// Remove the association between one or more `DBProxyTarget` data structures
    /// and a `DBProxyTargetGroup`.
    pub fn deregisterDbProxyTargets(self: *Self, allocator: std.mem.Allocator, input: deregister_db_proxy_targets.DeregisterDBProxyTargetsInput, options: deregister_db_proxy_targets.Options) !deregister_db_proxy_targets.DeregisterDBProxyTargetsOutput {
        return deregister_db_proxy_targets.execute(self, allocator, input, options);
    }

    /// Lists all of the attributes for a customer account. The attributes include
    /// Amazon RDS quotas for the account, such as the number of DB instances
    /// allowed. The description for a quota includes the quota name, current usage
    /// toward that quota, and the quota's maximum value.
    ///
    /// This command doesn't take any parameters.
    pub fn describeAccountAttributes(self: *Self, allocator: std.mem.Allocator, input: describe_account_attributes.DescribeAccountAttributesInput, options: describe_account_attributes.Options) !describe_account_attributes.DescribeAccountAttributesOutput {
        return describe_account_attributes.execute(self, allocator, input, options);
    }

    /// Describes one or more blue/green deployments.
    ///
    /// For more information, see [Using Amazon RDS Blue/Green Deployments for
    /// database
    /// updates](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/blue-green-deployments.html) in the *Amazon RDS User Guide* and [ Using Amazon RDS Blue/Green Deployments for database updates](https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/blue-green-deployments.html) in the *Amazon Aurora User Guide*.
    pub fn describeBlueGreenDeployments(self: *Self, allocator: std.mem.Allocator, input: describe_blue_green_deployments.DescribeBlueGreenDeploymentsInput, options: describe_blue_green_deployments.Options) !describe_blue_green_deployments.DescribeBlueGreenDeploymentsOutput {
        return describe_blue_green_deployments.execute(self, allocator, input, options);
    }

    /// Lists the set of certificate authority (CA) certificates provided by Amazon
    /// RDS for this Amazon Web Services account.
    ///
    /// For more information, see [Using SSL/TLS to encrypt a connection to a DB
    /// instance](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/UsingWithRDS.SSL.html) in the *Amazon RDS User Guide* and [ Using SSL/TLS to encrypt a connection to a DB cluster](https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/UsingWithRDS.SSL.html) in the *Amazon Aurora User Guide*.
    pub fn describeCertificates(self: *Self, allocator: std.mem.Allocator, input: describe_certificates.DescribeCertificatesInput, options: describe_certificates.Options) !describe_certificates.DescribeCertificatesOutput {
        return describe_certificates.execute(self, allocator, input, options);
    }

    /// Displays backups for both current and deleted DB clusters. For example, use
    /// this operation to find details about automated backups for previously
    /// deleted clusters. Current clusters are returned for both the
    /// `DescribeDBClusterAutomatedBackups` and `DescribeDBClusters` operations.
    ///
    /// All parameters are optional.
    pub fn describeDbClusterAutomatedBackups(self: *Self, allocator: std.mem.Allocator, input: describe_db_cluster_automated_backups.DescribeDBClusterAutomatedBackupsInput, options: describe_db_cluster_automated_backups.Options) !describe_db_cluster_automated_backups.DescribeDBClusterAutomatedBackupsOutput {
        return describe_db_cluster_automated_backups.execute(self, allocator, input, options);
    }

    /// Returns information about backtracks for a DB cluster.
    ///
    /// For more information on Amazon Aurora, see [ What is Amazon
    /// Aurora?](https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/CHAP_AuroraOverview.html) in the *Amazon Aurora User Guide*.
    ///
    /// This action only applies to Aurora MySQL DB clusters.
    pub fn describeDbClusterBacktracks(self: *Self, allocator: std.mem.Allocator, input: describe_db_cluster_backtracks.DescribeDBClusterBacktracksInput, options: describe_db_cluster_backtracks.Options) !describe_db_cluster_backtracks.DescribeDBClusterBacktracksOutput {
        return describe_db_cluster_backtracks.execute(self, allocator, input, options);
    }

    /// Returns information about endpoints for an Amazon Aurora DB cluster.
    ///
    /// This action only applies to Aurora DB clusters.
    pub fn describeDbClusterEndpoints(self: *Self, allocator: std.mem.Allocator, input: describe_db_cluster_endpoints.DescribeDBClusterEndpointsInput, options: describe_db_cluster_endpoints.Options) !describe_db_cluster_endpoints.DescribeDBClusterEndpointsOutput {
        return describe_db_cluster_endpoints.execute(self, allocator, input, options);
    }

    /// Returns a list of `DBClusterParameterGroup` descriptions. If a
    /// `DBClusterParameterGroupName` parameter is specified, the list will contain
    /// only the description of the specified DB cluster parameter group.
    ///
    /// For more information on Amazon Aurora, see [ What is Amazon
    /// Aurora?](https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/CHAP_AuroraOverview.html) in the *Amazon Aurora User Guide*.
    ///
    /// For more information on Multi-AZ DB clusters, see [ Multi-AZ DB cluster
    /// deployments](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/multi-az-db-clusters-concepts.html) in the *Amazon RDS User Guide*.
    pub fn describeDbClusterParameterGroups(self: *Self, allocator: std.mem.Allocator, input: describe_db_cluster_parameter_groups.DescribeDBClusterParameterGroupsInput, options: describe_db_cluster_parameter_groups.Options) !describe_db_cluster_parameter_groups.DescribeDBClusterParameterGroupsOutput {
        return describe_db_cluster_parameter_groups.execute(self, allocator, input, options);
    }

    /// Returns the detailed parameter list for a particular DB cluster parameter
    /// group.
    ///
    /// For more information on Amazon Aurora, see [ What is Amazon
    /// Aurora?](https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/CHAP_AuroraOverview.html) in the *Amazon Aurora User Guide*.
    ///
    /// For more information on Multi-AZ DB clusters, see [ Multi-AZ DB cluster
    /// deployments](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/multi-az-db-clusters-concepts.html) in the *Amazon RDS User Guide*.
    pub fn describeDbClusterParameters(self: *Self, allocator: std.mem.Allocator, input: describe_db_cluster_parameters.DescribeDBClusterParametersInput, options: describe_db_cluster_parameters.Options) !describe_db_cluster_parameters.DescribeDBClusterParametersOutput {
        return describe_db_cluster_parameters.execute(self, allocator, input, options);
    }

    /// Returns a list of DB cluster snapshot attribute names and values for a
    /// manual DB cluster snapshot.
    ///
    /// When sharing snapshots with other Amazon Web Services accounts,
    /// `DescribeDBClusterSnapshotAttributes` returns the `restore` attribute and a
    /// list of IDs for the Amazon Web Services accounts that are authorized to copy
    /// or restore the manual DB cluster snapshot. If `all` is included in the list
    /// of values for the `restore` attribute, then the manual DB cluster snapshot
    /// is public and can be copied or restored by all Amazon Web Services accounts.
    ///
    /// To add or remove access for an Amazon Web Services account to copy or
    /// restore a manual DB cluster snapshot, or to make the manual DB cluster
    /// snapshot public or private, use the `ModifyDBClusterSnapshotAttribute` API
    /// action.
    pub fn describeDbClusterSnapshotAttributes(self: *Self, allocator: std.mem.Allocator, input: describe_db_cluster_snapshot_attributes.DescribeDBClusterSnapshotAttributesInput, options: describe_db_cluster_snapshot_attributes.Options) !describe_db_cluster_snapshot_attributes.DescribeDBClusterSnapshotAttributesOutput {
        return describe_db_cluster_snapshot_attributes.execute(self, allocator, input, options);
    }

    /// Returns information about DB cluster snapshots. This API action supports
    /// pagination.
    ///
    /// For more information on Amazon Aurora DB clusters, see [ What is Amazon
    /// Aurora?](https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/CHAP_AuroraOverview.html) in the *Amazon Aurora User Guide*.
    ///
    /// For more information on Multi-AZ DB clusters, see [ Multi-AZ DB cluster
    /// deployments](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/multi-az-db-clusters-concepts.html) in the *Amazon RDS User Guide*.
    pub fn describeDbClusterSnapshots(self: *Self, allocator: std.mem.Allocator, input: describe_db_cluster_snapshots.DescribeDBClusterSnapshotsInput, options: describe_db_cluster_snapshots.Options) !describe_db_cluster_snapshots.DescribeDBClusterSnapshotsOutput {
        return describe_db_cluster_snapshots.execute(self, allocator, input, options);
    }

    /// Describes existing Amazon Aurora DB clusters and Multi-AZ DB clusters. This
    /// API supports pagination.
    ///
    /// For more information on Amazon Aurora DB clusters, see [ What is Amazon
    /// Aurora?](https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/CHAP_AuroraOverview.html) in the *Amazon Aurora User Guide*.
    ///
    /// For more information on Multi-AZ DB clusters, see [ Multi-AZ DB cluster
    /// deployments](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/multi-az-db-clusters-concepts.html) in the *Amazon RDS User Guide*.
    ///
    /// This operation can also return information for Amazon Neptune DB instances
    /// and Amazon DocumentDB instances.
    pub fn describeDbClusters(self: *Self, allocator: std.mem.Allocator, input: describe_db_clusters.DescribeDBClustersInput, options: describe_db_clusters.Options) !describe_db_clusters.DescribeDBClustersOutput {
        return describe_db_clusters.execute(self, allocator, input, options);
    }

    /// Describes the properties of specific versions of DB engines.
    pub fn describeDbEngineVersions(self: *Self, allocator: std.mem.Allocator, input: describe_db_engine_versions.DescribeDBEngineVersionsInput, options: describe_db_engine_versions.Options) !describe_db_engine_versions.DescribeDBEngineVersionsOutput {
        return describe_db_engine_versions.execute(self, allocator, input, options);
    }

    /// Displays backups for both current and deleted instances. For example, use
    /// this operation to find details about automated backups for previously
    /// deleted instances. Current instances with retention periods greater than
    /// zero (0) are returned for both the `DescribeDBInstanceAutomatedBackups` and
    /// `DescribeDBInstances` operations.
    ///
    /// All parameters are optional.
    pub fn describeDbInstanceAutomatedBackups(self: *Self, allocator: std.mem.Allocator, input: describe_db_instance_automated_backups.DescribeDBInstanceAutomatedBackupsInput, options: describe_db_instance_automated_backups.Options) !describe_db_instance_automated_backups.DescribeDBInstanceAutomatedBackupsOutput {
        return describe_db_instance_automated_backups.execute(self, allocator, input, options);
    }

    /// Describes provisioned RDS instances. This API supports pagination.
    ///
    /// This operation can also return information for Amazon Neptune DB instances
    /// and Amazon DocumentDB instances.
    pub fn describeDbInstances(self: *Self, allocator: std.mem.Allocator, input: describe_db_instances.DescribeDBInstancesInput, options: describe_db_instances.Options) !describe_db_instances.DescribeDBInstancesOutput {
        return describe_db_instances.execute(self, allocator, input, options);
    }

    /// Returns a list of DB log files for the DB instance.
    ///
    /// This command doesn't apply to RDS Custom.
    pub fn describeDbLogFiles(self: *Self, allocator: std.mem.Allocator, input: describe_db_log_files.DescribeDBLogFilesInput, options: describe_db_log_files.Options) !describe_db_log_files.DescribeDBLogFilesOutput {
        return describe_db_log_files.execute(self, allocator, input, options);
    }

    /// Describes the properties of specific major versions of DB engines.
    pub fn describeDbMajorEngineVersions(self: *Self, allocator: std.mem.Allocator, input: describe_db_major_engine_versions.DescribeDBMajorEngineVersionsInput, options: describe_db_major_engine_versions.Options) !describe_db_major_engine_versions.DescribeDBMajorEngineVersionsOutput {
        return describe_db_major_engine_versions.execute(self, allocator, input, options);
    }

    /// Returns a list of `DBParameterGroup` descriptions. If a
    /// `DBParameterGroupName` is specified, the list will contain only the
    /// description of the specified DB parameter group.
    pub fn describeDbParameterGroups(self: *Self, allocator: std.mem.Allocator, input: describe_db_parameter_groups.DescribeDBParameterGroupsInput, options: describe_db_parameter_groups.Options) !describe_db_parameter_groups.DescribeDBParameterGroupsOutput {
        return describe_db_parameter_groups.execute(self, allocator, input, options);
    }

    /// Returns the detailed parameter list for a particular DB parameter group.
    pub fn describeDbParameters(self: *Self, allocator: std.mem.Allocator, input: describe_db_parameters.DescribeDBParametersInput, options: describe_db_parameters.Options) !describe_db_parameters.DescribeDBParametersOutput {
        return describe_db_parameters.execute(self, allocator, input, options);
    }

    /// Returns information about DB proxies.
    pub fn describeDbProxies(self: *Self, allocator: std.mem.Allocator, input: describe_db_proxies.DescribeDBProxiesInput, options: describe_db_proxies.Options) !describe_db_proxies.DescribeDBProxiesOutput {
        return describe_db_proxies.execute(self, allocator, input, options);
    }

    /// Returns information about DB proxy endpoints.
    pub fn describeDbProxyEndpoints(self: *Self, allocator: std.mem.Allocator, input: describe_db_proxy_endpoints.DescribeDBProxyEndpointsInput, options: describe_db_proxy_endpoints.Options) !describe_db_proxy_endpoints.DescribeDBProxyEndpointsOutput {
        return describe_db_proxy_endpoints.execute(self, allocator, input, options);
    }

    /// Returns information about DB proxy target groups, represented by
    /// `DBProxyTargetGroup` data structures.
    pub fn describeDbProxyTargetGroups(self: *Self, allocator: std.mem.Allocator, input: describe_db_proxy_target_groups.DescribeDBProxyTargetGroupsInput, options: describe_db_proxy_target_groups.Options) !describe_db_proxy_target_groups.DescribeDBProxyTargetGroupsOutput {
        return describe_db_proxy_target_groups.execute(self, allocator, input, options);
    }

    /// Returns information about `DBProxyTarget` objects. This API supports
    /// pagination.
    pub fn describeDbProxyTargets(self: *Self, allocator: std.mem.Allocator, input: describe_db_proxy_targets.DescribeDBProxyTargetsInput, options: describe_db_proxy_targets.Options) !describe_db_proxy_targets.DescribeDBProxyTargetsOutput {
        return describe_db_proxy_targets.execute(self, allocator, input, options);
    }

    /// Describes the recommendations to resolve the issues for your DB instances,
    /// DB clusters, and DB parameter groups.
    pub fn describeDbRecommendations(self: *Self, allocator: std.mem.Allocator, input: describe_db_recommendations.DescribeDBRecommendationsInput, options: describe_db_recommendations.Options) !describe_db_recommendations.DescribeDBRecommendationsOutput {
        return describe_db_recommendations.execute(self, allocator, input, options);
    }

    /// Returns a list of `DBSecurityGroup` descriptions. If a `DBSecurityGroupName`
    /// is specified, the list will contain only the descriptions of the specified
    /// DB security group.
    ///
    /// EC2-Classic was retired on August 15, 2022. If you haven't migrated from
    /// EC2-Classic to a VPC, we recommend that you migrate as soon as possible. For
    /// more information, see [Migrate from EC2-Classic to a
    /// VPC](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/vpc-migrate.html)
    /// in the *Amazon EC2 User Guide*, the blog [EC2-Classic Networking is Retiring
    /// – Here’s How to
    /// Prepare](http://aws.amazon.com/blogs/aws/ec2-classic-is-retiring-heres-how-to-prepare/), and [Moving a DB instance not in a VPC into a VPC](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_VPC.Non-VPC2VPC.html) in the *Amazon RDS User Guide*.
    pub fn describeDbSecurityGroups(self: *Self, allocator: std.mem.Allocator, input: describe_db_security_groups.DescribeDBSecurityGroupsInput, options: describe_db_security_groups.Options) !describe_db_security_groups.DescribeDBSecurityGroupsOutput {
        return describe_db_security_groups.execute(self, allocator, input, options);
    }

    /// Describes existing Aurora Limitless Database DB shard groups.
    pub fn describeDbShardGroups(self: *Self, allocator: std.mem.Allocator, input: describe_db_shard_groups.DescribeDBShardGroupsInput, options: describe_db_shard_groups.Options) !describe_db_shard_groups.DescribeDBShardGroupsOutput {
        return describe_db_shard_groups.execute(self, allocator, input, options);
    }

    /// Returns a list of DB snapshot attribute names and values for a manual DB
    /// snapshot.
    ///
    /// When sharing snapshots with other Amazon Web Services accounts,
    /// `DescribeDBSnapshotAttributes` returns the `restore` attribute and a list of
    /// IDs for the Amazon Web Services accounts that are authorized to copy or
    /// restore the manual DB snapshot. If `all` is included in the list of values
    /// for the `restore` attribute, then the manual DB snapshot is public and can
    /// be copied or restored by all Amazon Web Services accounts.
    ///
    /// To add or remove access for an Amazon Web Services account to copy or
    /// restore a manual DB snapshot, or to make the manual DB snapshot public or
    /// private, use the `ModifyDBSnapshotAttribute` API action.
    pub fn describeDbSnapshotAttributes(self: *Self, allocator: std.mem.Allocator, input: describe_db_snapshot_attributes.DescribeDBSnapshotAttributesInput, options: describe_db_snapshot_attributes.Options) !describe_db_snapshot_attributes.DescribeDBSnapshotAttributesOutput {
        return describe_db_snapshot_attributes.execute(self, allocator, input, options);
    }

    /// Describes the tenant databases that exist in a DB snapshot. This command
    /// only applies to RDS for Oracle DB instances in the multi-tenant
    /// configuration.
    ///
    /// You can use this command to inspect the tenant databases within a snapshot
    /// before restoring it. You can't directly interact with the tenant databases
    /// in a DB snapshot. If you restore a snapshot that was taken from DB instance
    /// using the multi-tenant configuration, you restore all its tenant databases.
    pub fn describeDbSnapshotTenantDatabases(self: *Self, allocator: std.mem.Allocator, input: describe_db_snapshot_tenant_databases.DescribeDBSnapshotTenantDatabasesInput, options: describe_db_snapshot_tenant_databases.Options) !describe_db_snapshot_tenant_databases.DescribeDBSnapshotTenantDatabasesOutput {
        return describe_db_snapshot_tenant_databases.execute(self, allocator, input, options);
    }

    /// Returns information about DB snapshots. This API action supports pagination.
    pub fn describeDbSnapshots(self: *Self, allocator: std.mem.Allocator, input: describe_db_snapshots.DescribeDBSnapshotsInput, options: describe_db_snapshots.Options) !describe_db_snapshots.DescribeDBSnapshotsOutput {
        return describe_db_snapshots.execute(self, allocator, input, options);
    }

    /// Returns a list of DBSubnetGroup descriptions. If a DBSubnetGroupName is
    /// specified, the list will contain only the descriptions of the specified
    /// DBSubnetGroup.
    ///
    /// For an overview of CIDR ranges, go to the [Wikipedia
    /// Tutorial](http://en.wikipedia.org/wiki/Classless_Inter-Domain_Routing).
    pub fn describeDbSubnetGroups(self: *Self, allocator: std.mem.Allocator, input: describe_db_subnet_groups.DescribeDBSubnetGroupsInput, options: describe_db_subnet_groups.Options) !describe_db_subnet_groups.DescribeDBSubnetGroupsOutput {
        return describe_db_subnet_groups.execute(self, allocator, input, options);
    }

    /// Returns the default engine and system parameter information for the cluster
    /// database engine.
    ///
    /// For more information on Amazon Aurora, see [ What is Amazon
    /// Aurora?](https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/CHAP_AuroraOverview.html) in the *Amazon Aurora User Guide*.
    pub fn describeEngineDefaultClusterParameters(self: *Self, allocator: std.mem.Allocator, input: describe_engine_default_cluster_parameters.DescribeEngineDefaultClusterParametersInput, options: describe_engine_default_cluster_parameters.Options) !describe_engine_default_cluster_parameters.DescribeEngineDefaultClusterParametersOutput {
        return describe_engine_default_cluster_parameters.execute(self, allocator, input, options);
    }

    /// Returns the default engine and system parameter information for the
    /// specified database engine.
    pub fn describeEngineDefaultParameters(self: *Self, allocator: std.mem.Allocator, input: describe_engine_default_parameters.DescribeEngineDefaultParametersInput, options: describe_engine_default_parameters.Options) !describe_engine_default_parameters.DescribeEngineDefaultParametersOutput {
        return describe_engine_default_parameters.execute(self, allocator, input, options);
    }

    /// Displays a list of categories for all event source types, or, if specified,
    /// for a specified source type. You can also see this list in the "Amazon RDS
    /// event categories and event messages" section of the [ *Amazon RDS User
    /// Guide*
    /// ](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_Events.Messages.html) or the [ *Amazon Aurora User Guide* ](https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/USER_Events.Messages.html).
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

    /// Returns events related to DB instances, DB clusters, DB parameter groups, DB
    /// security groups, DB snapshots, DB cluster snapshots, and RDS Proxies for the
    /// past 14 days. Events specific to a particular DB instance, DB cluster, DB
    /// parameter group, DB security group, DB snapshot, DB cluster snapshot group,
    /// or RDS Proxy can be obtained by providing the name as a parameter.
    ///
    /// For more information on working with events, see [Monitoring Amazon RDS
    /// events](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/working-with-events.html) in the *Amazon RDS User Guide* and [Monitoring Amazon Aurora events](https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/working-with-events.html) in the *Amazon Aurora User Guide*.
    ///
    /// By default, RDS returns events that were generated in the past hour.
    pub fn describeEvents(self: *Self, allocator: std.mem.Allocator, input: describe_events.DescribeEventsInput, options: describe_events.Options) !describe_events.DescribeEventsOutput {
        return describe_events.execute(self, allocator, input, options);
    }

    /// Returns information about a snapshot or cluster export to Amazon S3. This
    /// API operation supports pagination.
    pub fn describeExportTasks(self: *Self, allocator: std.mem.Allocator, input: describe_export_tasks.DescribeExportTasksInput, options: describe_export_tasks.Options) !describe_export_tasks.DescribeExportTasksOutput {
        return describe_export_tasks.execute(self, allocator, input, options);
    }

    /// Returns information about Aurora global database clusters. This API supports
    /// pagination.
    ///
    /// For more information on Amazon Aurora, see [ What is Amazon
    /// Aurora?](https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/CHAP_AuroraOverview.html) in the *Amazon Aurora User Guide*.
    ///
    /// This action only applies to Aurora DB clusters.
    pub fn describeGlobalClusters(self: *Self, allocator: std.mem.Allocator, input: describe_global_clusters.DescribeGlobalClustersInput, options: describe_global_clusters.Options) !describe_global_clusters.DescribeGlobalClustersOutput {
        return describe_global_clusters.execute(self, allocator, input, options);
    }

    /// Describe one or more zero-ETL integrations with Amazon Redshift.
    pub fn describeIntegrations(self: *Self, allocator: std.mem.Allocator, input: describe_integrations.DescribeIntegrationsInput, options: describe_integrations.Options) !describe_integrations.DescribeIntegrationsOutput {
        return describe_integrations.execute(self, allocator, input, options);
    }

    /// Describes all available options for the specified engine.
    pub fn describeOptionGroupOptions(self: *Self, allocator: std.mem.Allocator, input: describe_option_group_options.DescribeOptionGroupOptionsInput, options: describe_option_group_options.Options) !describe_option_group_options.DescribeOptionGroupOptionsOutput {
        return describe_option_group_options.execute(self, allocator, input, options);
    }

    /// Describes the available option groups.
    pub fn describeOptionGroups(self: *Self, allocator: std.mem.Allocator, input: describe_option_groups.DescribeOptionGroupsInput, options: describe_option_groups.Options) !describe_option_groups.DescribeOptionGroupsOutput {
        return describe_option_groups.execute(self, allocator, input, options);
    }

    /// Describes the orderable DB instance options for a specified DB engine.
    pub fn describeOrderableDbInstanceOptions(self: *Self, allocator: std.mem.Allocator, input: describe_orderable_db_instance_options.DescribeOrderableDBInstanceOptionsInput, options: describe_orderable_db_instance_options.Options) !describe_orderable_db_instance_options.DescribeOrderableDBInstanceOptionsOutput {
        return describe_orderable_db_instance_options.execute(self, allocator, input, options);
    }

    /// Returns a list of resources (for example, DB instances) that have at least
    /// one pending maintenance action.
    ///
    /// This API follows an eventual consistency model. This means that the result
    /// of the `DescribePendingMaintenanceActions` command might not be immediately
    /// visible to all subsequent RDS commands. Keep this in mind when you use
    /// `DescribePendingMaintenanceActions` immediately after using a previous API
    /// command such as `ApplyPendingMaintenanceActions`.
    pub fn describePendingMaintenanceActions(self: *Self, allocator: std.mem.Allocator, input: describe_pending_maintenance_actions.DescribePendingMaintenanceActionsInput, options: describe_pending_maintenance_actions.Options) !describe_pending_maintenance_actions.DescribePendingMaintenanceActionsOutput {
        return describe_pending_maintenance_actions.execute(self, allocator, input, options);
    }

    /// Returns information about reserved DB instances for this account, or about a
    /// specified reserved DB instance.
    pub fn describeReservedDbInstances(self: *Self, allocator: std.mem.Allocator, input: describe_reserved_db_instances.DescribeReservedDBInstancesInput, options: describe_reserved_db_instances.Options) !describe_reserved_db_instances.DescribeReservedDBInstancesOutput {
        return describe_reserved_db_instances.execute(self, allocator, input, options);
    }

    /// Lists available reserved DB instance offerings.
    pub fn describeReservedDbInstancesOfferings(self: *Self, allocator: std.mem.Allocator, input: describe_reserved_db_instances_offerings.DescribeReservedDBInstancesOfferingsInput, options: describe_reserved_db_instances_offerings.Options) !describe_reserved_db_instances_offerings.DescribeReservedDBInstancesOfferingsOutput {
        return describe_reserved_db_instances_offerings.execute(self, allocator, input, options);
    }

    /// Returns a list of the source Amazon Web Services Regions where the current
    /// Amazon Web Services Region can create a read replica, copy a DB snapshot
    /// from, or replicate automated backups from.
    ///
    /// Use this operation to determine whether cross-Region features are supported
    /// between other Regions and your current Region. This operation supports
    /// pagination.
    ///
    /// To return information about the Regions that are enabled for your account,
    /// or all Regions, use the EC2 operation `DescribeRegions`. For more
    /// information, see [
    /// DescribeRegions](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_DescribeRegions.html) in the *Amazon EC2 API Reference*.
    pub fn describeSourceRegions(self: *Self, allocator: std.mem.Allocator, input: describe_source_regions.DescribeSourceRegionsInput, options: describe_source_regions.Options) !describe_source_regions.DescribeSourceRegionsOutput {
        return describe_source_regions.execute(self, allocator, input, options);
    }

    /// Describes the tenant databases in a DB instance that uses the multi-tenant
    /// configuration. Only RDS for Oracle CDB instances are supported.
    pub fn describeTenantDatabases(self: *Self, allocator: std.mem.Allocator, input: describe_tenant_databases.DescribeTenantDatabasesInput, options: describe_tenant_databases.Options) !describe_tenant_databases.DescribeTenantDatabasesOutput {
        return describe_tenant_databases.execute(self, allocator, input, options);
    }

    /// You can call `DescribeValidDBInstanceModifications` to learn what
    /// modifications you can make to your DB instance. You can use this information
    /// when you call `ModifyDBInstance`.
    ///
    /// This command doesn't apply to RDS Custom.
    pub fn describeValidDbInstanceModifications(self: *Self, allocator: std.mem.Allocator, input: describe_valid_db_instance_modifications.DescribeValidDBInstanceModificationsInput, options: describe_valid_db_instance_modifications.Options) !describe_valid_db_instance_modifications.DescribeValidDBInstanceModificationsOutput {
        return describe_valid_db_instance_modifications.execute(self, allocator, input, options);
    }

    /// Disables the HTTP endpoint for the specified DB cluster. Disabling this
    /// endpoint disables RDS Data API.
    ///
    /// For more information, see [Using RDS Data
    /// API](https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/data-api.html) in the *Amazon Aurora User Guide*.
    ///
    /// This operation applies only to Aurora Serverless v2 and provisioned DB
    /// clusters. To disable the HTTP endpoint for Aurora Serverless v1 DB clusters,
    /// use the `EnableHttpEndpoint` parameter of the `ModifyDBCluster` operation.
    pub fn disableHttpEndpoint(self: *Self, allocator: std.mem.Allocator, input: disable_http_endpoint.DisableHttpEndpointInput, options: disable_http_endpoint.Options) !disable_http_endpoint.DisableHttpEndpointOutput {
        return disable_http_endpoint.execute(self, allocator, input, options);
    }

    /// Downloads all or a portion of the specified log file, up to 1 MB in size.
    ///
    /// This command doesn't apply to RDS Custom.
    ///
    /// This operation uses resources on database instances. Because of this, we
    /// recommend publishing database logs to CloudWatch and then using the
    /// GetLogEvents operation. For more information, see
    /// [GetLogEvents](https://docs.aws.amazon.com/AmazonCloudWatchLogs/latest/APIReference/API_GetLogEvents.html) in the *Amazon CloudWatch Logs API Reference*.
    pub fn downloadDbLogFilePortion(self: *Self, allocator: std.mem.Allocator, input: download_db_log_file_portion.DownloadDBLogFilePortionInput, options: download_db_log_file_portion.Options) !download_db_log_file_portion.DownloadDBLogFilePortionOutput {
        return download_db_log_file_portion.execute(self, allocator, input, options);
    }

    /// Enables the HTTP endpoint for the DB cluster. By default, the HTTP endpoint
    /// isn't enabled.
    ///
    /// When enabled, this endpoint provides a connectionless web service API (RDS
    /// Data API) for running SQL queries on the Aurora DB cluster. You can also
    /// query your database from inside the RDS console with the RDS query editor.
    ///
    /// For more information, see [Using RDS Data
    /// API](https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/data-api.html) in the *Amazon Aurora User Guide*.
    ///
    /// This operation applies only to Aurora Serverless v2 and provisioned DB
    /// clusters. To enable the HTTP endpoint for Aurora Serverless v1 DB clusters,
    /// use the `EnableHttpEndpoint` parameter of the `ModifyDBCluster` operation.
    pub fn enableHttpEndpoint(self: *Self, allocator: std.mem.Allocator, input: enable_http_endpoint.EnableHttpEndpointInput, options: enable_http_endpoint.Options) !enable_http_endpoint.EnableHttpEndpointOutput {
        return enable_http_endpoint.execute(self, allocator, input, options);
    }

    /// Forces a failover for a DB cluster.
    ///
    /// For an Aurora DB cluster, failover for a DB cluster promotes one of the
    /// Aurora Replicas (read-only instances) in the DB cluster to be the primary DB
    /// instance (the cluster writer).
    ///
    /// For a Multi-AZ DB cluster, after RDS terminates the primary DB instance, the
    /// internal monitoring system detects that the primary DB instance is unhealthy
    /// and promotes a readable standby (read-only instances) in the DB cluster to
    /// be the primary DB instance (the cluster writer). Failover times are
    /// typically less than 35 seconds.
    ///
    /// An Amazon Aurora DB cluster automatically fails over to an Aurora Replica,
    /// if one exists, when the primary DB instance fails. A Multi-AZ DB cluster
    /// automatically fails over to a readable standby DB instance when the primary
    /// DB instance fails.
    ///
    /// To simulate a failure of a primary instance for testing, you can force a
    /// failover. Because each instance in a DB cluster has its own endpoint
    /// address, make sure to clean up and re-establish any existing connections
    /// that use those endpoint addresses when the failover is complete.
    ///
    /// For more information on Amazon Aurora DB clusters, see [ What is Amazon
    /// Aurora?](https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/CHAP_AuroraOverview.html) in the *Amazon Aurora User Guide*.
    ///
    /// For more information on Multi-AZ DB clusters, see [ Multi-AZ DB cluster
    /// deployments](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/multi-az-db-clusters-concepts.html) in the *Amazon RDS User Guide*.
    pub fn failoverDbCluster(self: *Self, allocator: std.mem.Allocator, input: failover_db_cluster.FailoverDBClusterInput, options: failover_db_cluster.Options) !failover_db_cluster.FailoverDBClusterOutput {
        return failover_db_cluster.execute(self, allocator, input, options);
    }

    /// Promotes the specified secondary DB cluster to be the primary DB cluster in
    /// the global database cluster to fail over or switch over a global database.
    /// Switchover operations were previously called "managed planned failovers."
    ///
    /// Although this operation can be used either to fail over or to switch over a
    /// global database cluster, its intended use is for global database failover.
    /// To switch over a global database cluster, we recommend that you use the
    /// SwitchoverGlobalCluster operation instead.
    ///
    /// How you use this operation depends on whether you are failing over or
    /// switching over your global database cluster:
    ///
    /// * Failing over - Specify the `AllowDataLoss` parameter and don't specify the
    ///   `Switchover` parameter.
    /// * Switching over - Specify the `Switchover` parameter or omit it, but don't
    ///   specify the `AllowDataLoss` parameter.
    ///
    /// **About failing over and switching over**
    ///
    /// While failing over and switching over a global database cluster both change
    /// the primary DB cluster, you use these operations for different reasons:
    ///
    /// * *Failing over* - Use this operation to respond to an unplanned event, such
    ///   as a Regional disaster in the primary Region. Failing over can result in a
    ///   loss of write transaction data that wasn't replicated to the chosen
    ///   secondary before the failover event occurred. However, the recovery
    ///   process that promotes a DB instance on the chosen seconday DB cluster to
    ///   be the primary writer DB instance guarantees that the data is in a
    ///   transactionally consistent state.
    ///
    /// For more information about failing over an Amazon Aurora global database,
    /// see [Performing managed failovers for Aurora global
    /// databases](https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/aurora-global-database-disaster-recovery.html#aurora-global-database-failover.managed-unplanned) in the *Amazon Aurora User Guide*.
    /// * *Switching over* - Use this operation on a healthy global database cluster
    ///   for planned events, such as Regional rotation or to fail back to the
    ///   original primary DB cluster after a failover operation. With this
    ///   operation, there is no data loss.
    ///
    /// For more information about switching over an Amazon Aurora global database,
    /// see [Performing switchovers for Aurora global
    /// databases](https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/aurora-global-database-disaster-recovery.html#aurora-global-database-disaster-recovery.managed-failover) in the *Amazon Aurora User Guide*.
    pub fn failoverGlobalCluster(self: *Self, allocator: std.mem.Allocator, input: failover_global_cluster.FailoverGlobalClusterInput, options: failover_global_cluster.Options) !failover_global_cluster.FailoverGlobalClusterOutput {
        return failover_global_cluster.execute(self, allocator, input, options);
    }

    /// Lists all tags on an Amazon RDS resource.
    ///
    /// For an overview on tagging an Amazon RDS resource, see [Tagging Amazon RDS
    /// Resources](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_Tagging.html) in the *Amazon RDS User Guide* or [Tagging Amazon Aurora and Amazon RDS Resources](https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/USER_Tagging.html) in the *Amazon Aurora User Guide*.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: list_tags_for_resource.Options) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Changes the audit policy state of a database activity stream to either
    /// locked (default) or unlocked. A locked policy is read-only, whereas an
    /// unlocked policy is read/write. If your activity stream is started and
    /// locked, you can unlock it, customize your audit policy, and then lock your
    /// activity stream. Restarting the activity stream isn't required. For more
    /// information, see [ Modifying a database activity
    /// stream](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/DBActivityStreams.Modifying.html) in the *Amazon RDS User Guide*.
    ///
    /// This operation is supported for RDS for Oracle and Microsoft SQL Server.
    pub fn modifyActivityStream(self: *Self, allocator: std.mem.Allocator, input: modify_activity_stream.ModifyActivityStreamInput, options: modify_activity_stream.Options) !modify_activity_stream.ModifyActivityStreamOutput {
        return modify_activity_stream.execute(self, allocator, input, options);
    }

    /// Override the system-default Secure Sockets Layer/Transport Layer Security
    /// (SSL/TLS) certificate for Amazon RDS for new DB instances, or remove the
    /// override.
    ///
    /// By using this operation, you can specify an RDS-approved SSL/TLS certificate
    /// for new DB instances that is different from the default certificate provided
    /// by RDS. You can also use this operation to remove the override, so that new
    /// DB instances use the default certificate provided by RDS.
    ///
    /// You might need to override the default certificate in the following
    /// situations:
    ///
    /// * You already migrated your applications to support the latest certificate
    ///   authority (CA) certificate, but the new CA certificate is not yet the RDS
    ///   default CA certificate for the specified Amazon Web Services Region.
    /// * RDS has already moved to a new default CA certificate for the specified
    ///   Amazon Web Services Region, but you are still in the process of supporting
    ///   the new CA certificate. In this case, you temporarily need additional time
    ///   to finish your application changes.
    ///
    /// For more information about rotating your SSL/TLS certificate for RDS DB
    /// engines, see [ Rotating Your SSL/TLS
    /// Certificate](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/UsingWithRDS.SSL-certificate-rotation.html) in the *Amazon RDS User Guide*.
    ///
    /// For more information about rotating your SSL/TLS certificate for Aurora DB
    /// engines, see [ Rotating Your SSL/TLS
    /// Certificate](https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/UsingWithRDS.SSL-certificate-rotation.html) in the *Amazon Aurora User Guide*.
    pub fn modifyCertificates(self: *Self, allocator: std.mem.Allocator, input: modify_certificates.ModifyCertificatesInput, options: modify_certificates.Options) !modify_certificates.ModifyCertificatesOutput {
        return modify_certificates.execute(self, allocator, input, options);
    }

    /// Set the capacity of an Aurora Serverless v1 DB cluster to a specific value.
    ///
    /// Aurora Serverless v1 scales seamlessly based on the workload on the DB
    /// cluster. In some cases, the capacity might not scale fast enough to meet a
    /// sudden change in workload, such as a large number of new transactions. Call
    /// `ModifyCurrentDBClusterCapacity` to set the capacity explicitly.
    ///
    /// After this call sets the DB cluster capacity, Aurora Serverless v1 can
    /// automatically scale the DB cluster based on the cooldown period for scaling
    /// up and the cooldown period for scaling down.
    ///
    /// For more information about Aurora Serverless v1, see [Using Amazon Aurora
    /// Serverless
    /// v1](https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/aurora-serverless.html) in the *Amazon Aurora User Guide*.
    ///
    /// If you call `ModifyCurrentDBClusterCapacity` with the default
    /// `TimeoutAction`, connections that prevent Aurora Serverless v1 from finding
    /// a scaling point might be dropped. For more information about scaling points,
    /// see [ Autoscaling for Aurora Serverless
    /// v1](https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/aurora-serverless.how-it-works.html#aurora-serverless.how-it-works.auto-scaling) in the *Amazon Aurora User Guide*.
    ///
    /// This operation only applies to Aurora Serverless v1 DB clusters.
    pub fn modifyCurrentDbClusterCapacity(self: *Self, allocator: std.mem.Allocator, input: modify_current_db_cluster_capacity.ModifyCurrentDBClusterCapacityInput, options: modify_current_db_cluster_capacity.Options) !modify_current_db_cluster_capacity.ModifyCurrentDBClusterCapacityOutput {
        return modify_current_db_cluster_capacity.execute(self, allocator, input, options);
    }

    /// Modifies the status of a custom engine version (CEV). You can find CEVs to
    /// modify by calling `DescribeDBEngineVersions`.
    ///
    /// The MediaImport service that imports files from Amazon S3 to create CEVs
    /// isn't integrated with Amazon Web Services CloudTrail. If you turn on data
    /// logging for Amazon RDS in CloudTrail, calls to the
    /// `ModifyCustomDbEngineVersion` event aren't logged. However, you might see
    /// calls from the API gateway that accesses your Amazon S3 bucket. These calls
    /// originate from the MediaImport service for the `ModifyCustomDbEngineVersion`
    /// event.
    ///
    /// For more information, see [Modifying CEV
    /// status](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/custom-cev.html#custom-cev.modify) in the *Amazon RDS User Guide*.
    pub fn modifyCustomDbEngineVersion(self: *Self, allocator: std.mem.Allocator, input: modify_custom_db_engine_version.ModifyCustomDBEngineVersionInput, options: modify_custom_db_engine_version.Options) !modify_custom_db_engine_version.ModifyCustomDBEngineVersionOutput {
        return modify_custom_db_engine_version.execute(self, allocator, input, options);
    }

    /// Modifies the settings of an Amazon Aurora DB cluster or a Multi-AZ DB
    /// cluster. You can change one or more settings by specifying these parameters
    /// and the new values in the request.
    ///
    /// For more information on Amazon Aurora DB clusters, see [ What is Amazon
    /// Aurora?](https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/CHAP_AuroraOverview.html) in the *Amazon Aurora User Guide*.
    ///
    /// For more information on Multi-AZ DB clusters, see [ Multi-AZ DB cluster
    /// deployments](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/multi-az-db-clusters-concepts.html) in the *Amazon RDS User Guide*.
    pub fn modifyDbCluster(self: *Self, allocator: std.mem.Allocator, input: modify_db_cluster.ModifyDBClusterInput, options: modify_db_cluster.Options) !modify_db_cluster.ModifyDBClusterOutput {
        return modify_db_cluster.execute(self, allocator, input, options);
    }

    /// Modifies the properties of an endpoint in an Amazon Aurora DB cluster.
    ///
    /// This operation only applies to Aurora DB clusters.
    pub fn modifyDbClusterEndpoint(self: *Self, allocator: std.mem.Allocator, input: modify_db_cluster_endpoint.ModifyDBClusterEndpointInput, options: modify_db_cluster_endpoint.Options) !modify_db_cluster_endpoint.ModifyDBClusterEndpointOutput {
        return modify_db_cluster_endpoint.execute(self, allocator, input, options);
    }

    /// Modifies the parameters of a DB cluster parameter group. To modify more than
    /// one parameter, submit a list of the following: `ParameterName`,
    /// `ParameterValue`, and `ApplyMethod`. A maximum of 20 parameters can be
    /// modified in a single request.
    ///
    /// There are two types of parameters - dynamic parameters and static
    /// parameters. Changes to dynamic parameters are applied to the DB cluster
    /// immediately without a reboot. Changes to static parameters are applied only
    /// after the DB cluster is rebooted, which can be done using `RebootDBCluster`
    /// operation. You can use the *Parameter Groups* option of the [Amazon RDS
    /// console](https://console.aws.amazon.com/rds/) or the
    /// `DescribeDBClusterParameters` operation to verify that your DB cluster
    /// parameter group has been created or modified.
    ///
    /// For more information on Amazon Aurora DB clusters, see [ What is Amazon
    /// Aurora?](https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/CHAP_AuroraOverview.html) in the *Amazon Aurora User Guide*.
    ///
    /// For more information on Multi-AZ DB clusters, see [ Multi-AZ DB cluster
    /// deployments](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/multi-az-db-clusters-concepts.html) in the *Amazon RDS User Guide.*
    pub fn modifyDbClusterParameterGroup(self: *Self, allocator: std.mem.Allocator, input: modify_db_cluster_parameter_group.ModifyDBClusterParameterGroupInput, options: modify_db_cluster_parameter_group.Options) !modify_db_cluster_parameter_group.ModifyDBClusterParameterGroupOutput {
        return modify_db_cluster_parameter_group.execute(self, allocator, input, options);
    }

    /// Adds an attribute and values to, or removes an attribute and values from, a
    /// manual DB cluster snapshot.
    ///
    /// To share a manual DB cluster snapshot with other Amazon Web Services
    /// accounts, specify `restore` as the `AttributeName` and use the `ValuesToAdd`
    /// parameter to add a list of IDs of the Amazon Web Services accounts that are
    /// authorized to restore the manual DB cluster snapshot. Use the value `all` to
    /// make the manual DB cluster snapshot public, which means that it can be
    /// copied or restored by all Amazon Web Services accounts.
    ///
    /// Don't add the `all` value for any manual DB cluster snapshots that contain
    /// private information that you don't want available to all Amazon Web Services
    /// accounts.
    ///
    /// If a manual DB cluster snapshot is encrypted, it can be shared, but only by
    /// specifying a list of authorized Amazon Web Services account IDs for the
    /// `ValuesToAdd` parameter. You can't use `all` as a value for that parameter
    /// in this case.
    ///
    /// To view which Amazon Web Services accounts have access to copy or restore a
    /// manual DB cluster snapshot, or whether a manual DB cluster snapshot is
    /// public or private, use the DescribeDBClusterSnapshotAttributes API
    /// operation. The accounts are returned as values for the `restore` attribute.
    pub fn modifyDbClusterSnapshotAttribute(self: *Self, allocator: std.mem.Allocator, input: modify_db_cluster_snapshot_attribute.ModifyDBClusterSnapshotAttributeInput, options: modify_db_cluster_snapshot_attribute.Options) !modify_db_cluster_snapshot_attribute.ModifyDBClusterSnapshotAttributeOutput {
        return modify_db_cluster_snapshot_attribute.execute(self, allocator, input, options);
    }

    /// Modifies settings for a DB instance. You can change one or more database
    /// configuration parameters by specifying these parameters and the new values
    /// in the request. To learn what modifications you can make to your DB
    /// instance, call `DescribeValidDBInstanceModifications` before you call
    /// `ModifyDBInstance`.
    pub fn modifyDbInstance(self: *Self, allocator: std.mem.Allocator, input: modify_db_instance.ModifyDBInstanceInput, options: modify_db_instance.Options) !modify_db_instance.ModifyDBInstanceOutput {
        return modify_db_instance.execute(self, allocator, input, options);
    }

    /// Modifies the parameters of a DB parameter group. To modify more than one
    /// parameter, submit a list of the following: `ParameterName`,
    /// `ParameterValue`, and `ApplyMethod`. A maximum of 20 parameters can be
    /// modified in a single request.
    ///
    /// After you modify a DB parameter group, you should wait at least 5 minutes
    /// before creating your first DB instance that uses that DB parameter group as
    /// the default parameter group. This allows Amazon RDS to fully complete the
    /// modify operation before the parameter group is used as the default for a new
    /// DB instance. This is especially important for parameters that are critical
    /// when creating the default database for a DB instance, such as the character
    /// set for the default database defined by the `character_set_database`
    /// parameter. You can use the *Parameter Groups* option of the [Amazon RDS
    /// console](https://console.aws.amazon.com/rds/) or the *DescribeDBParameters*
    /// command to verify that your DB parameter group has been created or modified.
    pub fn modifyDbParameterGroup(self: *Self, allocator: std.mem.Allocator, input: modify_db_parameter_group.ModifyDBParameterGroupInput, options: modify_db_parameter_group.Options) !modify_db_parameter_group.ModifyDBParameterGroupOutput {
        return modify_db_parameter_group.execute(self, allocator, input, options);
    }

    /// Changes the settings for an existing DB proxy.
    pub fn modifyDbProxy(self: *Self, allocator: std.mem.Allocator, input: modify_db_proxy.ModifyDBProxyInput, options: modify_db_proxy.Options) !modify_db_proxy.ModifyDBProxyOutput {
        return modify_db_proxy.execute(self, allocator, input, options);
    }

    /// Changes the settings for an existing DB proxy endpoint.
    pub fn modifyDbProxyEndpoint(self: *Self, allocator: std.mem.Allocator, input: modify_db_proxy_endpoint.ModifyDBProxyEndpointInput, options: modify_db_proxy_endpoint.Options) !modify_db_proxy_endpoint.ModifyDBProxyEndpointOutput {
        return modify_db_proxy_endpoint.execute(self, allocator, input, options);
    }

    /// Modifies the properties of a `DBProxyTargetGroup`.
    pub fn modifyDbProxyTargetGroup(self: *Self, allocator: std.mem.Allocator, input: modify_db_proxy_target_group.ModifyDBProxyTargetGroupInput, options: modify_db_proxy_target_group.Options) !modify_db_proxy_target_group.ModifyDBProxyTargetGroupOutput {
        return modify_db_proxy_target_group.execute(self, allocator, input, options);
    }

    /// Updates the recommendation status and recommended action status for the
    /// specified recommendation.
    pub fn modifyDbRecommendation(self: *Self, allocator: std.mem.Allocator, input: modify_db_recommendation.ModifyDBRecommendationInput, options: modify_db_recommendation.Options) !modify_db_recommendation.ModifyDBRecommendationOutput {
        return modify_db_recommendation.execute(self, allocator, input, options);
    }

    /// Modifies the settings of an Aurora Limitless Database DB shard group. You
    /// can change one or more settings by specifying these parameters and the new
    /// values in the request.
    pub fn modifyDbShardGroup(self: *Self, allocator: std.mem.Allocator, input: modify_db_shard_group.ModifyDBShardGroupInput, options: modify_db_shard_group.Options) !modify_db_shard_group.ModifyDBShardGroupOutput {
        return modify_db_shard_group.execute(self, allocator, input, options);
    }

    /// Updates a manual DB snapshot with a new engine version. The snapshot can be
    /// encrypted or unencrypted, but not shared or public.
    ///
    /// Amazon RDS supports upgrading DB snapshots for MariaDB, MySQL, PostgreSQL,
    /// and Oracle. This operation doesn't apply to RDS Custom or RDS for Db2.
    pub fn modifyDbSnapshot(self: *Self, allocator: std.mem.Allocator, input: modify_db_snapshot.ModifyDBSnapshotInput, options: modify_db_snapshot.Options) !modify_db_snapshot.ModifyDBSnapshotOutput {
        return modify_db_snapshot.execute(self, allocator, input, options);
    }

    /// Adds an attribute and values to, or removes an attribute and values from, a
    /// manual DB snapshot.
    ///
    /// To share a manual DB snapshot with other Amazon Web Services accounts,
    /// specify `restore` as the `AttributeName` and use the `ValuesToAdd` parameter
    /// to add a list of IDs of the Amazon Web Services accounts that are authorized
    /// to restore the manual DB snapshot. Uses the value `all` to make the manual
    /// DB snapshot public, which means it can be copied or restored by all Amazon
    /// Web Services accounts.
    ///
    /// Don't add the `all` value for any manual DB snapshots that contain private
    /// information that you don't want available to all Amazon Web Services
    /// accounts.
    ///
    /// If the manual DB snapshot is encrypted, it can be shared, but only by
    /// specifying a list of authorized Amazon Web Services account IDs for the
    /// `ValuesToAdd` parameter. You can't use `all` as a value for that parameter
    /// in this case.
    ///
    /// To view which Amazon Web Services accounts have access to copy or restore a
    /// manual DB snapshot, or whether a manual DB snapshot public or private, use
    /// the DescribeDBSnapshotAttributes API operation. The accounts are returned as
    /// values for the `restore` attribute.
    pub fn modifyDbSnapshotAttribute(self: *Self, allocator: std.mem.Allocator, input: modify_db_snapshot_attribute.ModifyDBSnapshotAttributeInput, options: modify_db_snapshot_attribute.Options) !modify_db_snapshot_attribute.ModifyDBSnapshotAttributeOutput {
        return modify_db_snapshot_attribute.execute(self, allocator, input, options);
    }

    /// Modifies an existing DB subnet group. DB subnet groups must contain at least
    /// one subnet in at least two AZs in the Amazon Web Services Region.
    pub fn modifyDbSubnetGroup(self: *Self, allocator: std.mem.Allocator, input: modify_db_subnet_group.ModifyDBSubnetGroupInput, options: modify_db_subnet_group.Options) !modify_db_subnet_group.ModifyDBSubnetGroupOutput {
        return modify_db_subnet_group.execute(self, allocator, input, options);
    }

    /// Modifies an existing RDS event notification subscription. You can't modify
    /// the source identifiers using this call. To change source identifiers for a
    /// subscription, use the `AddSourceIdentifierToSubscription` and
    /// `RemoveSourceIdentifierFromSubscription` calls.
    ///
    /// You can see a list of the event categories for a given source type
    /// (`SourceType`) in
    /// [Events](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_Events.html) in the *Amazon RDS User Guide* or by using the `DescribeEventCategories` operation.
    pub fn modifyEventSubscription(self: *Self, allocator: std.mem.Allocator, input: modify_event_subscription.ModifyEventSubscriptionInput, options: modify_event_subscription.Options) !modify_event_subscription.ModifyEventSubscriptionOutput {
        return modify_event_subscription.execute(self, allocator, input, options);
    }

    /// Modifies a setting for an Amazon Aurora global database cluster. You can
    /// change one or more database configuration parameters by specifying these
    /// parameters and the new values in the request. For more information on Amazon
    /// Aurora, see [ What is Amazon
    /// Aurora?](https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/CHAP_AuroraOverview.html) in the *Amazon Aurora User Guide*.
    ///
    /// This operation only applies to Aurora global database clusters.
    pub fn modifyGlobalCluster(self: *Self, allocator: std.mem.Allocator, input: modify_global_cluster.ModifyGlobalClusterInput, options: modify_global_cluster.Options) !modify_global_cluster.ModifyGlobalClusterOutput {
        return modify_global_cluster.execute(self, allocator, input, options);
    }

    /// Modifies a zero-ETL integration with Amazon Redshift.
    pub fn modifyIntegration(self: *Self, allocator: std.mem.Allocator, input: modify_integration.ModifyIntegrationInput, options: modify_integration.Options) !modify_integration.ModifyIntegrationOutput {
        return modify_integration.execute(self, allocator, input, options);
    }

    /// Modifies an existing option group.
    pub fn modifyOptionGroup(self: *Self, allocator: std.mem.Allocator, input: modify_option_group.ModifyOptionGroupInput, options: modify_option_group.Options) !modify_option_group.ModifyOptionGroupOutput {
        return modify_option_group.execute(self, allocator, input, options);
    }

    /// Modifies an existing tenant database in a DB instance. You can change the
    /// tenant database name or the master user password. This operation is
    /// supported only for RDS for Oracle CDB instances using the multi-tenant
    /// configuration.
    pub fn modifyTenantDatabase(self: *Self, allocator: std.mem.Allocator, input: modify_tenant_database.ModifyTenantDatabaseInput, options: modify_tenant_database.Options) !modify_tenant_database.ModifyTenantDatabaseOutput {
        return modify_tenant_database.execute(self, allocator, input, options);
    }

    /// Promotes a read replica DB instance to a standalone DB instance.
    ///
    /// * Backup duration is a function of the amount of changes to the database
    ///   since the previous backup. If you plan to promote a read replica to a
    ///   standalone instance, we recommend that you enable backups and complete at
    ///   least one backup prior to promotion. In addition, a read replica cannot be
    ///   promoted to a standalone instance when it is in the `backing-up` status.
    ///   If you have enabled backups on your read replica, configure the automated
    ///   backup window so that daily backups do not interfere with read replica
    ///   promotion.
    /// * This command doesn't apply to Aurora MySQL, Aurora PostgreSQL, or RDS
    ///   Custom.
    pub fn promoteReadReplica(self: *Self, allocator: std.mem.Allocator, input: promote_read_replica.PromoteReadReplicaInput, options: promote_read_replica.Options) !promote_read_replica.PromoteReadReplicaOutput {
        return promote_read_replica.execute(self, allocator, input, options);
    }

    /// Promotes a read replica DB cluster to a standalone DB cluster.
    pub fn promoteReadReplicaDbCluster(self: *Self, allocator: std.mem.Allocator, input: promote_read_replica_db_cluster.PromoteReadReplicaDBClusterInput, options: promote_read_replica_db_cluster.Options) !promote_read_replica_db_cluster.PromoteReadReplicaDBClusterOutput {
        return promote_read_replica_db_cluster.execute(self, allocator, input, options);
    }

    /// Purchases a reserved DB instance offering.
    pub fn purchaseReservedDbInstancesOffering(self: *Self, allocator: std.mem.Allocator, input: purchase_reserved_db_instances_offering.PurchaseReservedDBInstancesOfferingInput, options: purchase_reserved_db_instances_offering.Options) !purchase_reserved_db_instances_offering.PurchaseReservedDBInstancesOfferingOutput {
        return purchase_reserved_db_instances_offering.execute(self, allocator, input, options);
    }

    /// You might need to reboot your DB cluster, usually for maintenance reasons.
    /// For example, if you make certain modifications, or if you change the DB
    /// cluster parameter group associated with the DB cluster, reboot the DB
    /// cluster for the changes to take effect.
    ///
    /// Rebooting a DB cluster restarts the database engine service. Rebooting a DB
    /// cluster results in a momentary outage, during which the DB cluster status is
    /// set to rebooting.
    ///
    /// Use this operation only for a non-Aurora Multi-AZ DB cluster.
    ///
    /// For more information on Multi-AZ DB clusters, see [ Multi-AZ DB cluster
    /// deployments](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/multi-az-db-clusters-concepts.html) in the *Amazon RDS User Guide.*
    pub fn rebootDbCluster(self: *Self, allocator: std.mem.Allocator, input: reboot_db_cluster.RebootDBClusterInput, options: reboot_db_cluster.Options) !reboot_db_cluster.RebootDBClusterOutput {
        return reboot_db_cluster.execute(self, allocator, input, options);
    }

    /// You might need to reboot your DB instance, usually for maintenance reasons.
    /// For example, if you make certain modifications, or if you change the DB
    /// parameter group associated with the DB instance, you must reboot the
    /// instance for the changes to take effect.
    ///
    /// Rebooting a DB instance restarts the database engine service. Rebooting a DB
    /// instance results in a momentary outage, during which the DB instance status
    /// is set to rebooting.
    ///
    /// For more information about rebooting, see [Rebooting a DB
    /// Instance](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_RebootInstance.html) in the *Amazon RDS User Guide.*
    ///
    /// This command doesn't apply to RDS Custom.
    ///
    /// If your DB instance is part of a Multi-AZ DB cluster, you can reboot the DB
    /// cluster with the `RebootDBCluster` operation.
    pub fn rebootDbInstance(self: *Self, allocator: std.mem.Allocator, input: reboot_db_instance.RebootDBInstanceInput, options: reboot_db_instance.Options) !reboot_db_instance.RebootDBInstanceOutput {
        return reboot_db_instance.execute(self, allocator, input, options);
    }

    /// You might need to reboot your DB shard group, usually for maintenance
    /// reasons. For example, if you make certain modifications, reboot the DB shard
    /// group for the changes to take effect.
    ///
    /// This operation applies only to Aurora Limitless Database DBb shard groups.
    pub fn rebootDbShardGroup(self: *Self, allocator: std.mem.Allocator, input: reboot_db_shard_group.RebootDBShardGroupInput, options: reboot_db_shard_group.Options) !reboot_db_shard_group.RebootDBShardGroupOutput {
        return reboot_db_shard_group.execute(self, allocator, input, options);
    }

    /// Associate one or more `DBProxyTarget` data structures with a
    /// `DBProxyTargetGroup`.
    pub fn registerDbProxyTargets(self: *Self, allocator: std.mem.Allocator, input: register_db_proxy_targets.RegisterDBProxyTargetsInput, options: register_db_proxy_targets.Options) !register_db_proxy_targets.RegisterDBProxyTargetsOutput {
        return register_db_proxy_targets.execute(self, allocator, input, options);
    }

    /// Detaches an Aurora secondary cluster from an Aurora global database cluster.
    /// The cluster becomes a standalone cluster with read-write capability instead
    /// of being read-only and receiving data from a primary cluster in a different
    /// Region.
    ///
    /// This operation only applies to Aurora DB clusters.
    pub fn removeFromGlobalCluster(self: *Self, allocator: std.mem.Allocator, input: remove_from_global_cluster.RemoveFromGlobalClusterInput, options: remove_from_global_cluster.Options) !remove_from_global_cluster.RemoveFromGlobalClusterOutput {
        return remove_from_global_cluster.execute(self, allocator, input, options);
    }

    /// Removes the asssociation of an Amazon Web Services Identity and Access
    /// Management (IAM) role from a DB cluster.
    ///
    /// For more information on Amazon Aurora DB clusters, see [ What is Amazon
    /// Aurora?](https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/CHAP_AuroraOverview.html) in the *Amazon Aurora User Guide*.
    ///
    /// For more information on Multi-AZ DB clusters, see [ Multi-AZ DB cluster
    /// deployments](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/multi-az-db-clusters-concepts.html) in the *Amazon RDS User Guide.*
    pub fn removeRoleFromDbCluster(self: *Self, allocator: std.mem.Allocator, input: remove_role_from_db_cluster.RemoveRoleFromDBClusterInput, options: remove_role_from_db_cluster.Options) !remove_role_from_db_cluster.RemoveRoleFromDBClusterOutput {
        return remove_role_from_db_cluster.execute(self, allocator, input, options);
    }

    /// Disassociates an Amazon Web Services Identity and Access Management (IAM)
    /// role from a DB instance.
    pub fn removeRoleFromDbInstance(self: *Self, allocator: std.mem.Allocator, input: remove_role_from_db_instance.RemoveRoleFromDBInstanceInput, options: remove_role_from_db_instance.Options) !remove_role_from_db_instance.RemoveRoleFromDBInstanceOutput {
        return remove_role_from_db_instance.execute(self, allocator, input, options);
    }

    /// Removes a source identifier from an existing RDS event notification
    /// subscription.
    pub fn removeSourceIdentifierFromSubscription(self: *Self, allocator: std.mem.Allocator, input: remove_source_identifier_from_subscription.RemoveSourceIdentifierFromSubscriptionInput, options: remove_source_identifier_from_subscription.Options) !remove_source_identifier_from_subscription.RemoveSourceIdentifierFromSubscriptionOutput {
        return remove_source_identifier_from_subscription.execute(self, allocator, input, options);
    }

    /// Removes metadata tags from an Amazon RDS resource.
    ///
    /// For an overview on tagging an Amazon RDS resource, see [Tagging Amazon RDS
    /// Resources](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_Tagging.html) in the *Amazon RDS User Guide* or [Tagging Amazon Aurora and Amazon RDS Resources](https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/USER_Tagging.html) in the *Amazon Aurora User Guide*.
    pub fn removeTagsFromResource(self: *Self, allocator: std.mem.Allocator, input: remove_tags_from_resource.RemoveTagsFromResourceInput, options: remove_tags_from_resource.Options) !remove_tags_from_resource.RemoveTagsFromResourceOutput {
        return remove_tags_from_resource.execute(self, allocator, input, options);
    }

    /// Modifies the parameters of a DB cluster parameter group to the default
    /// value. To reset specific parameters submit a list of the following:
    /// `ParameterName` and `ApplyMethod`. To reset the entire DB cluster parameter
    /// group, specify the `DBClusterParameterGroupName` and `ResetAllParameters`
    /// parameters.
    ///
    /// When resetting the entire group, dynamic parameters are updated immediately
    /// and static parameters are set to `pending-reboot` to take effect on the next
    /// DB instance restart or `RebootDBInstance` request. You must call
    /// `RebootDBInstance` for every DB instance in your DB cluster that you want
    /// the updated static parameter to apply to.
    ///
    /// For more information on Amazon Aurora DB clusters, see [ What is Amazon
    /// Aurora?](https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/CHAP_AuroraOverview.html) in the *Amazon Aurora User Guide*.
    ///
    /// For more information on Multi-AZ DB clusters, see [ Multi-AZ DB cluster
    /// deployments](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/multi-az-db-clusters-concepts.html) in the *Amazon RDS User Guide.*
    pub fn resetDbClusterParameterGroup(self: *Self, allocator: std.mem.Allocator, input: reset_db_cluster_parameter_group.ResetDBClusterParameterGroupInput, options: reset_db_cluster_parameter_group.Options) !reset_db_cluster_parameter_group.ResetDBClusterParameterGroupOutput {
        return reset_db_cluster_parameter_group.execute(self, allocator, input, options);
    }

    /// Modifies the parameters of a DB parameter group to the engine/system default
    /// value. To reset specific parameters, provide a list of the following:
    /// `ParameterName` and `ApplyMethod`. To reset the entire DB parameter group,
    /// specify the `DBParameterGroup` name and `ResetAllParameters` parameters.
    /// When resetting the entire group, dynamic parameters are updated immediately
    /// and static parameters are set to `pending-reboot` to take effect on the next
    /// DB instance restart or `RebootDBInstance` request.
    pub fn resetDbParameterGroup(self: *Self, allocator: std.mem.Allocator, input: reset_db_parameter_group.ResetDBParameterGroupInput, options: reset_db_parameter_group.Options) !reset_db_parameter_group.ResetDBParameterGroupOutput {
        return reset_db_parameter_group.execute(self, allocator, input, options);
    }

    /// Creates an Amazon Aurora DB cluster from MySQL data stored in an Amazon S3
    /// bucket. Amazon RDS must be authorized to access the Amazon S3 bucket and the
    /// data must be created using the Percona XtraBackup utility as described in [
    /// Migrating Data from MySQL by Using an Amazon S3
    /// Bucket](https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/AuroraMySQL.Migrating.ExtMySQL.html#AuroraMySQL.Migrating.ExtMySQL.S3) in the *Amazon Aurora User Guide*.
    ///
    /// This operation only restores the DB cluster, not the DB instances for that
    /// DB cluster. You must invoke the `CreateDBInstance` operation to create DB
    /// instances for the restored DB cluster, specifying the identifier of the
    /// restored DB cluster in `DBClusterIdentifier`. You can create DB instances
    /// only after the `RestoreDBClusterFromS3` operation has completed and the DB
    /// cluster is available.
    ///
    /// For more information on Amazon Aurora, see [ What is Amazon
    /// Aurora?](https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/CHAP_AuroraOverview.html) in the *Amazon Aurora User Guide*.
    ///
    /// This operation only applies to Aurora DB clusters. The source DB engine must
    /// be MySQL.
    pub fn restoreDbClusterFromS3(self: *Self, allocator: std.mem.Allocator, input: restore_db_cluster_from_s3.RestoreDBClusterFromS3Input, options: restore_db_cluster_from_s3.Options) !restore_db_cluster_from_s3.RestoreDBClusterFromS3Output {
        return restore_db_cluster_from_s3.execute(self, allocator, input, options);
    }

    /// Creates a new DB cluster from a DB snapshot or DB cluster snapshot.
    ///
    /// The target DB cluster is created from the source snapshot with a default
    /// configuration. If you don't specify a security group, the new DB cluster is
    /// associated with the default security group.
    ///
    /// This operation only restores the DB cluster, not the DB instances for that
    /// DB cluster. You must invoke the `CreateDBInstance` operation to create DB
    /// instances for the restored DB cluster, specifying the identifier of the
    /// restored DB cluster in `DBClusterIdentifier`. You can create DB instances
    /// only after the `RestoreDBClusterFromSnapshot` operation has completed and
    /// the DB cluster is available.
    ///
    /// For more information on Amazon Aurora DB clusters, see [ What is Amazon
    /// Aurora?](https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/CHAP_AuroraOverview.html) in the *Amazon Aurora User Guide*.
    ///
    /// For more information on Multi-AZ DB clusters, see [ Multi-AZ DB cluster
    /// deployments](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/multi-az-db-clusters-concepts.html) in the *Amazon RDS User Guide.*
    pub fn restoreDbClusterFromSnapshot(self: *Self, allocator: std.mem.Allocator, input: restore_db_cluster_from_snapshot.RestoreDBClusterFromSnapshotInput, options: restore_db_cluster_from_snapshot.Options) !restore_db_cluster_from_snapshot.RestoreDBClusterFromSnapshotOutput {
        return restore_db_cluster_from_snapshot.execute(self, allocator, input, options);
    }

    /// Restores a DB cluster to an arbitrary point in time. Users can restore to
    /// any point in time before `LatestRestorableTime` for up to
    /// `BackupRetentionPeriod` days. The target DB cluster is created from the
    /// source DB cluster with the same configuration as the original DB cluster,
    /// except that the new DB cluster is created with the default DB security
    /// group. Unless the `RestoreType` is set to `copy-on-write`, the restore may
    /// occur in a different Availability Zone (AZ) from the original DB cluster.
    /// The AZ where RDS restores the DB cluster depends on the AZs in the specified
    /// subnet group.
    ///
    /// For Aurora, this operation only restores the DB cluster, not the DB
    /// instances for that DB cluster. You must invoke the `CreateDBInstance`
    /// operation to create DB instances for the restored DB cluster, specifying the
    /// identifier of the restored DB cluster in `DBClusterIdentifier`. You can
    /// create DB instances only after the `RestoreDBClusterToPointInTime` operation
    /// has completed and the DB cluster is available.
    ///
    /// For more information on Amazon Aurora DB clusters, see [ What is Amazon
    /// Aurora?](https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/CHAP_AuroraOverview.html) in the *Amazon Aurora User Guide*.
    ///
    /// For more information on Multi-AZ DB clusters, see [ Multi-AZ DB cluster
    /// deployments](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/multi-az-db-clusters-concepts.html) in the *Amazon RDS User Guide.*
    pub fn restoreDbClusterToPointInTime(self: *Self, allocator: std.mem.Allocator, input: restore_db_cluster_to_point_in_time.RestoreDBClusterToPointInTimeInput, options: restore_db_cluster_to_point_in_time.Options) !restore_db_cluster_to_point_in_time.RestoreDBClusterToPointInTimeOutput {
        return restore_db_cluster_to_point_in_time.execute(self, allocator, input, options);
    }

    /// Creates a new DB instance from a DB snapshot. The target database is created
    /// from the source database restore point with most of the source's original
    /// configuration, including the default security group and DB parameter group.
    /// By default, the new DB instance is created as a Single-AZ deployment, except
    /// when the instance is a SQL Server instance that has an option group
    /// associated with mirroring. In this case, the instance becomes a Multi-AZ
    /// deployment, not a Single-AZ deployment.
    ///
    /// If you want to replace your original DB instance with the new, restored DB
    /// instance, then rename your original DB instance before you call the
    /// `RestoreDBInstanceFromDBSnapshot` operation. RDS doesn't allow two DB
    /// instances with the same name. After you have renamed your original DB
    /// instance with a different identifier, then you can pass the original name of
    /// the DB instance as the `DBInstanceIdentifier` in the call to the
    /// `RestoreDBInstanceFromDBSnapshot` operation. The result is that you replace
    /// the original DB instance with the DB instance created from the snapshot.
    ///
    /// If you are restoring from a shared manual DB snapshot, the
    /// `DBSnapshotIdentifier` must be the ARN of the shared DB snapshot.
    ///
    /// To restore from a DB snapshot with an unsupported engine version, you must
    /// first upgrade the engine version of the snapshot. For more information about
    /// upgrading a RDS for MySQL DB snapshot engine version, see [Upgrading a MySQL
    /// DB snapshot engine
    /// version](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/mysql-upgrade-snapshot.html). For more information about upgrading a RDS for PostgreSQL DB snapshot engine version, [Upgrading a PostgreSQL DB snapshot engine version](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_UpgradeDBSnapshot.PostgreSQL.html).
    ///
    /// This command doesn't apply to Aurora MySQL and Aurora PostgreSQL. For
    /// Aurora, use `RestoreDBClusterFromSnapshot`.
    pub fn restoreDbInstanceFromDbSnapshot(self: *Self, allocator: std.mem.Allocator, input: restore_db_instance_from_db_snapshot.RestoreDBInstanceFromDBSnapshotInput, options: restore_db_instance_from_db_snapshot.Options) !restore_db_instance_from_db_snapshot.RestoreDBInstanceFromDBSnapshotOutput {
        return restore_db_instance_from_db_snapshot.execute(self, allocator, input, options);
    }

    /// Amazon Relational Database Service (Amazon RDS) supports importing MySQL
    /// databases by using backup files. You can create a backup of your on-premises
    /// database, store it on Amazon Simple Storage Service (Amazon S3), and then
    /// restore the backup file onto a new Amazon RDS DB instance running MySQL. For
    /// more information, see [Restoring a backup into an Amazon RDS for MySQL DB
    /// instance](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/MySQL.Procedural.Importing.html) in the *Amazon RDS User Guide.*
    ///
    /// This operation doesn't apply to RDS Custom.
    pub fn restoreDbInstanceFromS3(self: *Self, allocator: std.mem.Allocator, input: restore_db_instance_from_s3.RestoreDBInstanceFromS3Input, options: restore_db_instance_from_s3.Options) !restore_db_instance_from_s3.RestoreDBInstanceFromS3Output {
        return restore_db_instance_from_s3.execute(self, allocator, input, options);
    }

    /// Restores a DB instance to an arbitrary point in time. You can restore to any
    /// point in time before the time identified by the `LatestRestorableTime`
    /// property. You can restore to a point up to the number of days specified by
    /// the `BackupRetentionPeriod` property.
    ///
    /// The target database is created with most of the original configuration, but
    /// in a system-selected Availability Zone, with the default security group, the
    /// default subnet group, and the default DB parameter group. By default, the
    /// new DB instance is created as a single-AZ deployment except when the
    /// instance is a SQL Server instance that has an option group that is
    /// associated with mirroring; in this case, the instance becomes a mirrored
    /// deployment and not a single-AZ deployment.
    ///
    /// This operation doesn't apply to Aurora MySQL and Aurora PostgreSQL. For
    /// Aurora, use `RestoreDBClusterToPointInTime`.
    pub fn restoreDbInstanceToPointInTime(self: *Self, allocator: std.mem.Allocator, input: restore_db_instance_to_point_in_time.RestoreDBInstanceToPointInTimeInput, options: restore_db_instance_to_point_in_time.Options) !restore_db_instance_to_point_in_time.RestoreDBInstanceToPointInTimeOutput {
        return restore_db_instance_to_point_in_time.execute(self, allocator, input, options);
    }

    /// Revokes ingress from a DBSecurityGroup for previously authorized IP ranges
    /// or EC2 or VPC security groups. Required parameters for this API are one of
    /// CIDRIP, EC2SecurityGroupId for VPC, or (EC2SecurityGroupOwnerId and either
    /// EC2SecurityGroupName or EC2SecurityGroupId).
    ///
    /// EC2-Classic was retired on August 15, 2022. If you haven't migrated from
    /// EC2-Classic to a VPC, we recommend that you migrate as soon as possible. For
    /// more information, see [Migrate from EC2-Classic to a
    /// VPC](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/vpc-migrate.html)
    /// in the *Amazon EC2 User Guide*, the blog [EC2-Classic Networking is Retiring
    /// – Here’s How to
    /// Prepare](http://aws.amazon.com/blogs/aws/ec2-classic-is-retiring-heres-how-to-prepare/), and [Moving a DB instance not in a VPC into a VPC](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_VPC.Non-VPC2VPC.html) in the *Amazon RDS User Guide*.
    pub fn revokeDbSecurityGroupIngress(self: *Self, allocator: std.mem.Allocator, input: revoke_db_security_group_ingress.RevokeDBSecurityGroupIngressInput, options: revoke_db_security_group_ingress.Options) !revoke_db_security_group_ingress.RevokeDBSecurityGroupIngressOutput {
        return revoke_db_security_group_ingress.execute(self, allocator, input, options);
    }

    /// Starts a database activity stream to monitor activity on the database. For
    /// more information, see [ Monitoring Amazon Aurora with Database Activity
    /// Streams](https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/DBActivityStreams.html) in the *Amazon Aurora User Guide* or [ Monitoring Amazon RDS with Database Activity Streams](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/DBActivityStreams.html) in the *Amazon RDS User Guide*.
    pub fn startActivityStream(self: *Self, allocator: std.mem.Allocator, input: start_activity_stream.StartActivityStreamInput, options: start_activity_stream.Options) !start_activity_stream.StartActivityStreamOutput {
        return start_activity_stream.execute(self, allocator, input, options);
    }

    /// Starts an Amazon Aurora DB cluster that was stopped using the Amazon Web
    /// Services console, the stop-db-cluster CLI command, or the `StopDBCluster`
    /// operation.
    ///
    /// For more information, see [ Stopping and Starting an Aurora
    /// Cluster](https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/aurora-cluster-stop-start.html) in the *Amazon Aurora User Guide*.
    ///
    /// This operation only applies to Aurora DB clusters.
    pub fn startDbCluster(self: *Self, allocator: std.mem.Allocator, input: start_db_cluster.StartDBClusterInput, options: start_db_cluster.Options) !start_db_cluster.StartDBClusterOutput {
        return start_db_cluster.execute(self, allocator, input, options);
    }

    /// Starts an Amazon RDS DB instance that was stopped using the Amazon Web
    /// Services console, the stop-db-instance CLI command, or the `StopDBInstance`
    /// operation.
    ///
    /// For more information, see [ Starting an Amazon RDS DB instance That Was
    /// Previously
    /// Stopped](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_StartInstance.html) in the *Amazon RDS User Guide.*
    ///
    /// This command doesn't apply to RDS Custom, Aurora MySQL, and Aurora
    /// PostgreSQL. For Aurora DB clusters, use `StartDBCluster` instead.
    pub fn startDbInstance(self: *Self, allocator: std.mem.Allocator, input: start_db_instance.StartDBInstanceInput, options: start_db_instance.Options) !start_db_instance.StartDBInstanceOutput {
        return start_db_instance.execute(self, allocator, input, options);
    }

    /// Enables replication of automated backups to a different Amazon Web Services
    /// Region.
    ///
    /// This command doesn't apply to RDS Custom.
    ///
    /// For more information, see [ Replicating Automated Backups to Another Amazon
    /// Web Services
    /// Region](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_ReplicateBackups.html) in the *Amazon RDS User Guide.*
    pub fn startDbInstanceAutomatedBackupsReplication(self: *Self, allocator: std.mem.Allocator, input: start_db_instance_automated_backups_replication.StartDBInstanceAutomatedBackupsReplicationInput, options: start_db_instance_automated_backups_replication.Options) !start_db_instance_automated_backups_replication.StartDBInstanceAutomatedBackupsReplicationOutput {
        return start_db_instance_automated_backups_replication.execute(self, allocator, input, options);
    }

    /// Starts an export of DB snapshot or DB cluster data to Amazon S3. The
    /// provided IAM role must have access to the S3 bucket.
    ///
    /// You can't export snapshot data from RDS Custom DB instances. For more
    /// information, see [ Supported Regions and DB engines for exporting snapshots
    /// to S3 in Amazon
    /// RDS](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/Concepts.RDS_Fea_Regions_DB-eng.Feature.ExportSnapshotToS3.html).
    ///
    /// For more information on exporting DB snapshot data, see [Exporting DB
    /// snapshot data to Amazon
    /// S3](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_ExportSnapshot.html) in the *Amazon RDS User Guide* or [Exporting DB cluster snapshot data to Amazon S3](https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/aurora-export-snapshot.html) in the *Amazon Aurora User Guide*.
    ///
    /// For more information on exporting DB cluster data, see [Exporting DB cluster
    /// data to Amazon
    /// S3](https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/export-cluster-data.html) in the *Amazon Aurora User Guide*.
    pub fn startExportTask(self: *Self, allocator: std.mem.Allocator, input: start_export_task.StartExportTaskInput, options: start_export_task.Options) !start_export_task.StartExportTaskOutput {
        return start_export_task.execute(self, allocator, input, options);
    }

    /// Stops a database activity stream that was started using the Amazon Web
    /// Services console, the `start-activity-stream` CLI command, or the
    /// `StartActivityStream` operation.
    ///
    /// For more information, see [ Monitoring Amazon Aurora with Database Activity
    /// Streams](https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/DBActivityStreams.html) in the *Amazon Aurora User Guide* or [ Monitoring Amazon RDS with Database Activity Streams](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/DBActivityStreams.html) in the *Amazon RDS User Guide*.
    pub fn stopActivityStream(self: *Self, allocator: std.mem.Allocator, input: stop_activity_stream.StopActivityStreamInput, options: stop_activity_stream.Options) !stop_activity_stream.StopActivityStreamOutput {
        return stop_activity_stream.execute(self, allocator, input, options);
    }

    /// Stops an Amazon Aurora DB cluster. When you stop a DB cluster, Aurora
    /// retains the DB cluster's metadata, including its endpoints and DB parameter
    /// groups. Aurora also retains the transaction logs so you can do a
    /// point-in-time restore if necessary.
    ///
    /// For more information, see [ Stopping and Starting an Aurora
    /// Cluster](https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/aurora-cluster-stop-start.html) in the *Amazon Aurora User Guide*.
    ///
    /// This operation only applies to Aurora DB clusters.
    pub fn stopDbCluster(self: *Self, allocator: std.mem.Allocator, input: stop_db_cluster.StopDBClusterInput, options: stop_db_cluster.Options) !stop_db_cluster.StopDBClusterOutput {
        return stop_db_cluster.execute(self, allocator, input, options);
    }

    /// Stops an Amazon RDS DB instance temporarily. When you stop a DB instance,
    /// Amazon RDS retains the DB instance's metadata, including its endpoint, DB
    /// parameter group, and option group membership. Amazon RDS also retains the
    /// transaction logs so you can do a point-in-time restore if necessary. The
    /// instance restarts automatically after 7 days.
    ///
    /// For more information, see [ Stopping an Amazon RDS DB Instance
    /// Temporarily](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_StopInstance.html) in the *Amazon RDS User Guide.*
    ///
    /// This command doesn't apply to RDS Custom, Aurora MySQL, and Aurora
    /// PostgreSQL. For Aurora clusters, use `StopDBCluster` instead.
    pub fn stopDbInstance(self: *Self, allocator: std.mem.Allocator, input: stop_db_instance.StopDBInstanceInput, options: stop_db_instance.Options) !stop_db_instance.StopDBInstanceOutput {
        return stop_db_instance.execute(self, allocator, input, options);
    }

    /// Stops automated backup replication for a DB instance.
    ///
    /// This command doesn't apply to RDS Custom, Aurora MySQL, and Aurora
    /// PostgreSQL.
    ///
    /// For more information, see [ Replicating Automated Backups to Another Amazon
    /// Web Services
    /// Region](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_ReplicateBackups.html) in the *Amazon RDS User Guide.*
    pub fn stopDbInstanceAutomatedBackupsReplication(self: *Self, allocator: std.mem.Allocator, input: stop_db_instance_automated_backups_replication.StopDBInstanceAutomatedBackupsReplicationInput, options: stop_db_instance_automated_backups_replication.Options) !stop_db_instance_automated_backups_replication.StopDBInstanceAutomatedBackupsReplicationOutput {
        return stop_db_instance_automated_backups_replication.execute(self, allocator, input, options);
    }

    /// Switches over a blue/green deployment.
    ///
    /// Before you switch over, production traffic is routed to the databases in the
    /// blue environment. After you switch over, production traffic is routed to the
    /// databases in the green environment.
    ///
    /// For more information, see [Using Amazon RDS Blue/Green Deployments for
    /// database
    /// updates](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/blue-green-deployments.html) in the *Amazon RDS User Guide* and [Using Amazon RDS Blue/Green Deployments for database updates](https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/blue-green-deployments.html) in the *Amazon Aurora User Guide*.
    pub fn switchoverBlueGreenDeployment(self: *Self, allocator: std.mem.Allocator, input: switchover_blue_green_deployment.SwitchoverBlueGreenDeploymentInput, options: switchover_blue_green_deployment.Options) !switchover_blue_green_deployment.SwitchoverBlueGreenDeploymentOutput {
        return switchover_blue_green_deployment.execute(self, allocator, input, options);
    }

    /// Switches over the specified secondary DB cluster to be the new primary DB
    /// cluster in the global database cluster. Switchover operations were
    /// previously called "managed planned failovers."
    ///
    /// Aurora promotes the specified secondary cluster to assume full read/write
    /// capabilities and demotes the current primary cluster to a secondary
    /// (read-only) cluster, maintaining the orginal replication topology. All
    /// secondary clusters are synchronized with the primary at the beginning of the
    /// process so the new primary continues operations for the Aurora global
    /// database without losing any data. Your database is unavailable for a short
    /// time while the primary and selected secondary clusters are assuming their
    /// new roles. For more information about switching over an Aurora global
    /// database, see [Performing switchovers for Amazon Aurora global
    /// databases](https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/aurora-global-database-disaster-recovery.html#aurora-global-database-disaster-recovery.managed-failover) in the *Amazon Aurora User Guide*.
    ///
    /// This operation is intended for controlled environments, for operations such
    /// as "regional rotation" or to fall back to the original primary after a
    /// global database failover.
    pub fn switchoverGlobalCluster(self: *Self, allocator: std.mem.Allocator, input: switchover_global_cluster.SwitchoverGlobalClusterInput, options: switchover_global_cluster.Options) !switchover_global_cluster.SwitchoverGlobalClusterOutput {
        return switchover_global_cluster.execute(self, allocator, input, options);
    }

    /// Switches over an Oracle standby database in an Oracle Data Guard
    /// environment, making it the new primary database. Issue this command in the
    /// Region that hosts the current standby database.
    pub fn switchoverReadReplica(self: *Self, allocator: std.mem.Allocator, input: switchover_read_replica.SwitchoverReadReplicaInput, options: switchover_read_replica.Options) !switchover_read_replica.SwitchoverReadReplicaOutput {
        return switchover_read_replica.execute(self, allocator, input, options);
    }

    pub fn describeBlueGreenDeploymentsPaginator(self: *Self, params: describe_blue_green_deployments.DescribeBlueGreenDeploymentsInput) paginator.DescribeBlueGreenDeploymentsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeCertificatesPaginator(self: *Self, params: describe_certificates.DescribeCertificatesInput) paginator.DescribeCertificatesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeDbClusterAutomatedBackupsPaginator(self: *Self, params: describe_db_cluster_automated_backups.DescribeDBClusterAutomatedBackupsInput) paginator.DescribeDBClusterAutomatedBackupsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeDbClusterBacktracksPaginator(self: *Self, params: describe_db_cluster_backtracks.DescribeDBClusterBacktracksInput) paginator.DescribeDBClusterBacktracksPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeDbClusterEndpointsPaginator(self: *Self, params: describe_db_cluster_endpoints.DescribeDBClusterEndpointsInput) paginator.DescribeDBClusterEndpointsPaginator {
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

    pub fn describeDbInstanceAutomatedBackupsPaginator(self: *Self, params: describe_db_instance_automated_backups.DescribeDBInstanceAutomatedBackupsInput) paginator.DescribeDBInstanceAutomatedBackupsPaginator {
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

    pub fn describeDbLogFilesPaginator(self: *Self, params: describe_db_log_files.DescribeDBLogFilesInput) paginator.DescribeDBLogFilesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeDbMajorEngineVersionsPaginator(self: *Self, params: describe_db_major_engine_versions.DescribeDBMajorEngineVersionsInput) paginator.DescribeDBMajorEngineVersionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeDbParameterGroupsPaginator(self: *Self, params: describe_db_parameter_groups.DescribeDBParameterGroupsInput) paginator.DescribeDBParameterGroupsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeDbParametersPaginator(self: *Self, params: describe_db_parameters.DescribeDBParametersInput) paginator.DescribeDBParametersPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeDbProxiesPaginator(self: *Self, params: describe_db_proxies.DescribeDBProxiesInput) paginator.DescribeDBProxiesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeDbProxyEndpointsPaginator(self: *Self, params: describe_db_proxy_endpoints.DescribeDBProxyEndpointsInput) paginator.DescribeDBProxyEndpointsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeDbProxyTargetGroupsPaginator(self: *Self, params: describe_db_proxy_target_groups.DescribeDBProxyTargetGroupsInput) paginator.DescribeDBProxyTargetGroupsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeDbProxyTargetsPaginator(self: *Self, params: describe_db_proxy_targets.DescribeDBProxyTargetsInput) paginator.DescribeDBProxyTargetsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeDbRecommendationsPaginator(self: *Self, params: describe_db_recommendations.DescribeDBRecommendationsInput) paginator.DescribeDBRecommendationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeDbSecurityGroupsPaginator(self: *Self, params: describe_db_security_groups.DescribeDBSecurityGroupsInput) paginator.DescribeDBSecurityGroupsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeDbSnapshotTenantDatabasesPaginator(self: *Self, params: describe_db_snapshot_tenant_databases.DescribeDBSnapshotTenantDatabasesInput) paginator.DescribeDBSnapshotTenantDatabasesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeDbSnapshotsPaginator(self: *Self, params: describe_db_snapshots.DescribeDBSnapshotsInput) paginator.DescribeDBSnapshotsPaginator {
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

    pub fn describeEngineDefaultClusterParametersPaginator(self: *Self, params: describe_engine_default_cluster_parameters.DescribeEngineDefaultClusterParametersInput) paginator.DescribeEngineDefaultClusterParametersPaginator {
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

    pub fn describeExportTasksPaginator(self: *Self, params: describe_export_tasks.DescribeExportTasksInput) paginator.DescribeExportTasksPaginator {
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

    pub fn describeIntegrationsPaginator(self: *Self, params: describe_integrations.DescribeIntegrationsInput) paginator.DescribeIntegrationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeOptionGroupOptionsPaginator(self: *Self, params: describe_option_group_options.DescribeOptionGroupOptionsInput) paginator.DescribeOptionGroupOptionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeOptionGroupsPaginator(self: *Self, params: describe_option_groups.DescribeOptionGroupsInput) paginator.DescribeOptionGroupsPaginator {
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

    pub fn describeReservedDbInstancesPaginator(self: *Self, params: describe_reserved_db_instances.DescribeReservedDBInstancesInput) paginator.DescribeReservedDBInstancesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeReservedDbInstancesOfferingsPaginator(self: *Self, params: describe_reserved_db_instances_offerings.DescribeReservedDBInstancesOfferingsInput) paginator.DescribeReservedDBInstancesOfferingsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeSourceRegionsPaginator(self: *Self, params: describe_source_regions.DescribeSourceRegionsInput) paginator.DescribeSourceRegionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeTenantDatabasesPaginator(self: *Self, params: describe_tenant_databases.DescribeTenantDatabasesInput) paginator.DescribeTenantDatabasesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn downloadDbLogFilePortionPaginator(self: *Self, params: download_db_log_file_portion.DownloadDBLogFilePortionInput) paginator.DownloadDBLogFilePortionPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn waitUntilDBClusterDeleted(self: *Self, params: describe_db_clusters.DescribeDBClustersInput) aws.waiter.WaiterError!void {
        var w = waiters.DBClusterDeletedWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilDBClusterSnapshotDeleted(self: *Self, params: describe_db_cluster_snapshots.DescribeDBClusterSnapshotsInput) aws.waiter.WaiterError!void {
        var w = waiters.DBClusterSnapshotDeletedWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilDBInstanceDeleted(self: *Self, params: describe_db_instances.DescribeDBInstancesInput) aws.waiter.WaiterError!void {
        var w = waiters.DBInstanceDeletedWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilDBSnapshotDeleted(self: *Self, params: describe_db_snapshots.DescribeDBSnapshotsInput) aws.waiter.WaiterError!void {
        var w = waiters.DBSnapshotDeletedWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilTenantDatabaseDeleted(self: *Self, params: describe_tenant_databases.DescribeTenantDatabasesInput) aws.waiter.WaiterError!void {
        var w = waiters.TenantDatabaseDeletedWaiter{ .client = self, .params = params };
        return w.wait();
    }
};
