const aws = @import("aws");
const std = @import("std");

const batch_create_partition = @import("batch_create_partition.zig");
const batch_delete_connection = @import("batch_delete_connection.zig");
const batch_delete_partition = @import("batch_delete_partition.zig");
const batch_delete_table = @import("batch_delete_table.zig");
const batch_delete_table_version = @import("batch_delete_table_version.zig");
const batch_get_blueprints = @import("batch_get_blueprints.zig");
const batch_get_crawlers = @import("batch_get_crawlers.zig");
const batch_get_custom_entity_types = @import("batch_get_custom_entity_types.zig");
const batch_get_data_quality_result = @import("batch_get_data_quality_result.zig");
const batch_get_dev_endpoints = @import("batch_get_dev_endpoints.zig");
const batch_get_jobs = @import("batch_get_jobs.zig");
const batch_get_partition = @import("batch_get_partition.zig");
const batch_get_table_optimizer = @import("batch_get_table_optimizer.zig");
const batch_get_triggers = @import("batch_get_triggers.zig");
const batch_get_workflows = @import("batch_get_workflows.zig");
const batch_put_data_quality_statistic_annotation = @import("batch_put_data_quality_statistic_annotation.zig");
const batch_stop_job_run = @import("batch_stop_job_run.zig");
const batch_update_partition = @import("batch_update_partition.zig");
const cancel_data_quality_rule_recommendation_run = @import("cancel_data_quality_rule_recommendation_run.zig");
const cancel_data_quality_ruleset_evaluation_run = @import("cancel_data_quality_ruleset_evaluation_run.zig");
const cancel_ml_task_run = @import("cancel_ml_task_run.zig");
const cancel_statement = @import("cancel_statement.zig");
const check_schema_version_validity = @import("check_schema_version_validity.zig");
const create_blueprint = @import("create_blueprint.zig");
const create_catalog = @import("create_catalog.zig");
const create_classifier = @import("create_classifier.zig");
const create_column_statistics_task_settings = @import("create_column_statistics_task_settings.zig");
const create_connection = @import("create_connection.zig");
const create_crawler = @import("create_crawler.zig");
const create_custom_entity_type = @import("create_custom_entity_type.zig");
const create_data_quality_ruleset = @import("create_data_quality_ruleset.zig");
const create_database = @import("create_database.zig");
const create_dev_endpoint = @import("create_dev_endpoint.zig");
const create_glue_identity_center_configuration = @import("create_glue_identity_center_configuration.zig");
const create_integration = @import("create_integration.zig");
const create_integration_resource_property = @import("create_integration_resource_property.zig");
const create_integration_table_properties = @import("create_integration_table_properties.zig");
const create_job = @import("create_job.zig");
const create_ml_transform = @import("create_ml_transform.zig");
const create_partition = @import("create_partition.zig");
const create_partition_index = @import("create_partition_index.zig");
const create_registry = @import("create_registry.zig");
const create_schema = @import("create_schema.zig");
const create_script = @import("create_script.zig");
const create_security_configuration = @import("create_security_configuration.zig");
const create_session = @import("create_session.zig");
const create_table = @import("create_table.zig");
const create_table_optimizer = @import("create_table_optimizer.zig");
const create_trigger = @import("create_trigger.zig");
const create_usage_profile = @import("create_usage_profile.zig");
const create_user_defined_function = @import("create_user_defined_function.zig");
const create_workflow = @import("create_workflow.zig");
const delete_blueprint = @import("delete_blueprint.zig");
const delete_catalog = @import("delete_catalog.zig");
const delete_classifier = @import("delete_classifier.zig");
const delete_column_statistics_for_partition = @import("delete_column_statistics_for_partition.zig");
const delete_column_statistics_for_table = @import("delete_column_statistics_for_table.zig");
const delete_column_statistics_task_settings = @import("delete_column_statistics_task_settings.zig");
const delete_connection = @import("delete_connection.zig");
const delete_connection_type = @import("delete_connection_type.zig");
const delete_crawler = @import("delete_crawler.zig");
const delete_custom_entity_type = @import("delete_custom_entity_type.zig");
const delete_data_quality_ruleset = @import("delete_data_quality_ruleset.zig");
const delete_database = @import("delete_database.zig");
const delete_dev_endpoint = @import("delete_dev_endpoint.zig");
const delete_glue_identity_center_configuration = @import("delete_glue_identity_center_configuration.zig");
const delete_integration = @import("delete_integration.zig");
const delete_integration_resource_property = @import("delete_integration_resource_property.zig");
const delete_integration_table_properties = @import("delete_integration_table_properties.zig");
const delete_job = @import("delete_job.zig");
const delete_ml_transform = @import("delete_ml_transform.zig");
const delete_partition = @import("delete_partition.zig");
const delete_partition_index = @import("delete_partition_index.zig");
const delete_registry = @import("delete_registry.zig");
const delete_resource_policy = @import("delete_resource_policy.zig");
const delete_schema = @import("delete_schema.zig");
const delete_schema_versions = @import("delete_schema_versions.zig");
const delete_security_configuration = @import("delete_security_configuration.zig");
const delete_session = @import("delete_session.zig");
const delete_table = @import("delete_table.zig");
const delete_table_optimizer = @import("delete_table_optimizer.zig");
const delete_table_version = @import("delete_table_version.zig");
const delete_trigger = @import("delete_trigger.zig");
const delete_usage_profile = @import("delete_usage_profile.zig");
const delete_user_defined_function = @import("delete_user_defined_function.zig");
const delete_workflow = @import("delete_workflow.zig");
const describe_connection_type = @import("describe_connection_type.zig");
const describe_entity = @import("describe_entity.zig");
const describe_inbound_integrations = @import("describe_inbound_integrations.zig");
const describe_integrations = @import("describe_integrations.zig");
const get_blueprint = @import("get_blueprint.zig");
const get_blueprint_run = @import("get_blueprint_run.zig");
const get_blueprint_runs = @import("get_blueprint_runs.zig");
const get_catalog = @import("get_catalog.zig");
const get_catalog_import_status = @import("get_catalog_import_status.zig");
const get_catalogs = @import("get_catalogs.zig");
const get_classifier = @import("get_classifier.zig");
const get_classifiers = @import("get_classifiers.zig");
const get_column_statistics_for_partition = @import("get_column_statistics_for_partition.zig");
const get_column_statistics_for_table = @import("get_column_statistics_for_table.zig");
const get_column_statistics_task_run = @import("get_column_statistics_task_run.zig");
const get_column_statistics_task_runs = @import("get_column_statistics_task_runs.zig");
const get_column_statistics_task_settings = @import("get_column_statistics_task_settings.zig");
const get_connection = @import("get_connection.zig");
const get_connections = @import("get_connections.zig");
const get_crawler = @import("get_crawler.zig");
const get_crawler_metrics = @import("get_crawler_metrics.zig");
const get_crawlers = @import("get_crawlers.zig");
const get_custom_entity_type = @import("get_custom_entity_type.zig");
const get_data_catalog_encryption_settings = @import("get_data_catalog_encryption_settings.zig");
const get_data_quality_model = @import("get_data_quality_model.zig");
const get_data_quality_model_result = @import("get_data_quality_model_result.zig");
const get_data_quality_result = @import("get_data_quality_result.zig");
const get_data_quality_rule_recommendation_run = @import("get_data_quality_rule_recommendation_run.zig");
const get_data_quality_ruleset = @import("get_data_quality_ruleset.zig");
const get_data_quality_ruleset_evaluation_run = @import("get_data_quality_ruleset_evaluation_run.zig");
const get_database = @import("get_database.zig");
const get_databases = @import("get_databases.zig");
const get_dataflow_graph = @import("get_dataflow_graph.zig");
const get_dev_endpoint = @import("get_dev_endpoint.zig");
const get_dev_endpoints = @import("get_dev_endpoints.zig");
const get_entity_records = @import("get_entity_records.zig");
const get_glue_identity_center_configuration = @import("get_glue_identity_center_configuration.zig");
const get_integration_resource_property = @import("get_integration_resource_property.zig");
const get_integration_table_properties = @import("get_integration_table_properties.zig");
const get_job = @import("get_job.zig");
const get_job_bookmark = @import("get_job_bookmark.zig");
const get_job_run = @import("get_job_run.zig");
const get_job_runs = @import("get_job_runs.zig");
const get_jobs = @import("get_jobs.zig");
const get_mapping = @import("get_mapping.zig");
const get_materialized_view_refresh_task_run = @import("get_materialized_view_refresh_task_run.zig");
const get_ml_task_run = @import("get_ml_task_run.zig");
const get_ml_task_runs = @import("get_ml_task_runs.zig");
const get_ml_transform = @import("get_ml_transform.zig");
const get_ml_transforms = @import("get_ml_transforms.zig");
const get_partition = @import("get_partition.zig");
const get_partition_indexes = @import("get_partition_indexes.zig");
const get_partitions = @import("get_partitions.zig");
const get_plan = @import("get_plan.zig");
const get_registry = @import("get_registry.zig");
const get_resource_policies = @import("get_resource_policies.zig");
const get_resource_policy = @import("get_resource_policy.zig");
const get_schema = @import("get_schema.zig");
const get_schema_by_definition = @import("get_schema_by_definition.zig");
const get_schema_version = @import("get_schema_version.zig");
const get_schema_versions_diff = @import("get_schema_versions_diff.zig");
const get_security_configuration = @import("get_security_configuration.zig");
const get_security_configurations = @import("get_security_configurations.zig");
const get_session = @import("get_session.zig");
const get_statement = @import("get_statement.zig");
const get_table = @import("get_table.zig");
const get_table_optimizer = @import("get_table_optimizer.zig");
const get_table_version = @import("get_table_version.zig");
const get_table_versions = @import("get_table_versions.zig");
const get_tables = @import("get_tables.zig");
const get_tags = @import("get_tags.zig");
const get_trigger = @import("get_trigger.zig");
const get_triggers = @import("get_triggers.zig");
const get_unfiltered_partition_metadata = @import("get_unfiltered_partition_metadata.zig");
const get_unfiltered_partitions_metadata = @import("get_unfiltered_partitions_metadata.zig");
const get_unfiltered_table_metadata = @import("get_unfiltered_table_metadata.zig");
const get_usage_profile = @import("get_usage_profile.zig");
const get_user_defined_function = @import("get_user_defined_function.zig");
const get_user_defined_functions = @import("get_user_defined_functions.zig");
const get_workflow = @import("get_workflow.zig");
const get_workflow_run = @import("get_workflow_run.zig");
const get_workflow_run_properties = @import("get_workflow_run_properties.zig");
const get_workflow_runs = @import("get_workflow_runs.zig");
const import_catalog_to_glue = @import("import_catalog_to_glue.zig");
const list_blueprints = @import("list_blueprints.zig");
const list_column_statistics_task_runs = @import("list_column_statistics_task_runs.zig");
const list_connection_types = @import("list_connection_types.zig");
const list_crawlers = @import("list_crawlers.zig");
const list_crawls = @import("list_crawls.zig");
const list_custom_entity_types = @import("list_custom_entity_types.zig");
const list_data_quality_results = @import("list_data_quality_results.zig");
const list_data_quality_rule_recommendation_runs = @import("list_data_quality_rule_recommendation_runs.zig");
const list_data_quality_ruleset_evaluation_runs = @import("list_data_quality_ruleset_evaluation_runs.zig");
const list_data_quality_rulesets = @import("list_data_quality_rulesets.zig");
const list_data_quality_statistic_annotations = @import("list_data_quality_statistic_annotations.zig");
const list_data_quality_statistics = @import("list_data_quality_statistics.zig");
const list_dev_endpoints = @import("list_dev_endpoints.zig");
const list_entities = @import("list_entities.zig");
const list_integration_resource_properties = @import("list_integration_resource_properties.zig");
const list_jobs = @import("list_jobs.zig");
const list_materialized_view_refresh_task_runs = @import("list_materialized_view_refresh_task_runs.zig");
const list_ml_transforms = @import("list_ml_transforms.zig");
const list_registries = @import("list_registries.zig");
const list_schema_versions = @import("list_schema_versions.zig");
const list_schemas = @import("list_schemas.zig");
const list_sessions = @import("list_sessions.zig");
const list_statements = @import("list_statements.zig");
const list_table_optimizer_runs = @import("list_table_optimizer_runs.zig");
const list_triggers = @import("list_triggers.zig");
const list_usage_profiles = @import("list_usage_profiles.zig");
const list_workflows = @import("list_workflows.zig");
const modify_integration = @import("modify_integration.zig");
const put_data_catalog_encryption_settings = @import("put_data_catalog_encryption_settings.zig");
const put_data_quality_profile_annotation = @import("put_data_quality_profile_annotation.zig");
const put_resource_policy = @import("put_resource_policy.zig");
const put_schema_version_metadata = @import("put_schema_version_metadata.zig");
const put_workflow_run_properties = @import("put_workflow_run_properties.zig");
const query_schema_version_metadata = @import("query_schema_version_metadata.zig");
const register_connection_type = @import("register_connection_type.zig");
const register_schema_version = @import("register_schema_version.zig");
const remove_schema_version_metadata = @import("remove_schema_version_metadata.zig");
const reset_job_bookmark = @import("reset_job_bookmark.zig");
const resume_workflow_run = @import("resume_workflow_run.zig");
const run_statement = @import("run_statement.zig");
const search_tables = @import("search_tables.zig");
const start_blueprint_run = @import("start_blueprint_run.zig");
const start_column_statistics_task_run = @import("start_column_statistics_task_run.zig");
const start_column_statistics_task_run_schedule = @import("start_column_statistics_task_run_schedule.zig");
const start_crawler = @import("start_crawler.zig");
const start_crawler_schedule = @import("start_crawler_schedule.zig");
const start_data_quality_rule_recommendation_run = @import("start_data_quality_rule_recommendation_run.zig");
const start_data_quality_ruleset_evaluation_run = @import("start_data_quality_ruleset_evaluation_run.zig");
const start_export_labels_task_run = @import("start_export_labels_task_run.zig");
const start_import_labels_task_run = @import("start_import_labels_task_run.zig");
const start_job_run = @import("start_job_run.zig");
const start_materialized_view_refresh_task_run = @import("start_materialized_view_refresh_task_run.zig");
const start_ml_evaluation_task_run = @import("start_ml_evaluation_task_run.zig");
const start_ml_labeling_set_generation_task_run = @import("start_ml_labeling_set_generation_task_run.zig");
const start_trigger = @import("start_trigger.zig");
const start_workflow_run = @import("start_workflow_run.zig");
const stop_column_statistics_task_run = @import("stop_column_statistics_task_run.zig");
const stop_column_statistics_task_run_schedule = @import("stop_column_statistics_task_run_schedule.zig");
const stop_crawler = @import("stop_crawler.zig");
const stop_crawler_schedule = @import("stop_crawler_schedule.zig");
const stop_materialized_view_refresh_task_run = @import("stop_materialized_view_refresh_task_run.zig");
const stop_session = @import("stop_session.zig");
const stop_trigger = @import("stop_trigger.zig");
const stop_workflow_run = @import("stop_workflow_run.zig");
const tag_resource = @import("tag_resource.zig");
const test_connection = @import("test_connection.zig");
const untag_resource = @import("untag_resource.zig");
const update_blueprint = @import("update_blueprint.zig");
const update_catalog = @import("update_catalog.zig");
const update_classifier = @import("update_classifier.zig");
const update_column_statistics_for_partition = @import("update_column_statistics_for_partition.zig");
const update_column_statistics_for_table = @import("update_column_statistics_for_table.zig");
const update_column_statistics_task_settings = @import("update_column_statistics_task_settings.zig");
const update_connection = @import("update_connection.zig");
const update_crawler = @import("update_crawler.zig");
const update_crawler_schedule = @import("update_crawler_schedule.zig");
const update_data_quality_ruleset = @import("update_data_quality_ruleset.zig");
const update_database = @import("update_database.zig");
const update_dev_endpoint = @import("update_dev_endpoint.zig");
const update_glue_identity_center_configuration = @import("update_glue_identity_center_configuration.zig");
const update_integration_resource_property = @import("update_integration_resource_property.zig");
const update_integration_table_properties = @import("update_integration_table_properties.zig");
const update_job = @import("update_job.zig");
const update_job_from_source_control = @import("update_job_from_source_control.zig");
const update_ml_transform = @import("update_ml_transform.zig");
const update_partition = @import("update_partition.zig");
const update_registry = @import("update_registry.zig");
const update_schema = @import("update_schema.zig");
const update_source_control_from_job = @import("update_source_control_from_job.zig");
const update_table = @import("update_table.zig");
const update_table_optimizer = @import("update_table_optimizer.zig");
const update_trigger = @import("update_trigger.zig");
const update_usage_profile = @import("update_usage_profile.zig");
const update_user_defined_function = @import("update_user_defined_function.zig");
const update_workflow = @import("update_workflow.zig");
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "Glue";

    pub fn init(allocator: std.mem.Allocator, config: *aws.Config) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.init(allocator, config.retry_mode),
        };
    }

    pub fn initWithOptions(allocator: std.mem.Allocator, config: *aws.Config, options: aws.http.RequestOptions) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.initWithOptions(allocator, config.retry_mode, options),
        };
    }

    pub fn deinit(self: *Self) void {
        self.http_client.deinit();
    }

    /// Creates one or more partitions in a batch operation.
    pub fn batchCreatePartition(self: *Self, allocator: std.mem.Allocator, input: batch_create_partition.BatchCreatePartitionInput, options: batch_create_partition.Options) !batch_create_partition.BatchCreatePartitionOutput {
        return batch_create_partition.execute(self, allocator, input, options);
    }

    /// Deletes a list of connection definitions from the Data Catalog.
    pub fn batchDeleteConnection(self: *Self, allocator: std.mem.Allocator, input: batch_delete_connection.BatchDeleteConnectionInput, options: batch_delete_connection.Options) !batch_delete_connection.BatchDeleteConnectionOutput {
        return batch_delete_connection.execute(self, allocator, input, options);
    }

    /// Deletes one or more partitions in a batch operation.
    pub fn batchDeletePartition(self: *Self, allocator: std.mem.Allocator, input: batch_delete_partition.BatchDeletePartitionInput, options: batch_delete_partition.Options) !batch_delete_partition.BatchDeletePartitionOutput {
        return batch_delete_partition.execute(self, allocator, input, options);
    }

    /// Deletes multiple tables at once.
    ///
    /// After completing this operation, you no longer have access to the table
    /// versions and
    /// partitions that belong to the deleted table. Glue deletes these "orphaned"
    /// resources
    /// asynchronously in a timely manner, at the discretion of the service.
    ///
    /// To ensure the immediate deletion of all related resources, before calling
    /// `BatchDeleteTable`, use `DeleteTableVersion` or
    /// `BatchDeleteTableVersion`, and `DeletePartition` or
    /// `BatchDeletePartition`, to delete any resources that belong to the
    /// table.
    pub fn batchDeleteTable(self: *Self, allocator: std.mem.Allocator, input: batch_delete_table.BatchDeleteTableInput, options: batch_delete_table.Options) !batch_delete_table.BatchDeleteTableOutput {
        return batch_delete_table.execute(self, allocator, input, options);
    }

    /// Deletes a specified batch of versions of a table.
    pub fn batchDeleteTableVersion(self: *Self, allocator: std.mem.Allocator, input: batch_delete_table_version.BatchDeleteTableVersionInput, options: batch_delete_table_version.Options) !batch_delete_table_version.BatchDeleteTableVersionOutput {
        return batch_delete_table_version.execute(self, allocator, input, options);
    }

    /// Retrieves information about a list of blueprints.
    pub fn batchGetBlueprints(self: *Self, allocator: std.mem.Allocator, input: batch_get_blueprints.BatchGetBlueprintsInput, options: batch_get_blueprints.Options) !batch_get_blueprints.BatchGetBlueprintsOutput {
        return batch_get_blueprints.execute(self, allocator, input, options);
    }

    /// Returns a list of resource metadata for a given list of crawler names. After
    /// calling the `ListCrawlers` operation, you can call this operation to access
    /// the data to which you have been granted permissions. This operation supports
    /// all IAM permissions, including permission conditions that uses tags.
    pub fn batchGetCrawlers(self: *Self, allocator: std.mem.Allocator, input: batch_get_crawlers.BatchGetCrawlersInput, options: batch_get_crawlers.Options) !batch_get_crawlers.BatchGetCrawlersOutput {
        return batch_get_crawlers.execute(self, allocator, input, options);
    }

    /// Retrieves the details for the custom patterns specified by a list of names.
    pub fn batchGetCustomEntityTypes(self: *Self, allocator: std.mem.Allocator, input: batch_get_custom_entity_types.BatchGetCustomEntityTypesInput, options: batch_get_custom_entity_types.Options) !batch_get_custom_entity_types.BatchGetCustomEntityTypesOutput {
        return batch_get_custom_entity_types.execute(self, allocator, input, options);
    }

    /// Retrieves a list of data quality results for the specified result IDs.
    pub fn batchGetDataQualityResult(self: *Self, allocator: std.mem.Allocator, input: batch_get_data_quality_result.BatchGetDataQualityResultInput, options: batch_get_data_quality_result.Options) !batch_get_data_quality_result.BatchGetDataQualityResultOutput {
        return batch_get_data_quality_result.execute(self, allocator, input, options);
    }

    /// Returns a list of resource metadata for a given list of development endpoint
    /// names. After
    /// calling the `ListDevEndpoints` operation, you can call this operation to
    /// access the
    /// data to which you have been granted permissions. This operation supports all
    /// IAM permissions,
    /// including permission conditions that uses tags.
    pub fn batchGetDevEndpoints(self: *Self, allocator: std.mem.Allocator, input: batch_get_dev_endpoints.BatchGetDevEndpointsInput, options: batch_get_dev_endpoints.Options) !batch_get_dev_endpoints.BatchGetDevEndpointsOutput {
        return batch_get_dev_endpoints.execute(self, allocator, input, options);
    }

    /// Returns a list of resource metadata for a given list of job names. After
    /// calling the `ListJobs` operation, you can call this operation to access the
    /// data to which you have been granted permissions. This operation supports all
    /// IAM permissions, including permission conditions that uses tags.
    pub fn batchGetJobs(self: *Self, allocator: std.mem.Allocator, input: batch_get_jobs.BatchGetJobsInput, options: batch_get_jobs.Options) !batch_get_jobs.BatchGetJobsOutput {
        return batch_get_jobs.execute(self, allocator, input, options);
    }

    /// Retrieves partitions in a batch request.
    pub fn batchGetPartition(self: *Self, allocator: std.mem.Allocator, input: batch_get_partition.BatchGetPartitionInput, options: batch_get_partition.Options) !batch_get_partition.BatchGetPartitionOutput {
        return batch_get_partition.execute(self, allocator, input, options);
    }

    /// Returns the configuration for the specified table optimizers.
    pub fn batchGetTableOptimizer(self: *Self, allocator: std.mem.Allocator, input: batch_get_table_optimizer.BatchGetTableOptimizerInput, options: batch_get_table_optimizer.Options) !batch_get_table_optimizer.BatchGetTableOptimizerOutput {
        return batch_get_table_optimizer.execute(self, allocator, input, options);
    }

    /// Returns a list of resource metadata for a given list of trigger names. After
    /// calling the `ListTriggers` operation, you can call this operation to access
    /// the data to which you have been granted permissions. This operation supports
    /// all IAM permissions, including permission conditions that uses tags.
    pub fn batchGetTriggers(self: *Self, allocator: std.mem.Allocator, input: batch_get_triggers.BatchGetTriggersInput, options: batch_get_triggers.Options) !batch_get_triggers.BatchGetTriggersOutput {
        return batch_get_triggers.execute(self, allocator, input, options);
    }

    /// Returns a list of resource metadata for a given list of workflow names.
    /// After calling the `ListWorkflows` operation, you can call this operation to
    /// access the data to which you have been granted permissions. This operation
    /// supports all IAM permissions, including permission conditions that uses
    /// tags.
    pub fn batchGetWorkflows(self: *Self, allocator: std.mem.Allocator, input: batch_get_workflows.BatchGetWorkflowsInput, options: batch_get_workflows.Options) !batch_get_workflows.BatchGetWorkflowsOutput {
        return batch_get_workflows.execute(self, allocator, input, options);
    }

    /// Annotate datapoints over time for a specific data quality statistic.
    /// The API requires both profileID and statisticID as part of the
    /// InclusionAnnotation input.
    /// The API only works for a single statisticId across multiple profiles.
    pub fn batchPutDataQualityStatisticAnnotation(self: *Self, allocator: std.mem.Allocator, input: batch_put_data_quality_statistic_annotation.BatchPutDataQualityStatisticAnnotationInput, options: batch_put_data_quality_statistic_annotation.Options) !batch_put_data_quality_statistic_annotation.BatchPutDataQualityStatisticAnnotationOutput {
        return batch_put_data_quality_statistic_annotation.execute(self, allocator, input, options);
    }

    /// Stops one or more job runs for a specified job definition.
    pub fn batchStopJobRun(self: *Self, allocator: std.mem.Allocator, input: batch_stop_job_run.BatchStopJobRunInput, options: batch_stop_job_run.Options) !batch_stop_job_run.BatchStopJobRunOutput {
        return batch_stop_job_run.execute(self, allocator, input, options);
    }

    /// Updates one or more partitions in a batch operation.
    pub fn batchUpdatePartition(self: *Self, allocator: std.mem.Allocator, input: batch_update_partition.BatchUpdatePartitionInput, options: batch_update_partition.Options) !batch_update_partition.BatchUpdatePartitionOutput {
        return batch_update_partition.execute(self, allocator, input, options);
    }

    /// Cancels the specified recommendation run that was being used to generate
    /// rules.
    pub fn cancelDataQualityRuleRecommendationRun(self: *Self, allocator: std.mem.Allocator, input: cancel_data_quality_rule_recommendation_run.CancelDataQualityRuleRecommendationRunInput, options: cancel_data_quality_rule_recommendation_run.Options) !cancel_data_quality_rule_recommendation_run.CancelDataQualityRuleRecommendationRunOutput {
        return cancel_data_quality_rule_recommendation_run.execute(self, allocator, input, options);
    }

    /// Cancels a run where a ruleset is being evaluated against a data source.
    pub fn cancelDataQualityRulesetEvaluationRun(self: *Self, allocator: std.mem.Allocator, input: cancel_data_quality_ruleset_evaluation_run.CancelDataQualityRulesetEvaluationRunInput, options: cancel_data_quality_ruleset_evaluation_run.Options) !cancel_data_quality_ruleset_evaluation_run.CancelDataQualityRulesetEvaluationRunOutput {
        return cancel_data_quality_ruleset_evaluation_run.execute(self, allocator, input, options);
    }

    /// Cancels (stops) a task run. Machine learning task runs are asynchronous
    /// tasks that Glue runs on your behalf as part of various machine learning
    /// workflows. You can cancel a
    /// machine learning task run at any time by calling `CancelMLTaskRun` with a
    /// task
    /// run's parent transform's `TransformID` and the task run's `TaskRunId`.
    pub fn cancelMlTaskRun(self: *Self, allocator: std.mem.Allocator, input: cancel_ml_task_run.CancelMLTaskRunInput, options: cancel_ml_task_run.Options) !cancel_ml_task_run.CancelMLTaskRunOutput {
        return cancel_ml_task_run.execute(self, allocator, input, options);
    }

    /// Cancels the statement.
    pub fn cancelStatement(self: *Self, allocator: std.mem.Allocator, input: cancel_statement.CancelStatementInput, options: cancel_statement.Options) !cancel_statement.CancelStatementOutput {
        return cancel_statement.execute(self, allocator, input, options);
    }

    /// Validates the supplied schema. This call has no side effects, it simply
    /// validates using the supplied schema using `DataFormat` as the format. Since
    /// it does not take a schema set name, no compatibility checks are performed.
    pub fn checkSchemaVersionValidity(self: *Self, allocator: std.mem.Allocator, input: check_schema_version_validity.CheckSchemaVersionValidityInput, options: check_schema_version_validity.Options) !check_schema_version_validity.CheckSchemaVersionValidityOutput {
        return check_schema_version_validity.execute(self, allocator, input, options);
    }

    /// Registers a blueprint with Glue.
    pub fn createBlueprint(self: *Self, allocator: std.mem.Allocator, input: create_blueprint.CreateBlueprintInput, options: create_blueprint.Options) !create_blueprint.CreateBlueprintOutput {
        return create_blueprint.execute(self, allocator, input, options);
    }

    /// Creates a new catalog in the Glue Data Catalog.
    pub fn createCatalog(self: *Self, allocator: std.mem.Allocator, input: create_catalog.CreateCatalogInput, options: create_catalog.Options) !create_catalog.CreateCatalogOutput {
        return create_catalog.execute(self, allocator, input, options);
    }

    /// Creates a classifier in the user's account. This can be a `GrokClassifier`,
    /// an
    /// `XMLClassifier`, a `JsonClassifier`, or a `CsvClassifier`,
    /// depending on which field of the request is present.
    pub fn createClassifier(self: *Self, allocator: std.mem.Allocator, input: create_classifier.CreateClassifierInput, options: create_classifier.Options) !create_classifier.CreateClassifierOutput {
        return create_classifier.execute(self, allocator, input, options);
    }

    /// Creates settings for a column statistics task.
    pub fn createColumnStatisticsTaskSettings(self: *Self, allocator: std.mem.Allocator, input: create_column_statistics_task_settings.CreateColumnStatisticsTaskSettingsInput, options: create_column_statistics_task_settings.Options) !create_column_statistics_task_settings.CreateColumnStatisticsTaskSettingsOutput {
        return create_column_statistics_task_settings.execute(self, allocator, input, options);
    }

    /// Creates a connection definition in the Data Catalog.
    ///
    /// Connections used for creating federated resources require the IAM
    /// `glue:PassConnection` permission.
    pub fn createConnection(self: *Self, allocator: std.mem.Allocator, input: create_connection.CreateConnectionInput, options: create_connection.Options) !create_connection.CreateConnectionOutput {
        return create_connection.execute(self, allocator, input, options);
    }

    /// Creates a new crawler with specified targets, role, configuration, and
    /// optional schedule.
    /// At least one crawl target must be specified, in the `s3Targets` field, the
    /// `jdbcTargets` field, or the `DynamoDBTargets` field.
    pub fn createCrawler(self: *Self, allocator: std.mem.Allocator, input: create_crawler.CreateCrawlerInput, options: create_crawler.Options) !create_crawler.CreateCrawlerOutput {
        return create_crawler.execute(self, allocator, input, options);
    }

    /// Creates a custom pattern that is used to detect sensitive data across the
    /// columns and rows of your structured data.
    ///
    /// Each custom pattern you create specifies a regular expression and an
    /// optional list of context words. If no context words are passed only a
    /// regular expression is checked.
    pub fn createCustomEntityType(self: *Self, allocator: std.mem.Allocator, input: create_custom_entity_type.CreateCustomEntityTypeInput, options: create_custom_entity_type.Options) !create_custom_entity_type.CreateCustomEntityTypeOutput {
        return create_custom_entity_type.execute(self, allocator, input, options);
    }

    /// Creates a data quality ruleset with DQDL rules applied to a specified Glue
    /// table.
    ///
    /// You create the ruleset using the Data Quality Definition Language (DQDL).
    /// For more information, see the Glue developer guide.
    pub fn createDataQualityRuleset(self: *Self, allocator: std.mem.Allocator, input: create_data_quality_ruleset.CreateDataQualityRulesetInput, options: create_data_quality_ruleset.Options) !create_data_quality_ruleset.CreateDataQualityRulesetOutput {
        return create_data_quality_ruleset.execute(self, allocator, input, options);
    }

    /// Creates a new database in a Data Catalog.
    pub fn createDatabase(self: *Self, allocator: std.mem.Allocator, input: create_database.CreateDatabaseInput, options: create_database.Options) !create_database.CreateDatabaseOutput {
        return create_database.execute(self, allocator, input, options);
    }

    /// Creates a new development endpoint.
    pub fn createDevEndpoint(self: *Self, allocator: std.mem.Allocator, input: create_dev_endpoint.CreateDevEndpointInput, options: create_dev_endpoint.Options) !create_dev_endpoint.CreateDevEndpointOutput {
        return create_dev_endpoint.execute(self, allocator, input, options);
    }

    /// Creates a new Glue Identity Center configuration to enable integration
    /// between Glue and Amazon Web Services IAM
    /// Identity Center for authentication and authorization.
    pub fn createGlueIdentityCenterConfiguration(self: *Self, allocator: std.mem.Allocator, input: create_glue_identity_center_configuration.CreateGlueIdentityCenterConfigurationInput, options: create_glue_identity_center_configuration.Options) !create_glue_identity_center_configuration.CreateGlueIdentityCenterConfigurationOutput {
        return create_glue_identity_center_configuration.execute(self, allocator, input, options);
    }

    /// Creates a Zero-ETL integration in the caller's account between two resources
    /// with Amazon Resource Names (ARNs): the `SourceArn` and `TargetArn`.
    pub fn createIntegration(self: *Self, allocator: std.mem.Allocator, input: create_integration.CreateIntegrationInput, options: create_integration.Options) !create_integration.CreateIntegrationOutput {
        return create_integration.execute(self, allocator, input, options);
    }

    /// This API can be used for setting up the `ResourceProperty` of the Glue
    /// connection (for the source) or Glue database ARN (for the target). These
    /// properties can include the role to access the connection or database. To set
    /// both source and target properties the same API needs to be invoked with the
    /// Glue connection ARN as `ResourceArn` with `SourceProcessingProperties` and
    /// the Glue database ARN as `ResourceArn` with `TargetProcessingProperties`
    /// respectively.
    pub fn createIntegrationResourceProperty(self: *Self, allocator: std.mem.Allocator, input: create_integration_resource_property.CreateIntegrationResourcePropertyInput, options: create_integration_resource_property.Options) !create_integration_resource_property.CreateIntegrationResourcePropertyOutput {
        return create_integration_resource_property.execute(self, allocator, input, options);
    }

    /// This API is used to provide optional override properties for the the tables
    /// that need to be replicated. These properties can include properties for
    /// filtering and partitioning for the source and target tables. To set both
    /// source and target properties the same API need to be invoked with the Glue
    /// connection ARN as `ResourceArn` with `SourceTableConfig`, and the Glue
    /// database ARN as `ResourceArn` with `TargetTableConfig` respectively.
    pub fn createIntegrationTableProperties(self: *Self, allocator: std.mem.Allocator, input: create_integration_table_properties.CreateIntegrationTablePropertiesInput, options: create_integration_table_properties.Options) !create_integration_table_properties.CreateIntegrationTablePropertiesOutput {
        return create_integration_table_properties.execute(self, allocator, input, options);
    }

    /// Creates a new job definition.
    pub fn createJob(self: *Self, allocator: std.mem.Allocator, input: create_job.CreateJobInput, options: create_job.Options) !create_job.CreateJobOutput {
        return create_job.execute(self, allocator, input, options);
    }

    /// Creates an Glue machine learning transform. This operation creates the
    /// transform and
    /// all the necessary parameters to train it.
    ///
    /// Call this operation as the first step in the process of using a machine
    /// learning transform
    /// (such as the `FindMatches` transform) for deduplicating data. You can
    /// provide an
    /// optional `Description`, in addition to the parameters that you want to use
    /// for your
    /// algorithm.
    ///
    /// You must also specify certain parameters for the tasks that Glue runs on
    /// your
    /// behalf as part of learning from your data and creating a high-quality
    /// machine learning
    /// transform. These parameters include `Role`, and optionally,
    /// `AllocatedCapacity`, `Timeout`, and `MaxRetries`. For more
    /// information, see
    /// [Jobs](https://docs.aws.amazon.com/glue/latest/dg/aws-glue-api-jobs-job.html).
    pub fn createMlTransform(self: *Self, allocator: std.mem.Allocator, input: create_ml_transform.CreateMLTransformInput, options: create_ml_transform.Options) !create_ml_transform.CreateMLTransformOutput {
        return create_ml_transform.execute(self, allocator, input, options);
    }

    /// Creates a new partition.
    pub fn createPartition(self: *Self, allocator: std.mem.Allocator, input: create_partition.CreatePartitionInput, options: create_partition.Options) !create_partition.CreatePartitionOutput {
        return create_partition.execute(self, allocator, input, options);
    }

    /// Creates a specified partition index in an existing table.
    pub fn createPartitionIndex(self: *Self, allocator: std.mem.Allocator, input: create_partition_index.CreatePartitionIndexInput, options: create_partition_index.Options) !create_partition_index.CreatePartitionIndexOutput {
        return create_partition_index.execute(self, allocator, input, options);
    }

    /// Creates a new registry which may be used to hold a collection of schemas.
    pub fn createRegistry(self: *Self, allocator: std.mem.Allocator, input: create_registry.CreateRegistryInput, options: create_registry.Options) !create_registry.CreateRegistryOutput {
        return create_registry.execute(self, allocator, input, options);
    }

    /// Creates a new schema set and registers the schema definition. Returns an
    /// error if the schema set already exists without actually registering the
    /// version.
    ///
    /// When the schema set is created, a version checkpoint will be set to the
    /// first version. Compatibility mode "DISABLED" restricts any additional schema
    /// versions from being added after the first schema version. For all other
    /// compatibility modes, validation of compatibility settings will be applied
    /// only from the second version onwards when the `RegisterSchemaVersion` API is
    /// used.
    ///
    /// When this API is called without a `RegistryId`, this will create an entry
    /// for a "default-registry" in the registry database tables, if it is not
    /// already present.
    pub fn createSchema(self: *Self, allocator: std.mem.Allocator, input: create_schema.CreateSchemaInput, options: create_schema.Options) !create_schema.CreateSchemaOutput {
        return create_schema.execute(self, allocator, input, options);
    }

    /// Transforms a directed acyclic graph (DAG) into code.
    pub fn createScript(self: *Self, allocator: std.mem.Allocator, input: create_script.CreateScriptInput, options: create_script.Options) !create_script.CreateScriptOutput {
        return create_script.execute(self, allocator, input, options);
    }

    /// Creates a new security configuration. A security configuration is a set of
    /// security properties that can be used by Glue. You can use a security
    /// configuration to encrypt data at rest. For information about using security
    /// configurations in Glue, see [Encrypting Data Written by Crawlers, Jobs, and
    /// Development
    /// Endpoints](https://docs.aws.amazon.com/glue/latest/dg/encryption-security-configuration.html).
    pub fn createSecurityConfiguration(self: *Self, allocator: std.mem.Allocator, input: create_security_configuration.CreateSecurityConfigurationInput, options: create_security_configuration.Options) !create_security_configuration.CreateSecurityConfigurationOutput {
        return create_security_configuration.execute(self, allocator, input, options);
    }

    /// Creates a new session.
    pub fn createSession(self: *Self, allocator: std.mem.Allocator, input: create_session.CreateSessionInput, options: create_session.Options) !create_session.CreateSessionOutput {
        return create_session.execute(self, allocator, input, options);
    }

    /// Creates a new table definition in the Data Catalog.
    pub fn createTable(self: *Self, allocator: std.mem.Allocator, input: create_table.CreateTableInput, options: create_table.Options) !create_table.CreateTableOutput {
        return create_table.execute(self, allocator, input, options);
    }

    /// Creates a new table optimizer for a specific function.
    pub fn createTableOptimizer(self: *Self, allocator: std.mem.Allocator, input: create_table_optimizer.CreateTableOptimizerInput, options: create_table_optimizer.Options) !create_table_optimizer.CreateTableOptimizerOutput {
        return create_table_optimizer.execute(self, allocator, input, options);
    }

    /// Creates a new trigger.
    ///
    /// Job arguments may be logged. Do not pass plaintext secrets as arguments.
    /// Retrieve secrets from a Glue Connection, Amazon Web Services Secrets Manager
    /// or other secret management mechanism if you intend to keep them within the
    /// Job.
    pub fn createTrigger(self: *Self, allocator: std.mem.Allocator, input: create_trigger.CreateTriggerInput, options: create_trigger.Options) !create_trigger.CreateTriggerOutput {
        return create_trigger.execute(self, allocator, input, options);
    }

    /// Creates an Glue usage profile.
    pub fn createUsageProfile(self: *Self, allocator: std.mem.Allocator, input: create_usage_profile.CreateUsageProfileInput, options: create_usage_profile.Options) !create_usage_profile.CreateUsageProfileOutput {
        return create_usage_profile.execute(self, allocator, input, options);
    }

    /// Creates a new function definition in the Data Catalog.
    pub fn createUserDefinedFunction(self: *Self, allocator: std.mem.Allocator, input: create_user_defined_function.CreateUserDefinedFunctionInput, options: create_user_defined_function.Options) !create_user_defined_function.CreateUserDefinedFunctionOutput {
        return create_user_defined_function.execute(self, allocator, input, options);
    }

    /// Creates a new workflow.
    pub fn createWorkflow(self: *Self, allocator: std.mem.Allocator, input: create_workflow.CreateWorkflowInput, options: create_workflow.Options) !create_workflow.CreateWorkflowOutput {
        return create_workflow.execute(self, allocator, input, options);
    }

    /// Deletes an existing blueprint.
    pub fn deleteBlueprint(self: *Self, allocator: std.mem.Allocator, input: delete_blueprint.DeleteBlueprintInput, options: delete_blueprint.Options) !delete_blueprint.DeleteBlueprintOutput {
        return delete_blueprint.execute(self, allocator, input, options);
    }

    /// Removes the specified catalog from the Glue Data Catalog.
    ///
    /// After completing this operation, you no longer have access to the databases,
    /// tables (and all table versions and partitions that might belong to the
    /// tables) and the user-defined functions in the deleted catalog. Glue deletes
    /// these "orphaned" resources asynchronously in a timely manner, at the
    /// discretion of the service.
    ///
    /// To ensure the immediate deletion of all related resources before calling the
    /// `DeleteCatalog` operation, use `DeleteTableVersion` (or
    /// `BatchDeleteTableVersion`), `DeletePartition` (or `BatchDeletePartition`),
    /// `DeleteTable` (or `BatchDeleteTable`), `DeleteUserDefinedFunction` and
    /// `DeleteDatabase` to delete any resources that belong to the catalog.
    pub fn deleteCatalog(self: *Self, allocator: std.mem.Allocator, input: delete_catalog.DeleteCatalogInput, options: delete_catalog.Options) !delete_catalog.DeleteCatalogOutput {
        return delete_catalog.execute(self, allocator, input, options);
    }

    /// Removes a classifier from the Data Catalog.
    pub fn deleteClassifier(self: *Self, allocator: std.mem.Allocator, input: delete_classifier.DeleteClassifierInput, options: delete_classifier.Options) !delete_classifier.DeleteClassifierOutput {
        return delete_classifier.execute(self, allocator, input, options);
    }

    /// Delete the partition column statistics of a column.
    ///
    /// The Identity and Access Management (IAM) permission required for this
    /// operation is `DeletePartition`.
    pub fn deleteColumnStatisticsForPartition(self: *Self, allocator: std.mem.Allocator, input: delete_column_statistics_for_partition.DeleteColumnStatisticsForPartitionInput, options: delete_column_statistics_for_partition.Options) !delete_column_statistics_for_partition.DeleteColumnStatisticsForPartitionOutput {
        return delete_column_statistics_for_partition.execute(self, allocator, input, options);
    }

    /// Retrieves table statistics of columns.
    ///
    /// The Identity and Access Management (IAM) permission required for this
    /// operation is `DeleteTable`.
    pub fn deleteColumnStatisticsForTable(self: *Self, allocator: std.mem.Allocator, input: delete_column_statistics_for_table.DeleteColumnStatisticsForTableInput, options: delete_column_statistics_for_table.Options) !delete_column_statistics_for_table.DeleteColumnStatisticsForTableOutput {
        return delete_column_statistics_for_table.execute(self, allocator, input, options);
    }

    /// Deletes settings for a column statistics task.
    pub fn deleteColumnStatisticsTaskSettings(self: *Self, allocator: std.mem.Allocator, input: delete_column_statistics_task_settings.DeleteColumnStatisticsTaskSettingsInput, options: delete_column_statistics_task_settings.Options) !delete_column_statistics_task_settings.DeleteColumnStatisticsTaskSettingsOutput {
        return delete_column_statistics_task_settings.execute(self, allocator, input, options);
    }

    /// Deletes a connection from the Data Catalog.
    pub fn deleteConnection(self: *Self, allocator: std.mem.Allocator, input: delete_connection.DeleteConnectionInput, options: delete_connection.Options) !delete_connection.DeleteConnectionOutput {
        return delete_connection.execute(self, allocator, input, options);
    }

    /// Deletes a custom connection type in Glue.
    ///
    /// The connection type must exist and be registered before it can be deleted.
    /// This operation supports cleanup of connection type resources and helps
    /// maintain proper lifecycle management of custom connection types.
    pub fn deleteConnectionType(self: *Self, allocator: std.mem.Allocator, input: delete_connection_type.DeleteConnectionTypeInput, options: delete_connection_type.Options) !delete_connection_type.DeleteConnectionTypeOutput {
        return delete_connection_type.execute(self, allocator, input, options);
    }

    /// Removes a specified crawler from the Glue Data Catalog, unless the crawler
    /// state is
    /// `RUNNING`.
    pub fn deleteCrawler(self: *Self, allocator: std.mem.Allocator, input: delete_crawler.DeleteCrawlerInput, options: delete_crawler.Options) !delete_crawler.DeleteCrawlerOutput {
        return delete_crawler.execute(self, allocator, input, options);
    }

    /// Deletes a custom pattern by specifying its name.
    pub fn deleteCustomEntityType(self: *Self, allocator: std.mem.Allocator, input: delete_custom_entity_type.DeleteCustomEntityTypeInput, options: delete_custom_entity_type.Options) !delete_custom_entity_type.DeleteCustomEntityTypeOutput {
        return delete_custom_entity_type.execute(self, allocator, input, options);
    }

    /// Deletes a data quality ruleset.
    pub fn deleteDataQualityRuleset(self: *Self, allocator: std.mem.Allocator, input: delete_data_quality_ruleset.DeleteDataQualityRulesetInput, options: delete_data_quality_ruleset.Options) !delete_data_quality_ruleset.DeleteDataQualityRulesetOutput {
        return delete_data_quality_ruleset.execute(self, allocator, input, options);
    }

    /// Removes a specified database from a Data Catalog.
    ///
    /// After completing this operation, you no longer have access to the tables
    /// (and all table
    /// versions and partitions that might belong to the tables) and the
    /// user-defined functions in
    /// the deleted database. Glue deletes these "orphaned" resources asynchronously
    /// in a timely
    /// manner, at the discretion of the service.
    ///
    /// To ensure the immediate deletion of all related resources, before calling
    /// `DeleteDatabase`, use `DeleteTableVersion` or
    /// `BatchDeleteTableVersion`, `DeletePartition` or
    /// `BatchDeletePartition`, `DeleteUserDefinedFunction`, and
    /// `DeleteTable` or `BatchDeleteTable`, to delete any resources that
    /// belong to the database.
    pub fn deleteDatabase(self: *Self, allocator: std.mem.Allocator, input: delete_database.DeleteDatabaseInput, options: delete_database.Options) !delete_database.DeleteDatabaseOutput {
        return delete_database.execute(self, allocator, input, options);
    }

    /// Deletes a specified development endpoint.
    pub fn deleteDevEndpoint(self: *Self, allocator: std.mem.Allocator, input: delete_dev_endpoint.DeleteDevEndpointInput, options: delete_dev_endpoint.Options) !delete_dev_endpoint.DeleteDevEndpointOutput {
        return delete_dev_endpoint.execute(self, allocator, input, options);
    }

    /// Deletes the existing Glue Identity Center configuration, removing the
    /// integration between Glue and
    /// Amazon Web Services IAM Identity Center.
    pub fn deleteGlueIdentityCenterConfiguration(self: *Self, allocator: std.mem.Allocator, input: delete_glue_identity_center_configuration.DeleteGlueIdentityCenterConfigurationInput, options: delete_glue_identity_center_configuration.Options) !delete_glue_identity_center_configuration.DeleteGlueIdentityCenterConfigurationOutput {
        return delete_glue_identity_center_configuration.execute(self, allocator, input, options);
    }

    /// Deletes the specified Zero-ETL integration.
    pub fn deleteIntegration(self: *Self, allocator: std.mem.Allocator, input: delete_integration.DeleteIntegrationInput, options: delete_integration.Options) !delete_integration.DeleteIntegrationOutput {
        return delete_integration.execute(self, allocator, input, options);
    }

    /// This API is used for deleting the `ResourceProperty` of the Glue connection
    /// (for the source) or Glue database ARN (for the target).
    pub fn deleteIntegrationResourceProperty(self: *Self, allocator: std.mem.Allocator, input: delete_integration_resource_property.DeleteIntegrationResourcePropertyInput, options: delete_integration_resource_property.Options) !delete_integration_resource_property.DeleteIntegrationResourcePropertyOutput {
        return delete_integration_resource_property.execute(self, allocator, input, options);
    }

    /// Deletes the table properties that have been created for the tables that need
    /// to be replicated.
    pub fn deleteIntegrationTableProperties(self: *Self, allocator: std.mem.Allocator, input: delete_integration_table_properties.DeleteIntegrationTablePropertiesInput, options: delete_integration_table_properties.Options) !delete_integration_table_properties.DeleteIntegrationTablePropertiesOutput {
        return delete_integration_table_properties.execute(self, allocator, input, options);
    }

    /// Deletes a specified job definition. If the job definition
    /// is not found, no exception is thrown.
    pub fn deleteJob(self: *Self, allocator: std.mem.Allocator, input: delete_job.DeleteJobInput, options: delete_job.Options) !delete_job.DeleteJobOutput {
        return delete_job.execute(self, allocator, input, options);
    }

    /// Deletes an Glue machine learning transform. Machine learning transforms are
    /// a special
    /// type of transform that use machine learning to learn the details of the
    /// transformation to be
    /// performed by learning from examples provided by humans. These
    /// transformations are then saved
    /// by Glue. If you no longer need a transform, you can delete it by calling
    /// `DeleteMLTransforms`. However, any Glue jobs that still reference the
    /// deleted
    /// transform will no longer succeed.
    pub fn deleteMlTransform(self: *Self, allocator: std.mem.Allocator, input: delete_ml_transform.DeleteMLTransformInput, options: delete_ml_transform.Options) !delete_ml_transform.DeleteMLTransformOutput {
        return delete_ml_transform.execute(self, allocator, input, options);
    }

    /// Deletes a specified partition.
    pub fn deletePartition(self: *Self, allocator: std.mem.Allocator, input: delete_partition.DeletePartitionInput, options: delete_partition.Options) !delete_partition.DeletePartitionOutput {
        return delete_partition.execute(self, allocator, input, options);
    }

    /// Deletes a specified partition index from an existing table.
    pub fn deletePartitionIndex(self: *Self, allocator: std.mem.Allocator, input: delete_partition_index.DeletePartitionIndexInput, options: delete_partition_index.Options) !delete_partition_index.DeletePartitionIndexOutput {
        return delete_partition_index.execute(self, allocator, input, options);
    }

    /// Delete the entire registry including schema and all of its versions. To get
    /// the status of the delete operation, you can call the `GetRegistry` API after
    /// the asynchronous call. Deleting a registry will deactivate all online
    /// operations for the registry such as the `UpdateRegistry`, `CreateSchema`,
    /// `UpdateSchema`, and `RegisterSchemaVersion` APIs.
    pub fn deleteRegistry(self: *Self, allocator: std.mem.Allocator, input: delete_registry.DeleteRegistryInput, options: delete_registry.Options) !delete_registry.DeleteRegistryOutput {
        return delete_registry.execute(self, allocator, input, options);
    }

    /// Deletes a specified policy.
    pub fn deleteResourcePolicy(self: *Self, allocator: std.mem.Allocator, input: delete_resource_policy.DeleteResourcePolicyInput, options: delete_resource_policy.Options) !delete_resource_policy.DeleteResourcePolicyOutput {
        return delete_resource_policy.execute(self, allocator, input, options);
    }

    /// Deletes the entire schema set, including the schema set and all of its
    /// versions. To get the status of the delete operation, you can call
    /// `GetSchema` API after the asynchronous call. Deleting a registry will
    /// deactivate all online operations for the schema, such as the
    /// `GetSchemaByDefinition`, and `RegisterSchemaVersion` APIs.
    pub fn deleteSchema(self: *Self, allocator: std.mem.Allocator, input: delete_schema.DeleteSchemaInput, options: delete_schema.Options) !delete_schema.DeleteSchemaOutput {
        return delete_schema.execute(self, allocator, input, options);
    }

    /// Remove versions from the specified schema. A version number or range may be
    /// supplied. If the compatibility mode forbids deleting of a version that is
    /// necessary, such as BACKWARDS_FULL, an error is returned. Calling the
    /// `GetSchemaVersions` API after this call will list the status of the deleted
    /// versions.
    ///
    /// When the range of version numbers contain check pointed version, the API
    /// will return a 409 conflict and will not proceed with the deletion. You have
    /// to remove the checkpoint first using the `DeleteSchemaCheckpoint` API before
    /// using this API.
    ///
    /// You cannot use the `DeleteSchemaVersions` API to delete the first schema
    /// version in the schema set. The first schema version can only be deleted by
    /// the `DeleteSchema` API. This operation will also delete the attached
    /// `SchemaVersionMetadata` under the schema versions. Hard deletes will be
    /// enforced on the database.
    ///
    /// If the compatibility mode forbids deleting of a version that is necessary,
    /// such as BACKWARDS_FULL, an error is returned.
    pub fn deleteSchemaVersions(self: *Self, allocator: std.mem.Allocator, input: delete_schema_versions.DeleteSchemaVersionsInput, options: delete_schema_versions.Options) !delete_schema_versions.DeleteSchemaVersionsOutput {
        return delete_schema_versions.execute(self, allocator, input, options);
    }

    /// Deletes a specified security configuration.
    pub fn deleteSecurityConfiguration(self: *Self, allocator: std.mem.Allocator, input: delete_security_configuration.DeleteSecurityConfigurationInput, options: delete_security_configuration.Options) !delete_security_configuration.DeleteSecurityConfigurationOutput {
        return delete_security_configuration.execute(self, allocator, input, options);
    }

    /// Deletes the session.
    pub fn deleteSession(self: *Self, allocator: std.mem.Allocator, input: delete_session.DeleteSessionInput, options: delete_session.Options) !delete_session.DeleteSessionOutput {
        return delete_session.execute(self, allocator, input, options);
    }

    /// Removes a table definition from the Data Catalog.
    ///
    /// After completing this operation, you no longer have access to the table
    /// versions and
    /// partitions that belong to the deleted table. Glue deletes these "orphaned"
    /// resources
    /// asynchronously in a timely manner, at the discretion of the service.
    ///
    /// To ensure the immediate deletion of all related resources, before calling
    /// `DeleteTable`, use `DeleteTableVersion` or
    /// `BatchDeleteTableVersion`, and `DeletePartition` or
    /// `BatchDeletePartition`, to delete any resources that belong to the
    /// table.
    pub fn deleteTable(self: *Self, allocator: std.mem.Allocator, input: delete_table.DeleteTableInput, options: delete_table.Options) !delete_table.DeleteTableOutput {
        return delete_table.execute(self, allocator, input, options);
    }

    /// Deletes an optimizer and all associated metadata for a table. The
    /// optimization will no longer be performed on the table.
    pub fn deleteTableOptimizer(self: *Self, allocator: std.mem.Allocator, input: delete_table_optimizer.DeleteTableOptimizerInput, options: delete_table_optimizer.Options) !delete_table_optimizer.DeleteTableOptimizerOutput {
        return delete_table_optimizer.execute(self, allocator, input, options);
    }

    /// Deletes a specified version of a table.
    pub fn deleteTableVersion(self: *Self, allocator: std.mem.Allocator, input: delete_table_version.DeleteTableVersionInput, options: delete_table_version.Options) !delete_table_version.DeleteTableVersionOutput {
        return delete_table_version.execute(self, allocator, input, options);
    }

    /// Deletes a specified trigger. If the trigger is not found, no
    /// exception is thrown.
    pub fn deleteTrigger(self: *Self, allocator: std.mem.Allocator, input: delete_trigger.DeleteTriggerInput, options: delete_trigger.Options) !delete_trigger.DeleteTriggerOutput {
        return delete_trigger.execute(self, allocator, input, options);
    }

    /// Deletes the Glue specified usage profile.
    pub fn deleteUsageProfile(self: *Self, allocator: std.mem.Allocator, input: delete_usage_profile.DeleteUsageProfileInput, options: delete_usage_profile.Options) !delete_usage_profile.DeleteUsageProfileOutput {
        return delete_usage_profile.execute(self, allocator, input, options);
    }

    /// Deletes an existing function definition from the Data Catalog.
    pub fn deleteUserDefinedFunction(self: *Self, allocator: std.mem.Allocator, input: delete_user_defined_function.DeleteUserDefinedFunctionInput, options: delete_user_defined_function.Options) !delete_user_defined_function.DeleteUserDefinedFunctionOutput {
        return delete_user_defined_function.execute(self, allocator, input, options);
    }

    /// Deletes a workflow.
    pub fn deleteWorkflow(self: *Self, allocator: std.mem.Allocator, input: delete_workflow.DeleteWorkflowInput, options: delete_workflow.Options) !delete_workflow.DeleteWorkflowOutput {
        return delete_workflow.execute(self, allocator, input, options);
    }

    /// The `DescribeConnectionType` API provides full details of the supported
    /// options for a given connection type in Glue. The response includes
    /// authentication configuration details that show supported authentication
    /// types and properties, and RestConfiguration for custom REST-based connection
    /// types registered via `RegisterConnectionType`.
    ///
    /// See also: `ListConnectionTypes`, `RegisterConnectionType`,
    /// `DeleteConnectionType`
    pub fn describeConnectionType(self: *Self, allocator: std.mem.Allocator, input: describe_connection_type.DescribeConnectionTypeInput, options: describe_connection_type.Options) !describe_connection_type.DescribeConnectionTypeOutput {
        return describe_connection_type.execute(self, allocator, input, options);
    }

    /// Provides details regarding the entity used with the connection type, with a
    /// description of the data model for each field in the selected entity.
    ///
    /// The response includes all the fields which make up the entity.
    pub fn describeEntity(self: *Self, allocator: std.mem.Allocator, input: describe_entity.DescribeEntityInput, options: describe_entity.Options) !describe_entity.DescribeEntityOutput {
        return describe_entity.execute(self, allocator, input, options);
    }

    /// Returns a list of inbound integrations for the specified integration.
    pub fn describeInboundIntegrations(self: *Self, allocator: std.mem.Allocator, input: describe_inbound_integrations.DescribeInboundIntegrationsInput, options: describe_inbound_integrations.Options) !describe_inbound_integrations.DescribeInboundIntegrationsOutput {
        return describe_inbound_integrations.execute(self, allocator, input, options);
    }

    /// The API is used to retrieve a list of integrations.
    pub fn describeIntegrations(self: *Self, allocator: std.mem.Allocator, input: describe_integrations.DescribeIntegrationsInput, options: describe_integrations.Options) !describe_integrations.DescribeIntegrationsOutput {
        return describe_integrations.execute(self, allocator, input, options);
    }

    /// Retrieves the details of a blueprint.
    pub fn getBlueprint(self: *Self, allocator: std.mem.Allocator, input: get_blueprint.GetBlueprintInput, options: get_blueprint.Options) !get_blueprint.GetBlueprintOutput {
        return get_blueprint.execute(self, allocator, input, options);
    }

    /// Retrieves the details of a blueprint run.
    pub fn getBlueprintRun(self: *Self, allocator: std.mem.Allocator, input: get_blueprint_run.GetBlueprintRunInput, options: get_blueprint_run.Options) !get_blueprint_run.GetBlueprintRunOutput {
        return get_blueprint_run.execute(self, allocator, input, options);
    }

    /// Retrieves the details of blueprint runs for a specified blueprint.
    pub fn getBlueprintRuns(self: *Self, allocator: std.mem.Allocator, input: get_blueprint_runs.GetBlueprintRunsInput, options: get_blueprint_runs.Options) !get_blueprint_runs.GetBlueprintRunsOutput {
        return get_blueprint_runs.execute(self, allocator, input, options);
    }

    /// The name of the Catalog to retrieve. This should be all lowercase.
    pub fn getCatalog(self: *Self, allocator: std.mem.Allocator, input: get_catalog.GetCatalogInput, options: get_catalog.Options) !get_catalog.GetCatalogOutput {
        return get_catalog.execute(self, allocator, input, options);
    }

    /// Retrieves the status of a migration operation.
    pub fn getCatalogImportStatus(self: *Self, allocator: std.mem.Allocator, input: get_catalog_import_status.GetCatalogImportStatusInput, options: get_catalog_import_status.Options) !get_catalog_import_status.GetCatalogImportStatusOutput {
        return get_catalog_import_status.execute(self, allocator, input, options);
    }

    /// Retrieves all catalogs defined in a catalog in the Glue Data Catalog. For a
    /// Redshift-federated catalog use case, this operation returns the list of
    /// catalogs mapped to Redshift databases in the Redshift namespace catalog.
    pub fn getCatalogs(self: *Self, allocator: std.mem.Allocator, input: get_catalogs.GetCatalogsInput, options: get_catalogs.Options) !get_catalogs.GetCatalogsOutput {
        return get_catalogs.execute(self, allocator, input, options);
    }

    /// Retrieve a classifier by name.
    pub fn getClassifier(self: *Self, allocator: std.mem.Allocator, input: get_classifier.GetClassifierInput, options: get_classifier.Options) !get_classifier.GetClassifierOutput {
        return get_classifier.execute(self, allocator, input, options);
    }

    /// Lists all classifier objects in the Data Catalog.
    pub fn getClassifiers(self: *Self, allocator: std.mem.Allocator, input: get_classifiers.GetClassifiersInput, options: get_classifiers.Options) !get_classifiers.GetClassifiersOutput {
        return get_classifiers.execute(self, allocator, input, options);
    }

    /// Retrieves partition statistics of columns.
    ///
    /// The Identity and Access Management (IAM) permission required for this
    /// operation is `GetPartition`.
    pub fn getColumnStatisticsForPartition(self: *Self, allocator: std.mem.Allocator, input: get_column_statistics_for_partition.GetColumnStatisticsForPartitionInput, options: get_column_statistics_for_partition.Options) !get_column_statistics_for_partition.GetColumnStatisticsForPartitionOutput {
        return get_column_statistics_for_partition.execute(self, allocator, input, options);
    }

    /// Retrieves table statistics of columns.
    ///
    /// The Identity and Access Management (IAM) permission required for this
    /// operation is `GetTable`.
    pub fn getColumnStatisticsForTable(self: *Self, allocator: std.mem.Allocator, input: get_column_statistics_for_table.GetColumnStatisticsForTableInput, options: get_column_statistics_for_table.Options) !get_column_statistics_for_table.GetColumnStatisticsForTableOutput {
        return get_column_statistics_for_table.execute(self, allocator, input, options);
    }

    /// Get the associated metadata/information for a task run, given a task run ID.
    pub fn getColumnStatisticsTaskRun(self: *Self, allocator: std.mem.Allocator, input: get_column_statistics_task_run.GetColumnStatisticsTaskRunInput, options: get_column_statistics_task_run.Options) !get_column_statistics_task_run.GetColumnStatisticsTaskRunOutput {
        return get_column_statistics_task_run.execute(self, allocator, input, options);
    }

    /// Retrieves information about all runs associated with the specified table.
    pub fn getColumnStatisticsTaskRuns(self: *Self, allocator: std.mem.Allocator, input: get_column_statistics_task_runs.GetColumnStatisticsTaskRunsInput, options: get_column_statistics_task_runs.Options) !get_column_statistics_task_runs.GetColumnStatisticsTaskRunsOutput {
        return get_column_statistics_task_runs.execute(self, allocator, input, options);
    }

    /// Gets settings for a column statistics task.
    pub fn getColumnStatisticsTaskSettings(self: *Self, allocator: std.mem.Allocator, input: get_column_statistics_task_settings.GetColumnStatisticsTaskSettingsInput, options: get_column_statistics_task_settings.Options) !get_column_statistics_task_settings.GetColumnStatisticsTaskSettingsOutput {
        return get_column_statistics_task_settings.execute(self, allocator, input, options);
    }

    /// Retrieves a connection definition from the Data Catalog.
    pub fn getConnection(self: *Self, allocator: std.mem.Allocator, input: get_connection.GetConnectionInput, options: get_connection.Options) !get_connection.GetConnectionOutput {
        return get_connection.execute(self, allocator, input, options);
    }

    /// Retrieves a list of connection definitions from the Data Catalog.
    pub fn getConnections(self: *Self, allocator: std.mem.Allocator, input: get_connections.GetConnectionsInput, options: get_connections.Options) !get_connections.GetConnectionsOutput {
        return get_connections.execute(self, allocator, input, options);
    }

    /// Retrieves metadata for a specified crawler.
    pub fn getCrawler(self: *Self, allocator: std.mem.Allocator, input: get_crawler.GetCrawlerInput, options: get_crawler.Options) !get_crawler.GetCrawlerOutput {
        return get_crawler.execute(self, allocator, input, options);
    }

    /// Retrieves metrics about specified crawlers.
    pub fn getCrawlerMetrics(self: *Self, allocator: std.mem.Allocator, input: get_crawler_metrics.GetCrawlerMetricsInput, options: get_crawler_metrics.Options) !get_crawler_metrics.GetCrawlerMetricsOutput {
        return get_crawler_metrics.execute(self, allocator, input, options);
    }

    /// Retrieves metadata for all crawlers defined in the customer
    /// account.
    pub fn getCrawlers(self: *Self, allocator: std.mem.Allocator, input: get_crawlers.GetCrawlersInput, options: get_crawlers.Options) !get_crawlers.GetCrawlersOutput {
        return get_crawlers.execute(self, allocator, input, options);
    }

    /// Retrieves the details of a custom pattern by specifying its name.
    pub fn getCustomEntityType(self: *Self, allocator: std.mem.Allocator, input: get_custom_entity_type.GetCustomEntityTypeInput, options: get_custom_entity_type.Options) !get_custom_entity_type.GetCustomEntityTypeOutput {
        return get_custom_entity_type.execute(self, allocator, input, options);
    }

    /// Retrieves the security configuration for a specified catalog.
    pub fn getDataCatalogEncryptionSettings(self: *Self, allocator: std.mem.Allocator, input: get_data_catalog_encryption_settings.GetDataCatalogEncryptionSettingsInput, options: get_data_catalog_encryption_settings.Options) !get_data_catalog_encryption_settings.GetDataCatalogEncryptionSettingsOutput {
        return get_data_catalog_encryption_settings.execute(self, allocator, input, options);
    }

    /// Retrieve the training status of the model along with more information
    /// (CompletedOn, StartedOn, FailureReason).
    pub fn getDataQualityModel(self: *Self, allocator: std.mem.Allocator, input: get_data_quality_model.GetDataQualityModelInput, options: get_data_quality_model.Options) !get_data_quality_model.GetDataQualityModelOutput {
        return get_data_quality_model.execute(self, allocator, input, options);
    }

    /// Retrieve a statistic's predictions for a given Profile ID.
    pub fn getDataQualityModelResult(self: *Self, allocator: std.mem.Allocator, input: get_data_quality_model_result.GetDataQualityModelResultInput, options: get_data_quality_model_result.Options) !get_data_quality_model_result.GetDataQualityModelResultOutput {
        return get_data_quality_model_result.execute(self, allocator, input, options);
    }

    /// Retrieves the result of a data quality rule evaluation.
    pub fn getDataQualityResult(self: *Self, allocator: std.mem.Allocator, input: get_data_quality_result.GetDataQualityResultInput, options: get_data_quality_result.Options) !get_data_quality_result.GetDataQualityResultOutput {
        return get_data_quality_result.execute(self, allocator, input, options);
    }

    /// Gets the specified recommendation run that was used to generate rules.
    pub fn getDataQualityRuleRecommendationRun(self: *Self, allocator: std.mem.Allocator, input: get_data_quality_rule_recommendation_run.GetDataQualityRuleRecommendationRunInput, options: get_data_quality_rule_recommendation_run.Options) !get_data_quality_rule_recommendation_run.GetDataQualityRuleRecommendationRunOutput {
        return get_data_quality_rule_recommendation_run.execute(self, allocator, input, options);
    }

    /// Returns an existing ruleset by identifier or name.
    pub fn getDataQualityRuleset(self: *Self, allocator: std.mem.Allocator, input: get_data_quality_ruleset.GetDataQualityRulesetInput, options: get_data_quality_ruleset.Options) !get_data_quality_ruleset.GetDataQualityRulesetOutput {
        return get_data_quality_ruleset.execute(self, allocator, input, options);
    }

    /// Retrieves a specific run where a ruleset is evaluated against a data source.
    pub fn getDataQualityRulesetEvaluationRun(self: *Self, allocator: std.mem.Allocator, input: get_data_quality_ruleset_evaluation_run.GetDataQualityRulesetEvaluationRunInput, options: get_data_quality_ruleset_evaluation_run.Options) !get_data_quality_ruleset_evaluation_run.GetDataQualityRulesetEvaluationRunOutput {
        return get_data_quality_ruleset_evaluation_run.execute(self, allocator, input, options);
    }

    /// Retrieves the definition of a specified database.
    pub fn getDatabase(self: *Self, allocator: std.mem.Allocator, input: get_database.GetDatabaseInput, options: get_database.Options) !get_database.GetDatabaseOutput {
        return get_database.execute(self, allocator, input, options);
    }

    /// Retrieves all databases defined in a given Data Catalog.
    pub fn getDatabases(self: *Self, allocator: std.mem.Allocator, input: get_databases.GetDatabasesInput, options: get_databases.Options) !get_databases.GetDatabasesOutput {
        return get_databases.execute(self, allocator, input, options);
    }

    /// Transforms a Python script into a directed acyclic graph (DAG).
    pub fn getDataflowGraph(self: *Self, allocator: std.mem.Allocator, input: get_dataflow_graph.GetDataflowGraphInput, options: get_dataflow_graph.Options) !get_dataflow_graph.GetDataflowGraphOutput {
        return get_dataflow_graph.execute(self, allocator, input, options);
    }

    /// Retrieves information about a specified development endpoint.
    ///
    /// When you create a development endpoint in a virtual private cloud (VPC),
    /// Glue returns only
    /// a private IP address, and the public IP address field is not populated. When
    /// you create a
    /// non-VPC development endpoint, Glue returns only a public IP address.
    pub fn getDevEndpoint(self: *Self, allocator: std.mem.Allocator, input: get_dev_endpoint.GetDevEndpointInput, options: get_dev_endpoint.Options) !get_dev_endpoint.GetDevEndpointOutput {
        return get_dev_endpoint.execute(self, allocator, input, options);
    }

    /// Retrieves all the development endpoints in this Amazon Web Services account.
    ///
    /// When you create a development endpoint in a virtual private cloud (VPC),
    /// Glue returns only a private IP address
    /// and the public IP address field is not populated. When you create a non-VPC
    /// development
    /// endpoint, Glue returns only a public IP address.
    pub fn getDevEndpoints(self: *Self, allocator: std.mem.Allocator, input: get_dev_endpoints.GetDevEndpointsInput, options: get_dev_endpoints.Options) !get_dev_endpoints.GetDevEndpointsOutput {
        return get_dev_endpoints.execute(self, allocator, input, options);
    }

    /// This API is used to query preview data from a given connection type or from
    /// a native Amazon S3 based Glue Data Catalog.
    ///
    /// Returns records as an array of JSON blobs. Each record is formatted using
    /// Jackson JsonNode based on the field type defined by the `DescribeEntity`
    /// API.
    ///
    /// Spark connectors generate schemas according to the same data type mapping as
    /// in the `DescribeEntity` API. Spark connectors convert data to the
    /// appropriate data types matching the schema when returning rows.
    pub fn getEntityRecords(self: *Self, allocator: std.mem.Allocator, input: get_entity_records.GetEntityRecordsInput, options: get_entity_records.Options) !get_entity_records.GetEntityRecordsOutput {
        return get_entity_records.execute(self, allocator, input, options);
    }

    /// Retrieves the current Glue Identity Center configuration details, including
    /// the associated Identity Center instance and
    /// application information.
    pub fn getGlueIdentityCenterConfiguration(self: *Self, allocator: std.mem.Allocator, input: get_glue_identity_center_configuration.GetGlueIdentityCenterConfigurationInput, options: get_glue_identity_center_configuration.Options) !get_glue_identity_center_configuration.GetGlueIdentityCenterConfigurationOutput {
        return get_glue_identity_center_configuration.execute(self, allocator, input, options);
    }

    /// This API is used for fetching the `ResourceProperty` of the Glue connection
    /// (for the source) or Glue database ARN (for the target)
    pub fn getIntegrationResourceProperty(self: *Self, allocator: std.mem.Allocator, input: get_integration_resource_property.GetIntegrationResourcePropertyInput, options: get_integration_resource_property.Options) !get_integration_resource_property.GetIntegrationResourcePropertyOutput {
        return get_integration_resource_property.execute(self, allocator, input, options);
    }

    /// This API is used to retrieve optional override properties for the tables
    /// that need to be replicated. These properties can include properties for
    /// filtering and partition for source and target tables.
    pub fn getIntegrationTableProperties(self: *Self, allocator: std.mem.Allocator, input: get_integration_table_properties.GetIntegrationTablePropertiesInput, options: get_integration_table_properties.Options) !get_integration_table_properties.GetIntegrationTablePropertiesOutput {
        return get_integration_table_properties.execute(self, allocator, input, options);
    }

    /// Retrieves an existing job definition.
    pub fn getJob(self: *Self, allocator: std.mem.Allocator, input: get_job.GetJobInput, options: get_job.Options) !get_job.GetJobOutput {
        return get_job.execute(self, allocator, input, options);
    }

    /// Returns information on a job bookmark entry.
    ///
    /// For more information about enabling and using job bookmarks, see:
    ///
    /// * [Tracking processed data using job
    ///   bookmarks](https://docs.aws.amazon.com/glue/latest/dg/monitor-continuations.html)
    ///
    /// * [Job parameters used by
    ///   Glue](https://docs.aws.amazon.com/glue/latest/dg/aws-glue-programming-etl-glue-arguments.html)
    ///
    /// * [Job
    ///   structure](https://docs.aws.amazon.com/glue/latest/dg/aws-glue-api-jobs-job.html#aws-glue-api-jobs-job-Job)
    pub fn getJobBookmark(self: *Self, allocator: std.mem.Allocator, input: get_job_bookmark.GetJobBookmarkInput, options: get_job_bookmark.Options) !get_job_bookmark.GetJobBookmarkOutput {
        return get_job_bookmark.execute(self, allocator, input, options);
    }

    /// Retrieves the metadata for a given job run. Job run history is accessible
    /// for 365 days for your workflow and job run.
    pub fn getJobRun(self: *Self, allocator: std.mem.Allocator, input: get_job_run.GetJobRunInput, options: get_job_run.Options) !get_job_run.GetJobRunOutput {
        return get_job_run.execute(self, allocator, input, options);
    }

    /// Retrieves metadata for all runs of a given job definition.
    ///
    /// `GetJobRuns` returns the job runs in chronological order, with the newest
    /// jobs returned first.
    pub fn getJobRuns(self: *Self, allocator: std.mem.Allocator, input: get_job_runs.GetJobRunsInput, options: get_job_runs.Options) !get_job_runs.GetJobRunsOutput {
        return get_job_runs.execute(self, allocator, input, options);
    }

    /// Retrieves all current job definitions.
    pub fn getJobs(self: *Self, allocator: std.mem.Allocator, input: get_jobs.GetJobsInput, options: get_jobs.Options) !get_jobs.GetJobsOutput {
        return get_jobs.execute(self, allocator, input, options);
    }

    /// Creates mappings.
    pub fn getMapping(self: *Self, allocator: std.mem.Allocator, input: get_mapping.GetMappingInput, options: get_mapping.Options) !get_mapping.GetMappingOutput {
        return get_mapping.execute(self, allocator, input, options);
    }

    /// Get the associated metadata/information for a task run, given a task run ID.
    pub fn getMaterializedViewRefreshTaskRun(self: *Self, allocator: std.mem.Allocator, input: get_materialized_view_refresh_task_run.GetMaterializedViewRefreshTaskRunInput, options: get_materialized_view_refresh_task_run.Options) !get_materialized_view_refresh_task_run.GetMaterializedViewRefreshTaskRunOutput {
        return get_materialized_view_refresh_task_run.execute(self, allocator, input, options);
    }

    /// Gets details for a specific task run on a machine learning transform.
    /// Machine learning
    /// task runs are asynchronous tasks that Glue runs on your behalf as part of
    /// various machine
    /// learning workflows. You can check the stats of any task run by calling
    /// `GetMLTaskRun` with the `TaskRunID` and its parent transform's
    /// `TransformID`.
    pub fn getMlTaskRun(self: *Self, allocator: std.mem.Allocator, input: get_ml_task_run.GetMLTaskRunInput, options: get_ml_task_run.Options) !get_ml_task_run.GetMLTaskRunOutput {
        return get_ml_task_run.execute(self, allocator, input, options);
    }

    /// Gets a list of runs for a machine learning transform. Machine learning task
    /// runs are
    /// asynchronous tasks that Glue runs on your behalf as part of various machine
    /// learning
    /// workflows. You can get a sortable, filterable list of machine learning task
    /// runs by calling
    /// `GetMLTaskRuns` with their parent transform's `TransformID` and other
    /// optional parameters as documented in this section.
    ///
    /// This operation returns a list of historic runs and must be paginated.
    pub fn getMlTaskRuns(self: *Self, allocator: std.mem.Allocator, input: get_ml_task_runs.GetMLTaskRunsInput, options: get_ml_task_runs.Options) !get_ml_task_runs.GetMLTaskRunsOutput {
        return get_ml_task_runs.execute(self, allocator, input, options);
    }

    /// Gets an Glue machine learning transform artifact and all its corresponding
    /// metadata.
    /// Machine learning transforms are a special type of transform that use machine
    /// learning to learn
    /// the details of the transformation to be performed by learning from examples
    /// provided by
    /// humans. These transformations are then saved by Glue. You can retrieve their
    /// metadata by
    /// calling `GetMLTransform`.
    pub fn getMlTransform(self: *Self, allocator: std.mem.Allocator, input: get_ml_transform.GetMLTransformInput, options: get_ml_transform.Options) !get_ml_transform.GetMLTransformOutput {
        return get_ml_transform.execute(self, allocator, input, options);
    }

    /// Gets a sortable, filterable list of existing Glue machine learning
    /// transforms. Machine
    /// learning transforms are a special type of transform that use machine
    /// learning to learn the
    /// details of the transformation to be performed by learning from examples
    /// provided by humans.
    /// These transformations are then saved by Glue, and you can retrieve their
    /// metadata by
    /// calling `GetMLTransforms`.
    pub fn getMlTransforms(self: *Self, allocator: std.mem.Allocator, input: get_ml_transforms.GetMLTransformsInput, options: get_ml_transforms.Options) !get_ml_transforms.GetMLTransformsOutput {
        return get_ml_transforms.execute(self, allocator, input, options);
    }

    /// Retrieves information about a specified partition.
    pub fn getPartition(self: *Self, allocator: std.mem.Allocator, input: get_partition.GetPartitionInput, options: get_partition.Options) !get_partition.GetPartitionOutput {
        return get_partition.execute(self, allocator, input, options);
    }

    /// Retrieves the partition indexes associated with a table.
    pub fn getPartitionIndexes(self: *Self, allocator: std.mem.Allocator, input: get_partition_indexes.GetPartitionIndexesInput, options: get_partition_indexes.Options) !get_partition_indexes.GetPartitionIndexesOutput {
        return get_partition_indexes.execute(self, allocator, input, options);
    }

    /// Retrieves information about the partitions in a table.
    pub fn getPartitions(self: *Self, allocator: std.mem.Allocator, input: get_partitions.GetPartitionsInput, options: get_partitions.Options) !get_partitions.GetPartitionsOutput {
        return get_partitions.execute(self, allocator, input, options);
    }

    /// Gets code to perform a specified mapping.
    pub fn getPlan(self: *Self, allocator: std.mem.Allocator, input: get_plan.GetPlanInput, options: get_plan.Options) !get_plan.GetPlanOutput {
        return get_plan.execute(self, allocator, input, options);
    }

    /// Describes the specified registry in detail.
    pub fn getRegistry(self: *Self, allocator: std.mem.Allocator, input: get_registry.GetRegistryInput, options: get_registry.Options) !get_registry.GetRegistryOutput {
        return get_registry.execute(self, allocator, input, options);
    }

    /// Retrieves the resource policies set on individual resources by Resource
    /// Access Manager
    /// during cross-account permission grants. Also retrieves the Data Catalog
    /// resource
    /// policy.
    ///
    /// If you enabled metadata encryption in Data Catalog settings, and you do not
    /// have
    /// permission on the KMS key, the operation can't return the Data Catalog
    /// resource
    /// policy.
    pub fn getResourcePolicies(self: *Self, allocator: std.mem.Allocator, input: get_resource_policies.GetResourcePoliciesInput, options: get_resource_policies.Options) !get_resource_policies.GetResourcePoliciesOutput {
        return get_resource_policies.execute(self, allocator, input, options);
    }

    /// Retrieves a specified resource policy.
    pub fn getResourcePolicy(self: *Self, allocator: std.mem.Allocator, input: get_resource_policy.GetResourcePolicyInput, options: get_resource_policy.Options) !get_resource_policy.GetResourcePolicyOutput {
        return get_resource_policy.execute(self, allocator, input, options);
    }

    /// Describes the specified schema in detail.
    pub fn getSchema(self: *Self, allocator: std.mem.Allocator, input: get_schema.GetSchemaInput, options: get_schema.Options) !get_schema.GetSchemaOutput {
        return get_schema.execute(self, allocator, input, options);
    }

    /// Retrieves a schema by the `SchemaDefinition`. The schema definition is sent
    /// to the Schema Registry, canonicalized, and hashed. If the hash is matched
    /// within the scope of the `SchemaName` or ARN (or the default registry, if
    /// none is supplied), that schema’s metadata is returned. Otherwise, a 404 or
    /// NotFound error is returned. Schema versions in `Deleted` statuses will not
    /// be included in the results.
    pub fn getSchemaByDefinition(self: *Self, allocator: std.mem.Allocator, input: get_schema_by_definition.GetSchemaByDefinitionInput, options: get_schema_by_definition.Options) !get_schema_by_definition.GetSchemaByDefinitionOutput {
        return get_schema_by_definition.execute(self, allocator, input, options);
    }

    /// Get the specified schema by its unique ID assigned when a version of the
    /// schema is created or registered. Schema versions in Deleted status will not
    /// be included in the results.
    pub fn getSchemaVersion(self: *Self, allocator: std.mem.Allocator, input: get_schema_version.GetSchemaVersionInput, options: get_schema_version.Options) !get_schema_version.GetSchemaVersionOutput {
        return get_schema_version.execute(self, allocator, input, options);
    }

    /// Fetches the schema version difference in the specified difference type
    /// between two stored schema versions in the Schema Registry.
    ///
    /// This API allows you to compare two schema versions between two schema
    /// definitions under the same schema.
    pub fn getSchemaVersionsDiff(self: *Self, allocator: std.mem.Allocator, input: get_schema_versions_diff.GetSchemaVersionsDiffInput, options: get_schema_versions_diff.Options) !get_schema_versions_diff.GetSchemaVersionsDiffOutput {
        return get_schema_versions_diff.execute(self, allocator, input, options);
    }

    /// Retrieves a specified security configuration.
    pub fn getSecurityConfiguration(self: *Self, allocator: std.mem.Allocator, input: get_security_configuration.GetSecurityConfigurationInput, options: get_security_configuration.Options) !get_security_configuration.GetSecurityConfigurationOutput {
        return get_security_configuration.execute(self, allocator, input, options);
    }

    /// Retrieves a list of all security configurations.
    pub fn getSecurityConfigurations(self: *Self, allocator: std.mem.Allocator, input: get_security_configurations.GetSecurityConfigurationsInput, options: get_security_configurations.Options) !get_security_configurations.GetSecurityConfigurationsOutput {
        return get_security_configurations.execute(self, allocator, input, options);
    }

    /// Retrieves the session.
    pub fn getSession(self: *Self, allocator: std.mem.Allocator, input: get_session.GetSessionInput, options: get_session.Options) !get_session.GetSessionOutput {
        return get_session.execute(self, allocator, input, options);
    }

    /// Retrieves the statement.
    pub fn getStatement(self: *Self, allocator: std.mem.Allocator, input: get_statement.GetStatementInput, options: get_statement.Options) !get_statement.GetStatementOutput {
        return get_statement.execute(self, allocator, input, options);
    }

    /// Retrieves the `Table` definition in a Data Catalog for
    /// a specified table.
    pub fn getTable(self: *Self, allocator: std.mem.Allocator, input: get_table.GetTableInput, options: get_table.Options) !get_table.GetTableOutput {
        return get_table.execute(self, allocator, input, options);
    }

    /// Returns the configuration of all optimizers associated with a specified
    /// table.
    pub fn getTableOptimizer(self: *Self, allocator: std.mem.Allocator, input: get_table_optimizer.GetTableOptimizerInput, options: get_table_optimizer.Options) !get_table_optimizer.GetTableOptimizerOutput {
        return get_table_optimizer.execute(self, allocator, input, options);
    }

    /// Retrieves a specified version of a table.
    pub fn getTableVersion(self: *Self, allocator: std.mem.Allocator, input: get_table_version.GetTableVersionInput, options: get_table_version.Options) !get_table_version.GetTableVersionOutput {
        return get_table_version.execute(self, allocator, input, options);
    }

    /// Retrieves a list of strings that identify available versions of
    /// a specified table.
    pub fn getTableVersions(self: *Self, allocator: std.mem.Allocator, input: get_table_versions.GetTableVersionsInput, options: get_table_versions.Options) !get_table_versions.GetTableVersionsOutput {
        return get_table_versions.execute(self, allocator, input, options);
    }

    /// Retrieves the definitions of some or all of the tables in a given
    /// `Database`.
    pub fn getTables(self: *Self, allocator: std.mem.Allocator, input: get_tables.GetTablesInput, options: get_tables.Options) !get_tables.GetTablesOutput {
        return get_tables.execute(self, allocator, input, options);
    }

    /// Retrieves a list of tags associated with a resource.
    pub fn getTags(self: *Self, allocator: std.mem.Allocator, input: get_tags.GetTagsInput, options: get_tags.Options) !get_tags.GetTagsOutput {
        return get_tags.execute(self, allocator, input, options);
    }

    /// Retrieves the definition of a trigger.
    pub fn getTrigger(self: *Self, allocator: std.mem.Allocator, input: get_trigger.GetTriggerInput, options: get_trigger.Options) !get_trigger.GetTriggerOutput {
        return get_trigger.execute(self, allocator, input, options);
    }

    /// Gets all the triggers associated with a job.
    pub fn getTriggers(self: *Self, allocator: std.mem.Allocator, input: get_triggers.GetTriggersInput, options: get_triggers.Options) !get_triggers.GetTriggersOutput {
        return get_triggers.execute(self, allocator, input, options);
    }

    /// Retrieves partition metadata from the Data Catalog that contains unfiltered
    /// metadata.
    ///
    /// For IAM authorization, the public IAM action associated with this API is
    /// `glue:GetPartition`.
    pub fn getUnfilteredPartitionMetadata(self: *Self, allocator: std.mem.Allocator, input: get_unfiltered_partition_metadata.GetUnfilteredPartitionMetadataInput, options: get_unfiltered_partition_metadata.Options) !get_unfiltered_partition_metadata.GetUnfilteredPartitionMetadataOutput {
        return get_unfiltered_partition_metadata.execute(self, allocator, input, options);
    }

    /// Retrieves partition metadata from the Data Catalog that contains unfiltered
    /// metadata.
    ///
    /// For IAM authorization, the public IAM action associated with this API is
    /// `glue:GetPartitions`.
    pub fn getUnfilteredPartitionsMetadata(self: *Self, allocator: std.mem.Allocator, input: get_unfiltered_partitions_metadata.GetUnfilteredPartitionsMetadataInput, options: get_unfiltered_partitions_metadata.Options) !get_unfiltered_partitions_metadata.GetUnfilteredPartitionsMetadataOutput {
        return get_unfiltered_partitions_metadata.execute(self, allocator, input, options);
    }

    /// Allows a third-party analytical engine to retrieve unfiltered table metadata
    /// from the Data Catalog.
    ///
    /// For IAM authorization, the public IAM action associated with this API is
    /// `glue:GetTable`.
    pub fn getUnfilteredTableMetadata(self: *Self, allocator: std.mem.Allocator, input: get_unfiltered_table_metadata.GetUnfilteredTableMetadataInput, options: get_unfiltered_table_metadata.Options) !get_unfiltered_table_metadata.GetUnfilteredTableMetadataOutput {
        return get_unfiltered_table_metadata.execute(self, allocator, input, options);
    }

    /// Retrieves information about the specified Glue usage profile.
    pub fn getUsageProfile(self: *Self, allocator: std.mem.Allocator, input: get_usage_profile.GetUsageProfileInput, options: get_usage_profile.Options) !get_usage_profile.GetUsageProfileOutput {
        return get_usage_profile.execute(self, allocator, input, options);
    }

    /// Retrieves a specified function definition from the Data Catalog.
    pub fn getUserDefinedFunction(self: *Self, allocator: std.mem.Allocator, input: get_user_defined_function.GetUserDefinedFunctionInput, options: get_user_defined_function.Options) !get_user_defined_function.GetUserDefinedFunctionOutput {
        return get_user_defined_function.execute(self, allocator, input, options);
    }

    /// Retrieves multiple function definitions from the Data Catalog.
    pub fn getUserDefinedFunctions(self: *Self, allocator: std.mem.Allocator, input: get_user_defined_functions.GetUserDefinedFunctionsInput, options: get_user_defined_functions.Options) !get_user_defined_functions.GetUserDefinedFunctionsOutput {
        return get_user_defined_functions.execute(self, allocator, input, options);
    }

    /// Retrieves resource metadata for a workflow.
    pub fn getWorkflow(self: *Self, allocator: std.mem.Allocator, input: get_workflow.GetWorkflowInput, options: get_workflow.Options) !get_workflow.GetWorkflowOutput {
        return get_workflow.execute(self, allocator, input, options);
    }

    /// Retrieves the metadata for a given workflow run. Job run history is
    /// accessible for 90 days for your workflow and job run.
    pub fn getWorkflowRun(self: *Self, allocator: std.mem.Allocator, input: get_workflow_run.GetWorkflowRunInput, options: get_workflow_run.Options) !get_workflow_run.GetWorkflowRunOutput {
        return get_workflow_run.execute(self, allocator, input, options);
    }

    /// Retrieves the workflow run properties which were set during the run.
    pub fn getWorkflowRunProperties(self: *Self, allocator: std.mem.Allocator, input: get_workflow_run_properties.GetWorkflowRunPropertiesInput, options: get_workflow_run_properties.Options) !get_workflow_run_properties.GetWorkflowRunPropertiesOutput {
        return get_workflow_run_properties.execute(self, allocator, input, options);
    }

    /// Retrieves metadata for all runs of a given workflow.
    pub fn getWorkflowRuns(self: *Self, allocator: std.mem.Allocator, input: get_workflow_runs.GetWorkflowRunsInput, options: get_workflow_runs.Options) !get_workflow_runs.GetWorkflowRunsOutput {
        return get_workflow_runs.execute(self, allocator, input, options);
    }

    /// Imports an existing Amazon Athena Data Catalog to Glue.
    pub fn importCatalogToGlue(self: *Self, allocator: std.mem.Allocator, input: import_catalog_to_glue.ImportCatalogToGlueInput, options: import_catalog_to_glue.Options) !import_catalog_to_glue.ImportCatalogToGlueOutput {
        return import_catalog_to_glue.execute(self, allocator, input, options);
    }

    /// Lists all the blueprint names in an account.
    pub fn listBlueprints(self: *Self, allocator: std.mem.Allocator, input: list_blueprints.ListBlueprintsInput, options: list_blueprints.Options) !list_blueprints.ListBlueprintsOutput {
        return list_blueprints.execute(self, allocator, input, options);
    }

    /// List all task runs for a particular account.
    pub fn listColumnStatisticsTaskRuns(self: *Self, allocator: std.mem.Allocator, input: list_column_statistics_task_runs.ListColumnStatisticsTaskRunsInput, options: list_column_statistics_task_runs.Options) !list_column_statistics_task_runs.ListColumnStatisticsTaskRunsOutput {
        return list_column_statistics_task_runs.execute(self, allocator, input, options);
    }

    /// The `ListConnectionTypes` API provides a discovery mechanism to learn
    /// available connection types in Glue. The response contains a list of
    /// connection types with high-level details of what is supported for each
    /// connection type, including both built-in connection types and custom
    /// connection types registered via `RegisterConnectionType`. The connection
    /// types listed are the set of supported options for the `ConnectionType` value
    /// in the `CreateConnection` API.
    ///
    /// See also: `DescribeConnectionType`, `RegisterConnectionType`,
    /// `DeleteConnectionType`
    pub fn listConnectionTypes(self: *Self, allocator: std.mem.Allocator, input: list_connection_types.ListConnectionTypesInput, options: list_connection_types.Options) !list_connection_types.ListConnectionTypesOutput {
        return list_connection_types.execute(self, allocator, input, options);
    }

    /// Retrieves the names of all crawler resources in this Amazon Web Services
    /// account, or the
    /// resources with the specified tag. This operation allows you to see which
    /// resources are available in your account, and their names.
    ///
    /// This operation takes the optional `Tags` field, which you can use as a
    /// filter on
    /// the response so that tagged resources can be retrieved as a group. If you
    /// choose to use tags
    /// filtering, only resources with the tag are retrieved.
    pub fn listCrawlers(self: *Self, allocator: std.mem.Allocator, input: list_crawlers.ListCrawlersInput, options: list_crawlers.Options) !list_crawlers.ListCrawlersOutput {
        return list_crawlers.execute(self, allocator, input, options);
    }

    /// Returns all the crawls of a specified crawler. Returns only the crawls that
    /// have occurred since the launch date of the crawler history feature, and only
    /// retains up to 12 months of crawls. Older crawls will not be returned.
    ///
    /// You may use this API to:
    ///
    /// * Retrive all the crawls of a specified crawler.
    ///
    /// * Retrieve all the crawls of a specified crawler within a limited count.
    ///
    /// * Retrieve all the crawls of a specified crawler in a specific time range.
    ///
    /// * Retrieve all the crawls of a specified crawler with a particular state,
    ///   crawl ID, or DPU hour value.
    pub fn listCrawls(self: *Self, allocator: std.mem.Allocator, input: list_crawls.ListCrawlsInput, options: list_crawls.Options) !list_crawls.ListCrawlsOutput {
        return list_crawls.execute(self, allocator, input, options);
    }

    /// Lists all the custom patterns that have been created.
    pub fn listCustomEntityTypes(self: *Self, allocator: std.mem.Allocator, input: list_custom_entity_types.ListCustomEntityTypesInput, options: list_custom_entity_types.Options) !list_custom_entity_types.ListCustomEntityTypesOutput {
        return list_custom_entity_types.execute(self, allocator, input, options);
    }

    /// Returns all data quality execution results for your account.
    pub fn listDataQualityResults(self: *Self, allocator: std.mem.Allocator, input: list_data_quality_results.ListDataQualityResultsInput, options: list_data_quality_results.Options) !list_data_quality_results.ListDataQualityResultsOutput {
        return list_data_quality_results.execute(self, allocator, input, options);
    }

    /// Lists the recommendation runs meeting the filter criteria.
    pub fn listDataQualityRuleRecommendationRuns(self: *Self, allocator: std.mem.Allocator, input: list_data_quality_rule_recommendation_runs.ListDataQualityRuleRecommendationRunsInput, options: list_data_quality_rule_recommendation_runs.Options) !list_data_quality_rule_recommendation_runs.ListDataQualityRuleRecommendationRunsOutput {
        return list_data_quality_rule_recommendation_runs.execute(self, allocator, input, options);
    }

    /// Lists all the runs meeting the filter criteria, where a ruleset is evaluated
    /// against a data source.
    pub fn listDataQualityRulesetEvaluationRuns(self: *Self, allocator: std.mem.Allocator, input: list_data_quality_ruleset_evaluation_runs.ListDataQualityRulesetEvaluationRunsInput, options: list_data_quality_ruleset_evaluation_runs.Options) !list_data_quality_ruleset_evaluation_runs.ListDataQualityRulesetEvaluationRunsOutput {
        return list_data_quality_ruleset_evaluation_runs.execute(self, allocator, input, options);
    }

    /// Returns a paginated list of rulesets for the specified list of Glue tables.
    pub fn listDataQualityRulesets(self: *Self, allocator: std.mem.Allocator, input: list_data_quality_rulesets.ListDataQualityRulesetsInput, options: list_data_quality_rulesets.Options) !list_data_quality_rulesets.ListDataQualityRulesetsOutput {
        return list_data_quality_rulesets.execute(self, allocator, input, options);
    }

    /// Retrieve annotations for a data quality statistic.
    pub fn listDataQualityStatisticAnnotations(self: *Self, allocator: std.mem.Allocator, input: list_data_quality_statistic_annotations.ListDataQualityStatisticAnnotationsInput, options: list_data_quality_statistic_annotations.Options) !list_data_quality_statistic_annotations.ListDataQualityStatisticAnnotationsOutput {
        return list_data_quality_statistic_annotations.execute(self, allocator, input, options);
    }

    /// Retrieves a list of data quality statistics.
    pub fn listDataQualityStatistics(self: *Self, allocator: std.mem.Allocator, input: list_data_quality_statistics.ListDataQualityStatisticsInput, options: list_data_quality_statistics.Options) !list_data_quality_statistics.ListDataQualityStatisticsOutput {
        return list_data_quality_statistics.execute(self, allocator, input, options);
    }

    /// Retrieves the names of all `DevEndpoint` resources in this Amazon Web
    /// Services account, or the
    /// resources with the specified tag. This operation allows you to see which
    /// resources are
    /// available in your account, and their names.
    ///
    /// This operation takes the optional `Tags` field, which you can use as a
    /// filter on
    /// the response so that tagged resources can be retrieved as a group. If you
    /// choose to use tags
    /// filtering, only resources with the tag are retrieved.
    pub fn listDevEndpoints(self: *Self, allocator: std.mem.Allocator, input: list_dev_endpoints.ListDevEndpointsInput, options: list_dev_endpoints.Options) !list_dev_endpoints.ListDevEndpointsOutput {
        return list_dev_endpoints.execute(self, allocator, input, options);
    }

    /// Returns the available entities supported by the connection type.
    pub fn listEntities(self: *Self, allocator: std.mem.Allocator, input: list_entities.ListEntitiesInput, options: list_entities.Options) !list_entities.ListEntitiesOutput {
        return list_entities.execute(self, allocator, input, options);
    }

    /// List integration resource properties for a single customer. It supports the
    /// filters, maxRecords and markers.
    pub fn listIntegrationResourceProperties(self: *Self, allocator: std.mem.Allocator, input: list_integration_resource_properties.ListIntegrationResourcePropertiesInput, options: list_integration_resource_properties.Options) !list_integration_resource_properties.ListIntegrationResourcePropertiesOutput {
        return list_integration_resource_properties.execute(self, allocator, input, options);
    }

    /// Retrieves the names of all job resources in this Amazon Web Services
    /// account, or the resources with the specified tag. This operation allows you
    /// to see which resources are available in your account, and their names.
    ///
    /// This operation takes the optional `Tags` field, which you can use as a
    /// filter on
    /// the response so that tagged resources can be retrieved as a group. If you
    /// choose to use tags
    /// filtering, only resources with the tag are retrieved.
    pub fn listJobs(self: *Self, allocator: std.mem.Allocator, input: list_jobs.ListJobsInput, options: list_jobs.Options) !list_jobs.ListJobsOutput {
        return list_jobs.execute(self, allocator, input, options);
    }

    /// List all task runs for a particular account.
    pub fn listMaterializedViewRefreshTaskRuns(self: *Self, allocator: std.mem.Allocator, input: list_materialized_view_refresh_task_runs.ListMaterializedViewRefreshTaskRunsInput, options: list_materialized_view_refresh_task_runs.Options) !list_materialized_view_refresh_task_runs.ListMaterializedViewRefreshTaskRunsOutput {
        return list_materialized_view_refresh_task_runs.execute(self, allocator, input, options);
    }

    /// Retrieves a sortable, filterable list of existing Glue machine learning
    /// transforms in this Amazon Web Services account,
    /// or the resources with the specified tag. This operation takes the optional
    /// `Tags` field, which you can use as
    /// a filter of the responses so that tagged resources can be retrieved as a
    /// group. If you choose to use tag
    /// filtering, only resources with the tags are retrieved.
    pub fn listMlTransforms(self: *Self, allocator: std.mem.Allocator, input: list_ml_transforms.ListMLTransformsInput, options: list_ml_transforms.Options) !list_ml_transforms.ListMLTransformsOutput {
        return list_ml_transforms.execute(self, allocator, input, options);
    }

    /// Returns a list of registries that you have created, with minimal registry
    /// information. Registries in the `Deleting` status will not be included in the
    /// results. Empty results will be returned if there are no registries
    /// available.
    pub fn listRegistries(self: *Self, allocator: std.mem.Allocator, input: list_registries.ListRegistriesInput, options: list_registries.Options) !list_registries.ListRegistriesOutput {
        return list_registries.execute(self, allocator, input, options);
    }

    /// Returns a list of schema versions that you have created, with minimal
    /// information. Schema versions in Deleted status will not be included in the
    /// results. Empty results will be returned if there are no schema versions
    /// available.
    pub fn listSchemaVersions(self: *Self, allocator: std.mem.Allocator, input: list_schema_versions.ListSchemaVersionsInput, options: list_schema_versions.Options) !list_schema_versions.ListSchemaVersionsOutput {
        return list_schema_versions.execute(self, allocator, input, options);
    }

    /// Returns a list of schemas with minimal details. Schemas in Deleting status
    /// will not be included in the results. Empty results will be returned if there
    /// are no schemas available.
    ///
    /// When the `RegistryId` is not provided, all the schemas across registries
    /// will be part of the API response.
    pub fn listSchemas(self: *Self, allocator: std.mem.Allocator, input: list_schemas.ListSchemasInput, options: list_schemas.Options) !list_schemas.ListSchemasOutput {
        return list_schemas.execute(self, allocator, input, options);
    }

    /// Retrieve a list of sessions.
    pub fn listSessions(self: *Self, allocator: std.mem.Allocator, input: list_sessions.ListSessionsInput, options: list_sessions.Options) !list_sessions.ListSessionsOutput {
        return list_sessions.execute(self, allocator, input, options);
    }

    /// Lists statements for the session.
    pub fn listStatements(self: *Self, allocator: std.mem.Allocator, input: list_statements.ListStatementsInput, options: list_statements.Options) !list_statements.ListStatementsOutput {
        return list_statements.execute(self, allocator, input, options);
    }

    /// Lists the history of previous optimizer runs for a specific table.
    pub fn listTableOptimizerRuns(self: *Self, allocator: std.mem.Allocator, input: list_table_optimizer_runs.ListTableOptimizerRunsInput, options: list_table_optimizer_runs.Options) !list_table_optimizer_runs.ListTableOptimizerRunsOutput {
        return list_table_optimizer_runs.execute(self, allocator, input, options);
    }

    /// Retrieves the names of all trigger resources in this Amazon Web Services
    /// account, or the resources with the specified tag. This operation allows you
    /// to see which resources are available in your account, and their names.
    ///
    /// This operation takes the optional `Tags` field, which you can use as a
    /// filter on
    /// the response so that tagged resources can be retrieved as a group. If you
    /// choose to use tags
    /// filtering, only resources with the tag are retrieved.
    pub fn listTriggers(self: *Self, allocator: std.mem.Allocator, input: list_triggers.ListTriggersInput, options: list_triggers.Options) !list_triggers.ListTriggersOutput {
        return list_triggers.execute(self, allocator, input, options);
    }

    /// List all the Glue usage profiles.
    pub fn listUsageProfiles(self: *Self, allocator: std.mem.Allocator, input: list_usage_profiles.ListUsageProfilesInput, options: list_usage_profiles.Options) !list_usage_profiles.ListUsageProfilesOutput {
        return list_usage_profiles.execute(self, allocator, input, options);
    }

    /// Lists names of workflows created in the account.
    pub fn listWorkflows(self: *Self, allocator: std.mem.Allocator, input: list_workflows.ListWorkflowsInput, options: list_workflows.Options) !list_workflows.ListWorkflowsOutput {
        return list_workflows.execute(self, allocator, input, options);
    }

    /// Modifies a Zero-ETL integration in the caller's account.
    pub fn modifyIntegration(self: *Self, allocator: std.mem.Allocator, input: modify_integration.ModifyIntegrationInput, options: modify_integration.Options) !modify_integration.ModifyIntegrationOutput {
        return modify_integration.execute(self, allocator, input, options);
    }

    /// Sets the security configuration for a specified catalog. After the
    /// configuration has been
    /// set, the specified encryption is applied to every catalog write thereafter.
    pub fn putDataCatalogEncryptionSettings(self: *Self, allocator: std.mem.Allocator, input: put_data_catalog_encryption_settings.PutDataCatalogEncryptionSettingsInput, options: put_data_catalog_encryption_settings.Options) !put_data_catalog_encryption_settings.PutDataCatalogEncryptionSettingsOutput {
        return put_data_catalog_encryption_settings.execute(self, allocator, input, options);
    }

    /// Annotate all datapoints for a Profile.
    pub fn putDataQualityProfileAnnotation(self: *Self, allocator: std.mem.Allocator, input: put_data_quality_profile_annotation.PutDataQualityProfileAnnotationInput, options: put_data_quality_profile_annotation.Options) !put_data_quality_profile_annotation.PutDataQualityProfileAnnotationOutput {
        return put_data_quality_profile_annotation.execute(self, allocator, input, options);
    }

    /// Sets the Data Catalog resource policy for access control.
    pub fn putResourcePolicy(self: *Self, allocator: std.mem.Allocator, input: put_resource_policy.PutResourcePolicyInput, options: put_resource_policy.Options) !put_resource_policy.PutResourcePolicyOutput {
        return put_resource_policy.execute(self, allocator, input, options);
    }

    /// Puts the metadata key value pair for a specified schema version ID. A
    /// maximum of 10 key value pairs will be allowed per schema version. They can
    /// be added over one or more calls.
    pub fn putSchemaVersionMetadata(self: *Self, allocator: std.mem.Allocator, input: put_schema_version_metadata.PutSchemaVersionMetadataInput, options: put_schema_version_metadata.Options) !put_schema_version_metadata.PutSchemaVersionMetadataOutput {
        return put_schema_version_metadata.execute(self, allocator, input, options);
    }

    /// Puts the specified workflow run properties for the given workflow run. If a
    /// property already exists for the specified run, then it overrides the value
    /// otherwise adds the property to existing properties.
    pub fn putWorkflowRunProperties(self: *Self, allocator: std.mem.Allocator, input: put_workflow_run_properties.PutWorkflowRunPropertiesInput, options: put_workflow_run_properties.Options) !put_workflow_run_properties.PutWorkflowRunPropertiesOutput {
        return put_workflow_run_properties.execute(self, allocator, input, options);
    }

    /// Queries for the schema version metadata information.
    pub fn querySchemaVersionMetadata(self: *Self, allocator: std.mem.Allocator, input: query_schema_version_metadata.QuerySchemaVersionMetadataInput, options: query_schema_version_metadata.Options) !query_schema_version_metadata.QuerySchemaVersionMetadataOutput {
        return query_schema_version_metadata.execute(self, allocator, input, options);
    }

    /// Registers a custom connection type in Glue based on the configuration
    /// provided. This operation enables customers to configure custom connectors
    /// for any data source with REST-based APIs, eliminating the need for building
    /// custom Lambda connectors.
    ///
    /// The registered connection type stores details about how requests and
    /// responses are interpreted by REST sources, including connection properties,
    /// authentication configuration, and REST configuration with entity
    /// definitions. Once registered, customers can create connections using this
    /// connection type and work with them the same way as natively supported Glue
    /// connectors.
    ///
    /// Supports multiple authentication types including Basic, OAuth2 (Client
    /// Credentials, JWT Bearer, Authorization Code), and Custom Auth
    /// configurations.
    pub fn registerConnectionType(self: *Self, allocator: std.mem.Allocator, input: register_connection_type.RegisterConnectionTypeInput, options: register_connection_type.Options) !register_connection_type.RegisterConnectionTypeOutput {
        return register_connection_type.execute(self, allocator, input, options);
    }

    /// Adds a new version to the existing schema. Returns an error if new version
    /// of schema does not meet the compatibility requirements of the schema set.
    /// This API will not create a new schema set and will return a 404 error if the
    /// schema set is not already present in the Schema Registry.
    ///
    /// If this is the first schema definition to be registered in the Schema
    /// Registry, this API will store the schema version and return immediately.
    /// Otherwise, this call has the potential to run longer than other operations
    /// due to compatibility modes. You can call the `GetSchemaVersion` API with the
    /// `SchemaVersionId` to check compatibility modes.
    ///
    /// If the same schema definition is already stored in Schema Registry as a
    /// version, the schema ID of the existing schema is returned to the caller.
    pub fn registerSchemaVersion(self: *Self, allocator: std.mem.Allocator, input: register_schema_version.RegisterSchemaVersionInput, options: register_schema_version.Options) !register_schema_version.RegisterSchemaVersionOutput {
        return register_schema_version.execute(self, allocator, input, options);
    }

    /// Removes a key value pair from the schema version metadata for the specified
    /// schema version ID.
    pub fn removeSchemaVersionMetadata(self: *Self, allocator: std.mem.Allocator, input: remove_schema_version_metadata.RemoveSchemaVersionMetadataInput, options: remove_schema_version_metadata.Options) !remove_schema_version_metadata.RemoveSchemaVersionMetadataOutput {
        return remove_schema_version_metadata.execute(self, allocator, input, options);
    }

    /// Resets a bookmark entry.
    ///
    /// For more information about enabling and using job bookmarks, see:
    ///
    /// * [Tracking processed data using job
    ///   bookmarks](https://docs.aws.amazon.com/glue/latest/dg/monitor-continuations.html)
    ///
    /// * [Job parameters used by
    ///   Glue](https://docs.aws.amazon.com/glue/latest/dg/aws-glue-programming-etl-glue-arguments.html)
    ///
    /// * [Job
    ///   structure](https://docs.aws.amazon.com/glue/latest/dg/aws-glue-api-jobs-job.html#aws-glue-api-jobs-job-Job)
    pub fn resetJobBookmark(self: *Self, allocator: std.mem.Allocator, input: reset_job_bookmark.ResetJobBookmarkInput, options: reset_job_bookmark.Options) !reset_job_bookmark.ResetJobBookmarkOutput {
        return reset_job_bookmark.execute(self, allocator, input, options);
    }

    /// Restarts selected nodes of a previous partially completed workflow run and
    /// resumes the workflow run. The selected nodes and all nodes that are
    /// downstream from the selected nodes are run.
    pub fn resumeWorkflowRun(self: *Self, allocator: std.mem.Allocator, input: resume_workflow_run.ResumeWorkflowRunInput, options: resume_workflow_run.Options) !resume_workflow_run.ResumeWorkflowRunOutput {
        return resume_workflow_run.execute(self, allocator, input, options);
    }

    /// Executes the statement.
    pub fn runStatement(self: *Self, allocator: std.mem.Allocator, input: run_statement.RunStatementInput, options: run_statement.Options) !run_statement.RunStatementOutput {
        return run_statement.execute(self, allocator, input, options);
    }

    /// Searches a set of tables based on properties in the table metadata as well
    /// as on the parent database. You can search against text or filter conditions.
    ///
    /// You can only get tables that you have access to based on the security
    /// policies defined in Lake Formation. You need at least a read-only access to
    /// the table for it to be returned. If you do not have access to all the
    /// columns in the table, these columns will not be searched against when
    /// returning the list of tables back to you. If you have access to the columns
    /// but not the data in the columns, those columns and the associated metadata
    /// for those columns will be included in the search.
    pub fn searchTables(self: *Self, allocator: std.mem.Allocator, input: search_tables.SearchTablesInput, options: search_tables.Options) !search_tables.SearchTablesOutput {
        return search_tables.execute(self, allocator, input, options);
    }

    /// Starts a new run of the specified blueprint.
    pub fn startBlueprintRun(self: *Self, allocator: std.mem.Allocator, input: start_blueprint_run.StartBlueprintRunInput, options: start_blueprint_run.Options) !start_blueprint_run.StartBlueprintRunOutput {
        return start_blueprint_run.execute(self, allocator, input, options);
    }

    /// Starts a column statistics task run, for a specified table and columns.
    pub fn startColumnStatisticsTaskRun(self: *Self, allocator: std.mem.Allocator, input: start_column_statistics_task_run.StartColumnStatisticsTaskRunInput, options: start_column_statistics_task_run.Options) !start_column_statistics_task_run.StartColumnStatisticsTaskRunOutput {
        return start_column_statistics_task_run.execute(self, allocator, input, options);
    }

    /// Starts a column statistics task run schedule.
    pub fn startColumnStatisticsTaskRunSchedule(self: *Self, allocator: std.mem.Allocator, input: start_column_statistics_task_run_schedule.StartColumnStatisticsTaskRunScheduleInput, options: start_column_statistics_task_run_schedule.Options) !start_column_statistics_task_run_schedule.StartColumnStatisticsTaskRunScheduleOutput {
        return start_column_statistics_task_run_schedule.execute(self, allocator, input, options);
    }

    /// Starts a crawl using the specified crawler, regardless
    /// of what is scheduled. If the crawler is already running, returns a
    /// [CrawlerRunningException](https://docs.aws.amazon.com/glue/latest/dg/aws-glue-api-exceptions.html#aws-glue-api-exceptions-CrawlerRunningException).
    pub fn startCrawler(self: *Self, allocator: std.mem.Allocator, input: start_crawler.StartCrawlerInput, options: start_crawler.Options) !start_crawler.StartCrawlerOutput {
        return start_crawler.execute(self, allocator, input, options);
    }

    /// Changes the schedule state of the specified crawler to
    /// `SCHEDULED`, unless the crawler is already running or the
    /// schedule state is already `SCHEDULED`.
    pub fn startCrawlerSchedule(self: *Self, allocator: std.mem.Allocator, input: start_crawler_schedule.StartCrawlerScheduleInput, options: start_crawler_schedule.Options) !start_crawler_schedule.StartCrawlerScheduleOutput {
        return start_crawler_schedule.execute(self, allocator, input, options);
    }

    /// Starts a recommendation run that is used to generate rules when you don't
    /// know what rules to write. Glue Data Quality analyzes the data and comes up
    /// with recommendations for a potential ruleset. You can then triage the
    /// ruleset and modify the generated ruleset to your liking.
    ///
    /// Recommendation runs are automatically deleted after 90 days.
    pub fn startDataQualityRuleRecommendationRun(self: *Self, allocator: std.mem.Allocator, input: start_data_quality_rule_recommendation_run.StartDataQualityRuleRecommendationRunInput, options: start_data_quality_rule_recommendation_run.Options) !start_data_quality_rule_recommendation_run.StartDataQualityRuleRecommendationRunOutput {
        return start_data_quality_rule_recommendation_run.execute(self, allocator, input, options);
    }

    /// Once you have a ruleset definition (either recommended or your own), you
    /// call this operation to evaluate the ruleset against a data source (Glue
    /// table). The evaluation computes results which you can retrieve with the
    /// `GetDataQualityResult` API.
    pub fn startDataQualityRulesetEvaluationRun(self: *Self, allocator: std.mem.Allocator, input: start_data_quality_ruleset_evaluation_run.StartDataQualityRulesetEvaluationRunInput, options: start_data_quality_ruleset_evaluation_run.Options) !start_data_quality_ruleset_evaluation_run.StartDataQualityRulesetEvaluationRunOutput {
        return start_data_quality_ruleset_evaluation_run.execute(self, allocator, input, options);
    }

    /// Begins an asynchronous task to export all labeled data for a particular
    /// transform. This
    /// task is the only label-related API call that is not part of the typical
    /// active learning
    /// workflow. You typically use `StartExportLabelsTaskRun` when you want to work
    /// with
    /// all of your existing labels at the same time, such as when you want to
    /// remove or change labels
    /// that were previously submitted as truth. This API operation accepts the
    /// `TransformId` whose labels you want to export and an Amazon Simple Storage
    /// Service (Amazon S3) path to export the labels to. The operation returns a
    /// `TaskRunId`. You can check on the status of your task run by calling the
    /// `GetMLTaskRun` API.
    pub fn startExportLabelsTaskRun(self: *Self, allocator: std.mem.Allocator, input: start_export_labels_task_run.StartExportLabelsTaskRunInput, options: start_export_labels_task_run.Options) !start_export_labels_task_run.StartExportLabelsTaskRunOutput {
        return start_export_labels_task_run.execute(self, allocator, input, options);
    }

    /// Enables you to provide additional labels (examples of truth) to be used to
    /// teach the
    /// machine learning transform and improve its quality. This API operation is
    /// generally used as
    /// part of the active learning workflow that starts with the
    /// `StartMLLabelingSetGenerationTaskRun` call and that ultimately results in
    /// improving the quality of your machine learning transform.
    ///
    /// After the `StartMLLabelingSetGenerationTaskRun` finishes, Glue machine
    /// learning
    /// will have generated a series of questions for humans to answer. (Answering
    /// these questions is
    /// often called 'labeling' in the machine learning workflows). In the case of
    /// the
    /// `FindMatches` transform, these questions are of the form, “What is the
    /// correct
    /// way to group these rows together into groups composed entirely of matching
    /// records?” After the
    /// labeling process is finished, users upload their answers/labels with a call
    /// to
    /// `StartImportLabelsTaskRun`. After `StartImportLabelsTaskRun` finishes,
    /// all future runs of the machine learning transform use the new and improved
    /// labels and perform
    /// a higher-quality transformation.
    ///
    /// By default, `StartMLLabelingSetGenerationTaskRun` continually learns from
    /// and
    /// combines all labels that you upload unless you set `Replace` to true. If you
    /// set
    /// `Replace` to true, `StartImportLabelsTaskRun` deletes and forgets all
    /// previously uploaded labels and learns only from the exact set that you
    /// upload. Replacing
    /// labels can be helpful if you realize that you previously uploaded incorrect
    /// labels, and you
    /// believe that they are having a negative effect on your transform quality.
    ///
    /// You can check on the status of your task run by calling the `GetMLTaskRun`
    /// operation.
    pub fn startImportLabelsTaskRun(self: *Self, allocator: std.mem.Allocator, input: start_import_labels_task_run.StartImportLabelsTaskRunInput, options: start_import_labels_task_run.Options) !start_import_labels_task_run.StartImportLabelsTaskRunOutput {
        return start_import_labels_task_run.execute(self, allocator, input, options);
    }

    /// Starts a job run using a job definition.
    pub fn startJobRun(self: *Self, allocator: std.mem.Allocator, input: start_job_run.StartJobRunInput, options: start_job_run.Options) !start_job_run.StartJobRunOutput {
        return start_job_run.execute(self, allocator, input, options);
    }

    /// Starts a materialized view refresh task run, for a specified table and
    /// columns.
    pub fn startMaterializedViewRefreshTaskRun(self: *Self, allocator: std.mem.Allocator, input: start_materialized_view_refresh_task_run.StartMaterializedViewRefreshTaskRunInput, options: start_materialized_view_refresh_task_run.Options) !start_materialized_view_refresh_task_run.StartMaterializedViewRefreshTaskRunOutput {
        return start_materialized_view_refresh_task_run.execute(self, allocator, input, options);
    }

    /// Starts a task to estimate the quality of the transform.
    ///
    /// When you provide label sets as examples of truth, Glue machine learning uses
    /// some of
    /// those examples to learn from them. The rest of the labels are used as a test
    /// to estimate
    /// quality.
    ///
    /// Returns a unique identifier for the run. You can call `GetMLTaskRun` to get
    /// more
    /// information about the stats of the `EvaluationTaskRun`.
    pub fn startMlEvaluationTaskRun(self: *Self, allocator: std.mem.Allocator, input: start_ml_evaluation_task_run.StartMLEvaluationTaskRunInput, options: start_ml_evaluation_task_run.Options) !start_ml_evaluation_task_run.StartMLEvaluationTaskRunOutput {
        return start_ml_evaluation_task_run.execute(self, allocator, input, options);
    }

    /// Starts the active learning workflow for your machine learning transform to
    /// improve the
    /// transform's quality by generating label sets and adding labels.
    ///
    /// When the `StartMLLabelingSetGenerationTaskRun` finishes, Glue will have
    /// generated a "labeling set" or a set of questions for humans to answer.
    ///
    /// In the case of the `FindMatches` transform, these questions are of the form,
    /// “What is the correct way to group these rows together into groups composed
    /// entirely of
    /// matching records?”
    ///
    /// After the labeling process is finished, you can upload your labels with a
    /// call to
    /// `StartImportLabelsTaskRun`. After `StartImportLabelsTaskRun` finishes,
    /// all future runs of the machine learning transform will use the new and
    /// improved labels and
    /// perform a higher-quality transformation.
    ///
    /// Note: The role used to write the generated labeling set to the
    /// `OutputS3Path` is the role
    /// associated with the Machine Learning Transform, specified in the
    /// `CreateMLTransform` API.
    pub fn startMlLabelingSetGenerationTaskRun(self: *Self, allocator: std.mem.Allocator, input: start_ml_labeling_set_generation_task_run.StartMLLabelingSetGenerationTaskRunInput, options: start_ml_labeling_set_generation_task_run.Options) !start_ml_labeling_set_generation_task_run.StartMLLabelingSetGenerationTaskRunOutput {
        return start_ml_labeling_set_generation_task_run.execute(self, allocator, input, options);
    }

    /// Starts an existing trigger. See [Triggering
    /// Jobs](https://docs.aws.amazon.com/glue/latest/dg/trigger-job.html) for
    /// information about how different types of trigger are
    /// started.
    pub fn startTrigger(self: *Self, allocator: std.mem.Allocator, input: start_trigger.StartTriggerInput, options: start_trigger.Options) !start_trigger.StartTriggerOutput {
        return start_trigger.execute(self, allocator, input, options);
    }

    /// Starts a new run of the specified workflow.
    pub fn startWorkflowRun(self: *Self, allocator: std.mem.Allocator, input: start_workflow_run.StartWorkflowRunInput, options: start_workflow_run.Options) !start_workflow_run.StartWorkflowRunOutput {
        return start_workflow_run.execute(self, allocator, input, options);
    }

    /// Stops a task run for the specified table.
    pub fn stopColumnStatisticsTaskRun(self: *Self, allocator: std.mem.Allocator, input: stop_column_statistics_task_run.StopColumnStatisticsTaskRunInput, options: stop_column_statistics_task_run.Options) !stop_column_statistics_task_run.StopColumnStatisticsTaskRunOutput {
        return stop_column_statistics_task_run.execute(self, allocator, input, options);
    }

    /// Stops a column statistics task run schedule.
    pub fn stopColumnStatisticsTaskRunSchedule(self: *Self, allocator: std.mem.Allocator, input: stop_column_statistics_task_run_schedule.StopColumnStatisticsTaskRunScheduleInput, options: stop_column_statistics_task_run_schedule.Options) !stop_column_statistics_task_run_schedule.StopColumnStatisticsTaskRunScheduleOutput {
        return stop_column_statistics_task_run_schedule.execute(self, allocator, input, options);
    }

    /// If the specified crawler is running, stops the crawl.
    pub fn stopCrawler(self: *Self, allocator: std.mem.Allocator, input: stop_crawler.StopCrawlerInput, options: stop_crawler.Options) !stop_crawler.StopCrawlerOutput {
        return stop_crawler.execute(self, allocator, input, options);
    }

    /// Sets the schedule state of the specified crawler to
    /// `NOT_SCHEDULED`, but does not stop the crawler if it is
    /// already running.
    pub fn stopCrawlerSchedule(self: *Self, allocator: std.mem.Allocator, input: stop_crawler_schedule.StopCrawlerScheduleInput, options: stop_crawler_schedule.Options) !stop_crawler_schedule.StopCrawlerScheduleOutput {
        return stop_crawler_schedule.execute(self, allocator, input, options);
    }

    /// Stops a materialized view refresh task run, for a specified table and
    /// columns.
    pub fn stopMaterializedViewRefreshTaskRun(self: *Self, allocator: std.mem.Allocator, input: stop_materialized_view_refresh_task_run.StopMaterializedViewRefreshTaskRunInput, options: stop_materialized_view_refresh_task_run.Options) !stop_materialized_view_refresh_task_run.StopMaterializedViewRefreshTaskRunOutput {
        return stop_materialized_view_refresh_task_run.execute(self, allocator, input, options);
    }

    /// Stops the session.
    pub fn stopSession(self: *Self, allocator: std.mem.Allocator, input: stop_session.StopSessionInput, options: stop_session.Options) !stop_session.StopSessionOutput {
        return stop_session.execute(self, allocator, input, options);
    }

    /// Stops a specified trigger.
    pub fn stopTrigger(self: *Self, allocator: std.mem.Allocator, input: stop_trigger.StopTriggerInput, options: stop_trigger.Options) !stop_trigger.StopTriggerOutput {
        return stop_trigger.execute(self, allocator, input, options);
    }

    /// Stops the execution of the specified workflow run.
    pub fn stopWorkflowRun(self: *Self, allocator: std.mem.Allocator, input: stop_workflow_run.StopWorkflowRunInput, options: stop_workflow_run.Options) !stop_workflow_run.StopWorkflowRunOutput {
        return stop_workflow_run.execute(self, allocator, input, options);
    }

    /// Adds tags to a resource. A tag is a label you can assign to an Amazon Web
    /// Services resource.
    /// In Glue, you can tag only certain resources. For information about what
    /// resources you can tag, see [Amazon Web Services Tags in
    /// Glue](https://docs.aws.amazon.com/glue/latest/dg/monitor-tags.html).
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: tag_resource.Options) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Tests a connection to a service to validate the service credentials that you
    /// provide.
    ///
    /// You can either provide an existing connection name or a
    /// `TestConnectionInput` for testing a non-existing connection input. Providing
    /// both at the same time will cause an error.
    ///
    /// If the action is successful, the service sends back an HTTP 200 response.
    pub fn testConnection(self: *Self, allocator: std.mem.Allocator, input: test_connection.TestConnectionInput, options: test_connection.Options) !test_connection.TestConnectionOutput {
        return test_connection.execute(self, allocator, input, options);
    }

    /// Removes tags from a resource.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: untag_resource.Options) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Updates a registered blueprint.
    pub fn updateBlueprint(self: *Self, allocator: std.mem.Allocator, input: update_blueprint.UpdateBlueprintInput, options: update_blueprint.Options) !update_blueprint.UpdateBlueprintOutput {
        return update_blueprint.execute(self, allocator, input, options);
    }

    /// Updates an existing catalog's properties in the Glue Data Catalog.
    pub fn updateCatalog(self: *Self, allocator: std.mem.Allocator, input: update_catalog.UpdateCatalogInput, options: update_catalog.Options) !update_catalog.UpdateCatalogOutput {
        return update_catalog.execute(self, allocator, input, options);
    }

    /// Modifies an existing classifier (a `GrokClassifier`,
    /// an `XMLClassifier`, a `JsonClassifier`, or a `CsvClassifier`, depending on
    /// which field is present).
    pub fn updateClassifier(self: *Self, allocator: std.mem.Allocator, input: update_classifier.UpdateClassifierInput, options: update_classifier.Options) !update_classifier.UpdateClassifierOutput {
        return update_classifier.execute(self, allocator, input, options);
    }

    /// Creates or updates partition statistics of columns.
    ///
    /// The Identity and Access Management (IAM) permission required for this
    /// operation is `UpdatePartition`.
    pub fn updateColumnStatisticsForPartition(self: *Self, allocator: std.mem.Allocator, input: update_column_statistics_for_partition.UpdateColumnStatisticsForPartitionInput, options: update_column_statistics_for_partition.Options) !update_column_statistics_for_partition.UpdateColumnStatisticsForPartitionOutput {
        return update_column_statistics_for_partition.execute(self, allocator, input, options);
    }

    /// Creates or updates table statistics of columns.
    ///
    /// The Identity and Access Management (IAM) permission required for this
    /// operation is `UpdateTable`.
    pub fn updateColumnStatisticsForTable(self: *Self, allocator: std.mem.Allocator, input: update_column_statistics_for_table.UpdateColumnStatisticsForTableInput, options: update_column_statistics_for_table.Options) !update_column_statistics_for_table.UpdateColumnStatisticsForTableOutput {
        return update_column_statistics_for_table.execute(self, allocator, input, options);
    }

    /// Updates settings for a column statistics task.
    pub fn updateColumnStatisticsTaskSettings(self: *Self, allocator: std.mem.Allocator, input: update_column_statistics_task_settings.UpdateColumnStatisticsTaskSettingsInput, options: update_column_statistics_task_settings.Options) !update_column_statistics_task_settings.UpdateColumnStatisticsTaskSettingsOutput {
        return update_column_statistics_task_settings.execute(self, allocator, input, options);
    }

    /// Updates a connection definition in the Data Catalog.
    pub fn updateConnection(self: *Self, allocator: std.mem.Allocator, input: update_connection.UpdateConnectionInput, options: update_connection.Options) !update_connection.UpdateConnectionOutput {
        return update_connection.execute(self, allocator, input, options);
    }

    /// Updates a crawler. If a crawler is
    /// running, you must stop it using `StopCrawler` before updating
    /// it.
    pub fn updateCrawler(self: *Self, allocator: std.mem.Allocator, input: update_crawler.UpdateCrawlerInput, options: update_crawler.Options) !update_crawler.UpdateCrawlerOutput {
        return update_crawler.execute(self, allocator, input, options);
    }

    /// Updates the schedule of a crawler using a `cron` expression.
    pub fn updateCrawlerSchedule(self: *Self, allocator: std.mem.Allocator, input: update_crawler_schedule.UpdateCrawlerScheduleInput, options: update_crawler_schedule.Options) !update_crawler_schedule.UpdateCrawlerScheduleOutput {
        return update_crawler_schedule.execute(self, allocator, input, options);
    }

    /// Updates the specified data quality ruleset.
    pub fn updateDataQualityRuleset(self: *Self, allocator: std.mem.Allocator, input: update_data_quality_ruleset.UpdateDataQualityRulesetInput, options: update_data_quality_ruleset.Options) !update_data_quality_ruleset.UpdateDataQualityRulesetOutput {
        return update_data_quality_ruleset.execute(self, allocator, input, options);
    }

    /// Updates an existing database definition in a Data Catalog.
    pub fn updateDatabase(self: *Self, allocator: std.mem.Allocator, input: update_database.UpdateDatabaseInput, options: update_database.Options) !update_database.UpdateDatabaseOutput {
        return update_database.execute(self, allocator, input, options);
    }

    /// Updates a specified development endpoint.
    pub fn updateDevEndpoint(self: *Self, allocator: std.mem.Allocator, input: update_dev_endpoint.UpdateDevEndpointInput, options: update_dev_endpoint.Options) !update_dev_endpoint.UpdateDevEndpointOutput {
        return update_dev_endpoint.execute(self, allocator, input, options);
    }

    /// Updates the existing Glue Identity Center configuration, allowing
    /// modification of scopes and permissions for the integration.
    pub fn updateGlueIdentityCenterConfiguration(self: *Self, allocator: std.mem.Allocator, input: update_glue_identity_center_configuration.UpdateGlueIdentityCenterConfigurationInput, options: update_glue_identity_center_configuration.Options) !update_glue_identity_center_configuration.UpdateGlueIdentityCenterConfigurationOutput {
        return update_glue_identity_center_configuration.execute(self, allocator, input, options);
    }

    /// This API can be used for updating the `ResourceProperty` of the Glue
    /// connection (for the source) or Glue database ARN (for the target). These
    /// properties can include the role to access the connection or database. Since
    /// the same resource can be used across multiple integrations, updating
    /// resource properties will impact all the integrations using it.
    pub fn updateIntegrationResourceProperty(self: *Self, allocator: std.mem.Allocator, input: update_integration_resource_property.UpdateIntegrationResourcePropertyInput, options: update_integration_resource_property.Options) !update_integration_resource_property.UpdateIntegrationResourcePropertyOutput {
        return update_integration_resource_property.execute(self, allocator, input, options);
    }

    /// This API is used to provide optional override properties for the tables that
    /// need to be replicated. These properties can include properties for filtering
    /// and partitioning for the source and target tables. To set both source and
    /// target properties the same API need to be invoked with the Glue connection
    /// ARN as `ResourceArn` with `SourceTableConfig`, and the Glue database ARN as
    /// `ResourceArn` with `TargetTableConfig` respectively.
    ///
    /// The override will be reflected across all the integrations using same
    /// `ResourceArn` and source table.
    pub fn updateIntegrationTableProperties(self: *Self, allocator: std.mem.Allocator, input: update_integration_table_properties.UpdateIntegrationTablePropertiesInput, options: update_integration_table_properties.Options) !update_integration_table_properties.UpdateIntegrationTablePropertiesOutput {
        return update_integration_table_properties.execute(self, allocator, input, options);
    }

    /// Updates an existing job definition. The previous job definition is
    /// completely overwritten by this information.
    pub fn updateJob(self: *Self, allocator: std.mem.Allocator, input: update_job.UpdateJobInput, options: update_job.Options) !update_job.UpdateJobOutput {
        return update_job.execute(self, allocator, input, options);
    }

    /// Synchronizes a job from the source control repository. This operation takes
    /// the job artifacts that are located in the remote repository and updates the
    /// Glue internal stores with these artifacts.
    ///
    /// This API supports optional parameters which take in the repository
    /// information.
    pub fn updateJobFromSourceControl(self: *Self, allocator: std.mem.Allocator, input: update_job_from_source_control.UpdateJobFromSourceControlInput, options: update_job_from_source_control.Options) !update_job_from_source_control.UpdateJobFromSourceControlOutput {
        return update_job_from_source_control.execute(self, allocator, input, options);
    }

    /// Updates an existing machine learning transform. Call this operation to tune
    /// the algorithm parameters to achieve better results.
    ///
    /// After calling this operation, you can call the `StartMLEvaluationTaskRun`
    /// operation to assess how well your new parameters achieved your goals (such
    /// as improving the
    /// quality of your machine learning transform, or making it more
    /// cost-effective).
    pub fn updateMlTransform(self: *Self, allocator: std.mem.Allocator, input: update_ml_transform.UpdateMLTransformInput, options: update_ml_transform.Options) !update_ml_transform.UpdateMLTransformOutput {
        return update_ml_transform.execute(self, allocator, input, options);
    }

    /// Updates a partition.
    pub fn updatePartition(self: *Self, allocator: std.mem.Allocator, input: update_partition.UpdatePartitionInput, options: update_partition.Options) !update_partition.UpdatePartitionOutput {
        return update_partition.execute(self, allocator, input, options);
    }

    /// Updates an existing registry which is used to hold a collection of schemas.
    /// The updated properties relate to the registry, and do not modify any of the
    /// schemas within the registry.
    pub fn updateRegistry(self: *Self, allocator: std.mem.Allocator, input: update_registry.UpdateRegistryInput, options: update_registry.Options) !update_registry.UpdateRegistryOutput {
        return update_registry.execute(self, allocator, input, options);
    }

    /// Updates the description, compatibility setting, or version checkpoint for a
    /// schema set.
    ///
    /// For updating the compatibility setting, the call will not validate
    /// compatibility for the entire set of schema versions with the new
    /// compatibility setting. If the value for `Compatibility` is provided, the
    /// `VersionNumber` (a checkpoint) is also required. The API will validate the
    /// checkpoint version number for consistency.
    ///
    /// If the value for the `VersionNumber` (checkpoint) is provided,
    /// `Compatibility` is optional and this can be used to set/reset a checkpoint
    /// for the schema.
    ///
    /// This update will happen only if the schema is in the AVAILABLE state.
    pub fn updateSchema(self: *Self, allocator: std.mem.Allocator, input: update_schema.UpdateSchemaInput, options: update_schema.Options) !update_schema.UpdateSchemaOutput {
        return update_schema.execute(self, allocator, input, options);
    }

    /// Synchronizes a job to the source control repository. This operation takes
    /// the job artifacts from the Glue internal stores and makes a commit to the
    /// remote repository that is configured on the job.
    ///
    /// This API supports optional parameters which take in the repository
    /// information.
    pub fn updateSourceControlFromJob(self: *Self, allocator: std.mem.Allocator, input: update_source_control_from_job.UpdateSourceControlFromJobInput, options: update_source_control_from_job.Options) !update_source_control_from_job.UpdateSourceControlFromJobOutput {
        return update_source_control_from_job.execute(self, allocator, input, options);
    }

    /// Updates a metadata table in the Data Catalog.
    pub fn updateTable(self: *Self, allocator: std.mem.Allocator, input: update_table.UpdateTableInput, options: update_table.Options) !update_table.UpdateTableOutput {
        return update_table.execute(self, allocator, input, options);
    }

    /// Updates the configuration for an existing table optimizer.
    pub fn updateTableOptimizer(self: *Self, allocator: std.mem.Allocator, input: update_table_optimizer.UpdateTableOptimizerInput, options: update_table_optimizer.Options) !update_table_optimizer.UpdateTableOptimizerOutput {
        return update_table_optimizer.execute(self, allocator, input, options);
    }

    /// Updates a trigger definition.
    ///
    /// Job arguments may be logged. Do not pass plaintext secrets as arguments.
    /// Retrieve secrets from a Glue Connection, Amazon Web Services Secrets Manager
    /// or other secret management mechanism if you intend to keep them within the
    /// Job.
    pub fn updateTrigger(self: *Self, allocator: std.mem.Allocator, input: update_trigger.UpdateTriggerInput, options: update_trigger.Options) !update_trigger.UpdateTriggerOutput {
        return update_trigger.execute(self, allocator, input, options);
    }

    /// Update an Glue usage profile.
    pub fn updateUsageProfile(self: *Self, allocator: std.mem.Allocator, input: update_usage_profile.UpdateUsageProfileInput, options: update_usage_profile.Options) !update_usage_profile.UpdateUsageProfileOutput {
        return update_usage_profile.execute(self, allocator, input, options);
    }

    /// Updates an existing function definition in the Data Catalog.
    pub fn updateUserDefinedFunction(self: *Self, allocator: std.mem.Allocator, input: update_user_defined_function.UpdateUserDefinedFunctionInput, options: update_user_defined_function.Options) !update_user_defined_function.UpdateUserDefinedFunctionOutput {
        return update_user_defined_function.execute(self, allocator, input, options);
    }

    /// Updates an existing workflow.
    pub fn updateWorkflow(self: *Self, allocator: std.mem.Allocator, input: update_workflow.UpdateWorkflowInput, options: update_workflow.Options) !update_workflow.UpdateWorkflowOutput {
        return update_workflow.execute(self, allocator, input, options);
    }

    pub fn describeEntityPaginator(self: *Self, params: describe_entity.DescribeEntityInput) paginator.DescribeEntityPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn getBlueprintRunsPaginator(self: *Self, params: get_blueprint_runs.GetBlueprintRunsInput) paginator.GetBlueprintRunsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn getClassifiersPaginator(self: *Self, params: get_classifiers.GetClassifiersInput) paginator.GetClassifiersPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn getColumnStatisticsTaskRunsPaginator(self: *Self, params: get_column_statistics_task_runs.GetColumnStatisticsTaskRunsInput) paginator.GetColumnStatisticsTaskRunsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn getConnectionsPaginator(self: *Self, params: get_connections.GetConnectionsInput) paginator.GetConnectionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn getCrawlerMetricsPaginator(self: *Self, params: get_crawler_metrics.GetCrawlerMetricsInput) paginator.GetCrawlerMetricsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn getCrawlersPaginator(self: *Self, params: get_crawlers.GetCrawlersInput) paginator.GetCrawlersPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn getDatabasesPaginator(self: *Self, params: get_databases.GetDatabasesInput) paginator.GetDatabasesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn getDevEndpointsPaginator(self: *Self, params: get_dev_endpoints.GetDevEndpointsInput) paginator.GetDevEndpointsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn getJobRunsPaginator(self: *Self, params: get_job_runs.GetJobRunsInput) paginator.GetJobRunsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn getJobsPaginator(self: *Self, params: get_jobs.GetJobsInput) paginator.GetJobsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn getMlTaskRunsPaginator(self: *Self, params: get_ml_task_runs.GetMLTaskRunsInput) paginator.GetMLTaskRunsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn getMlTransformsPaginator(self: *Self, params: get_ml_transforms.GetMLTransformsInput) paginator.GetMLTransformsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn getPartitionIndexesPaginator(self: *Self, params: get_partition_indexes.GetPartitionIndexesInput) paginator.GetPartitionIndexesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn getPartitionsPaginator(self: *Self, params: get_partitions.GetPartitionsInput) paginator.GetPartitionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn getResourcePoliciesPaginator(self: *Self, params: get_resource_policies.GetResourcePoliciesInput) paginator.GetResourcePoliciesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn getSecurityConfigurationsPaginator(self: *Self, params: get_security_configurations.GetSecurityConfigurationsInput) paginator.GetSecurityConfigurationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn getTableVersionsPaginator(self: *Self, params: get_table_versions.GetTableVersionsInput) paginator.GetTableVersionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn getTablesPaginator(self: *Self, params: get_tables.GetTablesInput) paginator.GetTablesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn getTriggersPaginator(self: *Self, params: get_triggers.GetTriggersInput) paginator.GetTriggersPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn getUnfilteredPartitionsMetadataPaginator(self: *Self, params: get_unfiltered_partitions_metadata.GetUnfilteredPartitionsMetadataInput) paginator.GetUnfilteredPartitionsMetadataPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn getUserDefinedFunctionsPaginator(self: *Self, params: get_user_defined_functions.GetUserDefinedFunctionsInput) paginator.GetUserDefinedFunctionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn getWorkflowRunsPaginator(self: *Self, params: get_workflow_runs.GetWorkflowRunsInput) paginator.GetWorkflowRunsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listBlueprintsPaginator(self: *Self, params: list_blueprints.ListBlueprintsInput) paginator.ListBlueprintsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listColumnStatisticsTaskRunsPaginator(self: *Self, params: list_column_statistics_task_runs.ListColumnStatisticsTaskRunsInput) paginator.ListColumnStatisticsTaskRunsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listConnectionTypesPaginator(self: *Self, params: list_connection_types.ListConnectionTypesInput) paginator.ListConnectionTypesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listCrawlersPaginator(self: *Self, params: list_crawlers.ListCrawlersInput) paginator.ListCrawlersPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listCustomEntityTypesPaginator(self: *Self, params: list_custom_entity_types.ListCustomEntityTypesInput) paginator.ListCustomEntityTypesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listDataQualityResultsPaginator(self: *Self, params: list_data_quality_results.ListDataQualityResultsInput) paginator.ListDataQualityResultsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listDataQualityRuleRecommendationRunsPaginator(self: *Self, params: list_data_quality_rule_recommendation_runs.ListDataQualityRuleRecommendationRunsInput) paginator.ListDataQualityRuleRecommendationRunsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listDataQualityRulesetEvaluationRunsPaginator(self: *Self, params: list_data_quality_ruleset_evaluation_runs.ListDataQualityRulesetEvaluationRunsInput) paginator.ListDataQualityRulesetEvaluationRunsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listDataQualityRulesetsPaginator(self: *Self, params: list_data_quality_rulesets.ListDataQualityRulesetsInput) paginator.ListDataQualityRulesetsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listDevEndpointsPaginator(self: *Self, params: list_dev_endpoints.ListDevEndpointsInput) paginator.ListDevEndpointsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listEntitiesPaginator(self: *Self, params: list_entities.ListEntitiesInput) paginator.ListEntitiesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listJobsPaginator(self: *Self, params: list_jobs.ListJobsInput) paginator.ListJobsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listMaterializedViewRefreshTaskRunsPaginator(self: *Self, params: list_materialized_view_refresh_task_runs.ListMaterializedViewRefreshTaskRunsInput) paginator.ListMaterializedViewRefreshTaskRunsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listMlTransformsPaginator(self: *Self, params: list_ml_transforms.ListMLTransformsInput) paginator.ListMLTransformsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listRegistriesPaginator(self: *Self, params: list_registries.ListRegistriesInput) paginator.ListRegistriesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listSchemaVersionsPaginator(self: *Self, params: list_schema_versions.ListSchemaVersionsInput) paginator.ListSchemaVersionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listSchemasPaginator(self: *Self, params: list_schemas.ListSchemasInput) paginator.ListSchemasPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listSessionsPaginator(self: *Self, params: list_sessions.ListSessionsInput) paginator.ListSessionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listTableOptimizerRunsPaginator(self: *Self, params: list_table_optimizer_runs.ListTableOptimizerRunsInput) paginator.ListTableOptimizerRunsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listTriggersPaginator(self: *Self, params: list_triggers.ListTriggersInput) paginator.ListTriggersPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listUsageProfilesPaginator(self: *Self, params: list_usage_profiles.ListUsageProfilesInput) paginator.ListUsageProfilesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listWorkflowsPaginator(self: *Self, params: list_workflows.ListWorkflowsInput) paginator.ListWorkflowsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn searchTablesPaginator(self: *Self, params: search_tables.SearchTablesInput) paginator.SearchTablesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};
