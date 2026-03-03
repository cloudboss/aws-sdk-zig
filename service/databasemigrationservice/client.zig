const aws = @import("aws");
const std = @import("std");

const add_tags_to_resource = @import("add_tags_to_resource.zig");
const apply_pending_maintenance_action = @import("apply_pending_maintenance_action.zig");
const batch_start_recommendations = @import("batch_start_recommendations.zig");
const cancel_metadata_model_conversion = @import("cancel_metadata_model_conversion.zig");
const cancel_metadata_model_creation = @import("cancel_metadata_model_creation.zig");
const cancel_replication_task_assessment_run = @import("cancel_replication_task_assessment_run.zig");
const create_data_migration = @import("create_data_migration.zig");
const create_data_provider = @import("create_data_provider.zig");
const create_endpoint = @import("create_endpoint.zig");
const create_event_subscription = @import("create_event_subscription.zig");
const create_fleet_advisor_collector = @import("create_fleet_advisor_collector.zig");
const create_instance_profile = @import("create_instance_profile.zig");
const create_migration_project = @import("create_migration_project.zig");
const create_replication_config = @import("create_replication_config.zig");
const create_replication_instance = @import("create_replication_instance.zig");
const create_replication_subnet_group = @import("create_replication_subnet_group.zig");
const create_replication_task = @import("create_replication_task.zig");
const delete_certificate = @import("delete_certificate.zig");
const delete_connection = @import("delete_connection.zig");
const delete_data_migration = @import("delete_data_migration.zig");
const delete_data_provider = @import("delete_data_provider.zig");
const delete_endpoint = @import("delete_endpoint.zig");
const delete_event_subscription = @import("delete_event_subscription.zig");
const delete_fleet_advisor_collector = @import("delete_fleet_advisor_collector.zig");
const delete_fleet_advisor_databases = @import("delete_fleet_advisor_databases.zig");
const delete_instance_profile = @import("delete_instance_profile.zig");
const delete_migration_project = @import("delete_migration_project.zig");
const delete_replication_config = @import("delete_replication_config.zig");
const delete_replication_instance = @import("delete_replication_instance.zig");
const delete_replication_subnet_group = @import("delete_replication_subnet_group.zig");
const delete_replication_task = @import("delete_replication_task.zig");
const delete_replication_task_assessment_run = @import("delete_replication_task_assessment_run.zig");
const describe_account_attributes = @import("describe_account_attributes.zig");
const describe_applicable_individual_assessments = @import("describe_applicable_individual_assessments.zig");
const describe_certificates = @import("describe_certificates.zig");
const describe_connections = @import("describe_connections.zig");
const describe_conversion_configuration = @import("describe_conversion_configuration.zig");
const describe_data_migrations = @import("describe_data_migrations.zig");
const describe_data_providers = @import("describe_data_providers.zig");
const describe_endpoint_settings = @import("describe_endpoint_settings.zig");
const describe_endpoint_types = @import("describe_endpoint_types.zig");
const describe_endpoints = @import("describe_endpoints.zig");
const describe_engine_versions = @import("describe_engine_versions.zig");
const describe_event_categories = @import("describe_event_categories.zig");
const describe_event_subscriptions = @import("describe_event_subscriptions.zig");
const describe_events = @import("describe_events.zig");
const describe_extension_pack_associations = @import("describe_extension_pack_associations.zig");
const describe_fleet_advisor_collectors = @import("describe_fleet_advisor_collectors.zig");
const describe_fleet_advisor_databases = @import("describe_fleet_advisor_databases.zig");
const describe_fleet_advisor_lsa_analysis = @import("describe_fleet_advisor_lsa_analysis.zig");
const describe_fleet_advisor_schema_object_summary = @import("describe_fleet_advisor_schema_object_summary.zig");
const describe_fleet_advisor_schemas = @import("describe_fleet_advisor_schemas.zig");
const describe_instance_profiles = @import("describe_instance_profiles.zig");
const describe_metadata_model = @import("describe_metadata_model.zig");
const describe_metadata_model_assessments = @import("describe_metadata_model_assessments.zig");
const describe_metadata_model_children = @import("describe_metadata_model_children.zig");
const describe_metadata_model_conversions = @import("describe_metadata_model_conversions.zig");
const describe_metadata_model_creations = @import("describe_metadata_model_creations.zig");
const describe_metadata_model_exports_as_script = @import("describe_metadata_model_exports_as_script.zig");
const describe_metadata_model_exports_to_target = @import("describe_metadata_model_exports_to_target.zig");
const describe_metadata_model_imports = @import("describe_metadata_model_imports.zig");
const describe_migration_projects = @import("describe_migration_projects.zig");
const describe_orderable_replication_instances = @import("describe_orderable_replication_instances.zig");
const describe_pending_maintenance_actions = @import("describe_pending_maintenance_actions.zig");
const describe_recommendation_limitations = @import("describe_recommendation_limitations.zig");
const describe_recommendations = @import("describe_recommendations.zig");
const describe_refresh_schemas_status = @import("describe_refresh_schemas_status.zig");
const describe_replication_configs = @import("describe_replication_configs.zig");
const describe_replication_instance_task_logs = @import("describe_replication_instance_task_logs.zig");
const describe_replication_instances = @import("describe_replication_instances.zig");
const describe_replication_subnet_groups = @import("describe_replication_subnet_groups.zig");
const describe_replication_table_statistics = @import("describe_replication_table_statistics.zig");
const describe_replication_task_assessment_results = @import("describe_replication_task_assessment_results.zig");
const describe_replication_task_assessment_runs = @import("describe_replication_task_assessment_runs.zig");
const describe_replication_task_individual_assessments = @import("describe_replication_task_individual_assessments.zig");
const describe_replication_tasks = @import("describe_replication_tasks.zig");
const describe_replications = @import("describe_replications.zig");
const describe_schemas = @import("describe_schemas.zig");
const describe_table_statistics = @import("describe_table_statistics.zig");
const export_metadata_model_assessment = @import("export_metadata_model_assessment.zig");
const get_target_selection_rules = @import("get_target_selection_rules.zig");
const import_certificate = @import("import_certificate.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const modify_conversion_configuration = @import("modify_conversion_configuration.zig");
const modify_data_migration = @import("modify_data_migration.zig");
const modify_data_provider = @import("modify_data_provider.zig");
const modify_endpoint = @import("modify_endpoint.zig");
const modify_event_subscription = @import("modify_event_subscription.zig");
const modify_instance_profile = @import("modify_instance_profile.zig");
const modify_migration_project = @import("modify_migration_project.zig");
const modify_replication_config = @import("modify_replication_config.zig");
const modify_replication_instance = @import("modify_replication_instance.zig");
const modify_replication_subnet_group = @import("modify_replication_subnet_group.zig");
const modify_replication_task = @import("modify_replication_task.zig");
const move_replication_task = @import("move_replication_task.zig");
const reboot_replication_instance = @import("reboot_replication_instance.zig");
const refresh_schemas = @import("refresh_schemas.zig");
const reload_replication_tables = @import("reload_replication_tables.zig");
const reload_tables = @import("reload_tables.zig");
const remove_tags_from_resource = @import("remove_tags_from_resource.zig");
const run_fleet_advisor_lsa_analysis = @import("run_fleet_advisor_lsa_analysis.zig");
const start_data_migration = @import("start_data_migration.zig");
const start_extension_pack_association = @import("start_extension_pack_association.zig");
const start_metadata_model_assessment = @import("start_metadata_model_assessment.zig");
const start_metadata_model_conversion = @import("start_metadata_model_conversion.zig");
const start_metadata_model_creation = @import("start_metadata_model_creation.zig");
const start_metadata_model_export_as_script = @import("start_metadata_model_export_as_script.zig");
const start_metadata_model_export_to_target = @import("start_metadata_model_export_to_target.zig");
const start_metadata_model_import = @import("start_metadata_model_import.zig");
const start_recommendations = @import("start_recommendations.zig");
const start_replication = @import("start_replication.zig");
const start_replication_task = @import("start_replication_task.zig");
const start_replication_task_assessment = @import("start_replication_task_assessment.zig");
const start_replication_task_assessment_run = @import("start_replication_task_assessment_run.zig");
const stop_data_migration = @import("stop_data_migration.zig");
const stop_replication = @import("stop_replication.zig");
const stop_replication_task = @import("stop_replication_task.zig");
const test_connection = @import("test_connection.zig");
const update_subscriptions_to_event_bridge = @import("update_subscriptions_to_event_bridge.zig");
const paginator = @import("paginator.zig");
const waiters = @import("waiters.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "Database Migration Service";

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

    /// Adds metadata tags to an DMS resource, including replication instance,
    /// endpoint,
    /// subnet group, and migration task. These tags can also be used with cost
    /// allocation
    /// reporting to track cost associated with DMS resources, or used in a
    /// Condition statement in
    /// an IAM policy for DMS. For more information, see [
    /// `Tag`
    /// ](https://docs.aws.amazon.com/dms/latest/APIReference/API_Tag.html) data
    /// type
    /// description.
    pub fn addTagsToResource(self: *Self, allocator: std.mem.Allocator, input: add_tags_to_resource.AddTagsToResourceInput, options: add_tags_to_resource.Options) !add_tags_to_resource.AddTagsToResourceOutput {
        return add_tags_to_resource.execute(self, allocator, input, options);
    }

    /// Applies a pending maintenance action to a resource (for example, to a
    /// replication
    /// instance).
    pub fn applyPendingMaintenanceAction(self: *Self, allocator: std.mem.Allocator, input: apply_pending_maintenance_action.ApplyPendingMaintenanceActionInput, options: apply_pending_maintenance_action.Options) !apply_pending_maintenance_action.ApplyPendingMaintenanceActionOutput {
        return apply_pending_maintenance_action.execute(self, allocator, input, options);
    }

    /// End of support notice: On May 20, 2026, Amazon Web Services will end support
    /// for Amazon Web Services DMS Fleet Advisor;. After May 20, 2026, you will no
    /// longer be able to access the Amazon Web Services DMS Fleet Advisor; console
    /// or Amazon Web Services DMS Fleet Advisor; resources. For more information,
    /// see [Amazon Web Services DMS Fleet Advisor end of
    /// support](https://docs.aws.amazon.com/dms/latest/userguide/dms_fleet.advisor-end-of-support.html).
    ///
    /// Starts the analysis of up to 20 source databases to recommend target engines
    /// for each
    /// source database. This is a batch version of
    /// [StartRecommendations](https://docs.aws.amazon.com/dms/latest/APIReference/API_StartRecommendations.html).
    ///
    /// The result of analysis of each source database is reported individually in
    /// the
    /// response. Because the batch request can result in a combination of
    /// successful and
    /// unsuccessful actions, you should check for batch errors even when the call
    /// returns an
    /// HTTP status code of `200`.
    pub fn batchStartRecommendations(self: *Self, allocator: std.mem.Allocator, input: batch_start_recommendations.BatchStartRecommendationsInput, options: batch_start_recommendations.Options) !batch_start_recommendations.BatchStartRecommendationsOutput {
        return batch_start_recommendations.execute(self, allocator, input, options);
    }

    /// Cancels a single metadata model conversion operation that was started with
    /// `StartMetadataModelConversion`.
    pub fn cancelMetadataModelConversion(self: *Self, allocator: std.mem.Allocator, input: cancel_metadata_model_conversion.CancelMetadataModelConversionInput, options: cancel_metadata_model_conversion.Options) !cancel_metadata_model_conversion.CancelMetadataModelConversionOutput {
        return cancel_metadata_model_conversion.execute(self, allocator, input, options);
    }

    /// Cancels a single metadata model creation operation that was started with
    /// `StartMetadataModelCreation`.
    pub fn cancelMetadataModelCreation(self: *Self, allocator: std.mem.Allocator, input: cancel_metadata_model_creation.CancelMetadataModelCreationInput, options: cancel_metadata_model_creation.Options) !cancel_metadata_model_creation.CancelMetadataModelCreationOutput {
        return cancel_metadata_model_creation.execute(self, allocator, input, options);
    }

    /// Cancels a single premigration assessment run.
    ///
    /// This operation prevents any individual assessments from running if they
    /// haven't started
    /// running. It also attempts to cancel any individual assessments that are
    /// currently
    /// running.
    pub fn cancelReplicationTaskAssessmentRun(self: *Self, allocator: std.mem.Allocator, input: cancel_replication_task_assessment_run.CancelReplicationTaskAssessmentRunInput, options: cancel_replication_task_assessment_run.Options) !cancel_replication_task_assessment_run.CancelReplicationTaskAssessmentRunOutput {
        return cancel_replication_task_assessment_run.execute(self, allocator, input, options);
    }

    /// Creates a data migration using the provided settings.
    pub fn createDataMigration(self: *Self, allocator: std.mem.Allocator, input: create_data_migration.CreateDataMigrationInput, options: create_data_migration.Options) !create_data_migration.CreateDataMigrationOutput {
        return create_data_migration.execute(self, allocator, input, options);
    }

    /// Creates a data provider using the provided settings. A data provider stores
    /// a data store
    /// type and location information about your database.
    pub fn createDataProvider(self: *Self, allocator: std.mem.Allocator, input: create_data_provider.CreateDataProviderInput, options: create_data_provider.Options) !create_data_provider.CreateDataProviderOutput {
        return create_data_provider.execute(self, allocator, input, options);
    }

    /// Creates an endpoint using the provided settings.
    ///
    /// For a MySQL source or target endpoint, don't explicitly specify the database
    /// using
    /// the `DatabaseName` request parameter on the `CreateEndpoint` API
    /// call. Specifying `DatabaseName` when you create a MySQL endpoint replicates
    /// all the task tables to this single database. For MySQL endpoints, you
    /// specify the
    /// database only when you specify the schema in the table-mapping rules of the
    /// DMS
    /// task.
    pub fn createEndpoint(self: *Self, allocator: std.mem.Allocator, input: create_endpoint.CreateEndpointInput, options: create_endpoint.Options) !create_endpoint.CreateEndpointOutput {
        return create_endpoint.execute(self, allocator, input, options);
    }

    /// Creates an DMS event notification subscription.
    ///
    /// You can specify the type of source (`SourceType`) you want to be notified
    /// of,
    /// provide a list of DMS source IDs (`SourceIds`) that triggers the events, and
    /// provide a list of event categories (`EventCategories`) for events you want
    /// to be
    /// notified of. If you specify both the `SourceType` and `SourceIds`,
    /// such as `SourceType = replication-instance` and `SourceIdentifier =
    /// my-replinstance`, you will be notified of all the replication instance
    /// events for
    /// the specified source. If you specify a `SourceType` but don't specify a
    /// `SourceIdentifier`, you receive notice of the events for that source type
    /// for
    /// all your DMS sources. If you don't specify either `SourceType` nor
    /// `SourceIdentifier`, you will be notified of events generated from all DMS
    /// sources belonging to your customer account.
    ///
    /// For more information about DMS events, see [Working with Events and
    /// Notifications](https://docs.aws.amazon.com/dms/latest/userguide/CHAP_Events.html) in the *Database Migration Service User Guide.*
    pub fn createEventSubscription(self: *Self, allocator: std.mem.Allocator, input: create_event_subscription.CreateEventSubscriptionInput, options: create_event_subscription.Options) !create_event_subscription.CreateEventSubscriptionOutput {
        return create_event_subscription.execute(self, allocator, input, options);
    }

    /// End of support notice: On May 20, 2026, Amazon Web Services will end support
    /// for Amazon Web Services DMS Fleet Advisor;. After May 20, 2026, you will no
    /// longer be able to access the Amazon Web Services DMS Fleet Advisor; console
    /// or Amazon Web Services DMS Fleet Advisor; resources. For more information,
    /// see [Amazon Web Services DMS Fleet Advisor end of
    /// support](https://docs.aws.amazon.com/dms/latest/userguide/dms_fleet.advisor-end-of-support.html).
    ///
    /// Creates a Fleet Advisor collector using the specified parameters.
    pub fn createFleetAdvisorCollector(self: *Self, allocator: std.mem.Allocator, input: create_fleet_advisor_collector.CreateFleetAdvisorCollectorInput, options: create_fleet_advisor_collector.Options) !create_fleet_advisor_collector.CreateFleetAdvisorCollectorOutput {
        return create_fleet_advisor_collector.execute(self, allocator, input, options);
    }

    /// Creates the instance profile using the specified parameters.
    pub fn createInstanceProfile(self: *Self, allocator: std.mem.Allocator, input: create_instance_profile.CreateInstanceProfileInput, options: create_instance_profile.Options) !create_instance_profile.CreateInstanceProfileOutput {
        return create_instance_profile.execute(self, allocator, input, options);
    }

    /// Creates the migration project using the specified parameters.
    ///
    /// You can run this action only after you create an instance profile and data
    /// providers
    /// using
    /// [CreateInstanceProfile](https://docs.aws.amazon.com/dms/latest/APIReference/API_CreateInstanceProfile.html) and [CreateDataProvider](https://docs.aws.amazon.com/dms/latest/APIReference/API_CreateDataProvider.html).
    pub fn createMigrationProject(self: *Self, allocator: std.mem.Allocator, input: create_migration_project.CreateMigrationProjectInput, options: create_migration_project.Options) !create_migration_project.CreateMigrationProjectOutput {
        return create_migration_project.execute(self, allocator, input, options);
    }

    /// Creates a configuration that you can later provide to configure and start an
    /// DMS
    /// Serverless replication. You can also provide options to validate the
    /// configuration inputs
    /// before you start the replication.
    pub fn createReplicationConfig(self: *Self, allocator: std.mem.Allocator, input: create_replication_config.CreateReplicationConfigInput, options: create_replication_config.Options) !create_replication_config.CreateReplicationConfigOutput {
        return create_replication_config.execute(self, allocator, input, options);
    }

    /// Creates the replication instance using the specified parameters.
    ///
    /// DMS requires that your account have certain roles with appropriate
    /// permissions before
    /// you can create a replication instance. For information on the required
    /// roles, see [Creating the IAM Roles to Use With the CLI and DMS
    /// API](https://docs.aws.amazon.com/dms/latest/userguide/CHAP_Security.html#CHAP_Security.APIRole). For information on
    /// the required permissions, see [IAM
    /// Permissions Needed to Use
    /// DMS](https://docs.aws.amazon.com/dms/latest/userguide/CHAP_Security.html#CHAP_Security.IAMPermissions).
    ///
    /// If you don't specify a version when creating a replication instance, DMS
    /// will
    /// create the instance using the default engine version. For information about
    /// the default
    /// engine version, see [Release
    /// Notes](https://docs.aws.amazon.com/dms/latest/userguide/CHAP_ReleaseNotes.html).
    pub fn createReplicationInstance(self: *Self, allocator: std.mem.Allocator, input: create_replication_instance.CreateReplicationInstanceInput, options: create_replication_instance.Options) !create_replication_instance.CreateReplicationInstanceOutput {
        return create_replication_instance.execute(self, allocator, input, options);
    }

    /// Creates a replication subnet group given a list of the subnet IDs in a VPC.
    ///
    /// The VPC needs to have at least one subnet in at least two availability zones
    /// in the
    /// Amazon Web Services Region, otherwise the service will throw a
    /// `ReplicationSubnetGroupDoesNotCoverEnoughAZs` exception.
    ///
    /// If a replication subnet group exists in your Amazon Web Services account,
    /// the
    /// CreateReplicationSubnetGroup action returns the following error message: The
    /// Replication
    /// Subnet Group already exists. In this case, delete the existing replication
    /// subnet group. To
    /// do so, use the
    /// [DeleteReplicationSubnetGroup](https://docs.aws.amazon.com/en_us/dms/latest/APIReference/API_DeleteReplicationSubnetGroup.html) action. Optionally, choose Subnet groups in the
    /// DMS console, then choose your subnet group. Next, choose Delete from
    /// Actions.
    pub fn createReplicationSubnetGroup(self: *Self, allocator: std.mem.Allocator, input: create_replication_subnet_group.CreateReplicationSubnetGroupInput, options: create_replication_subnet_group.Options) !create_replication_subnet_group.CreateReplicationSubnetGroupOutput {
        return create_replication_subnet_group.execute(self, allocator, input, options);
    }

    /// Creates a replication task using the specified parameters.
    pub fn createReplicationTask(self: *Self, allocator: std.mem.Allocator, input: create_replication_task.CreateReplicationTaskInput, options: create_replication_task.Options) !create_replication_task.CreateReplicationTaskOutput {
        return create_replication_task.execute(self, allocator, input, options);
    }

    /// Deletes the specified certificate.
    pub fn deleteCertificate(self: *Self, allocator: std.mem.Allocator, input: delete_certificate.DeleteCertificateInput, options: delete_certificate.Options) !delete_certificate.DeleteCertificateOutput {
        return delete_certificate.execute(self, allocator, input, options);
    }

    /// Deletes the connection between a replication instance and an endpoint.
    pub fn deleteConnection(self: *Self, allocator: std.mem.Allocator, input: delete_connection.DeleteConnectionInput, options: delete_connection.Options) !delete_connection.DeleteConnectionOutput {
        return delete_connection.execute(self, allocator, input, options);
    }

    /// Deletes the specified data migration.
    pub fn deleteDataMigration(self: *Self, allocator: std.mem.Allocator, input: delete_data_migration.DeleteDataMigrationInput, options: delete_data_migration.Options) !delete_data_migration.DeleteDataMigrationOutput {
        return delete_data_migration.execute(self, allocator, input, options);
    }

    /// Deletes the specified data provider.
    ///
    /// All migration projects associated with the data provider must be deleted or
    /// modified
    /// before you can delete the data provider.
    pub fn deleteDataProvider(self: *Self, allocator: std.mem.Allocator, input: delete_data_provider.DeleteDataProviderInput, options: delete_data_provider.Options) !delete_data_provider.DeleteDataProviderOutput {
        return delete_data_provider.execute(self, allocator, input, options);
    }

    /// Deletes the specified endpoint.
    ///
    /// All tasks associated with the endpoint must be deleted before you can delete
    /// the
    /// endpoint.
    pub fn deleteEndpoint(self: *Self, allocator: std.mem.Allocator, input: delete_endpoint.DeleteEndpointInput, options: delete_endpoint.Options) !delete_endpoint.DeleteEndpointOutput {
        return delete_endpoint.execute(self, allocator, input, options);
    }

    /// Deletes an DMS event subscription.
    pub fn deleteEventSubscription(self: *Self, allocator: std.mem.Allocator, input: delete_event_subscription.DeleteEventSubscriptionInput, options: delete_event_subscription.Options) !delete_event_subscription.DeleteEventSubscriptionOutput {
        return delete_event_subscription.execute(self, allocator, input, options);
    }

    /// End of support notice: On May 20, 2026, Amazon Web Services will end support
    /// for Amazon Web Services DMS Fleet Advisor;. After May 20, 2026, you will no
    /// longer be able to access the Amazon Web Services DMS Fleet Advisor; console
    /// or Amazon Web Services DMS Fleet Advisor; resources. For more information,
    /// see [Amazon Web Services DMS Fleet Advisor end of
    /// support](https://docs.aws.amazon.com/dms/latest/userguide/dms_fleet.advisor-end-of-support.html).
    ///
    /// Deletes the specified Fleet Advisor collector.
    pub fn deleteFleetAdvisorCollector(self: *Self, allocator: std.mem.Allocator, input: delete_fleet_advisor_collector.DeleteFleetAdvisorCollectorInput, options: delete_fleet_advisor_collector.Options) !delete_fleet_advisor_collector.DeleteFleetAdvisorCollectorOutput {
        return delete_fleet_advisor_collector.execute(self, allocator, input, options);
    }

    /// End of support notice: On May 20, 2026, Amazon Web Services will end support
    /// for Amazon Web Services DMS Fleet Advisor;. After May 20, 2026, you will no
    /// longer be able to access the Amazon Web Services DMS Fleet Advisor; console
    /// or Amazon Web Services DMS Fleet Advisor; resources. For more information,
    /// see [Amazon Web Services DMS Fleet Advisor end of
    /// support](https://docs.aws.amazon.com/dms/latest/userguide/dms_fleet.advisor-end-of-support.html).
    ///
    /// Deletes the specified Fleet Advisor collector databases.
    pub fn deleteFleetAdvisorDatabases(self: *Self, allocator: std.mem.Allocator, input: delete_fleet_advisor_databases.DeleteFleetAdvisorDatabasesInput, options: delete_fleet_advisor_databases.Options) !delete_fleet_advisor_databases.DeleteFleetAdvisorDatabasesOutput {
        return delete_fleet_advisor_databases.execute(self, allocator, input, options);
    }

    /// Deletes the specified instance profile.
    ///
    /// All migration projects associated with the instance profile must be deleted
    /// or
    /// modified before you can delete the instance profile.
    pub fn deleteInstanceProfile(self: *Self, allocator: std.mem.Allocator, input: delete_instance_profile.DeleteInstanceProfileInput, options: delete_instance_profile.Options) !delete_instance_profile.DeleteInstanceProfileOutput {
        return delete_instance_profile.execute(self, allocator, input, options);
    }

    /// Deletes the specified migration project.
    ///
    /// The migration project must be closed before you can delete it.
    pub fn deleteMigrationProject(self: *Self, allocator: std.mem.Allocator, input: delete_migration_project.DeleteMigrationProjectInput, options: delete_migration_project.Options) !delete_migration_project.DeleteMigrationProjectOutput {
        return delete_migration_project.execute(self, allocator, input, options);
    }

    /// Deletes an DMS Serverless replication configuration. This effectively
    /// deprovisions any
    /// and all replications that use this configuration. You can't delete the
    /// configuration for an
    /// DMS Serverless replication that is ongoing. You can delete the configuration
    /// when the
    /// replication is in a non-RUNNING and non-STARTING state.
    pub fn deleteReplicationConfig(self: *Self, allocator: std.mem.Allocator, input: delete_replication_config.DeleteReplicationConfigInput, options: delete_replication_config.Options) !delete_replication_config.DeleteReplicationConfigOutput {
        return delete_replication_config.execute(self, allocator, input, options);
    }

    /// Deletes the specified replication instance.
    ///
    /// You must delete any migration tasks that are associated with the replication
    /// instance
    /// before you can delete it.
    pub fn deleteReplicationInstance(self: *Self, allocator: std.mem.Allocator, input: delete_replication_instance.DeleteReplicationInstanceInput, options: delete_replication_instance.Options) !delete_replication_instance.DeleteReplicationInstanceOutput {
        return delete_replication_instance.execute(self, allocator, input, options);
    }

    /// Deletes a subnet group.
    pub fn deleteReplicationSubnetGroup(self: *Self, allocator: std.mem.Allocator, input: delete_replication_subnet_group.DeleteReplicationSubnetGroupInput, options: delete_replication_subnet_group.Options) !delete_replication_subnet_group.DeleteReplicationSubnetGroupOutput {
        return delete_replication_subnet_group.execute(self, allocator, input, options);
    }

    /// Deletes the specified replication task.
    pub fn deleteReplicationTask(self: *Self, allocator: std.mem.Allocator, input: delete_replication_task.DeleteReplicationTaskInput, options: delete_replication_task.Options) !delete_replication_task.DeleteReplicationTaskOutput {
        return delete_replication_task.execute(self, allocator, input, options);
    }

    /// Deletes the record of a single premigration assessment run.
    ///
    /// This operation removes all metadata that DMS maintains about this assessment
    /// run.
    /// However, the operation leaves untouched all information about this
    /// assessment run that is
    /// stored in your Amazon S3 bucket.
    pub fn deleteReplicationTaskAssessmentRun(self: *Self, allocator: std.mem.Allocator, input: delete_replication_task_assessment_run.DeleteReplicationTaskAssessmentRunInput, options: delete_replication_task_assessment_run.Options) !delete_replication_task_assessment_run.DeleteReplicationTaskAssessmentRunOutput {
        return delete_replication_task_assessment_run.execute(self, allocator, input, options);
    }

    /// Lists all of the DMS attributes for a customer account. These attributes
    /// include DMS
    /// quotas for the account and a unique account identifier in a particular DMS
    /// region. DMS
    /// quotas include a list of resource quotas supported by the account, such as
    /// the number of
    /// replication instances allowed. The description for each resource quota,
    /// includes the quota
    /// name, current usage toward that quota, and the quota's maximum value. DMS
    /// uses the unique
    /// account identifier to name each artifact used by DMS in the given region.
    ///
    /// This command does not take any parameters.
    pub fn describeAccountAttributes(self: *Self, allocator: std.mem.Allocator, input: describe_account_attributes.DescribeAccountAttributesInput, options: describe_account_attributes.Options) !describe_account_attributes.DescribeAccountAttributesOutput {
        return describe_account_attributes.execute(self, allocator, input, options);
    }

    /// Provides a list of individual assessments that you can specify for a new
    /// premigration
    /// assessment run, given one or more parameters.
    ///
    /// If you specify an existing migration task, this operation provides the
    /// default
    /// individual assessments you can specify for that task. Otherwise, the
    /// specified parameters
    /// model elements of a possible migration task on which to base a premigration
    /// assessment
    /// run.
    ///
    /// To use these migration task modeling parameters, you must specify an
    /// existing
    /// replication instance, a source database engine, a target database engine,
    /// and a migration
    /// type. This combination of parameters potentially limits the default
    /// individual assessments
    /// available for an assessment run created for a corresponding migration task.
    ///
    /// If you specify no parameters, this operation provides a list of all possible
    /// individual
    /// assessments that you can specify for an assessment run. If you specify any
    /// one of the task
    /// modeling parameters, you must specify all of them or the operation cannot
    /// provide a list of
    /// individual assessments. The only parameter that you can specify alone is for
    /// an existing
    /// migration task. The specified task definition then determines the default
    /// list of
    /// individual assessments that you can specify in an assessment run for the
    /// task.
    pub fn describeApplicableIndividualAssessments(self: *Self, allocator: std.mem.Allocator, input: describe_applicable_individual_assessments.DescribeApplicableIndividualAssessmentsInput, options: describe_applicable_individual_assessments.Options) !describe_applicable_individual_assessments.DescribeApplicableIndividualAssessmentsOutput {
        return describe_applicable_individual_assessments.execute(self, allocator, input, options);
    }

    /// Provides a description of the certificate.
    pub fn describeCertificates(self: *Self, allocator: std.mem.Allocator, input: describe_certificates.DescribeCertificatesInput, options: describe_certificates.Options) !describe_certificates.DescribeCertificatesOutput {
        return describe_certificates.execute(self, allocator, input, options);
    }

    /// Describes the status of the connections that have been made between the
    /// replication
    /// instance and an endpoint. Connections are created when you test an endpoint.
    pub fn describeConnections(self: *Self, allocator: std.mem.Allocator, input: describe_connections.DescribeConnectionsInput, options: describe_connections.Options) !describe_connections.DescribeConnectionsOutput {
        return describe_connections.execute(self, allocator, input, options);
    }

    /// Returns configuration parameters for a schema conversion project.
    pub fn describeConversionConfiguration(self: *Self, allocator: std.mem.Allocator, input: describe_conversion_configuration.DescribeConversionConfigurationInput, options: describe_conversion_configuration.Options) !describe_conversion_configuration.DescribeConversionConfigurationOutput {
        return describe_conversion_configuration.execute(self, allocator, input, options);
    }

    /// Returns information about data migrations.
    pub fn describeDataMigrations(self: *Self, allocator: std.mem.Allocator, input: describe_data_migrations.DescribeDataMigrationsInput, options: describe_data_migrations.Options) !describe_data_migrations.DescribeDataMigrationsOutput {
        return describe_data_migrations.execute(self, allocator, input, options);
    }

    /// Returns a paginated list of data providers for your account in the current
    /// region.
    pub fn describeDataProviders(self: *Self, allocator: std.mem.Allocator, input: describe_data_providers.DescribeDataProvidersInput, options: describe_data_providers.Options) !describe_data_providers.DescribeDataProvidersOutput {
        return describe_data_providers.execute(self, allocator, input, options);
    }

    /// Returns information about the possible endpoint settings available when you
    /// create an
    /// endpoint for a specific database engine.
    pub fn describeEndpointSettings(self: *Self, allocator: std.mem.Allocator, input: describe_endpoint_settings.DescribeEndpointSettingsInput, options: describe_endpoint_settings.Options) !describe_endpoint_settings.DescribeEndpointSettingsOutput {
        return describe_endpoint_settings.execute(self, allocator, input, options);
    }

    /// Returns information about the type of endpoints available.
    pub fn describeEndpointTypes(self: *Self, allocator: std.mem.Allocator, input: describe_endpoint_types.DescribeEndpointTypesInput, options: describe_endpoint_types.Options) !describe_endpoint_types.DescribeEndpointTypesOutput {
        return describe_endpoint_types.execute(self, allocator, input, options);
    }

    /// Returns information about the endpoints for your account in the current
    /// region.
    pub fn describeEndpoints(self: *Self, allocator: std.mem.Allocator, input: describe_endpoints.DescribeEndpointsInput, options: describe_endpoints.Options) !describe_endpoints.DescribeEndpointsOutput {
        return describe_endpoints.execute(self, allocator, input, options);
    }

    /// Returns information about the replication instance versions used in the
    /// project.
    pub fn describeEngineVersions(self: *Self, allocator: std.mem.Allocator, input: describe_engine_versions.DescribeEngineVersionsInput, options: describe_engine_versions.Options) !describe_engine_versions.DescribeEngineVersionsOutput {
        return describe_engine_versions.execute(self, allocator, input, options);
    }

    /// Lists categories for all event source types, or, if specified, for a
    /// specified source
    /// type. You can see a list of the event categories and source types in
    /// [Working with Events
    /// and
    /// Notifications](https://docs.aws.amazon.com/dms/latest/userguide/CHAP_Events.html) in the *Database Migration Service User Guide.*
    pub fn describeEventCategories(self: *Self, allocator: std.mem.Allocator, input: describe_event_categories.DescribeEventCategoriesInput, options: describe_event_categories.Options) !describe_event_categories.DescribeEventCategoriesOutput {
        return describe_event_categories.execute(self, allocator, input, options);
    }

    /// Lists all the event subscriptions for a customer account. The description of
    /// a
    /// subscription includes `SubscriptionName`, `SNSTopicARN`,
    /// `CustomerID`, `SourceType`, `SourceID`,
    /// `CreationTime`, and `Status`.
    ///
    /// If you specify `SubscriptionName`, this action lists the description for
    /// that
    /// subscription.
    pub fn describeEventSubscriptions(self: *Self, allocator: std.mem.Allocator, input: describe_event_subscriptions.DescribeEventSubscriptionsInput, options: describe_event_subscriptions.Options) !describe_event_subscriptions.DescribeEventSubscriptionsOutput {
        return describe_event_subscriptions.execute(self, allocator, input, options);
    }

    /// Lists events for a given source identifier and source type. You can also
    /// specify a
    /// start and end time. For more information on DMS events, see [Working with
    /// Events and
    /// Notifications](https://docs.aws.amazon.com/dms/latest/userguide/CHAP_Events.html) in the *Database Migration Service User Guide.*
    pub fn describeEvents(self: *Self, allocator: std.mem.Allocator, input: describe_events.DescribeEventsInput, options: describe_events.Options) !describe_events.DescribeEventsOutput {
        return describe_events.execute(self, allocator, input, options);
    }

    /// Returns a paginated list of extension pack associations for the specified
    /// migration
    /// project. An extension pack is an add-on module that emulates functions
    /// present in a source
    /// database that are required when converting objects to the target database.
    pub fn describeExtensionPackAssociations(self: *Self, allocator: std.mem.Allocator, input: describe_extension_pack_associations.DescribeExtensionPackAssociationsInput, options: describe_extension_pack_associations.Options) !describe_extension_pack_associations.DescribeExtensionPackAssociationsOutput {
        return describe_extension_pack_associations.execute(self, allocator, input, options);
    }

    /// End of support notice: On May 20, 2026, Amazon Web Services will end support
    /// for Amazon Web Services DMS Fleet Advisor;. After May 20, 2026, you will no
    /// longer be able to access the Amazon Web Services DMS Fleet Advisor; console
    /// or Amazon Web Services DMS Fleet Advisor; resources. For more information,
    /// see [Amazon Web Services DMS Fleet Advisor end of
    /// support](https://docs.aws.amazon.com/dms/latest/userguide/dms_fleet.advisor-end-of-support.html).
    ///
    /// Returns a list of the Fleet Advisor collectors in your account.
    pub fn describeFleetAdvisorCollectors(self: *Self, allocator: std.mem.Allocator, input: describe_fleet_advisor_collectors.DescribeFleetAdvisorCollectorsInput, options: describe_fleet_advisor_collectors.Options) !describe_fleet_advisor_collectors.DescribeFleetAdvisorCollectorsOutput {
        return describe_fleet_advisor_collectors.execute(self, allocator, input, options);
    }

    /// End of support notice: On May 20, 2026, Amazon Web Services will end support
    /// for Amazon Web Services DMS Fleet Advisor;. After May 20, 2026, you will no
    /// longer be able to access the Amazon Web Services DMS Fleet Advisor; console
    /// or Amazon Web Services DMS Fleet Advisor; resources. For more information,
    /// see [Amazon Web Services DMS Fleet Advisor end of
    /// support](https://docs.aws.amazon.com/dms/latest/userguide/dms_fleet.advisor-end-of-support.html).
    ///
    /// Returns a list of Fleet Advisor databases in your account.
    pub fn describeFleetAdvisorDatabases(self: *Self, allocator: std.mem.Allocator, input: describe_fleet_advisor_databases.DescribeFleetAdvisorDatabasesInput, options: describe_fleet_advisor_databases.Options) !describe_fleet_advisor_databases.DescribeFleetAdvisorDatabasesOutput {
        return describe_fleet_advisor_databases.execute(self, allocator, input, options);
    }

    /// End of support notice: On May 20, 2026, Amazon Web Services will end support
    /// for Amazon Web Services DMS Fleet Advisor;. After May 20, 2026, you will no
    /// longer be able to access the Amazon Web Services DMS Fleet Advisor; console
    /// or Amazon Web Services DMS Fleet Advisor; resources. For more information,
    /// see [Amazon Web Services DMS Fleet Advisor end of
    /// support](https://docs.aws.amazon.com/dms/latest/userguide/dms_fleet.advisor-end-of-support.html).
    ///
    /// Provides descriptions of large-scale assessment (LSA) analyses produced by
    /// your Fleet
    /// Advisor collectors.
    pub fn describeFleetAdvisorLsaAnalysis(self: *Self, allocator: std.mem.Allocator, input: describe_fleet_advisor_lsa_analysis.DescribeFleetAdvisorLsaAnalysisInput, options: describe_fleet_advisor_lsa_analysis.Options) !describe_fleet_advisor_lsa_analysis.DescribeFleetAdvisorLsaAnalysisOutput {
        return describe_fleet_advisor_lsa_analysis.execute(self, allocator, input, options);
    }

    /// End of support notice: On May 20, 2026, Amazon Web Services will end support
    /// for Amazon Web Services DMS Fleet Advisor;. After May 20, 2026, you will no
    /// longer be able to access the Amazon Web Services DMS Fleet Advisor; console
    /// or Amazon Web Services DMS Fleet Advisor; resources. For more information,
    /// see [Amazon Web Services DMS Fleet Advisor end of
    /// support](https://docs.aws.amazon.com/dms/latest/userguide/dms_fleet.advisor-end-of-support.html).
    ///
    /// Provides descriptions of the schemas discovered by your Fleet Advisor
    /// collectors.
    pub fn describeFleetAdvisorSchemaObjectSummary(self: *Self, allocator: std.mem.Allocator, input: describe_fleet_advisor_schema_object_summary.DescribeFleetAdvisorSchemaObjectSummaryInput, options: describe_fleet_advisor_schema_object_summary.Options) !describe_fleet_advisor_schema_object_summary.DescribeFleetAdvisorSchemaObjectSummaryOutput {
        return describe_fleet_advisor_schema_object_summary.execute(self, allocator, input, options);
    }

    /// End of support notice: On May 20, 2026, Amazon Web Services will end support
    /// for Amazon Web Services DMS Fleet Advisor;. After May 20, 2026, you will no
    /// longer be able to access the Amazon Web Services DMS Fleet Advisor; console
    /// or Amazon Web Services DMS Fleet Advisor; resources. For more information,
    /// see [Amazon Web Services DMS Fleet Advisor end of
    /// support](https://docs.aws.amazon.com/dms/latest/userguide/dms_fleet.advisor-end-of-support.html).
    ///
    /// Returns a list of schemas detected by Fleet Advisor Collectors in your
    /// account.
    pub fn describeFleetAdvisorSchemas(self: *Self, allocator: std.mem.Allocator, input: describe_fleet_advisor_schemas.DescribeFleetAdvisorSchemasInput, options: describe_fleet_advisor_schemas.Options) !describe_fleet_advisor_schemas.DescribeFleetAdvisorSchemasOutput {
        return describe_fleet_advisor_schemas.execute(self, allocator, input, options);
    }

    /// Returns a paginated list of instance profiles for your account in the
    /// current
    /// region.
    pub fn describeInstanceProfiles(self: *Self, allocator: std.mem.Allocator, input: describe_instance_profiles.DescribeInstanceProfilesInput, options: describe_instance_profiles.Options) !describe_instance_profiles.DescribeInstanceProfilesOutput {
        return describe_instance_profiles.execute(self, allocator, input, options);
    }

    /// Gets detailed information about the specified metadata model, including its
    /// definition and corresponding converted objects in the target database if
    /// applicable.
    pub fn describeMetadataModel(self: *Self, allocator: std.mem.Allocator, input: describe_metadata_model.DescribeMetadataModelInput, options: describe_metadata_model.Options) !describe_metadata_model.DescribeMetadataModelOutput {
        return describe_metadata_model.execute(self, allocator, input, options);
    }

    /// Returns a paginated list of metadata model assessments for your account in
    /// the current
    /// region.
    pub fn describeMetadataModelAssessments(self: *Self, allocator: std.mem.Allocator, input: describe_metadata_model_assessments.DescribeMetadataModelAssessmentsInput, options: describe_metadata_model_assessments.Options) !describe_metadata_model_assessments.DescribeMetadataModelAssessmentsOutput {
        return describe_metadata_model_assessments.execute(self, allocator, input, options);
    }

    /// Gets a list of child metadata models for the specified metadata model in the
    /// database hierarchy.
    pub fn describeMetadataModelChildren(self: *Self, allocator: std.mem.Allocator, input: describe_metadata_model_children.DescribeMetadataModelChildrenInput, options: describe_metadata_model_children.Options) !describe_metadata_model_children.DescribeMetadataModelChildrenOutput {
        return describe_metadata_model_children.execute(self, allocator, input, options);
    }

    /// Returns a paginated list of metadata model conversions for a migration
    /// project.
    pub fn describeMetadataModelConversions(self: *Self, allocator: std.mem.Allocator, input: describe_metadata_model_conversions.DescribeMetadataModelConversionsInput, options: describe_metadata_model_conversions.Options) !describe_metadata_model_conversions.DescribeMetadataModelConversionsOutput {
        return describe_metadata_model_conversions.execute(self, allocator, input, options);
    }

    /// Returns a paginated list of metadata model creation requests for a migration
    /// project.
    pub fn describeMetadataModelCreations(self: *Self, allocator: std.mem.Allocator, input: describe_metadata_model_creations.DescribeMetadataModelCreationsInput, options: describe_metadata_model_creations.Options) !describe_metadata_model_creations.DescribeMetadataModelCreationsOutput {
        return describe_metadata_model_creations.execute(self, allocator, input, options);
    }

    /// Returns a paginated list of metadata model exports.
    pub fn describeMetadataModelExportsAsScript(self: *Self, allocator: std.mem.Allocator, input: describe_metadata_model_exports_as_script.DescribeMetadataModelExportsAsScriptInput, options: describe_metadata_model_exports_as_script.Options) !describe_metadata_model_exports_as_script.DescribeMetadataModelExportsAsScriptOutput {
        return describe_metadata_model_exports_as_script.execute(self, allocator, input, options);
    }

    /// Returns a paginated list of metadata model exports.
    pub fn describeMetadataModelExportsToTarget(self: *Self, allocator: std.mem.Allocator, input: describe_metadata_model_exports_to_target.DescribeMetadataModelExportsToTargetInput, options: describe_metadata_model_exports_to_target.Options) !describe_metadata_model_exports_to_target.DescribeMetadataModelExportsToTargetOutput {
        return describe_metadata_model_exports_to_target.execute(self, allocator, input, options);
    }

    /// Returns a paginated list of metadata model imports.
    pub fn describeMetadataModelImports(self: *Self, allocator: std.mem.Allocator, input: describe_metadata_model_imports.DescribeMetadataModelImportsInput, options: describe_metadata_model_imports.Options) !describe_metadata_model_imports.DescribeMetadataModelImportsOutput {
        return describe_metadata_model_imports.execute(self, allocator, input, options);
    }

    /// Returns a paginated list of migration projects for your account in the
    /// current
    /// region.
    pub fn describeMigrationProjects(self: *Self, allocator: std.mem.Allocator, input: describe_migration_projects.DescribeMigrationProjectsInput, options: describe_migration_projects.Options) !describe_migration_projects.DescribeMigrationProjectsOutput {
        return describe_migration_projects.execute(self, allocator, input, options);
    }

    /// Returns information about the replication instance types that can be created
    /// in the
    /// specified region.
    pub fn describeOrderableReplicationInstances(self: *Self, allocator: std.mem.Allocator, input: describe_orderable_replication_instances.DescribeOrderableReplicationInstancesInput, options: describe_orderable_replication_instances.Options) !describe_orderable_replication_instances.DescribeOrderableReplicationInstancesOutput {
        return describe_orderable_replication_instances.execute(self, allocator, input, options);
    }

    /// Returns a list of upcoming maintenance events for replication instances in
    /// your account
    /// in the current Region.
    pub fn describePendingMaintenanceActions(self: *Self, allocator: std.mem.Allocator, input: describe_pending_maintenance_actions.DescribePendingMaintenanceActionsInput, options: describe_pending_maintenance_actions.Options) !describe_pending_maintenance_actions.DescribePendingMaintenanceActionsOutput {
        return describe_pending_maintenance_actions.execute(self, allocator, input, options);
    }

    /// End of support notice: On May 20, 2026, Amazon Web Services will end support
    /// for Amazon Web Services DMS Fleet Advisor;. After May 20, 2026, you will no
    /// longer be able to access the Amazon Web Services DMS Fleet Advisor; console
    /// or Amazon Web Services DMS Fleet Advisor; resources. For more information,
    /// see [Amazon Web Services DMS Fleet Advisor end of
    /// support](https://docs.aws.amazon.com/dms/latest/userguide/dms_fleet.advisor-end-of-support.html).
    ///
    /// Returns a paginated list of limitations for recommendations of target Amazon
    /// Web Services
    /// engines.
    pub fn describeRecommendationLimitations(self: *Self, allocator: std.mem.Allocator, input: describe_recommendation_limitations.DescribeRecommendationLimitationsInput, options: describe_recommendation_limitations.Options) !describe_recommendation_limitations.DescribeRecommendationLimitationsOutput {
        return describe_recommendation_limitations.execute(self, allocator, input, options);
    }

    /// End of support notice: On May 20, 2026, Amazon Web Services will end support
    /// for Amazon Web Services DMS Fleet Advisor;. After May 20, 2026, you will no
    /// longer be able to access the Amazon Web Services DMS Fleet Advisor; console
    /// or Amazon Web Services DMS Fleet Advisor; resources. For more information,
    /// see [Amazon Web Services DMS Fleet Advisor end of
    /// support](https://docs.aws.amazon.com/dms/latest/userguide/dms_fleet.advisor-end-of-support.html).
    ///
    /// Returns a paginated list of target engine recommendations for your source
    /// databases.
    pub fn describeRecommendations(self: *Self, allocator: std.mem.Allocator, input: describe_recommendations.DescribeRecommendationsInput, options: describe_recommendations.Options) !describe_recommendations.DescribeRecommendationsOutput {
        return describe_recommendations.execute(self, allocator, input, options);
    }

    /// Returns the status of the RefreshSchemas operation.
    pub fn describeRefreshSchemasStatus(self: *Self, allocator: std.mem.Allocator, input: describe_refresh_schemas_status.DescribeRefreshSchemasStatusInput, options: describe_refresh_schemas_status.Options) !describe_refresh_schemas_status.DescribeRefreshSchemasStatusOutput {
        return describe_refresh_schemas_status.execute(self, allocator, input, options);
    }

    /// Returns one or more existing DMS Serverless replication configurations as a
    /// list of
    /// structures.
    pub fn describeReplicationConfigs(self: *Self, allocator: std.mem.Allocator, input: describe_replication_configs.DescribeReplicationConfigsInput, options: describe_replication_configs.Options) !describe_replication_configs.DescribeReplicationConfigsOutput {
        return describe_replication_configs.execute(self, allocator, input, options);
    }

    /// Returns information about the task logs for the specified task.
    pub fn describeReplicationInstanceTaskLogs(self: *Self, allocator: std.mem.Allocator, input: describe_replication_instance_task_logs.DescribeReplicationInstanceTaskLogsInput, options: describe_replication_instance_task_logs.Options) !describe_replication_instance_task_logs.DescribeReplicationInstanceTaskLogsOutput {
        return describe_replication_instance_task_logs.execute(self, allocator, input, options);
    }

    /// Returns information about replication instances for your account in the
    /// current
    /// region.
    pub fn describeReplicationInstances(self: *Self, allocator: std.mem.Allocator, input: describe_replication_instances.DescribeReplicationInstancesInput, options: describe_replication_instances.Options) !describe_replication_instances.DescribeReplicationInstancesOutput {
        return describe_replication_instances.execute(self, allocator, input, options);
    }

    /// Returns information about the replication subnet groups.
    pub fn describeReplicationSubnetGroups(self: *Self, allocator: std.mem.Allocator, input: describe_replication_subnet_groups.DescribeReplicationSubnetGroupsInput, options: describe_replication_subnet_groups.Options) !describe_replication_subnet_groups.DescribeReplicationSubnetGroupsOutput {
        return describe_replication_subnet_groups.execute(self, allocator, input, options);
    }

    /// Returns table and schema statistics for one or more provisioned replications
    /// that use a
    /// given DMS Serverless replication configuration.
    pub fn describeReplicationTableStatistics(self: *Self, allocator: std.mem.Allocator, input: describe_replication_table_statistics.DescribeReplicationTableStatisticsInput, options: describe_replication_table_statistics.Options) !describe_replication_table_statistics.DescribeReplicationTableStatisticsOutput {
        return describe_replication_table_statistics.execute(self, allocator, input, options);
    }

    /// Returns the task assessment results from the Amazon S3 bucket that DMS
    /// creates in your
    /// Amazon Web Services account. This action always returns the latest results.
    ///
    /// For more information about DMS task assessments, see [Creating a task
    /// assessment
    /// report](https://docs.aws.amazon.com/dms/latest/userguide/CHAP_Tasks.AssessmentReport.html) in the *Database Migration Service User Guide*.
    pub fn describeReplicationTaskAssessmentResults(self: *Self, allocator: std.mem.Allocator, input: describe_replication_task_assessment_results.DescribeReplicationTaskAssessmentResultsInput, options: describe_replication_task_assessment_results.Options) !describe_replication_task_assessment_results.DescribeReplicationTaskAssessmentResultsOutput {
        return describe_replication_task_assessment_results.execute(self, allocator, input, options);
    }

    /// Returns a paginated list of premigration assessment runs based on filter
    /// settings.
    ///
    /// These filter settings can specify a combination of premigration assessment
    /// runs,
    /// migration tasks, replication instances, and assessment run status values.
    ///
    /// This operation doesn't return information about individual assessments. For
    /// this
    /// information, see the `DescribeReplicationTaskIndividualAssessments`
    /// operation.
    pub fn describeReplicationTaskAssessmentRuns(self: *Self, allocator: std.mem.Allocator, input: describe_replication_task_assessment_runs.DescribeReplicationTaskAssessmentRunsInput, options: describe_replication_task_assessment_runs.Options) !describe_replication_task_assessment_runs.DescribeReplicationTaskAssessmentRunsOutput {
        return describe_replication_task_assessment_runs.execute(self, allocator, input, options);
    }

    /// Returns a paginated list of individual assessments based on filter settings.
    ///
    /// These filter settings can specify a combination of premigration assessment
    /// runs,
    /// migration tasks, and assessment status values.
    pub fn describeReplicationTaskIndividualAssessments(self: *Self, allocator: std.mem.Allocator, input: describe_replication_task_individual_assessments.DescribeReplicationTaskIndividualAssessmentsInput, options: describe_replication_task_individual_assessments.Options) !describe_replication_task_individual_assessments.DescribeReplicationTaskIndividualAssessmentsOutput {
        return describe_replication_task_individual_assessments.execute(self, allocator, input, options);
    }

    /// Returns information about replication tasks for your account in the current
    /// region.
    pub fn describeReplicationTasks(self: *Self, allocator: std.mem.Allocator, input: describe_replication_tasks.DescribeReplicationTasksInput, options: describe_replication_tasks.Options) !describe_replication_tasks.DescribeReplicationTasksOutput {
        return describe_replication_tasks.execute(self, allocator, input, options);
    }

    /// Provides details on replication progress by returning status information for
    /// one or more
    /// provisioned DMS Serverless replications.
    pub fn describeReplications(self: *Self, allocator: std.mem.Allocator, input: describe_replications.DescribeReplicationsInput, options: describe_replications.Options) !describe_replications.DescribeReplicationsOutput {
        return describe_replications.execute(self, allocator, input, options);
    }

    /// Returns information about the schema for the specified endpoint.
    pub fn describeSchemas(self: *Self, allocator: std.mem.Allocator, input: describe_schemas.DescribeSchemasInput, options: describe_schemas.Options) !describe_schemas.DescribeSchemasOutput {
        return describe_schemas.execute(self, allocator, input, options);
    }

    /// Returns table statistics on the database migration task, including table
    /// name, rows
    /// inserted, rows updated, and rows deleted.
    ///
    /// Note that the "last updated" column the DMS console only indicates the time
    /// that DMS
    /// last updated the table statistics record for a table. It does not indicate
    /// the time of the
    /// last update to the table.
    pub fn describeTableStatistics(self: *Self, allocator: std.mem.Allocator, input: describe_table_statistics.DescribeTableStatisticsInput, options: describe_table_statistics.Options) !describe_table_statistics.DescribeTableStatisticsOutput {
        return describe_table_statistics.execute(self, allocator, input, options);
    }

    /// Saves a copy of a database migration assessment report to your Amazon S3
    /// bucket. DMS can
    /// save your assessment report as a comma-separated value (CSV) or a PDF file.
    pub fn exportMetadataModelAssessment(self: *Self, allocator: std.mem.Allocator, input: export_metadata_model_assessment.ExportMetadataModelAssessmentInput, options: export_metadata_model_assessment.Options) !export_metadata_model_assessment.ExportMetadataModelAssessmentOutput {
        return export_metadata_model_assessment.execute(self, allocator, input, options);
    }

    /// Converts source selection rules into their target counterparts for schema
    /// conversion operations.
    pub fn getTargetSelectionRules(self: *Self, allocator: std.mem.Allocator, input: get_target_selection_rules.GetTargetSelectionRulesInput, options: get_target_selection_rules.Options) !get_target_selection_rules.GetTargetSelectionRulesOutput {
        return get_target_selection_rules.execute(self, allocator, input, options);
    }

    /// Uploads the specified certificate.
    pub fn importCertificate(self: *Self, allocator: std.mem.Allocator, input: import_certificate.ImportCertificateInput, options: import_certificate.Options) !import_certificate.ImportCertificateOutput {
        return import_certificate.execute(self, allocator, input, options);
    }

    /// Lists all metadata tags attached to an DMS resource, including replication
    /// instance,
    /// endpoint, subnet group, and migration task. For more information, see [
    /// `Tag`
    /// ](https://docs.aws.amazon.com/dms/latest/APIReference/API_Tag.html)
    /// data type description.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: list_tags_for_resource.Options) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Modifies the specified schema conversion configuration using the provided
    /// parameters.
    pub fn modifyConversionConfiguration(self: *Self, allocator: std.mem.Allocator, input: modify_conversion_configuration.ModifyConversionConfigurationInput, options: modify_conversion_configuration.Options) !modify_conversion_configuration.ModifyConversionConfigurationOutput {
        return modify_conversion_configuration.execute(self, allocator, input, options);
    }

    /// Modifies an existing DMS data migration.
    pub fn modifyDataMigration(self: *Self, allocator: std.mem.Allocator, input: modify_data_migration.ModifyDataMigrationInput, options: modify_data_migration.Options) !modify_data_migration.ModifyDataMigrationOutput {
        return modify_data_migration.execute(self, allocator, input, options);
    }

    /// Modifies the specified data provider using the provided settings.
    ///
    /// You must remove the data provider from all migration projects before you can
    /// modify
    /// it.
    pub fn modifyDataProvider(self: *Self, allocator: std.mem.Allocator, input: modify_data_provider.ModifyDataProviderInput, options: modify_data_provider.Options) !modify_data_provider.ModifyDataProviderOutput {
        return modify_data_provider.execute(self, allocator, input, options);
    }

    /// Modifies the specified endpoint.
    ///
    /// For a MySQL source or target endpoint, don't explicitly specify the database
    /// using
    /// the `DatabaseName` request parameter on the `ModifyEndpoint` API
    /// call. Specifying `DatabaseName` when you modify a MySQL endpoint replicates
    /// all the task tables to this single database. For MySQL endpoints, you
    /// specify the
    /// database only when you specify the schema in the table-mapping rules of the
    /// DMS
    /// task.
    pub fn modifyEndpoint(self: *Self, allocator: std.mem.Allocator, input: modify_endpoint.ModifyEndpointInput, options: modify_endpoint.Options) !modify_endpoint.ModifyEndpointOutput {
        return modify_endpoint.execute(self, allocator, input, options);
    }

    /// Modifies an existing DMS event notification subscription.
    pub fn modifyEventSubscription(self: *Self, allocator: std.mem.Allocator, input: modify_event_subscription.ModifyEventSubscriptionInput, options: modify_event_subscription.Options) !modify_event_subscription.ModifyEventSubscriptionOutput {
        return modify_event_subscription.execute(self, allocator, input, options);
    }

    /// Modifies the specified instance profile using the provided parameters.
    ///
    /// All migration projects associated with the instance profile must be deleted
    /// or
    /// modified before you can modify the instance profile.
    pub fn modifyInstanceProfile(self: *Self, allocator: std.mem.Allocator, input: modify_instance_profile.ModifyInstanceProfileInput, options: modify_instance_profile.Options) !modify_instance_profile.ModifyInstanceProfileOutput {
        return modify_instance_profile.execute(self, allocator, input, options);
    }

    /// Modifies the specified migration project using the provided parameters.
    ///
    /// The migration project must be closed before you can modify it.
    pub fn modifyMigrationProject(self: *Self, allocator: std.mem.Allocator, input: modify_migration_project.ModifyMigrationProjectInput, options: modify_migration_project.Options) !modify_migration_project.ModifyMigrationProjectOutput {
        return modify_migration_project.execute(self, allocator, input, options);
    }

    /// Modifies an existing DMS Serverless replication configuration that you can
    /// use to
    /// start a replication. This command includes input validation and logic to
    /// check the state of
    /// any replication that uses this configuration. You can only modify a
    /// replication
    /// configuration before any replication that uses it has started. As soon as
    /// you have
    /// initially started a replication with a given configuiration, you can't
    /// modify that
    /// configuration, even if you stop it.
    ///
    /// Other run statuses that allow you to run this command include FAILED and
    /// CREATED. A
    /// provisioning state that allows you to run this command is FAILED_PROVISION.
    pub fn modifyReplicationConfig(self: *Self, allocator: std.mem.Allocator, input: modify_replication_config.ModifyReplicationConfigInput, options: modify_replication_config.Options) !modify_replication_config.ModifyReplicationConfigOutput {
        return modify_replication_config.execute(self, allocator, input, options);
    }

    /// Modifies the replication instance to apply new settings. You can change one
    /// or more
    /// parameters by specifying these parameters and the new values in the request.
    ///
    /// Some settings are applied during the maintenance window.
    pub fn modifyReplicationInstance(self: *Self, allocator: std.mem.Allocator, input: modify_replication_instance.ModifyReplicationInstanceInput, options: modify_replication_instance.Options) !modify_replication_instance.ModifyReplicationInstanceOutput {
        return modify_replication_instance.execute(self, allocator, input, options);
    }

    /// Modifies the settings for the specified replication subnet group.
    pub fn modifyReplicationSubnetGroup(self: *Self, allocator: std.mem.Allocator, input: modify_replication_subnet_group.ModifyReplicationSubnetGroupInput, options: modify_replication_subnet_group.Options) !modify_replication_subnet_group.ModifyReplicationSubnetGroupOutput {
        return modify_replication_subnet_group.execute(self, allocator, input, options);
    }

    /// Modifies the specified replication task.
    ///
    /// You can't modify the task endpoints. The task must be stopped before you can
    /// modify it.
    ///
    /// For more information about DMS tasks, see [Working with Migration
    /// Tasks](https://docs.aws.amazon.com/dms/latest/userguide/CHAP_Tasks.html) in
    /// the
    /// *Database Migration Service User Guide*.
    pub fn modifyReplicationTask(self: *Self, allocator: std.mem.Allocator, input: modify_replication_task.ModifyReplicationTaskInput, options: modify_replication_task.Options) !modify_replication_task.ModifyReplicationTaskOutput {
        return modify_replication_task.execute(self, allocator, input, options);
    }

    /// Moves a replication task from its current replication instance to a
    /// different target
    /// replication instance using the specified parameters. The target replication
    /// instance must
    /// be created with the same or later DMS version as the current replication
    /// instance.
    pub fn moveReplicationTask(self: *Self, allocator: std.mem.Allocator, input: move_replication_task.MoveReplicationTaskInput, options: move_replication_task.Options) !move_replication_task.MoveReplicationTaskOutput {
        return move_replication_task.execute(self, allocator, input, options);
    }

    /// Reboots a replication instance. Rebooting results in a momentary outage,
    /// until the
    /// replication instance becomes available again.
    pub fn rebootReplicationInstance(self: *Self, allocator: std.mem.Allocator, input: reboot_replication_instance.RebootReplicationInstanceInput, options: reboot_replication_instance.Options) !reboot_replication_instance.RebootReplicationInstanceOutput {
        return reboot_replication_instance.execute(self, allocator, input, options);
    }

    /// Populates the schema for the specified endpoint. This is an asynchronous
    /// operation and
    /// can take several minutes. You can check the status of this operation by
    /// calling the
    /// DescribeRefreshSchemasStatus operation.
    pub fn refreshSchemas(self: *Self, allocator: std.mem.Allocator, input: refresh_schemas.RefreshSchemasInput, options: refresh_schemas.Options) !refresh_schemas.RefreshSchemasOutput {
        return refresh_schemas.execute(self, allocator, input, options);
    }

    /// Reloads the target database table with the source data for a given DMS
    /// Serverless
    /// replication configuration.
    ///
    /// You can only use this operation with a task in the RUNNING state, otherwise
    /// the service
    /// will throw an `InvalidResourceStateFault` exception.
    pub fn reloadReplicationTables(self: *Self, allocator: std.mem.Allocator, input: reload_replication_tables.ReloadReplicationTablesInput, options: reload_replication_tables.Options) !reload_replication_tables.ReloadReplicationTablesOutput {
        return reload_replication_tables.execute(self, allocator, input, options);
    }

    /// Reloads the target database table with the source data.
    ///
    /// You can only use this operation with a task in the `RUNNING` state,
    /// otherwise
    /// the service will throw an `InvalidResourceStateFault` exception.
    pub fn reloadTables(self: *Self, allocator: std.mem.Allocator, input: reload_tables.ReloadTablesInput, options: reload_tables.Options) !reload_tables.ReloadTablesOutput {
        return reload_tables.execute(self, allocator, input, options);
    }

    /// Removes metadata tags from an DMS resource, including replication instance,
    /// endpoint,
    /// subnet group, and migration task. For more information, see [
    /// `Tag`
    /// ](https://docs.aws.amazon.com/dms/latest/APIReference/API_Tag.html) data
    /// type
    /// description.
    pub fn removeTagsFromResource(self: *Self, allocator: std.mem.Allocator, input: remove_tags_from_resource.RemoveTagsFromResourceInput, options: remove_tags_from_resource.Options) !remove_tags_from_resource.RemoveTagsFromResourceOutput {
        return remove_tags_from_resource.execute(self, allocator, input, options);
    }

    /// End of support notice: On May 20, 2026, Amazon Web Services will end support
    /// for Amazon Web Services DMS Fleet Advisor;. After May 20, 2026, you will no
    /// longer be able to access the Amazon Web Services DMS Fleet Advisor; console
    /// or Amazon Web Services DMS Fleet Advisor; resources. For more information,
    /// see [Amazon Web Services DMS Fleet Advisor end of
    /// support](https://docs.aws.amazon.com/dms/latest/userguide/dms_fleet.advisor-end-of-support.html).
    ///
    /// Runs large-scale assessment (LSA) analysis on every Fleet Advisor collector
    /// in your account.
    pub fn runFleetAdvisorLsaAnalysis(self: *Self, allocator: std.mem.Allocator, input: run_fleet_advisor_lsa_analysis.RunFleetAdvisorLsaAnalysisInput, options: run_fleet_advisor_lsa_analysis.Options) !run_fleet_advisor_lsa_analysis.RunFleetAdvisorLsaAnalysisOutput {
        return run_fleet_advisor_lsa_analysis.execute(self, allocator, input, options);
    }

    /// Starts the specified data migration.
    pub fn startDataMigration(self: *Self, allocator: std.mem.Allocator, input: start_data_migration.StartDataMigrationInput, options: start_data_migration.Options) !start_data_migration.StartDataMigrationOutput {
        return start_data_migration.execute(self, allocator, input, options);
    }

    /// Applies the extension pack to your target database. An extension pack is an
    /// add-on
    /// module that emulates functions present in a source database that are
    /// required when
    /// converting objects to the target database.
    pub fn startExtensionPackAssociation(self: *Self, allocator: std.mem.Allocator, input: start_extension_pack_association.StartExtensionPackAssociationInput, options: start_extension_pack_association.Options) !start_extension_pack_association.StartExtensionPackAssociationOutput {
        return start_extension_pack_association.execute(self, allocator, input, options);
    }

    /// Creates a database migration assessment report by assessing the migration
    /// complexity for
    /// your source database. A database migration assessment report summarizes all
    /// of the schema
    /// conversion tasks. It also details the action items for database objects that
    /// can't be
    /// converted to the database engine of your target database instance.
    pub fn startMetadataModelAssessment(self: *Self, allocator: std.mem.Allocator, input: start_metadata_model_assessment.StartMetadataModelAssessmentInput, options: start_metadata_model_assessment.Options) !start_metadata_model_assessment.StartMetadataModelAssessmentOutput {
        return start_metadata_model_assessment.execute(self, allocator, input, options);
    }

    /// Converts your source database objects to a format compatible with the target
    /// database.
    pub fn startMetadataModelConversion(self: *Self, allocator: std.mem.Allocator, input: start_metadata_model_conversion.StartMetadataModelConversionInput, options: start_metadata_model_conversion.Options) !start_metadata_model_conversion.StartMetadataModelConversionOutput {
        return start_metadata_model_conversion.execute(self, allocator, input, options);
    }

    /// Creates source metadata model of the given type with the specified
    /// properties for schema conversion operations.
    ///
    /// This action supports only these directions: from SQL Server to Aurora
    /// PostgreSQL, or from SQL Server to RDS for PostgreSQL.
    pub fn startMetadataModelCreation(self: *Self, allocator: std.mem.Allocator, input: start_metadata_model_creation.StartMetadataModelCreationInput, options: start_metadata_model_creation.Options) !start_metadata_model_creation.StartMetadataModelCreationOutput {
        return start_metadata_model_creation.execute(self, allocator, input, options);
    }

    /// Saves your converted code to a file as a SQL script, and stores this file on
    /// your Amazon S3
    /// bucket.
    pub fn startMetadataModelExportAsScript(self: *Self, allocator: std.mem.Allocator, input: start_metadata_model_export_as_script.StartMetadataModelExportAsScriptInput, options: start_metadata_model_export_as_script.Options) !start_metadata_model_export_as_script.StartMetadataModelExportAsScriptOutput {
        return start_metadata_model_export_as_script.execute(self, allocator, input, options);
    }

    /// Applies converted database objects to your target database.
    pub fn startMetadataModelExportToTarget(self: *Self, allocator: std.mem.Allocator, input: start_metadata_model_export_to_target.StartMetadataModelExportToTargetInput, options: start_metadata_model_export_to_target.Options) !start_metadata_model_export_to_target.StartMetadataModelExportToTargetOutput {
        return start_metadata_model_export_to_target.execute(self, allocator, input, options);
    }

    /// Loads the metadata for all the dependent database objects of the parent
    /// object.
    ///
    /// This operation uses your project's Amazon S3 bucket as a metadata cache to
    /// improve
    /// performance.
    pub fn startMetadataModelImport(self: *Self, allocator: std.mem.Allocator, input: start_metadata_model_import.StartMetadataModelImportInput, options: start_metadata_model_import.Options) !start_metadata_model_import.StartMetadataModelImportOutput {
        return start_metadata_model_import.execute(self, allocator, input, options);
    }

    /// End of support notice: On May 20, 2026, Amazon Web Services will end support
    /// for Amazon Web Services DMS Fleet Advisor;. After May 20, 2026, you will no
    /// longer be able to access the Amazon Web Services DMS Fleet Advisor; console
    /// or Amazon Web Services DMS Fleet Advisor; resources. For more information,
    /// see [Amazon Web Services DMS Fleet Advisor end of
    /// support](https://docs.aws.amazon.com/dms/latest/userguide/dms_fleet.advisor-end-of-support.html).
    ///
    /// Starts the analysis of your source database to provide recommendations of
    /// target
    /// engines.
    ///
    /// You can create recommendations for multiple source databases using
    /// [BatchStartRecommendations](https://docs.aws.amazon.com/dms/latest/APIReference/API_BatchStartRecommendations.html).
    pub fn startRecommendations(self: *Self, allocator: std.mem.Allocator, input: start_recommendations.StartRecommendationsInput, options: start_recommendations.Options) !start_recommendations.StartRecommendationsOutput {
        return start_recommendations.execute(self, allocator, input, options);
    }

    /// For a given DMS Serverless replication configuration, DMS connects to the
    /// source
    /// endpoint and collects the metadata to analyze the replication workload.
    /// Using this
    /// metadata, DMS then computes and provisions the required capacity and starts
    /// replicating
    /// to the target endpoint using the server resources that DMS has provisioned
    /// for the DMS
    /// Serverless replication.
    pub fn startReplication(self: *Self, allocator: std.mem.Allocator, input: start_replication.StartReplicationInput, options: start_replication.Options) !start_replication.StartReplicationOutput {
        return start_replication.execute(self, allocator, input, options);
    }

    /// Starts the replication task.
    ///
    /// For more information about DMS tasks, see [Working with Migration Tasks
    /// ](https://docs.aws.amazon.com/dms/latest/userguide/CHAP_Tasks.html) in the
    /// *Database Migration Service User Guide.*
    pub fn startReplicationTask(self: *Self, allocator: std.mem.Allocator, input: start_replication_task.StartReplicationTaskInput, options: start_replication_task.Options) !start_replication_task.StartReplicationTaskOutput {
        return start_replication_task.execute(self, allocator, input, options);
    }

    /// Starts the replication task assessment for unsupported data types in the
    /// source
    /// database.
    ///
    /// You can only use this operation for a task if the following conditions are
    /// true:
    ///
    /// * The task must be in the `stopped` state.
    ///
    /// * The task must have successful connections to the source and target.
    ///
    /// If either of these conditions are not met, an `InvalidResourceStateFault`
    /// error will result.
    ///
    /// For information about DMS task assessments, see [Creating a task assessment
    /// report](https://docs.aws.amazon.com/dms/latest/userguide/CHAP_Tasks.AssessmentReport.html) in the *Database Migration Service User
    /// Guide*.
    pub fn startReplicationTaskAssessment(self: *Self, allocator: std.mem.Allocator, input: start_replication_task_assessment.StartReplicationTaskAssessmentInput, options: start_replication_task_assessment.Options) !start_replication_task_assessment.StartReplicationTaskAssessmentOutput {
        return start_replication_task_assessment.execute(self, allocator, input, options);
    }

    /// Starts a new premigration assessment run for one or more individual
    /// assessments of a
    /// migration task.
    ///
    /// The assessments that you can specify depend on the source and target
    /// database engine and
    /// the migration type defined for the given task. To run this operation, your
    /// migration task
    /// must already be created. After you run this operation, you can review the
    /// status of each
    /// individual assessment. You can also run the migration task manually after
    /// the assessment
    /// run and its individual assessments complete.
    pub fn startReplicationTaskAssessmentRun(self: *Self, allocator: std.mem.Allocator, input: start_replication_task_assessment_run.StartReplicationTaskAssessmentRunInput, options: start_replication_task_assessment_run.Options) !start_replication_task_assessment_run.StartReplicationTaskAssessmentRunOutput {
        return start_replication_task_assessment_run.execute(self, allocator, input, options);
    }

    /// Stops the specified data migration.
    pub fn stopDataMigration(self: *Self, allocator: std.mem.Allocator, input: stop_data_migration.StopDataMigrationInput, options: stop_data_migration.Options) !stop_data_migration.StopDataMigrationOutput {
        return stop_data_migration.execute(self, allocator, input, options);
    }

    /// For a given DMS Serverless replication configuration, DMS stops any and all
    /// ongoing
    /// DMS Serverless replications. This command doesn't deprovision the stopped
    /// replications.
    pub fn stopReplication(self: *Self, allocator: std.mem.Allocator, input: stop_replication.StopReplicationInput, options: stop_replication.Options) !stop_replication.StopReplicationOutput {
        return stop_replication.execute(self, allocator, input, options);
    }

    /// Stops the replication task.
    pub fn stopReplicationTask(self: *Self, allocator: std.mem.Allocator, input: stop_replication_task.StopReplicationTaskInput, options: stop_replication_task.Options) !stop_replication_task.StopReplicationTaskOutput {
        return stop_replication_task.execute(self, allocator, input, options);
    }

    /// Tests the connection between the replication instance and the endpoint.
    pub fn testConnection(self: *Self, allocator: std.mem.Allocator, input: test_connection.TestConnectionInput, options: test_connection.Options) !test_connection.TestConnectionOutput {
        return test_connection.execute(self, allocator, input, options);
    }

    /// Migrates 10 active and enabled Amazon SNS subscriptions at a time and
    /// converts them to
    /// corresponding Amazon EventBridge rules. By default, this operation migrates
    /// subscriptions
    /// only when all your replication instance versions are 3.4.5 or higher. If any
    /// replication
    /// instances are from versions earlier than 3.4.5, the operation raises an
    /// error and tells you
    /// to upgrade these instances to version 3.4.5 or higher. To enable migration
    /// regardless of
    /// version, set the `Force` option to true. However, if you don't upgrade
    /// instances
    /// earlier than version 3.4.5, some types of events might not be available when
    /// you use Amazon
    /// EventBridge.
    ///
    /// To call this operation, make sure that you have certain permissions added to
    /// your user
    /// account. For more information, see [Migrating event subscriptions to Amazon
    /// EventBridge](https://docs.aws.amazon.com/dms/latest/userguide/CHAP_Events.html#CHAP_Events-migrate-to-eventbridge) in the
    /// *Amazon Web Services Database Migration Service User Guide*.
    pub fn updateSubscriptionsToEventBridge(self: *Self, allocator: std.mem.Allocator, input: update_subscriptions_to_event_bridge.UpdateSubscriptionsToEventBridgeInput, options: update_subscriptions_to_event_bridge.Options) !update_subscriptions_to_event_bridge.UpdateSubscriptionsToEventBridgeOutput {
        return update_subscriptions_to_event_bridge.execute(self, allocator, input, options);
    }

    pub fn describeApplicableIndividualAssessmentsPaginator(self: *Self, params: describe_applicable_individual_assessments.DescribeApplicableIndividualAssessmentsInput) paginator.DescribeApplicableIndividualAssessmentsPaginator {
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

    pub fn describeConnectionsPaginator(self: *Self, params: describe_connections.DescribeConnectionsInput) paginator.DescribeConnectionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeDataMigrationsPaginator(self: *Self, params: describe_data_migrations.DescribeDataMigrationsInput) paginator.DescribeDataMigrationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeDataProvidersPaginator(self: *Self, params: describe_data_providers.DescribeDataProvidersInput) paginator.DescribeDataProvidersPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeEndpointSettingsPaginator(self: *Self, params: describe_endpoint_settings.DescribeEndpointSettingsInput) paginator.DescribeEndpointSettingsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeEndpointTypesPaginator(self: *Self, params: describe_endpoint_types.DescribeEndpointTypesInput) paginator.DescribeEndpointTypesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeEndpointsPaginator(self: *Self, params: describe_endpoints.DescribeEndpointsInput) paginator.DescribeEndpointsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeEngineVersionsPaginator(self: *Self, params: describe_engine_versions.DescribeEngineVersionsInput) paginator.DescribeEngineVersionsPaginator {
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

    pub fn describeExtensionPackAssociationsPaginator(self: *Self, params: describe_extension_pack_associations.DescribeExtensionPackAssociationsInput) paginator.DescribeExtensionPackAssociationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeFleetAdvisorCollectorsPaginator(self: *Self, params: describe_fleet_advisor_collectors.DescribeFleetAdvisorCollectorsInput) paginator.DescribeFleetAdvisorCollectorsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeFleetAdvisorDatabasesPaginator(self: *Self, params: describe_fleet_advisor_databases.DescribeFleetAdvisorDatabasesInput) paginator.DescribeFleetAdvisorDatabasesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeFleetAdvisorLsaAnalysisPaginator(self: *Self, params: describe_fleet_advisor_lsa_analysis.DescribeFleetAdvisorLsaAnalysisInput) paginator.DescribeFleetAdvisorLsaAnalysisPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeFleetAdvisorSchemaObjectSummaryPaginator(self: *Self, params: describe_fleet_advisor_schema_object_summary.DescribeFleetAdvisorSchemaObjectSummaryInput) paginator.DescribeFleetAdvisorSchemaObjectSummaryPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeFleetAdvisorSchemasPaginator(self: *Self, params: describe_fleet_advisor_schemas.DescribeFleetAdvisorSchemasInput) paginator.DescribeFleetAdvisorSchemasPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeInstanceProfilesPaginator(self: *Self, params: describe_instance_profiles.DescribeInstanceProfilesInput) paginator.DescribeInstanceProfilesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeMetadataModelAssessmentsPaginator(self: *Self, params: describe_metadata_model_assessments.DescribeMetadataModelAssessmentsInput) paginator.DescribeMetadataModelAssessmentsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeMetadataModelChildrenPaginator(self: *Self, params: describe_metadata_model_children.DescribeMetadataModelChildrenInput) paginator.DescribeMetadataModelChildrenPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeMetadataModelConversionsPaginator(self: *Self, params: describe_metadata_model_conversions.DescribeMetadataModelConversionsInput) paginator.DescribeMetadataModelConversionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeMetadataModelCreationsPaginator(self: *Self, params: describe_metadata_model_creations.DescribeMetadataModelCreationsInput) paginator.DescribeMetadataModelCreationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeMetadataModelExportsAsScriptPaginator(self: *Self, params: describe_metadata_model_exports_as_script.DescribeMetadataModelExportsAsScriptInput) paginator.DescribeMetadataModelExportsAsScriptPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeMetadataModelExportsToTargetPaginator(self: *Self, params: describe_metadata_model_exports_to_target.DescribeMetadataModelExportsToTargetInput) paginator.DescribeMetadataModelExportsToTargetPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeMetadataModelImportsPaginator(self: *Self, params: describe_metadata_model_imports.DescribeMetadataModelImportsInput) paginator.DescribeMetadataModelImportsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeMigrationProjectsPaginator(self: *Self, params: describe_migration_projects.DescribeMigrationProjectsInput) paginator.DescribeMigrationProjectsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeOrderableReplicationInstancesPaginator(self: *Self, params: describe_orderable_replication_instances.DescribeOrderableReplicationInstancesInput) paginator.DescribeOrderableReplicationInstancesPaginator {
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

    pub fn describeRecommendationLimitationsPaginator(self: *Self, params: describe_recommendation_limitations.DescribeRecommendationLimitationsInput) paginator.DescribeRecommendationLimitationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeRecommendationsPaginator(self: *Self, params: describe_recommendations.DescribeRecommendationsInput) paginator.DescribeRecommendationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeReplicationConfigsPaginator(self: *Self, params: describe_replication_configs.DescribeReplicationConfigsInput) paginator.DescribeReplicationConfigsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeReplicationInstanceTaskLogsPaginator(self: *Self, params: describe_replication_instance_task_logs.DescribeReplicationInstanceTaskLogsInput) paginator.DescribeReplicationInstanceTaskLogsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeReplicationInstancesPaginator(self: *Self, params: describe_replication_instances.DescribeReplicationInstancesInput) paginator.DescribeReplicationInstancesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeReplicationSubnetGroupsPaginator(self: *Self, params: describe_replication_subnet_groups.DescribeReplicationSubnetGroupsInput) paginator.DescribeReplicationSubnetGroupsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeReplicationTableStatisticsPaginator(self: *Self, params: describe_replication_table_statistics.DescribeReplicationTableStatisticsInput) paginator.DescribeReplicationTableStatisticsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeReplicationTaskAssessmentResultsPaginator(self: *Self, params: describe_replication_task_assessment_results.DescribeReplicationTaskAssessmentResultsInput) paginator.DescribeReplicationTaskAssessmentResultsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeReplicationTaskAssessmentRunsPaginator(self: *Self, params: describe_replication_task_assessment_runs.DescribeReplicationTaskAssessmentRunsInput) paginator.DescribeReplicationTaskAssessmentRunsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeReplicationTaskIndividualAssessmentsPaginator(self: *Self, params: describe_replication_task_individual_assessments.DescribeReplicationTaskIndividualAssessmentsInput) paginator.DescribeReplicationTaskIndividualAssessmentsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeReplicationTasksPaginator(self: *Self, params: describe_replication_tasks.DescribeReplicationTasksInput) paginator.DescribeReplicationTasksPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeReplicationsPaginator(self: *Self, params: describe_replications.DescribeReplicationsInput) paginator.DescribeReplicationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeSchemasPaginator(self: *Self, params: describe_schemas.DescribeSchemasInput) paginator.DescribeSchemasPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeTableStatisticsPaginator(self: *Self, params: describe_table_statistics.DescribeTableStatisticsInput) paginator.DescribeTableStatisticsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn waitUntilEndpointDeleted(self: *Self, params: describe_endpoints.DescribeEndpointsInput) aws.waiter.WaiterError!void {
        var w = waiters.EndpointDeletedWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilReplicationInstanceDeleted(self: *Self, params: describe_replication_instances.DescribeReplicationInstancesInput) aws.waiter.WaiterError!void {
        var w = waiters.ReplicationInstanceDeletedWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilReplicationTaskDeleted(self: *Self, params: describe_replication_tasks.DescribeReplicationTasksInput) aws.waiter.WaiterError!void {
        var w = waiters.ReplicationTaskDeletedWaiter{ .client = self, .params = params };
        return w.wait();
    }
};
