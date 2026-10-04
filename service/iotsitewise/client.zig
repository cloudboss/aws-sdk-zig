const aws = @import("aws");
const std = @import("std");

const associate_assets = @import("associate_assets.zig");
const associate_time_series_to_asset_property = @import("associate_time_series_to_asset_property.zig");
const batch_associate_data_segments_to_dataset = @import("batch_associate_data_segments_to_dataset.zig");
const batch_associate_project_assets = @import("batch_associate_project_assets.zig");
const batch_delete_dataset_data_segments = @import("batch_delete_dataset_data_segments.zig");
const batch_disassociate_data_segments_from_dataset = @import("batch_disassociate_data_segments_from_dataset.zig");
const batch_disassociate_project_assets = @import("batch_disassociate_project_assets.zig");
const batch_get_asset_property_aggregates = @import("batch_get_asset_property_aggregates.zig");
const batch_get_asset_property_value = @import("batch_get_asset_property_value.zig");
const batch_get_asset_property_value_history = @import("batch_get_asset_property_value_history.zig");
const batch_put_asset_property_value = @import("batch_put_asset_property_value.zig");
const cancel_enrichment_job = @import("cancel_enrichment_job.zig");
const cancel_pipeline_execution = @import("cancel_pipeline_execution.zig");
const cancel_query = @import("cancel_query.zig");
const create_access_policy = @import("create_access_policy.zig");
const create_application = @import("create_application.zig");
const create_asset = @import("create_asset.zig");
const create_asset_model = @import("create_asset_model.zig");
const create_asset_model_composite_model = @import("create_asset_model_composite_model.zig");
const create_bulk_import_job = @import("create_bulk_import_job.zig");
const create_computation_model = @import("create_computation_model.zig");
const create_dashboard = @import("create_dashboard.zig");
const create_dataset = @import("create_dataset.zig");
const create_dataset_export_job = @import("create_dataset_export_job.zig");
const create_enrichment_job = @import("create_enrichment_job.zig");
const create_gateway = @import("create_gateway.zig");
const create_pipeline = @import("create_pipeline.zig");
const create_portal = @import("create_portal.zig");
const create_project = @import("create_project.zig");
const create_task = @import("create_task.zig");
const create_workspace = @import("create_workspace.zig");
const delete_access_policy = @import("delete_access_policy.zig");
const delete_application = @import("delete_application.zig");
const delete_asset = @import("delete_asset.zig");
const delete_asset_model = @import("delete_asset_model.zig");
const delete_asset_model_composite_model = @import("delete_asset_model_composite_model.zig");
const delete_asset_model_interface_relationship = @import("delete_asset_model_interface_relationship.zig");
const delete_computation_model = @import("delete_computation_model.zig");
const delete_dashboard = @import("delete_dashboard.zig");
const delete_dataset = @import("delete_dataset.zig");
const delete_gateway = @import("delete_gateway.zig");
const delete_pipeline = @import("delete_pipeline.zig");
const delete_portal = @import("delete_portal.zig");
const delete_project = @import("delete_project.zig");
const delete_task = @import("delete_task.zig");
const delete_time_series = @import("delete_time_series.zig");
const delete_workspace = @import("delete_workspace.zig");
const describe_access_policy = @import("describe_access_policy.zig");
const describe_action = @import("describe_action.zig");
const describe_application = @import("describe_application.zig");
const describe_asset = @import("describe_asset.zig");
const describe_asset_composite_model = @import("describe_asset_composite_model.zig");
const describe_asset_model = @import("describe_asset_model.zig");
const describe_asset_model_composite_model = @import("describe_asset_model_composite_model.zig");
const describe_asset_model_interface_relationship = @import("describe_asset_model_interface_relationship.zig");
const describe_asset_property = @import("describe_asset_property.zig");
const describe_bulk_import_job = @import("describe_bulk_import_job.zig");
const describe_computation_model = @import("describe_computation_model.zig");
const describe_computation_model_execution_summary = @import("describe_computation_model_execution_summary.zig");
const describe_dashboard = @import("describe_dashboard.zig");
const describe_dataset = @import("describe_dataset.zig");
const describe_dataset_export_job = @import("describe_dataset_export_job.zig");
const describe_default_encryption_configuration = @import("describe_default_encryption_configuration.zig");
const describe_enrichment_job = @import("describe_enrichment_job.zig");
const describe_execution = @import("describe_execution.zig");
const describe_gateway = @import("describe_gateway.zig");
const describe_gateway_capability_configuration = @import("describe_gateway_capability_configuration.zig");
const describe_logging_options = @import("describe_logging_options.zig");
const describe_pipeline = @import("describe_pipeline.zig");
const describe_pipeline_execution = @import("describe_pipeline_execution.zig");
const describe_portal = @import("describe_portal.zig");
const describe_project = @import("describe_project.zig");
const describe_query = @import("describe_query.zig");
const describe_search = @import("describe_search.zig");
const describe_storage_configuration = @import("describe_storage_configuration.zig");
const describe_task = @import("describe_task.zig");
const describe_time_series = @import("describe_time_series.zig");
const describe_workspace = @import("describe_workspace.zig");
const disassociate_assets = @import("disassociate_assets.zig");
const disassociate_time_series_from_asset_property = @import("disassociate_time_series_from_asset_property.zig");
const execute_action = @import("execute_action.zig");
const execute_query = @import("execute_query.zig");
const get_asset_property_aggregates = @import("get_asset_property_aggregates.zig");
const get_asset_property_value = @import("get_asset_property_value.zig");
const get_asset_property_value_history = @import("get_asset_property_value_history.zig");
const get_capture_data = @import("get_capture_data.zig");
const get_interpolated_asset_property_values = @import("get_interpolated_asset_property_values.zig");
const get_query_results = @import("get_query_results.zig");
const get_search_results = @import("get_search_results.zig");
const invoke_assistant = @import("invoke_assistant.zig");
const list_access_policies = @import("list_access_policies.zig");
const list_actions = @import("list_actions.zig");
const list_applications = @import("list_applications.zig");
const list_asset_model_composite_models = @import("list_asset_model_composite_models.zig");
const list_asset_model_properties = @import("list_asset_model_properties.zig");
const list_asset_models = @import("list_asset_models.zig");
const list_asset_properties = @import("list_asset_properties.zig");
const list_asset_relationships = @import("list_asset_relationships.zig");
const list_assets = @import("list_assets.zig");
const list_associated_assets = @import("list_associated_assets.zig");
const list_bulk_import_jobs = @import("list_bulk_import_jobs.zig");
const list_composition_relationships = @import("list_composition_relationships.zig");
const list_computation_model_data_binding_usages = @import("list_computation_model_data_binding_usages.zig");
const list_computation_model_resolve_to_resources = @import("list_computation_model_resolve_to_resources.zig");
const list_computation_models = @import("list_computation_models.zig");
const list_dashboards = @import("list_dashboards.zig");
const list_dataset_data_segment_relationships = @import("list_dataset_data_segment_relationships.zig");
const list_dataset_data_segments = @import("list_dataset_data_segments.zig");
const list_dataset_export_jobs = @import("list_dataset_export_jobs.zig");
const list_datasets = @import("list_datasets.zig");
const list_enrichment_jobs = @import("list_enrichment_jobs.zig");
const list_executions = @import("list_executions.zig");
const list_gateways = @import("list_gateways.zig");
const list_interface_relationships = @import("list_interface_relationships.zig");
const list_pipeline_executions = @import("list_pipeline_executions.zig");
const list_pipelines = @import("list_pipelines.zig");
const list_portals = @import("list_portals.zig");
const list_project_assets = @import("list_project_assets.zig");
const list_projects = @import("list_projects.zig");
const list_queries = @import("list_queries.zig");
const list_searches = @import("list_searches.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const list_tasks = @import("list_tasks.zig");
const list_time_series = @import("list_time_series.zig");
const list_workspaces = @import("list_workspaces.zig");
const put_asset_model_interface_relationship = @import("put_asset_model_interface_relationship.zig");
const put_default_encryption_configuration = @import("put_default_encryption_configuration.zig");
const put_logging_options = @import("put_logging_options.zig");
const put_storage_configuration = @import("put_storage_configuration.zig");
const start_pipeline_execution = @import("start_pipeline_execution.zig");
const start_query = @import("start_query.zig");
const start_search = @import("start_search.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_access_policy = @import("update_access_policy.zig");
const update_asset = @import("update_asset.zig");
const update_asset_model = @import("update_asset_model.zig");
const update_asset_model_composite_model = @import("update_asset_model_composite_model.zig");
const update_asset_property = @import("update_asset_property.zig");
const update_computation_model = @import("update_computation_model.zig");
const update_dashboard = @import("update_dashboard.zig");
const update_dataset = @import("update_dataset.zig");
const update_gateway = @import("update_gateway.zig");
const update_gateway_capability_configuration = @import("update_gateway_capability_configuration.zig");
const update_pipeline = @import("update_pipeline.zig");
const update_portal = @import("update_portal.zig");
const update_project = @import("update_project.zig");
const update_task = @import("update_task.zig");
const update_workspace = @import("update_workspace.zig");
const CallOptions = @import("call_options.zig").CallOptions;
const paginator = @import("paginator.zig");
const waiters = @import("waiters.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    options: aws.http.RequestOptions = .{},

    const Self = @This();
    pub const sdk_id = "IoTSiteWise";

    pub fn init(allocator: std.mem.Allocator, config: *aws.Config) Self {
        return .{
            .allocator = allocator,
            .config = config,
        };
    }

    pub fn initWithOptions(allocator: std.mem.Allocator, config: *aws.Config, options: aws.http.RequestOptions) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .options = options,
        };
    }

    pub fn deinit(self: *Self) void {
        _ = self;
    }

    /// Associates a child asset with the given parent asset through a hierarchy
    /// defined in the
    /// parent asset's model. For more information, see [Associating
    /// assets](https://docs.aws.amazon.com/iot-sitewise/latest/userguide/add-associated-assets.html) in the
    /// *IoT SiteWise User Guide*.
    pub fn associateAssets(self: *Self, allocator: std.mem.Allocator, input: associate_assets.AssociateAssetsInput, options: CallOptions) !associate_assets.AssociateAssetsOutput {
        return associate_assets.execute(self, allocator, input, options);
    }

    /// Associates a time series (data stream) with an asset property.
    pub fn associateTimeSeriesToAssetProperty(self: *Self, allocator: std.mem.Allocator, input: associate_time_series_to_asset_property.AssociateTimeSeriesToAssetPropertyInput, options: CallOptions) !associate_time_series_to_asset_property.AssociateTimeSeriesToAssetPropertyOutput {
        return associate_time_series_to_asset_property.execute(self, allocator, input, options);
    }

    /// Associates a batch of data segments with a curated dataset. Data segments
    /// are
    /// time-bounded slices of time series data selected from source session
    /// datasets. Data segments
    /// that belong to the same time series can't overlap in time, regardless of
    /// which dataset they
    /// belong to.
    pub fn batchAssociateDataSegmentsToDataset(self: *Self, allocator: std.mem.Allocator, input: batch_associate_data_segments_to_dataset.BatchAssociateDataSegmentsToDatasetInput, options: CallOptions) !batch_associate_data_segments_to_dataset.BatchAssociateDataSegmentsToDatasetOutput {
        return batch_associate_data_segments_to_dataset.execute(self, allocator, input, options);
    }

    /// The IoT SiteWise Monitor feature will no longer be open to new
    /// customers starting November 7, 2025. If you would like to use the IoT
    /// SiteWise Monitor feature, sign up prior to that date. Existing customers can
    /// continue to use the service as normal. For more information, see
    /// [IoT SiteWise Monitor availability
    /// change](https://docs.aws.amazon.com/iot-sitewise/latest/appguide/iotsitewise-monitor-availability-change.html).
    ///
    /// Associates a group (batch) of assets with an IoT SiteWise Monitor project.
    pub fn batchAssociateProjectAssets(self: *Self, allocator: std.mem.Allocator, input: batch_associate_project_assets.BatchAssociateProjectAssetsInput, options: CallOptions) !batch_associate_project_assets.BatchAssociateProjectAssetsOutput {
        return batch_associate_project_assets.execute(self, allocator, input, options);
    }

    /// Deletes a batch of data segments from a session dataset. Deleting a data
    /// segment deletes
    /// the underlying time series data for the segment's time range.
    pub fn batchDeleteDatasetDataSegments(self: *Self, allocator: std.mem.Allocator, input: batch_delete_dataset_data_segments.BatchDeleteDatasetDataSegmentsInput, options: CallOptions) !batch_delete_dataset_data_segments.BatchDeleteDatasetDataSegmentsOutput {
        return batch_delete_dataset_data_segments.execute(self, allocator, input, options);
    }

    /// Disassociates a batch of data segments from a curated dataset.
    /// Disassociating a data
    /// segment doesn't delete the underlying data in the source session dataset.
    pub fn batchDisassociateDataSegmentsFromDataset(self: *Self, allocator: std.mem.Allocator, input: batch_disassociate_data_segments_from_dataset.BatchDisassociateDataSegmentsFromDatasetInput, options: CallOptions) !batch_disassociate_data_segments_from_dataset.BatchDisassociateDataSegmentsFromDatasetOutput {
        return batch_disassociate_data_segments_from_dataset.execute(self, allocator, input, options);
    }

    /// Disassociates a group (batch) of assets from an IoT SiteWise Monitor
    /// project.
    pub fn batchDisassociateProjectAssets(self: *Self, allocator: std.mem.Allocator, input: batch_disassociate_project_assets.BatchDisassociateProjectAssetsInput, options: CallOptions) !batch_disassociate_project_assets.BatchDisassociateProjectAssetsOutput {
        return batch_disassociate_project_assets.execute(self, allocator, input, options);
    }

    /// Gets aggregated values (for example, average, minimum, and maximum) for one
    /// or more asset
    /// properties. For more information, see [Querying
    /// aggregates](https://docs.aws.amazon.com/iot-sitewise/latest/userguide/query-industrial-data.html#aggregates) in the
    /// *IoT SiteWise User Guide*.
    pub fn batchGetAssetPropertyAggregates(self: *Self, allocator: std.mem.Allocator, input: batch_get_asset_property_aggregates.BatchGetAssetPropertyAggregatesInput, options: CallOptions) !batch_get_asset_property_aggregates.BatchGetAssetPropertyAggregatesOutput {
        return batch_get_asset_property_aggregates.execute(self, allocator, input, options);
    }

    /// Gets the current value for one or more asset properties. For more
    /// information, see [Querying
    /// current
    /// values](https://docs.aws.amazon.com/iot-sitewise/latest/userguide/query-industrial-data.html#current-values) in the *IoT SiteWise User Guide*.
    pub fn batchGetAssetPropertyValue(self: *Self, allocator: std.mem.Allocator, input: batch_get_asset_property_value.BatchGetAssetPropertyValueInput, options: CallOptions) !batch_get_asset_property_value.BatchGetAssetPropertyValueOutput {
        return batch_get_asset_property_value.execute(self, allocator, input, options);
    }

    /// Gets the historical values for one or more asset properties. For more
    /// information, see
    /// [Querying historical
    /// values](https://docs.aws.amazon.com/iot-sitewise/latest/userguide/query-industrial-data.html#historical-values) in the *IoT SiteWise User Guide*.
    pub fn batchGetAssetPropertyValueHistory(self: *Self, allocator: std.mem.Allocator, input: batch_get_asset_property_value_history.BatchGetAssetPropertyValueHistoryInput, options: CallOptions) !batch_get_asset_property_value_history.BatchGetAssetPropertyValueHistoryOutput {
        return batch_get_asset_property_value_history.execute(self, allocator, input, options);
    }

    /// Sends a list of asset property values to IoT SiteWise. Each value is a
    /// timestamp-quality-value
    /// (TQV) data point. For more information, see [Ingesting data using the
    /// API](https://docs.aws.amazon.com/iot-sitewise/latest/userguide/ingest-api.html) in the
    /// *IoT SiteWise User Guide*.
    ///
    /// To identify an asset property, you must specify one of the following:
    ///
    /// * The `assetId` and `propertyId` of an asset property.
    ///
    /// * A `propertyAlias`, which is a data stream alias (for example,
    /// `/company/windfarm/3/turbine/7/temperature`). To define an asset property's
    /// alias, see
    /// [UpdateAssetProperty](https://docs.aws.amazon.com/iot-sitewise/latest/APIReference/API_UpdateAssetProperty.html).
    ///
    /// With respect to Unix epoch time, IoT SiteWise accepts only TQVs that have a
    /// timestamp of no more
    /// than 7 days in the past and no more than 10 minutes in the future. IoT
    /// SiteWise rejects timestamps
    /// outside of the inclusive range of [-7 days, +10 minutes] and returns a
    /// `TimestampOutOfRangeException` error.
    ///
    /// For each asset property, IoT SiteWise overwrites TQVs with duplicate
    /// timestamps unless the newer
    /// TQV has a different quality. For example, if you store a TQV `{T1, GOOD,
    /// V1}`,
    /// then storing `{T1, GOOD, V2}` replaces the existing TQV.
    ///
    /// IoT SiteWise authorizes access to each `BatchPutAssetPropertyValue` entry
    /// individually.
    /// For more information, see [BatchPutAssetPropertyValue
    /// authorization](https://docs.aws.amazon.com/iot-sitewise/latest/userguide/security_iam_service-with-iam.html#security_iam_service-with-iam-id-based-policies-batchputassetpropertyvalue-action) in the
    /// *IoT SiteWise User Guide*.
    pub fn batchPutAssetPropertyValue(self: *Self, allocator: std.mem.Allocator, input: batch_put_asset_property_value.BatchPutAssetPropertyValueInput, options: CallOptions) !batch_put_asset_property_value.BatchPutAssetPropertyValueOutput {
        return batch_put_asset_property_value.execute(self, allocator, input, options);
    }

    /// Cancels a running or pending enrichment job. This is an idempotent
    /// operation—calling it multiple
    /// times with the same jobId is safe and returns the current status.
    /// Behavior
    ///
    /// * Jobs in PENDING or RUNNING status transition to CANCELLED
    ///
    /// * Jobs in RUNNING state may not be cancellable once they have progressed to
    ///   certain processing stages
    ///
    /// * Jobs already in terminal states (COMPLETED, FAILED, TIMED_OUT) cannot be
    ///   cancelled;
    /// the operation returns a ConflictingOperationException
    ///
    /// * Cancelling an already-CANCELLED job is a no-op and returns the current
    ///   status (idempotent behavior)
    ///
    /// * The API responds immediately after recording the cancellation
    ///
    /// * Cleanup of job resources happens asynchronously in the background
    ///
    /// When to Cancel
    ///
    /// Cancel a job when:
    ///
    /// * The job is taking longer than expected
    ///
    /// * The job was created with incorrect parameters
    ///
    /// * You no longer need the results
    ///
    /// Idempotency
    ///
    /// You can safely retry cancellation requests. Calling CancelEnrichmentJob
    /// multiple times for the same
    /// job returns the current status without error as long as the job is not in a
    /// terminal state other
    /// than CANCELLED.
    pub fn cancelEnrichmentJob(self: *Self, allocator: std.mem.Allocator, input: cancel_enrichment_job.CancelEnrichmentJobInput, options: CallOptions) !cancel_enrichment_job.CancelEnrichmentJobOutput {
        return cancel_enrichment_job.execute(self, allocator, input, options);
    }

    /// Cancels a pipeline execution in the specified workspace. If the execution
    /// is not in a terminal state (such as NOT_STARTED or RUNNING), it transitions
    /// to
    /// CANCELLING and asynchronously to CANCELLED. This operation is idempotent:
    /// calling
    /// it on an execution that is already CANCELLING or CANCELLED returns success
    /// with
    /// the current state. Calling it on a terminal execution (SUCCEEDED or FAILED)
    /// returns a conflict error. You can optionally provide a reason; it is
    /// returned in
    /// the stateDetails field when you describe the execution.
    pub fn cancelPipelineExecution(self: *Self, allocator: std.mem.Allocator, input: cancel_pipeline_execution.CancelPipelineExecutionInput, options: CallOptions) !cancel_pipeline_execution.CancelPipelineExecutionOutput {
        return cancel_pipeline_execution.execute(self, allocator, input, options);
    }

    /// Cancels a running query.
    pub fn cancelQuery(self: *Self, allocator: std.mem.Allocator, input: cancel_query.CancelQueryInput, options: CallOptions) !cancel_query.CancelQueryOutput {
        return cancel_query.execute(self, allocator, input, options);
    }

    /// The IoT SiteWise Monitor feature will no longer be open to new
    /// customers starting November 7, 2025. If you would like to use the IoT
    /// SiteWise Monitor feature, sign up prior to that date. Existing customers can
    /// continue to use the service as normal. For more information, see
    /// [IoT SiteWise Monitor availability
    /// change](https://docs.aws.amazon.com/iot-sitewise/latest/appguide/iotsitewise-monitor-availability-change.html).
    ///
    /// Creates an access policy that grants the specified identity (IAM Identity
    /// Center user, IAM Identity Center group, or
    /// IAM user) access to the specified IoT SiteWise Monitor portal or project
    /// resource.
    ///
    /// Support for access policies that use an SSO Group as the identity is not
    /// supported at this time.
    pub fn createAccessPolicy(self: *Self, allocator: std.mem.Allocator, input: create_access_policy.CreateAccessPolicyInput, options: CallOptions) !create_access_policy.CreateAccessPolicyOutput {
        return create_access_policy.execute(self, allocator, input, options);
    }

    /// Creates a new application for the workspace and IdC application provided
    pub fn createApplication(self: *Self, allocator: std.mem.Allocator, input: create_application.CreateApplicationInput, options: CallOptions) !create_application.CreateApplicationOutput {
        return create_application.execute(self, allocator, input, options);
    }

    /// Creates an asset from an existing asset model. For more information, see
    /// [Creating
    /// assets](https://docs.aws.amazon.com/iot-sitewise/latest/userguide/create-assets.html) in the
    /// *IoT SiteWise User Guide*.
    pub fn createAsset(self: *Self, allocator: std.mem.Allocator, input: create_asset.CreateAssetInput, options: CallOptions) !create_asset.CreateAssetOutput {
        return create_asset.execute(self, allocator, input, options);
    }

    /// Creates an asset model from specified property and hierarchy definitions.
    /// You create
    /// assets from asset models. With asset models, you can easily create assets of
    /// the same type
    /// that have standardized definitions. Each asset created from a model inherits
    /// the asset model's
    /// property and hierarchy definitions. For more information, see [Defining
    /// asset
    /// models](https://docs.aws.amazon.com/iot-sitewise/latest/userguide/define-models.html) in the
    /// *IoT SiteWise User Guide*.
    ///
    /// You can create three types of asset models, `ASSET_MODEL`,
    /// `COMPONENT_MODEL`, or an `INTERFACE`.
    ///
    /// * **ASSET_MODEL** – (default) An asset model that
    /// you can use to create assets. Can't be included as a component in another
    /// asset
    /// model.
    ///
    /// * **COMPONENT_MODEL** – A reusable component that
    /// you can include in the composite models of other asset models. You can't
    /// create
    /// assets directly from this type of asset model.
    ///
    /// * **INTERFACE** – An interface is a type of model
    /// that defines a standard structure that can be applied to different asset
    /// models.
    pub fn createAssetModel(self: *Self, allocator: std.mem.Allocator, input: create_asset_model.CreateAssetModelInput, options: CallOptions) !create_asset_model.CreateAssetModelOutput {
        return create_asset_model.execute(self, allocator, input, options);
    }

    /// Creates a custom composite model from specified property and hierarchy
    /// definitions. There
    /// are two types of custom composite models, `inline` and
    /// `component-model-based`.
    ///
    /// Use component-model-based custom composite models to define standard,
    /// reusable components.
    /// A component-model-based custom composite model consists of a name, a
    /// description, and the ID
    /// of the component model it references. A component-model-based custom
    /// composite model has no
    /// properties of its own; its referenced component model provides its
    /// associated properties to
    /// any created assets. For more information, see [Custom composite models
    /// (Components)](https://docs.aws.amazon.com/iot-sitewise/latest/userguide/custom-composite-models.html)
    /// in the *IoT SiteWise User Guide*.
    ///
    /// Use inline custom composite models to organize the properties of an asset
    /// model. The
    /// properties of inline custom composite models are local to the asset model
    /// where they are
    /// included and can't be used to create multiple assets.
    ///
    /// To create a component-model-based model, specify the `composedAssetModelId`
    /// of
    /// an existing asset model with `assetModelType` of
    /// `COMPONENT_MODEL`.
    ///
    /// To create an inline model, specify the `assetModelCompositeModelProperties`
    /// and
    /// don't include an `composedAssetModelId`.
    pub fn createAssetModelCompositeModel(self: *Self, allocator: std.mem.Allocator, input: create_asset_model_composite_model.CreateAssetModelCompositeModelInput, options: CallOptions) !create_asset_model_composite_model.CreateAssetModelCompositeModelOutput {
        return create_asset_model_composite_model.execute(self, allocator, input, options);
    }

    /// Defines a job to ingest data to IoT SiteWise from Amazon S3. For more
    /// information, see [Create a
    /// bulk import job
    /// (CLI)](https://docs.aws.amazon.com/iot-sitewise/latest/userguide/CreateBulkImportJob.html) in the *Amazon Simple Storage Service User Guide*.
    ///
    /// Before you create a bulk import job that ingests data into time series
    /// outside of a
    /// workspace, you must enable IoT SiteWise warm tier or IoT SiteWise cold tier.
    /// For more information about how
    /// to configure storage settings, see
    /// [PutStorageConfiguration](https://docs.aws.amazon.com/iot-sitewise/latest/APIReference/API_PutStorageConfiguration.html). This requirement doesn't apply to bulk import jobs that
    /// ingest data into a session dataset in a workspace (jobs that specify a
    /// `workspaceName` and `datasetId`). Those jobs don't use IoT SiteWise warm or
    /// cold tier storage.
    ///
    /// Bulk import is designed to store historical data to IoT SiteWise.
    ///
    /// * Newly ingested data in the hot tier triggers notifications and
    ///   computations.
    ///
    /// * After data moves from the hot tier to the warm or cold tier based on
    ///   retention
    /// settings, it does not trigger computations or notifications.
    ///
    /// * Data older than 7 days does not trigger computations or notifications.
    pub fn createBulkImportJob(self: *Self, allocator: std.mem.Allocator, input: create_bulk_import_job.CreateBulkImportJobInput, options: CallOptions) !create_bulk_import_job.CreateBulkImportJobOutput {
        return create_bulk_import_job.execute(self, allocator, input, options);
    }

    /// Create a computation model with a configuration and data binding.
    pub fn createComputationModel(self: *Self, allocator: std.mem.Allocator, input: create_computation_model.CreateComputationModelInput, options: CallOptions) !create_computation_model.CreateComputationModelOutput {
        return create_computation_model.execute(self, allocator, input, options);
    }

    /// The IoT SiteWise Monitor feature will no longer be open to new
    /// customers starting November 7, 2025. If you would like to use the IoT
    /// SiteWise Monitor feature, sign up prior to that date. Existing customers can
    /// continue to use the service as normal. For more information, see
    /// [IoT SiteWise Monitor availability
    /// change](https://docs.aws.amazon.com/iot-sitewise/latest/appguide/iotsitewise-monitor-availability-change.html).
    ///
    /// Creates a dashboard in an IoT SiteWise Monitor project.
    pub fn createDashboard(self: *Self, allocator: std.mem.Allocator, input: create_dashboard.CreateDashboardInput, options: CallOptions) !create_dashboard.CreateDashboardOutput {
        return create_dashboard.execute(self, allocator, input, options);
    }

    /// Creates a dataset. Session and curated datasets are created in a workspace.
    /// A session dataset contains data segments of time series data, and a curated
    /// dataset curates data segments selected from source session datasets. A
    /// dataset that connects to an external datasource is created outside of a
    /// workspace.
    pub fn createDataset(self: *Self, allocator: std.mem.Allocator, input: create_dataset.CreateDatasetInput, options: CallOptions) !create_dataset.CreateDatasetOutput {
        return create_dataset.execute(self, allocator, input, options);
    }

    /// Starts an asynchronous job that exports dataset and time-series data from a
    /// workspace to Amazon
    /// S3. The operation returns a jobId immediately; poll DescribeDatasetExportJob
    /// to track progress and
    /// ListDatasetExportJobs to enumerate a workspace's jobs.
    pub fn createDatasetExportJob(self: *Self, allocator: std.mem.Allocator, input: create_dataset_export_job.CreateDatasetExportJobInput, options: CallOptions) !create_dataset_export_job.CreateDatasetExportJobOutput {
        return create_dataset_export_job.execute(self, allocator, input, options);
    }

    /// Creates an asynchronous enrichment job to analyze time-series sensor data.
    /// The operation returns
    /// immediately with job details while processing continues in the background.
    /// Idempotency
    ///
    /// Include a clientToken to make the operation idempotent. If you submit the
    /// same request with the same
    /// token within the idempotency window, you receive the original job details
    /// without creating a duplicate.
    /// Prerequisites
    ///
    /// Before creating a job, ensure:
    ///
    /// * The workspace is in ACTIVE state (not being deleted)
    ///
    /// * You have IAM permissions for the workspace, dataset, and time-series
    ///   resources
    ///
    /// * You have KMS Decrypt permission on the workspace's customer-managed
    ///   encryption key
    ///
    /// * No duplicate job (same workspace, dataset, property, and job type) is
    ///   currently running
    ///
    /// Workflow
    ///
    /// * Submit the job with configuration specifying which video data to analyze
    ///   and the time range
    ///
    /// * Capture the jobId from the response
    ///
    /// * Use DescribeEnrichmentJob to monitor progress and check job status
    ///
    /// * When status reaches a terminal state (COMPLETED, FAILED, TIMED_OUT,
    ///   CANCELLED), check results
    ///
    /// * For COMPLETED jobs, query IoT SiteWise for semantic search on video events
    ///
    /// Error Handling
    ///
    /// * ConflictingOperationException: A duplicate job is already running for the
    ///   same configuration
    ///
    /// * InvalidRequestException: Invalid parameters (e.g., both timeSeriesId and
    ///   propertyAlias specified)
    ///
    /// * AccessDeniedException: Insufficient IAM or KMS permissions
    ///
    /// * LimitExceededException: Too many concurrent jobs or requests
    pub fn createEnrichmentJob(self: *Self, allocator: std.mem.Allocator, input: create_enrichment_job.CreateEnrichmentJobInput, options: CallOptions) !create_enrichment_job.CreateEnrichmentJobOutput {
        return create_enrichment_job.execute(self, allocator, input, options);
    }

    /// Creates a gateway, which is a virtual or edge device that delivers
    /// industrial data streams
    /// from local servers to IoT SiteWise. For more information, see [Ingesting
    /// data using a
    /// gateway](https://docs.aws.amazon.com/iot-sitewise/latest/userguide/gateway-connector.html) in the
    /// *IoT SiteWise User Guide*.
    pub fn createGateway(self: *Self, allocator: std.mem.Allocator, input: create_gateway.CreateGatewayInput, options: CallOptions) !create_gateway.CreateGatewayOutput {
        return create_gateway.execute(self, allocator, input, options);
    }

    /// Creates a new pipeline in the specified workspace. A pipeline defines a
    /// directed acyclic graph (DAG) of compute nodes, where each node references a
    /// task
    /// and can declare dependencies on other nodes. Cyclic dependencies are not
    /// allowed. Nodes without dependencies run in parallel, while nodes with
    /// dependencies
    /// wait for all upstream nodes to complete successfully before starting.
    ///
    /// You can set environment variables at the pipeline level that are shared
    /// across all
    /// compute nodes, and override them at the individual compute node level.
    pub fn createPipeline(self: *Self, allocator: std.mem.Allocator, input: create_pipeline.CreatePipelineInput, options: CallOptions) !create_pipeline.CreatePipelineOutput {
        return create_pipeline.execute(self, allocator, input, options);
    }

    /// The IoT SiteWise Monitor feature will no longer be open to new
    /// customers starting November 7, 2025. If you would like to use the IoT
    /// SiteWise Monitor feature, sign up prior to that date. Existing customers can
    /// continue to use the service as normal. For more information, see
    /// [IoT SiteWise Monitor availability
    /// change](https://docs.aws.amazon.com/iot-sitewise/latest/appguide/iotsitewise-monitor-availability-change.html).
    ///
    /// Creates a portal, which can contain projects and dashboards. IoT SiteWise
    /// Monitor uses IAM Identity Center or IAM
    /// to authenticate portal users and manage user permissions.
    ///
    /// Before you can sign in to a new portal, you must add at least one identity
    /// to that
    /// portal. For more information, see [Adding or removing portal
    /// administrators](https://docs.aws.amazon.com/iot-sitewise/latest/userguide/administer-portals.html#portal-change-admins) in the *IoT SiteWise User Guide*.
    pub fn createPortal(self: *Self, allocator: std.mem.Allocator, input: create_portal.CreatePortalInput, options: CallOptions) !create_portal.CreatePortalOutput {
        return create_portal.execute(self, allocator, input, options);
    }

    /// The IoT SiteWise Monitor feature will no longer be open to new
    /// customers starting November 7, 2025. If you would like to use the IoT
    /// SiteWise Monitor feature, sign up prior to that date. Existing customers can
    /// continue to use the service as normal. For more information, see
    /// [IoT SiteWise Monitor availability
    /// change](https://docs.aws.amazon.com/iot-sitewise/latest/appguide/iotsitewise-monitor-availability-change.html).
    ///
    /// Creates a project in the specified portal.
    ///
    /// Make sure that the project name and description don't contain confidential
    /// information.
    pub fn createProject(self: *Self, allocator: std.mem.Allocator, input: create_project.CreateProjectInput, options: CallOptions) !create_project.CreateProjectOutput {
        return create_project.execute(self, allocator, input, options);
    }

    /// Creates a new task in the specified workspace. A task defines a reusable
    /// containerized compute workload that can be referenced by one or more
    /// pipeline compute nodes.
    ///
    /// Specify a
    /// [`containerTaskConfiguration`](https://docs.aws.amazon.com/iot-sitewise/latest/APIReference/API_ContainerTaskConfiguration.html) for custom container workloads with
    /// configurable ECR image, processing type, processing unit, and environment
    /// variables.
    pub fn createTask(self: *Self, allocator: std.mem.Allocator, input: create_task.CreateTaskInput, options: CallOptions) !create_task.CreateTaskOutput {
        return create_task.execute(self, allocator, input, options);
    }

    /// Creates a workspace in IoT SiteWise. A workspace isolates its resources,
    /// such as datasets, time
    /// series, pipelines, and tasks, and their data from other workspaces, and has
    /// its own quotas
    /// and throttling limits. You must specify an encryption configuration when you
    /// create
    /// a workspace. The operation returns immediately with the workspace in the
    /// `CREATING` state. Provisioning completes asynchronously, after which the
    /// workspace
    /// state is `ACTIVE`, or `FAILED` if provisioning doesn't complete.
    pub fn createWorkspace(self: *Self, allocator: std.mem.Allocator, input: create_workspace.CreateWorkspaceInput, options: CallOptions) !create_workspace.CreateWorkspaceOutput {
        return create_workspace.execute(self, allocator, input, options);
    }

    /// Deletes an access policy that grants the specified identity access to the
    /// specified
    /// IoT SiteWise Monitor resource. You can use this operation to revoke access
    /// to an IoT SiteWise Monitor
    /// resource.
    pub fn deleteAccessPolicy(self: *Self, allocator: std.mem.Allocator, input: delete_access_policy.DeleteAccessPolicyInput, options: CallOptions) !delete_access_policy.DeleteAccessPolicyOutput {
        return delete_access_policy.execute(self, allocator, input, options);
    }

    /// Deletes an application by ID
    pub fn deleteApplication(self: *Self, allocator: std.mem.Allocator, input: delete_application.DeleteApplicationInput, options: CallOptions) !delete_application.DeleteApplicationOutput {
        return delete_application.execute(self, allocator, input, options);
    }

    /// Deletes an asset. This action can't be undone. For more information, see
    /// [Deleting assets and
    /// models](https://docs.aws.amazon.com/iot-sitewise/latest/userguide/delete-assets-and-models.html) in the *IoT SiteWise User Guide*.
    ///
    /// You can't delete an asset that's associated to another asset. For more
    /// information, see
    /// [DisassociateAssets](https://docs.aws.amazon.com/iot-sitewise/latest/APIReference/API_DisassociateAssets.html).
    pub fn deleteAsset(self: *Self, allocator: std.mem.Allocator, input: delete_asset.DeleteAssetInput, options: CallOptions) !delete_asset.DeleteAssetOutput {
        return delete_asset.execute(self, allocator, input, options);
    }

    /// Deletes an asset model. This action can't be undone. You must delete all
    /// assets created
    /// from an asset model before you can delete the model. Also, you can't delete
    /// an asset model if
    /// a parent asset model exists that contains a property formula expression that
    /// depends on the
    /// asset model that you want to delete. For more information, see [Deleting
    /// assets and
    /// models](https://docs.aws.amazon.com/iot-sitewise/latest/userguide/delete-assets-and-models.html) in the
    /// *IoT SiteWise User Guide*.
    pub fn deleteAssetModel(self: *Self, allocator: std.mem.Allocator, input: delete_asset_model.DeleteAssetModelInput, options: CallOptions) !delete_asset_model.DeleteAssetModelOutput {
        return delete_asset_model.execute(self, allocator, input, options);
    }

    /// Deletes a composite model. This action can't be undone. You must delete all
    /// assets created
    /// from a composite model before you can delete the model. Also, you can't
    /// delete a composite
    /// model if a parent asset model exists that contains a property formula
    /// expression that depends
    /// on the asset model that you want to delete. For more information, see
    /// [Deleting assets and
    /// models](https://docs.aws.amazon.com/iot-sitewise/latest/userguide/delete-assets-and-models.html) in the *IoT SiteWise User Guide*.
    pub fn deleteAssetModelCompositeModel(self: *Self, allocator: std.mem.Allocator, input: delete_asset_model_composite_model.DeleteAssetModelCompositeModelInput, options: CallOptions) !delete_asset_model_composite_model.DeleteAssetModelCompositeModelOutput {
        return delete_asset_model_composite_model.execute(self, allocator, input, options);
    }

    /// Deletes an interface relationship between an asset model and an interface
    /// asset
    /// model.
    pub fn deleteAssetModelInterfaceRelationship(self: *Self, allocator: std.mem.Allocator, input: delete_asset_model_interface_relationship.DeleteAssetModelInterfaceRelationshipInput, options: CallOptions) !delete_asset_model_interface_relationship.DeleteAssetModelInterfaceRelationshipOutput {
        return delete_asset_model_interface_relationship.execute(self, allocator, input, options);
    }

    /// Deletes a computation model. This action can't be undone.
    pub fn deleteComputationModel(self: *Self, allocator: std.mem.Allocator, input: delete_computation_model.DeleteComputationModelInput, options: CallOptions) !delete_computation_model.DeleteComputationModelOutput {
        return delete_computation_model.execute(self, allocator, input, options);
    }

    /// Deletes a dashboard from IoT SiteWise Monitor.
    pub fn deleteDashboard(self: *Self, allocator: std.mem.Allocator, input: delete_dashboard.DeleteDashboardInput, options: CallOptions) !delete_dashboard.DeleteDashboardOutput {
        return delete_dashboard.execute(self, allocator, input, options);
    }

    /// Deletes a dataset. This can't be undone. Deleting a session dataset also
    /// deletes the underlying time series data in the session. You can't delete a
    /// session dataset while a curated dataset references its data segments. First
    /// delete the curated dataset or disassociate the data segments. Deleting a
    /// curated dataset doesn't delete the underlying data in the source session
    /// datasets.
    pub fn deleteDataset(self: *Self, allocator: std.mem.Allocator, input: delete_dataset.DeleteDatasetInput, options: CallOptions) !delete_dataset.DeleteDatasetOutput {
        return delete_dataset.execute(self, allocator, input, options);
    }

    /// Deletes a gateway from IoT SiteWise. When you delete a gateway, some of the
    /// gateway's files remain
    /// in your gateway's file system.
    pub fn deleteGateway(self: *Self, allocator: std.mem.Allocator, input: delete_gateway.DeleteGatewayInput, options: CallOptions) !delete_gateway.DeleteGatewayOutput {
        return delete_gateway.execute(self, allocator, input, options);
    }

    /// Deletes a pipeline from the specified workspace. A pipeline cannot be
    /// deleted if it has any active executions. Wait for all executions to complete
    /// before
    /// attempting to delete the pipeline, or use
    /// [CancelPipelineExecution](https://docs.aws.amazon.com/iot-sitewise/latest/APIReference/API_CancelPipelineExecution.html) to stop a running
    /// execution.
    pub fn deletePipeline(self: *Self, allocator: std.mem.Allocator, input: delete_pipeline.DeletePipelineInput, options: CallOptions) !delete_pipeline.DeletePipelineOutput {
        return delete_pipeline.execute(self, allocator, input, options);
    }

    /// Deletes a portal from IoT SiteWise Monitor.
    pub fn deletePortal(self: *Self, allocator: std.mem.Allocator, input: delete_portal.DeletePortalInput, options: CallOptions) !delete_portal.DeletePortalOutput {
        return delete_portal.execute(self, allocator, input, options);
    }

    /// Deletes a project from IoT SiteWise Monitor.
    pub fn deleteProject(self: *Self, allocator: std.mem.Allocator, input: delete_project.DeleteProjectInput, options: CallOptions) !delete_project.DeleteProjectOutput {
        return delete_project.execute(self, allocator, input, options);
    }

    /// Deletes a task from the specified workspace. A task cannot be deleted
    /// if it is currently referenced by any existing pipeline. Remove the task from
    /// all
    /// pipelines before attempting to delete it.
    pub fn deleteTask(self: *Self, allocator: std.mem.Allocator, input: delete_task.DeleteTaskInput, options: CallOptions) !delete_task.DeleteTaskOutput {
        return delete_task.execute(self, allocator, input, options);
    }

    /// Deletes a time series (data stream). If you delete a time series that's
    /// associated with an
    /// asset property, the asset property still exists, but the time series will no
    /// longer be
    /// associated with this asset property. You can't delete a time series until
    /// all of its data
    /// segments have been deleted from session datasets.
    ///
    /// To identify a time series, do one of the following:
    ///
    /// * If the time series isn't associated with an asset property,
    /// specify the `alias` of the time series.
    ///
    /// * If the time series is associated with an asset property,
    /// specify one of the following:
    ///
    /// * The `alias` of the time series.
    ///
    /// * The `assetId` and `propertyId` that identifies the asset property.
    pub fn deleteTimeSeries(self: *Self, allocator: std.mem.Allocator, input: delete_time_series.DeleteTimeSeriesInput, options: CallOptions) !delete_time_series.DeleteTimeSeriesOutput {
        return delete_time_series.execute(self, allocator, input, options);
    }

    /// Deletes a workspace. Before you delete a workspace, you must delete all
    /// resources
    /// contained in or associated with the workspace, such as datasets, time
    /// series, pipelines,
    /// and tasks.
    pub fn deleteWorkspace(self: *Self, allocator: std.mem.Allocator, input: delete_workspace.DeleteWorkspaceInput, options: CallOptions) !delete_workspace.DeleteWorkspaceOutput {
        return delete_workspace.execute(self, allocator, input, options);
    }

    /// Describes an access policy, which specifies an identity's access to an IoT
    /// SiteWise Monitor portal or
    /// project.
    pub fn describeAccessPolicy(self: *Self, allocator: std.mem.Allocator, input: describe_access_policy.DescribeAccessPolicyInput, options: CallOptions) !describe_access_policy.DescribeAccessPolicyOutput {
        return describe_access_policy.execute(self, allocator, input, options);
    }

    /// Retrieves information about an action.
    pub fn describeAction(self: *Self, allocator: std.mem.Allocator, input: describe_action.DescribeActionInput, options: CallOptions) !describe_action.DescribeActionOutput {
        return describe_action.execute(self, allocator, input, options);
    }

    /// Retrieves Application details based on the ID
    pub fn describeApplication(self: *Self, allocator: std.mem.Allocator, input: describe_application.DescribeApplicationInput, options: CallOptions) !describe_application.DescribeApplicationOutput {
        return describe_application.execute(self, allocator, input, options);
    }

    /// Retrieves information about an asset.
    pub fn describeAsset(self: *Self, allocator: std.mem.Allocator, input: describe_asset.DescribeAssetInput, options: CallOptions) !describe_asset.DescribeAssetOutput {
        return describe_asset.execute(self, allocator, input, options);
    }

    /// Retrieves information about an asset composite model (also known as an asset
    /// component).
    /// An `AssetCompositeModel` is an instance of an
    /// `AssetModelCompositeModel`. If you want to see information about the model
    /// this is
    /// based on, call
    /// [DescribeAssetModelCompositeModel](https://docs.aws.amazon.com/iot-sitewise/latest/APIReference/API_DescribeAssetModelCompositeModel.html).
    pub fn describeAssetCompositeModel(self: *Self, allocator: std.mem.Allocator, input: describe_asset_composite_model.DescribeAssetCompositeModelInput, options: CallOptions) !describe_asset_composite_model.DescribeAssetCompositeModelOutput {
        return describe_asset_composite_model.execute(self, allocator, input, options);
    }

    /// Retrieves information about an asset model. This includes details about the
    /// asset model's
    /// properties, hierarchies, composite models, and any interface relationships
    /// if the asset model
    /// implements interfaces.
    pub fn describeAssetModel(self: *Self, allocator: std.mem.Allocator, input: describe_asset_model.DescribeAssetModelInput, options: CallOptions) !describe_asset_model.DescribeAssetModelOutput {
        return describe_asset_model.execute(self, allocator, input, options);
    }

    /// Retrieves information about an asset model composite model (also known as an
    /// asset model
    /// component). For more information, see [Custom composite models
    /// (Components)](https://docs.aws.amazon.com/iot-sitewise/latest/userguide/custom-composite-models.html) in the *IoT SiteWise User Guide*.
    pub fn describeAssetModelCompositeModel(self: *Self, allocator: std.mem.Allocator, input: describe_asset_model_composite_model.DescribeAssetModelCompositeModelInput, options: CallOptions) !describe_asset_model_composite_model.DescribeAssetModelCompositeModelOutput {
        return describe_asset_model_composite_model.execute(self, allocator, input, options);
    }

    /// Retrieves information about an interface relationship between an asset model
    /// and an
    /// interface asset model.
    pub fn describeAssetModelInterfaceRelationship(self: *Self, allocator: std.mem.Allocator, input: describe_asset_model_interface_relationship.DescribeAssetModelInterfaceRelationshipInput, options: CallOptions) !describe_asset_model_interface_relationship.DescribeAssetModelInterfaceRelationshipOutput {
        return describe_asset_model_interface_relationship.execute(self, allocator, input, options);
    }

    /// Retrieves information about an asset property.
    ///
    /// When you call this operation for an attribute property, this response
    /// includes the
    /// default attribute value that you define in the asset model. If you update
    /// the default value
    /// in the model, this operation's response includes the new default value.
    ///
    /// This operation doesn't return the value of the asset property. To get the
    /// value of an
    /// asset property, use
    /// [GetAssetPropertyValue](https://docs.aws.amazon.com/iot-sitewise/latest/APIReference/API_GetAssetPropertyValue.html).
    pub fn describeAssetProperty(self: *Self, allocator: std.mem.Allocator, input: describe_asset_property.DescribeAssetPropertyInput, options: CallOptions) !describe_asset_property.DescribeAssetPropertyOutput {
        return describe_asset_property.execute(self, allocator, input, options);
    }

    /// Retrieves information about a bulk import job request. For more information,
    /// see [Describe
    /// a bulk import job
    /// (CLI)](https://docs.aws.amazon.com/iot-sitewise/latest/userguide/DescribeBulkImportJob.html) in the *Amazon Simple Storage Service User Guide*.
    pub fn describeBulkImportJob(self: *Self, allocator: std.mem.Allocator, input: describe_bulk_import_job.DescribeBulkImportJobInput, options: CallOptions) !describe_bulk_import_job.DescribeBulkImportJobOutput {
        return describe_bulk_import_job.execute(self, allocator, input, options);
    }

    /// Retrieves information about a computation model.
    pub fn describeComputationModel(self: *Self, allocator: std.mem.Allocator, input: describe_computation_model.DescribeComputationModelInput, options: CallOptions) !describe_computation_model.DescribeComputationModelOutput {
        return describe_computation_model.execute(self, allocator, input, options);
    }

    /// Retrieves information about the execution summary of a computation model.
    pub fn describeComputationModelExecutionSummary(self: *Self, allocator: std.mem.Allocator, input: describe_computation_model_execution_summary.DescribeComputationModelExecutionSummaryInput, options: CallOptions) !describe_computation_model_execution_summary.DescribeComputationModelExecutionSummaryOutput {
        return describe_computation_model_execution_summary.execute(self, allocator, input, options);
    }

    /// Retrieves information about a dashboard.
    pub fn describeDashboard(self: *Self, allocator: std.mem.Allocator, input: describe_dashboard.DescribeDashboardInput, options: CallOptions) !describe_dashboard.DescribeDashboardOutput {
        return describe_dashboard.execute(self, allocator, input, options);
    }

    /// Retrieves information about a dataset.
    pub fn describeDataset(self: *Self, allocator: std.mem.Allocator, input: describe_dataset.DescribeDatasetInput, options: CallOptions) !describe_dataset.DescribeDatasetOutput {
        return describe_dataset.execute(self, allocator, input, options);
    }

    /// Retrieves information about a dataset export job.
    pub fn describeDatasetExportJob(self: *Self, allocator: std.mem.Allocator, input: describe_dataset_export_job.DescribeDatasetExportJobInput, options: CallOptions) !describe_dataset_export_job.DescribeDatasetExportJobOutput {
        return describe_dataset_export_job.execute(self, allocator, input, options);
    }

    /// Retrieves information about the default encryption configuration for the
    /// Amazon Web Services account in
    /// the default or specified Region. For more information, see [Key
    /// management](https://docs.aws.amazon.com/iot-sitewise/latest/userguide/key-management.html) in the
    /// *IoT SiteWise User Guide*.
    pub fn describeDefaultEncryptionConfiguration(self: *Self, allocator: std.mem.Allocator, input: describe_default_encryption_configuration.DescribeDefaultEncryptionConfigurationInput, options: CallOptions) !describe_default_encryption_configuration.DescribeDefaultEncryptionConfigurationOutput {
        return describe_default_encryption_configuration.execute(self, allocator, input, options);
    }

    /// Retrieves detailed information about a specific enrichment job, including
    /// its current status,
    /// configuration, and timestamps.
    /// Use Cases
    ///
    /// * Monitor job progress by checking status updates with DescribeEnrichmentJob
    ///
    /// * Retrieve the complete job configuration submitted during creation
    ///
    /// * Debug failed jobs by examining the failureMessage field
    ///
    /// * Track job lifecycle with creation, update, completion, and cancellation
    ///   timestamps
    ///
    /// Status Monitoring
    ///
    /// Jobs progress through statuses: PENDING → RUNNING → terminal state
    ///
    /// Terminal states:
    ///
    /// * COMPLETED: Job finished successfully; query IoT SiteWise for semantic
    ///   search results
    ///
    /// * FAILED: Job encountered an error; check failureMessage for details
    ///
    /// * TIMED_OUT: Job exceeded maximum processing time
    ///
    /// * CANCELLED: Job was cancelled via CancelEnrichmentJob
    ///
    /// Response Fields
    ///
    /// The response includes:
    ///
    /// * Current job status and type
    ///
    /// * Full job configuration as originally submitted
    ///
    /// * Lifecycle timestamps (created, updated, completed, cancelled)
    ///
    /// * Failure details if status is FAILED
    pub fn describeEnrichmentJob(self: *Self, allocator: std.mem.Allocator, input: describe_enrichment_job.DescribeEnrichmentJobInput, options: CallOptions) !describe_enrichment_job.DescribeEnrichmentJobOutput {
        return describe_enrichment_job.execute(self, allocator, input, options);
    }

    /// Retrieves information about the execution.
    pub fn describeExecution(self: *Self, allocator: std.mem.Allocator, input: describe_execution.DescribeExecutionInput, options: CallOptions) !describe_execution.DescribeExecutionOutput {
        return describe_execution.execute(self, allocator, input, options);
    }

    /// Retrieves information about a gateway.
    pub fn describeGateway(self: *Self, allocator: std.mem.Allocator, input: describe_gateway.DescribeGatewayInput, options: CallOptions) !describe_gateway.DescribeGatewayOutput {
        return describe_gateway.execute(self, allocator, input, options);
    }

    /// Each gateway capability defines data sources for a gateway. This is the
    /// namespace of the gateway capability.
    ///
    /// . The namespace follows the format `service:capability:version`, where:
    ///
    /// * `service` - The service providing the capability, or `iotsitewise`.
    ///
    /// * `capability` - The specific capability type. Options include:
    ///   `opcuacollector` for the OPC UA data source collector, or `publisher` for
    ///   data publisher capability.
    ///
    /// * `version` - The version number of the capability. Option include `2` for
    ///   Classic streams, V2 gateways, and `3` for MQTT-enabled, V3 gateways.
    ///
    /// After updating a capability configuration, the sync status becomes
    /// `OUT_OF_SYNC` until the gateway processes the configuration.Use
    /// `DescribeGatewayCapabilityConfiguration` to check the sync status and verify
    /// the configuration was applied.
    ///
    /// A gateway can have multiple capability configurations with different
    /// namespaces.
    pub fn describeGatewayCapabilityConfiguration(self: *Self, allocator: std.mem.Allocator, input: describe_gateway_capability_configuration.DescribeGatewayCapabilityConfigurationInput, options: CallOptions) !describe_gateway_capability_configuration.DescribeGatewayCapabilityConfigurationOutput {
        return describe_gateway_capability_configuration.execute(self, allocator, input, options);
    }

    /// Retrieves the current IoT SiteWise logging options.
    pub fn describeLoggingOptions(self: *Self, allocator: std.mem.Allocator, input: describe_logging_options.DescribeLoggingOptionsInput, options: CallOptions) !describe_logging_options.DescribeLoggingOptionsOutput {
        return describe_logging_options.execute(self, allocator, input, options);
    }

    /// Retrieves detailed information about a specific pipeline in a workspace.
    pub fn describePipeline(self: *Self, allocator: std.mem.Allocator, input: describe_pipeline.DescribePipelineInput, options: CallOptions) !describe_pipeline.DescribePipelineOutput {
        return describe_pipeline.execute(self, allocator, input, options);
    }

    /// Retrieves detailed information about a specific pipeline execution,
    /// including the
    /// overall execution status and the status of each individual compute node. Use
    /// this
    /// operation to monitor execution progress and inspect per-node results,
    /// environment
    /// variables, and error details.
    pub fn describePipelineExecution(self: *Self, allocator: std.mem.Allocator, input: describe_pipeline_execution.DescribePipelineExecutionInput, options: CallOptions) !describe_pipeline_execution.DescribePipelineExecutionOutput {
        return describe_pipeline_execution.execute(self, allocator, input, options);
    }

    /// Retrieves information about a portal.
    pub fn describePortal(self: *Self, allocator: std.mem.Allocator, input: describe_portal.DescribePortalInput, options: CallOptions) !describe_portal.DescribePortalOutput {
        return describe_portal.execute(self, allocator, input, options);
    }

    /// Retrieves information about a project.
    pub fn describeProject(self: *Self, allocator: std.mem.Allocator, input: describe_project.DescribeProjectInput, options: CallOptions) !describe_project.DescribeProjectOutput {
        return describe_project.execute(self, allocator, input, options);
    }

    /// Retrieves information about a query, including its status.
    pub fn describeQuery(self: *Self, allocator: std.mem.Allocator, input: describe_query.DescribeQueryInput, options: CallOptions) !describe_query.DescribeQueryOutput {
        return describe_query.execute(self, allocator, input, options);
    }

    /// Returns the current status and metadata of a single search, including the
    /// query that was
    /// submitted, the search type, and — when the search has failed — the reason.
    /// Use this to poll a
    /// search started with `StartSearch` until it reaches a terminal status
    /// (`SUCCEEDED` or
    /// `FAILED`).
    pub fn describeSearch(self: *Self, allocator: std.mem.Allocator, input: describe_search.DescribeSearchInput, options: CallOptions) !describe_search.DescribeSearchOutput {
        return describe_search.execute(self, allocator, input, options);
    }

    /// Retrieves information about the storage configuration for IoT SiteWise.
    pub fn describeStorageConfiguration(self: *Self, allocator: std.mem.Allocator, input: describe_storage_configuration.DescribeStorageConfigurationInput, options: CallOptions) !describe_storage_configuration.DescribeStorageConfigurationOutput {
        return describe_storage_configuration.execute(self, allocator, input, options);
    }

    /// Retrieves detailed information about a specific task in a workspace.
    pub fn describeTask(self: *Self, allocator: std.mem.Allocator, input: describe_task.DescribeTaskInput, options: CallOptions) !describe_task.DescribeTaskOutput {
        return describe_task.execute(self, allocator, input, options);
    }

    /// Retrieves information about a time series (data stream).
    ///
    /// To identify a time series, do one of the following:
    ///
    /// * If the time series isn't associated with an asset property,
    /// specify the `alias` of the time series.
    ///
    /// * If the time series is associated with an asset property,
    /// specify one of the following:
    ///
    /// * The `alias` of the time series.
    ///
    /// * The `assetId` and `propertyId` that identifies the asset property.
    pub fn describeTimeSeries(self: *Self, allocator: std.mem.Allocator, input: describe_time_series.DescribeTimeSeriesInput, options: CallOptions) !describe_time_series.DescribeTimeSeriesOutput {
        return describe_time_series.execute(self, allocator, input, options);
    }

    /// Retrieves information about a workspace.
    pub fn describeWorkspace(self: *Self, allocator: std.mem.Allocator, input: describe_workspace.DescribeWorkspaceInput, options: CallOptions) !describe_workspace.DescribeWorkspaceOutput {
        return describe_workspace.execute(self, allocator, input, options);
    }

    /// Disassociates a child asset from the given parent asset through a hierarchy
    /// defined in the
    /// parent asset's model.
    pub fn disassociateAssets(self: *Self, allocator: std.mem.Allocator, input: disassociate_assets.DisassociateAssetsInput, options: CallOptions) !disassociate_assets.DisassociateAssetsOutput {
        return disassociate_assets.execute(self, allocator, input, options);
    }

    /// Disassociates a time series (data stream) from an asset property.
    pub fn disassociateTimeSeriesFromAssetProperty(self: *Self, allocator: std.mem.Allocator, input: disassociate_time_series_from_asset_property.DisassociateTimeSeriesFromAssetPropertyInput, options: CallOptions) !disassociate_time_series_from_asset_property.DisassociateTimeSeriesFromAssetPropertyOutput {
        return disassociate_time_series_from_asset_property.execute(self, allocator, input, options);
    }

    /// Executes an action on a target resource.
    pub fn executeAction(self: *Self, allocator: std.mem.Allocator, input: execute_action.ExecuteActionInput, options: CallOptions) !execute_action.ExecuteActionOutput {
        return execute_action.execute(self, allocator, input, options);
    }

    /// Run SQL queries to retrieve metadata and time-series data from asset models,
    /// assets,
    /// measurements, metrics, transforms, and aggregates.
    pub fn executeQuery(self: *Self, allocator: std.mem.Allocator, input: execute_query.ExecuteQueryInput, options: CallOptions) !execute_query.ExecuteQueryOutput {
        return execute_query.execute(self, allocator, input, options);
    }

    /// Gets aggregated values for an asset property. For more information, see
    /// [Querying
    /// aggregates](https://docs.aws.amazon.com/iot-sitewise/latest/userguide/query-industrial-data.html#aggregates) in the *IoT SiteWise User Guide*.
    ///
    /// To identify an asset property, you must specify one of the following:
    ///
    /// * The `assetId` and `propertyId` of an asset property.
    ///
    /// * A `propertyAlias`, which is a data stream alias (for example,
    /// `/company/windfarm/3/turbine/7/temperature`). To define an asset property's
    /// alias, see
    /// [UpdateAssetProperty](https://docs.aws.amazon.com/iot-sitewise/latest/APIReference/API_UpdateAssetProperty.html).
    pub fn getAssetPropertyAggregates(self: *Self, allocator: std.mem.Allocator, input: get_asset_property_aggregates.GetAssetPropertyAggregatesInput, options: CallOptions) !get_asset_property_aggregates.GetAssetPropertyAggregatesOutput {
        return get_asset_property_aggregates.execute(self, allocator, input, options);
    }

    /// Gets an asset property's current value. For more information, see [Querying
    /// current
    /// values](https://docs.aws.amazon.com/iot-sitewise/latest/userguide/query-industrial-data.html#current-values) in the *IoT SiteWise User Guide*.
    ///
    /// To identify an asset property, you must specify one of the following:
    ///
    /// * The `assetId` and `propertyId` of an asset property.
    ///
    /// * A `propertyAlias`, which is a data stream alias (for example,
    /// `/company/windfarm/3/turbine/7/temperature`). To define an asset property's
    /// alias, see
    /// [UpdateAssetProperty](https://docs.aws.amazon.com/iot-sitewise/latest/APIReference/API_UpdateAssetProperty.html).
    pub fn getAssetPropertyValue(self: *Self, allocator: std.mem.Allocator, input: get_asset_property_value.GetAssetPropertyValueInput, options: CallOptions) !get_asset_property_value.GetAssetPropertyValueOutput {
        return get_asset_property_value.execute(self, allocator, input, options);
    }

    /// Gets the history of an asset property's values. For more information, see
    /// [Querying
    /// historical
    /// values](https://docs.aws.amazon.com/iot-sitewise/latest/userguide/query-industrial-data.html#historical-values) in the *IoT SiteWise User Guide*.
    ///
    /// To identify an asset property, you must specify one of the following:
    ///
    /// * The `assetId` and `propertyId` of an asset property.
    ///
    /// * A `propertyAlias`, which is a data stream alias (for example,
    /// `/company/windfarm/3/turbine/7/temperature`). To define an asset property's
    /// alias, see
    /// [UpdateAssetProperty](https://docs.aws.amazon.com/iot-sitewise/latest/APIReference/API_UpdateAssetProperty.html).
    pub fn getAssetPropertyValueHistory(self: *Self, allocator: std.mem.Allocator, input: get_asset_property_value_history.GetAssetPropertyValueHistoryInput, options: CallOptions) !get_asset_property_value_history.GetAssetPropertyValueHistoryOutput {
        return get_asset_property_value_history.execute(self, allocator, input, options);
    }

    /// Retrieves video data for a specific time range.
    pub fn getCaptureData(self: *Self, allocator: std.mem.Allocator, input: get_capture_data.GetCaptureDataInput, options: CallOptions) !get_capture_data.GetCaptureDataOutput {
        return get_capture_data.execute(self, allocator, input, options);
    }

    /// Get interpolated values for an asset property for a specified time interval,
    /// during a
    /// period of time. If your time series is missing data points during the
    /// specified time interval,
    /// you can use interpolation to estimate the missing data.
    ///
    /// For example, you can use this operation to return the interpolated
    /// temperature values for
    /// a wind turbine every 24 hours over a duration of 7 days.
    ///
    /// To identify an asset property, you must specify one of the following:
    ///
    /// * The `assetId` and `propertyId` of an asset property.
    ///
    /// * A `propertyAlias`, which is a data stream alias (for example,
    /// `/company/windfarm/3/turbine/7/temperature`). To define an asset property's
    /// alias, see
    /// [UpdateAssetProperty](https://docs.aws.amazon.com/iot-sitewise/latest/APIReference/API_UpdateAssetProperty.html).
    pub fn getInterpolatedAssetPropertyValues(self: *Self, allocator: std.mem.Allocator, input: get_interpolated_asset_property_values.GetInterpolatedAssetPropertyValuesInput, options: CallOptions) !get_interpolated_asset_property_values.GetInterpolatedAssetPropertyValuesOutput {
        return get_interpolated_asset_property_values.execute(self, allocator, input, options);
    }

    /// Retrieves the paginated results of a query. Returns empty rows if the query
    /// is not yet complete.
    pub fn getQueryResults(self: *Self, allocator: std.mem.Allocator, input: get_query_results.GetQueryResultsInput, options: CallOptions) !get_query_results.GetQueryResultsOutput {
        return get_query_results.execute(self, allocator, input, options);
    }

    /// Retrieves the ranked results of a search, ordered by descending relevance
    /// score. Results are
    /// available only after the search has reached the `SUCCEEDED` status. Calling
    /// this on a search
    /// that exists but has not yet completed returns `InvalidRequestException`,
    /// while calling it on a
    /// search that does not exist returns `ResourceNotFoundException`. The response
    /// is paginated: when
    /// `nextToken` is present, pass it on a subsequent call to retrieve the next
    /// page.
    pub fn getSearchResults(self: *Self, allocator: std.mem.Allocator, input: get_search_results.GetSearchResultsInput, options: CallOptions) !get_search_results.GetSearchResultsOutput {
        return get_search_results.execute(self, allocator, input, options);
    }

    /// Invokes SiteWise Assistant to start or continue a conversation.
    pub fn invokeAssistant(self: *Self, allocator: std.mem.Allocator, input: invoke_assistant.InvokeAssistantInput, options: CallOptions) !invoke_assistant.InvokeAssistantOutput {
        return invoke_assistant.execute(self, allocator, input, options);
    }

    /// Retrieves a paginated list of access policies for an identity (an IAM
    /// Identity Center user, an IAM Identity Center
    /// group, or an IAM user) or an IoT SiteWise Monitor resource (a portal or
    /// project).
    pub fn listAccessPolicies(self: *Self, allocator: std.mem.Allocator, input: list_access_policies.ListAccessPoliciesInput, options: CallOptions) !list_access_policies.ListAccessPoliciesOutput {
        return list_access_policies.execute(self, allocator, input, options);
    }

    /// Retrieves a paginated list of actions for a specific target resource.
    pub fn listActions(self: *Self, allocator: std.mem.Allocator, input: list_actions.ListActionsInput, options: CallOptions) !list_actions.ListActionsOutput {
        return list_actions.execute(self, allocator, input, options);
    }

    /// Retrieves a paginated list of existing applications
    pub fn listApplications(self: *Self, allocator: std.mem.Allocator, input: list_applications.ListApplicationsInput, options: CallOptions) !list_applications.ListApplicationsOutput {
        return list_applications.execute(self, allocator, input, options);
    }

    /// Retrieves a paginated list of composite models associated with the asset
    /// model
    pub fn listAssetModelCompositeModels(self: *Self, allocator: std.mem.Allocator, input: list_asset_model_composite_models.ListAssetModelCompositeModelsInput, options: CallOptions) !list_asset_model_composite_models.ListAssetModelCompositeModelsOutput {
        return list_asset_model_composite_models.execute(self, allocator, input, options);
    }

    /// Retrieves a paginated list of properties associated with an asset model.
    /// If you update properties associated with the model before you finish listing
    /// all the properties,
    /// you need to start all over again.
    pub fn listAssetModelProperties(self: *Self, allocator: std.mem.Allocator, input: list_asset_model_properties.ListAssetModelPropertiesInput, options: CallOptions) !list_asset_model_properties.ListAssetModelPropertiesOutput {
        return list_asset_model_properties.execute(self, allocator, input, options);
    }

    /// Retrieves a paginated list of summaries of all asset models.
    pub fn listAssetModels(self: *Self, allocator: std.mem.Allocator, input: list_asset_models.ListAssetModelsInput, options: CallOptions) !list_asset_models.ListAssetModelsOutput {
        return list_asset_models.execute(self, allocator, input, options);
    }

    /// Retrieves a paginated list of properties associated with an asset.
    /// If you update properties associated with the model before you finish listing
    /// all the properties,
    /// you need to start all over again.
    pub fn listAssetProperties(self: *Self, allocator: std.mem.Allocator, input: list_asset_properties.ListAssetPropertiesInput, options: CallOptions) !list_asset_properties.ListAssetPropertiesOutput {
        return list_asset_properties.execute(self, allocator, input, options);
    }

    /// Retrieves a paginated list of asset relationships for an asset. You can use
    /// this operation
    /// to identify an asset's root asset and all associated assets between that
    /// asset and its
    /// root.
    pub fn listAssetRelationships(self: *Self, allocator: std.mem.Allocator, input: list_asset_relationships.ListAssetRelationshipsInput, options: CallOptions) !list_asset_relationships.ListAssetRelationshipsOutput {
        return list_asset_relationships.execute(self, allocator, input, options);
    }

    /// Retrieves a paginated list of asset summaries.
    ///
    /// You can use this operation to do the following:
    ///
    /// * List assets based on a specific asset model.
    ///
    /// * List top-level assets.
    ///
    /// You can't use this operation to list all assets. To retrieve summaries for
    /// all of your
    /// assets, use
    /// [ListAssetModels](https://docs.aws.amazon.com/iot-sitewise/latest/APIReference/API_ListAssetModels.html) to get all of your asset model IDs. Then, use ListAssets to get all
    /// assets for each asset model.
    pub fn listAssets(self: *Self, allocator: std.mem.Allocator, input: list_assets.ListAssetsInput, options: CallOptions) !list_assets.ListAssetsOutput {
        return list_assets.execute(self, allocator, input, options);
    }

    /// Retrieves a paginated list of associated assets.
    ///
    /// You can use this operation to do the following:
    ///
    /// * `CHILD` - List all child assets associated to the asset.
    ///
    /// * `PARENT` - List the asset's parent asset.
    pub fn listAssociatedAssets(self: *Self, allocator: std.mem.Allocator, input: list_associated_assets.ListAssociatedAssetsInput, options: CallOptions) !list_associated_assets.ListAssociatedAssetsOutput {
        return list_associated_assets.execute(self, allocator, input, options);
    }

    /// Retrieves a paginated list of bulk import job requests. For more
    /// information, see [List bulk
    /// import jobs
    /// (CLI)](https://docs.aws.amazon.com/iot-sitewise/latest/userguide/ListBulkImportJobs.html) in the *IoT SiteWise User Guide*.
    pub fn listBulkImportJobs(self: *Self, allocator: std.mem.Allocator, input: list_bulk_import_jobs.ListBulkImportJobsInput, options: CallOptions) !list_bulk_import_jobs.ListBulkImportJobsOutput {
        return list_bulk_import_jobs.execute(self, allocator, input, options);
    }

    /// Retrieves a paginated list of composition relationships for an asset model
    /// of type
    /// `COMPONENT_MODEL`.
    pub fn listCompositionRelationships(self: *Self, allocator: std.mem.Allocator, input: list_composition_relationships.ListCompositionRelationshipsInput, options: CallOptions) !list_composition_relationships.ListCompositionRelationshipsOutput {
        return list_composition_relationships.execute(self, allocator, input, options);
    }

    /// Lists all data binding usages for computation models. This allows to
    /// identify where
    /// specific data bindings are being utilized across the computation models.
    /// This track
    /// dependencies between data sources and computation models.
    pub fn listComputationModelDataBindingUsages(self: *Self, allocator: std.mem.Allocator, input: list_computation_model_data_binding_usages.ListComputationModelDataBindingUsagesInput, options: CallOptions) !list_computation_model_data_binding_usages.ListComputationModelDataBindingUsagesOutput {
        return list_computation_model_data_binding_usages.execute(self, allocator, input, options);
    }

    /// Lists all distinct resources that are resolved from the executed actions of
    /// the
    /// computation model.
    pub fn listComputationModelResolveToResources(self: *Self, allocator: std.mem.Allocator, input: list_computation_model_resolve_to_resources.ListComputationModelResolveToResourcesInput, options: CallOptions) !list_computation_model_resolve_to_resources.ListComputationModelResolveToResourcesOutput {
        return list_computation_model_resolve_to_resources.execute(self, allocator, input, options);
    }

    /// Retrieves a paginated list of summaries of all computation models.
    pub fn listComputationModels(self: *Self, allocator: std.mem.Allocator, input: list_computation_models.ListComputationModelsInput, options: CallOptions) !list_computation_models.ListComputationModelsOutput {
        return list_computation_models.execute(self, allocator, input, options);
    }

    /// Retrieves a paginated list of dashboards for an IoT SiteWise Monitor
    /// project.
    pub fn listDashboards(self: *Self, allocator: std.mem.Allocator, input: list_dashboards.ListDashboardsInput, options: CallOptions) !list_dashboards.ListDashboardsOutput {
        return list_dashboards.execute(self, allocator, input, options);
    }

    /// Retrieves a paginated list of data segment relationships for a session
    /// dataset. Use this
    /// operation to find the curated datasets that reference data segments of the
    /// specified session
    /// dataset. Use the `nextToken` parameter to retrieve additional results.
    pub fn listDatasetDataSegmentRelationships(self: *Self, allocator: std.mem.Allocator, input: list_dataset_data_segment_relationships.ListDatasetDataSegmentRelationshipsInput, options: CallOptions) !list_dataset_data_segment_relationships.ListDatasetDataSegmentRelationshipsOutput {
        return list_dataset_data_segment_relationships.execute(self, allocator, input, options);
    }

    /// Retrieves a paginated list of data segments associated with a dataset. Use
    /// the `nextToken` parameter to retrieve additional results.
    pub fn listDatasetDataSegments(self: *Self, allocator: std.mem.Allocator, input: list_dataset_data_segments.ListDatasetDataSegmentsInput, options: CallOptions) !list_dataset_data_segments.ListDatasetDataSegmentsOutput {
        return list_dataset_data_segments.execute(self, allocator, input, options);
    }

    /// Retrieves a paginated list of dataset export jobs for a workspace.
    pub fn listDatasetExportJobs(self: *Self, allocator: std.mem.Allocator, input: list_dataset_export_jobs.ListDatasetExportJobsInput, options: CallOptions) !list_dataset_export_jobs.ListDatasetExportJobsOutput {
        return list_dataset_export_jobs.execute(self, allocator, input, options);
    }

    /// Retrieves a paginated list of datasets for a specific target resource.
    pub fn listDatasets(self: *Self, allocator: std.mem.Allocator, input: list_datasets.ListDatasetsInput, options: CallOptions) !list_datasets.ListDatasetsOutput {
        return list_datasets.execute(self, allocator, input, options);
    }

    /// Lists enrichment jobs within a workspace with optional filtering and
    /// pagination. Results are ordered
    /// by createdAt timestamp descending (newest first).
    /// Filtering
    ///
    /// Combine filters to narrow results:
    ///
    /// * **datasetId**: Filter by dataset
    ///
    /// * **propertyAlias** OR **timeSeriesId**: Filter by time series (specify one,
    ///   not both)
    ///
    /// * **status**: Filter by job status (e.g., RUNNING to find active jobs)
    ///
    /// * **jobType**: Filter by enrichment type (currently only EVENT_DETECTION)
    ///
    /// * **startDate** and **endDate**: Filter by job creation time range
    ///
    /// Important Constraints
    ///
    /// * You must specify either propertyAlias OR timeSeriesId, but not both
    ///
    /// * Attempting to specify both results in an InvalidRequestException
    ///
    /// * Date filters use ISO 8601 format
    ///
    /// * startDate is exclusive, endDate is inclusive
    ///
    /// Pagination
    ///
    /// The operation returns up to maxResults jobs per page (default 50). If more
    /// results exist, the
    /// response includes a nextToken. Submit this token in a subsequent request to
    /// retrieve the next page.
    /// Common Use Cases
    ///
    /// * Find all running jobs: Filter by status=RUNNING
    ///
    /// * List recent jobs for a dataset: Filter by datasetId with optional date
    ///   range
    ///
    /// * Monitor jobs for a specific sensor: Filter by propertyAlias or
    ///   timeSeriesId
    ///
    /// * Track all event detection jobs: Filter by jobType=EVENT_DETECTION
    ///
    /// Performance
    ///
    /// Performance is optimal when filtering by supported fields (datasetId,
    /// propertyAlias, timeSeriesId, status, jobType).
    pub fn listEnrichmentJobs(self: *Self, allocator: std.mem.Allocator, input: list_enrichment_jobs.ListEnrichmentJobsInput, options: CallOptions) !list_enrichment_jobs.ListEnrichmentJobsOutput {
        return list_enrichment_jobs.execute(self, allocator, input, options);
    }

    /// Retrieves a paginated list of summaries of all executions.
    pub fn listExecutions(self: *Self, allocator: std.mem.Allocator, input: list_executions.ListExecutionsInput, options: CallOptions) !list_executions.ListExecutionsOutput {
        return list_executions.execute(self, allocator, input, options);
    }

    /// Retrieves a paginated list of gateways.
    pub fn listGateways(self: *Self, allocator: std.mem.Allocator, input: list_gateways.ListGatewaysInput, options: CallOptions) !list_gateways.ListGatewaysOutput {
        return list_gateways.execute(self, allocator, input, options);
    }

    /// Retrieves a paginated list of asset models that have a specific interface
    /// asset model
    /// applied to them.
    pub fn listInterfaceRelationships(self: *Self, allocator: std.mem.Allocator, input: list_interface_relationships.ListInterfaceRelationshipsInput, options: CallOptions) !list_interface_relationships.ListInterfaceRelationshipsOutput {
        return list_interface_relationships.execute(self, allocator, input, options);
    }

    /// Lists pipeline executions for a specific pipeline in a workspace.
    /// Supports filtering by state and time range. State can be combined with
    /// either
    /// startTime or endTime filters. Time range filters are grouped: use startTime
    /// filters
    /// (startTimeAfter, startTimeBefore) or endTime filters (endTimeAfter,
    /// endTimeBefore),
    /// but not both. Combining startTime and endTime filters returns an
    /// InvalidRequestException.
    /// Note: endTime filters only return executions in terminal states, as
    /// in-progress
    /// executions have no endTime.
    pub fn listPipelineExecutions(self: *Self, allocator: std.mem.Allocator, input: list_pipeline_executions.ListPipelineExecutionsInput, options: CallOptions) !list_pipeline_executions.ListPipelineExecutionsOutput {
        return list_pipeline_executions.execute(self, allocator, input, options);
    }

    /// Lists pipelines in a workspace. To get complete details about a pipeline,
    /// use
    /// [DescribePipeline](https://docs.aws.amazon.com/iot-sitewise/latest/APIReference/API_DescribePipeline.html).
    pub fn listPipelines(self: *Self, allocator: std.mem.Allocator, input: list_pipelines.ListPipelinesInput, options: CallOptions) !list_pipelines.ListPipelinesOutput {
        return list_pipelines.execute(self, allocator, input, options);
    }

    /// Retrieves a paginated list of IoT SiteWise Monitor portals.
    pub fn listPortals(self: *Self, allocator: std.mem.Allocator, input: list_portals.ListPortalsInput, options: CallOptions) !list_portals.ListPortalsOutput {
        return list_portals.execute(self, allocator, input, options);
    }

    /// Retrieves a paginated list of assets associated with an IoT SiteWise Monitor
    /// project.
    pub fn listProjectAssets(self: *Self, allocator: std.mem.Allocator, input: list_project_assets.ListProjectAssetsInput, options: CallOptions) !list_project_assets.ListProjectAssetsOutput {
        return list_project_assets.execute(self, allocator, input, options);
    }

    /// Retrieves a paginated list of projects for an IoT SiteWise Monitor portal.
    pub fn listProjects(self: *Self, allocator: std.mem.Allocator, input: list_projects.ListProjectsInput, options: CallOptions) !list_projects.ListProjectsOutput {
        return list_projects.execute(self, allocator, input, options);
    }

    /// Retrieves a paginated list of queries for a workspace.
    pub fn listQueries(self: *Self, allocator: std.mem.Allocator, input: list_queries.ListQueriesInput, options: CallOptions) !list_queries.ListQueriesOutput {
        return list_queries.execute(self, allocator, input, options);
    }

    /// Lists the searches in a workspace, most recently started first. Results can
    /// be narrowed with
    /// optional filters (status, search type, group, and started-at time range) and
    /// are paginated: when
    /// `nextToken` is present, pass it on a subsequent call to retrieve the next
    /// page.
    pub fn listSearches(self: *Self, allocator: std.mem.Allocator, input: list_searches.ListSearchesInput, options: CallOptions) !list_searches.ListSearchesOutput {
        return list_searches.execute(self, allocator, input, options);
    }

    /// Retrieves the list of tags for an IoT SiteWise resource.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: CallOptions) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Lists tasks in a workspace. To get complete details about a task, use
    /// [DescribeTask](https://docs.aws.amazon.com/iot-sitewise/latest/APIReference/API_DescribeTask.html).
    pub fn listTasks(self: *Self, allocator: std.mem.Allocator, input: list_tasks.ListTasksInput, options: CallOptions) !list_tasks.ListTasksOutput {
        return list_tasks.execute(self, allocator, input, options);
    }

    /// Retrieves a paginated list of time series (data streams).
    pub fn listTimeSeries(self: *Self, allocator: std.mem.Allocator, input: list_time_series.ListTimeSeriesInput, options: CallOptions) !list_time_series.ListTimeSeriesOutput {
        return list_time_series.execute(self, allocator, input, options);
    }

    /// Retrieves a paginated list of workspaces. Use the `nextToken` parameter to
    /// retrieve additional results.
    pub fn listWorkspaces(self: *Self, allocator: std.mem.Allocator, input: list_workspaces.ListWorkspacesInput, options: CallOptions) !list_workspaces.ListWorkspacesOutput {
        return list_workspaces.execute(self, allocator, input, options);
    }

    /// Creates or updates an interface relationship between an asset model and an
    /// interface asset
    /// model. This operation applies an interface to an asset model.
    pub fn putAssetModelInterfaceRelationship(self: *Self, allocator: std.mem.Allocator, input: put_asset_model_interface_relationship.PutAssetModelInterfaceRelationshipInput, options: CallOptions) !put_asset_model_interface_relationship.PutAssetModelInterfaceRelationshipOutput {
        return put_asset_model_interface_relationship.execute(self, allocator, input, options);
    }

    /// Sets the default encryption configuration for the Amazon Web Services
    /// account. For more information, see
    /// [Key
    /// management](https://docs.aws.amazon.com/iot-sitewise/latest/userguide/key-management.html) in
    /// the *IoT SiteWise User Guide*.
    pub fn putDefaultEncryptionConfiguration(self: *Self, allocator: std.mem.Allocator, input: put_default_encryption_configuration.PutDefaultEncryptionConfigurationInput, options: CallOptions) !put_default_encryption_configuration.PutDefaultEncryptionConfigurationOutput {
        return put_default_encryption_configuration.execute(self, allocator, input, options);
    }

    /// Sets logging options for IoT SiteWise.
    pub fn putLoggingOptions(self: *Self, allocator: std.mem.Allocator, input: put_logging_options.PutLoggingOptionsInput, options: CallOptions) !put_logging_options.PutLoggingOptionsOutput {
        return put_logging_options.execute(self, allocator, input, options);
    }

    /// Configures storage settings for IoT SiteWise.
    pub fn putStorageConfiguration(self: *Self, allocator: std.mem.Allocator, input: put_storage_configuration.PutStorageConfigurationInput, options: CallOptions) !put_storage_configuration.PutStorageConfigurationOutput {
        return put_storage_configuration.execute(self, allocator, input, options);
    }

    /// Starts execution of a pipeline in the specified workspace. Each compute node
    /// runs
    /// according to the DAG dependency order defined in the pipeline. Nodes without
    /// dependencies start immediately, while dependent nodes wait for all upstream
    /// nodes
    /// to complete successfully.
    ///
    /// You can provide runtime environment variable overrides that take the highest
    /// priority
    /// in the environment variable hierarchy, without modifying the pipeline
    /// definition.
    pub fn startPipelineExecution(self: *Self, allocator: std.mem.Allocator, input: start_pipeline_execution.StartPipelineExecutionInput, options: CallOptions) !start_pipeline_execution.StartPipelineExecutionOutput {
        return start_pipeline_execution.execute(self, allocator, input, options);
    }

    /// Starts an asynchronous SQL query against workspace telemetry, annotations,
    /// data segment, and dataset data.
    pub fn startQuery(self: *Self, allocator: std.mem.Allocator, input: start_query.StartQueryInput, options: CallOptions) !start_query.StartQueryOutput {
        return start_query.execute(self, allocator, input, options);
    }

    /// Starts an asynchronous search over the data in a workspace. The search runs
    /// in the background;
    /// the response returns immediately with a `searchId` and an initial status of
    /// `QUEUED`. Use
    /// `DescribeSearch` to poll for completion and `GetSearchResults` to retrieve
    /// the results once the
    /// search reaches `SUCCEEDED`. The request is idempotent on `clientToken`:
    /// repeating a call with the
    /// same token returns the original search instead of starting a new one.
    pub fn startSearch(self: *Self, allocator: std.mem.Allocator, input: start_search.StartSearchInput, options: CallOptions) !start_search.StartSearchOutput {
        return start_search.execute(self, allocator, input, options);
    }

    /// Adds tags to an IoT SiteWise resource. If a tag already exists for the
    /// resource, this operation
    /// updates the tag's value.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: CallOptions) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Removes a tag from an IoT SiteWise resource.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: CallOptions) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// The IoT SiteWise Monitor feature will no longer be open to new
    /// customers starting November 7, 2025. If you would like to use the IoT
    /// SiteWise Monitor feature, sign up prior to that date. Existing customers can
    /// continue to use the service as normal. For more information, see
    /// [IoT SiteWise Monitor availability
    /// change](https://docs.aws.amazon.com/iot-sitewise/latest/appguide/iotsitewise-monitor-availability-change.html).
    ///
    /// Updates an existing access policy that specifies an identity's access to an
    /// IoT SiteWise Monitor
    /// portal or project resource.
    pub fn updateAccessPolicy(self: *Self, allocator: std.mem.Allocator, input: update_access_policy.UpdateAccessPolicyInput, options: CallOptions) !update_access_policy.UpdateAccessPolicyOutput {
        return update_access_policy.execute(self, allocator, input, options);
    }

    /// Updates an asset's name. For more information, see [Updating assets and
    /// models](https://docs.aws.amazon.com/iot-sitewise/latest/userguide/update-assets-and-models.html) in the
    /// *IoT SiteWise User Guide*.
    pub fn updateAsset(self: *Self, allocator: std.mem.Allocator, input: update_asset.UpdateAssetInput, options: CallOptions) !update_asset.UpdateAssetOutput {
        return update_asset.execute(self, allocator, input, options);
    }

    /// Updates an asset model and all of the assets that were created from the
    /// model. Each asset
    /// created from the model inherits the updated asset model's property and
    /// hierarchy definitions.
    /// For more information, see [Updating assets and
    /// models](https://docs.aws.amazon.com/iot-sitewise/latest/userguide/update-assets-and-models.html) in the
    /// *IoT SiteWise User Guide*.
    ///
    /// If you remove a property from an asset model, IoT SiteWise deletes all
    /// previous data for that
    /// property. You can’t change the type or data type of an existing property.
    ///
    /// To replace an existing asset model property with a new one with the same
    /// `name`, do the following:
    ///
    /// * Submit an `UpdateAssetModel` request with the entire existing property
    /// removed.
    ///
    /// * Submit a second `UpdateAssetModel` request that includes the new
    /// property. The new asset property will have the same `name` as the previous
    /// one and IoT SiteWise will generate a new unique `id`.
    pub fn updateAssetModel(self: *Self, allocator: std.mem.Allocator, input: update_asset_model.UpdateAssetModelInput, options: CallOptions) !update_asset_model.UpdateAssetModelOutput {
        return update_asset_model.execute(self, allocator, input, options);
    }

    /// Updates a composite model and all of the assets that were created from the
    /// model. Each
    /// asset created from the model inherits the updated asset model's property and
    /// hierarchy
    /// definitions. For more information, see [Updating assets and
    /// models](https://docs.aws.amazon.com/iot-sitewise/latest/userguide/update-assets-and-models.html) in the
    /// *IoT SiteWise User Guide*.
    ///
    /// If you remove a property from a composite asset model, IoT SiteWise deletes
    /// all previous data
    /// for that property. You can’t change the type or data type of an existing
    /// property.
    ///
    /// To replace an existing composite asset model property with a new one with
    /// the same
    /// `name`, do the following:
    ///
    /// * Submit an `UpdateAssetModelCompositeModel` request with the entire
    /// existing property removed.
    ///
    /// * Submit a second `UpdateAssetModelCompositeModel` request that includes
    /// the new property. The new asset property will have the same `name` as the
    /// previous one and IoT SiteWise will generate a new unique `id`.
    pub fn updateAssetModelCompositeModel(self: *Self, allocator: std.mem.Allocator, input: update_asset_model_composite_model.UpdateAssetModelCompositeModelInput, options: CallOptions) !update_asset_model_composite_model.UpdateAssetModelCompositeModelOutput {
        return update_asset_model_composite_model.execute(self, allocator, input, options);
    }

    /// Updates an asset property's alias and notification state.
    ///
    /// This operation overwrites the property's existing alias and notification
    /// state. To keep
    /// your existing property's alias or notification state, you must include the
    /// existing values
    /// in the UpdateAssetProperty request. For more information, see
    /// [DescribeAssetProperty](https://docs.aws.amazon.com/iot-sitewise/latest/APIReference/API_DescribeAssetProperty.html).
    pub fn updateAssetProperty(self: *Self, allocator: std.mem.Allocator, input: update_asset_property.UpdateAssetPropertyInput, options: CallOptions) !update_asset_property.UpdateAssetPropertyOutput {
        return update_asset_property.execute(self, allocator, input, options);
    }

    /// Updates the computation model.
    pub fn updateComputationModel(self: *Self, allocator: std.mem.Allocator, input: update_computation_model.UpdateComputationModelInput, options: CallOptions) !update_computation_model.UpdateComputationModelOutput {
        return update_computation_model.execute(self, allocator, input, options);
    }

    /// The IoT SiteWise Monitor feature will no longer be open to new
    /// customers starting November 7, 2025. If you would like to use the IoT
    /// SiteWise Monitor feature, sign up prior to that date. Existing customers can
    /// continue to use the service as normal. For more information, see
    /// [IoT SiteWise Monitor availability
    /// change](https://docs.aws.amazon.com/iot-sitewise/latest/appguide/iotsitewise-monitor-availability-change.html).
    ///
    /// Updates an IoT SiteWise Monitor dashboard.
    pub fn updateDashboard(self: *Self, allocator: std.mem.Allocator, input: update_dashboard.UpdateDashboardInput, options: CallOptions) !update_dashboard.UpdateDashboardOutput {
        return update_dashboard.execute(self, allocator, input, options);
    }

    /// Updates a dataset.
    pub fn updateDataset(self: *Self, allocator: std.mem.Allocator, input: update_dataset.UpdateDatasetInput, options: CallOptions) !update_dataset.UpdateDatasetOutput {
        return update_dataset.execute(self, allocator, input, options);
    }

    /// Updates a gateway's name.
    pub fn updateGateway(self: *Self, allocator: std.mem.Allocator, input: update_gateway.UpdateGatewayInput, options: CallOptions) !update_gateway.UpdateGatewayOutput {
        return update_gateway.execute(self, allocator, input, options);
    }

    /// Updates a gateway capability configuration or defines a new capability
    /// configuration. Each gateway capability defines data sources for a gateway.
    ///
    /// Important workflow notes:
    ///
    /// Each gateway capability defines data sources for a gateway. This is the
    /// namespace of the gateway capability.
    ///
    /// . The namespace follows the format `service:capability:version`, where:
    ///
    /// * `service` - The service providing the capability, or `iotsitewise`.
    ///
    /// * `capability` - The specific capability type. Options include:
    ///   `opcuacollector` for the OPC UA data source collector, or `publisher` for
    ///   data publisher capability.
    ///
    /// * `version` - The version number of the capability. Option include `2` for
    ///   Classic streams, V2 gateways, and `3` for MQTT-enabled, V3 gateways.
    ///
    /// After updating a capability configuration, the sync status becomes
    /// `OUT_OF_SYNC` until the gateway processes the configuration.Use
    /// `DescribeGatewayCapabilityConfiguration` to check the sync status and verify
    /// the configuration was applied.
    ///
    /// A gateway can have multiple capability configurations with different
    /// namespaces.
    pub fn updateGatewayCapabilityConfiguration(self: *Self, allocator: std.mem.Allocator, input: update_gateway_capability_configuration.UpdateGatewayCapabilityConfigurationInput, options: CallOptions) !update_gateway_capability_configuration.UpdateGatewayCapabilityConfigurationOutput {
        return update_gateway_capability_configuration.execute(self, allocator, input, options);
    }

    /// Updates an existing pipeline in the specified workspace. Only the fields
    /// provided in the request are updated; fields not included in the request are
    /// preserved
    /// unchanged. You can update the pipeline description, environment variables,
    /// and the
    /// list of compute nodes independently.
    pub fn updatePipeline(self: *Self, allocator: std.mem.Allocator, input: update_pipeline.UpdatePipelineInput, options: CallOptions) !update_pipeline.UpdatePipelineOutput {
        return update_pipeline.execute(self, allocator, input, options);
    }

    /// The IoT SiteWise Monitor feature will no longer be open to new
    /// customers starting November 7, 2025. If you would like to use the IoT
    /// SiteWise Monitor feature, sign up prior to that date. Existing customers can
    /// continue to use the service as normal. For more information, see
    /// [IoT SiteWise Monitor availability
    /// change](https://docs.aws.amazon.com/iot-sitewise/latest/appguide/iotsitewise-monitor-availability-change.html).
    ///
    /// Updates an IoT SiteWise Monitor portal.
    pub fn updatePortal(self: *Self, allocator: std.mem.Allocator, input: update_portal.UpdatePortalInput, options: CallOptions) !update_portal.UpdatePortalOutput {
        return update_portal.execute(self, allocator, input, options);
    }

    /// The IoT SiteWise Monitor feature will no longer be open to new
    /// customers starting November 7, 2025. If you would like to use the IoT
    /// SiteWise Monitor feature, sign up prior to that date. Existing customers can
    /// continue to use the service as normal. For more information, see
    /// [IoT SiteWise Monitor availability
    /// change](https://docs.aws.amazon.com/iot-sitewise/latest/appguide/iotsitewise-monitor-availability-change.html).
    ///
    /// Updates an IoT SiteWise Monitor project.
    pub fn updateProject(self: *Self, allocator: std.mem.Allocator, input: update_project.UpdateProjectInput, options: CallOptions) !update_project.UpdateProjectOutput {
        return update_project.execute(self, allocator, input, options);
    }

    /// Updates an existing task in the specified workspace. Only the fields
    /// provided in the request are updated; fields not included in the request are
    /// preserved
    /// unchanged.
    pub fn updateTask(self: *Self, allocator: std.mem.Allocator, input: update_task.UpdateTaskInput, options: CallOptions) !update_task.UpdateTaskOutput {
        return update_task.execute(self, allocator, input, options);
    }

    /// Updates a workspace. You can update only workspaces in the `ACTIVE` or
    /// `FAILED` state. Fields that you omit from the request are left unchanged. To
    /// recover a workspace in the `FAILED` state, call this operation and supply
    /// its
    /// encryption configuration again.
    pub fn updateWorkspace(self: *Self, allocator: std.mem.Allocator, input: update_workspace.UpdateWorkspaceInput, options: CallOptions) !update_workspace.UpdateWorkspaceOutput {
        return update_workspace.execute(self, allocator, input, options);
    }

    pub fn batchGetAssetPropertyAggregatesPaginator(self: *Self, params: batch_get_asset_property_aggregates.BatchGetAssetPropertyAggregatesInput) paginator.BatchGetAssetPropertyAggregatesPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn batchGetAssetPropertyValuePaginator(self: *Self, params: batch_get_asset_property_value.BatchGetAssetPropertyValueInput) paginator.BatchGetAssetPropertyValuePaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn batchGetAssetPropertyValueHistoryPaginator(self: *Self, params: batch_get_asset_property_value_history.BatchGetAssetPropertyValueHistoryInput) paginator.BatchGetAssetPropertyValueHistoryPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn describePipelineExecutionPaginator(self: *Self, params: describe_pipeline_execution.DescribePipelineExecutionInput) paginator.DescribePipelineExecutionPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn executeQueryPaginator(self: *Self, params: execute_query.ExecuteQueryInput) paginator.ExecuteQueryPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn getAssetPropertyAggregatesPaginator(self: *Self, params: get_asset_property_aggregates.GetAssetPropertyAggregatesInput) paginator.GetAssetPropertyAggregatesPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn getAssetPropertyValueHistoryPaginator(self: *Self, params: get_asset_property_value_history.GetAssetPropertyValueHistoryInput) paginator.GetAssetPropertyValueHistoryPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn getInterpolatedAssetPropertyValuesPaginator(self: *Self, params: get_interpolated_asset_property_values.GetInterpolatedAssetPropertyValuesInput) paginator.GetInterpolatedAssetPropertyValuesPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn getQueryResultsPaginator(self: *Self, params: get_query_results.GetQueryResultsInput) paginator.GetQueryResultsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn getSearchResultsPaginator(self: *Self, params: get_search_results.GetSearchResultsInput) paginator.GetSearchResultsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listAccessPoliciesPaginator(self: *Self, params: list_access_policies.ListAccessPoliciesInput) paginator.ListAccessPoliciesPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listActionsPaginator(self: *Self, params: list_actions.ListActionsInput) paginator.ListActionsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listApplicationsPaginator(self: *Self, params: list_applications.ListApplicationsInput) paginator.ListApplicationsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listAssetModelCompositeModelsPaginator(self: *Self, params: list_asset_model_composite_models.ListAssetModelCompositeModelsInput) paginator.ListAssetModelCompositeModelsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listAssetModelPropertiesPaginator(self: *Self, params: list_asset_model_properties.ListAssetModelPropertiesInput) paginator.ListAssetModelPropertiesPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listAssetModelsPaginator(self: *Self, params: list_asset_models.ListAssetModelsInput) paginator.ListAssetModelsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listAssetPropertiesPaginator(self: *Self, params: list_asset_properties.ListAssetPropertiesInput) paginator.ListAssetPropertiesPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listAssetRelationshipsPaginator(self: *Self, params: list_asset_relationships.ListAssetRelationshipsInput) paginator.ListAssetRelationshipsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listAssetsPaginator(self: *Self, params: list_assets.ListAssetsInput) paginator.ListAssetsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listAssociatedAssetsPaginator(self: *Self, params: list_associated_assets.ListAssociatedAssetsInput) paginator.ListAssociatedAssetsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listBulkImportJobsPaginator(self: *Self, params: list_bulk_import_jobs.ListBulkImportJobsInput) paginator.ListBulkImportJobsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listCompositionRelationshipsPaginator(self: *Self, params: list_composition_relationships.ListCompositionRelationshipsInput) paginator.ListCompositionRelationshipsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listComputationModelDataBindingUsagesPaginator(self: *Self, params: list_computation_model_data_binding_usages.ListComputationModelDataBindingUsagesInput) paginator.ListComputationModelDataBindingUsagesPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listComputationModelResolveToResourcesPaginator(self: *Self, params: list_computation_model_resolve_to_resources.ListComputationModelResolveToResourcesInput) paginator.ListComputationModelResolveToResourcesPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listComputationModelsPaginator(self: *Self, params: list_computation_models.ListComputationModelsInput) paginator.ListComputationModelsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listDashboardsPaginator(self: *Self, params: list_dashboards.ListDashboardsInput) paginator.ListDashboardsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listDatasetDataSegmentRelationshipsPaginator(self: *Self, params: list_dataset_data_segment_relationships.ListDatasetDataSegmentRelationshipsInput) paginator.ListDatasetDataSegmentRelationshipsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listDatasetDataSegmentsPaginator(self: *Self, params: list_dataset_data_segments.ListDatasetDataSegmentsInput) paginator.ListDatasetDataSegmentsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listDatasetExportJobsPaginator(self: *Self, params: list_dataset_export_jobs.ListDatasetExportJobsInput) paginator.ListDatasetExportJobsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listDatasetsPaginator(self: *Self, params: list_datasets.ListDatasetsInput) paginator.ListDatasetsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listEnrichmentJobsPaginator(self: *Self, params: list_enrichment_jobs.ListEnrichmentJobsInput) paginator.ListEnrichmentJobsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listExecutionsPaginator(self: *Self, params: list_executions.ListExecutionsInput) paginator.ListExecutionsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listGatewaysPaginator(self: *Self, params: list_gateways.ListGatewaysInput) paginator.ListGatewaysPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listInterfaceRelationshipsPaginator(self: *Self, params: list_interface_relationships.ListInterfaceRelationshipsInput) paginator.ListInterfaceRelationshipsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listPipelineExecutionsPaginator(self: *Self, params: list_pipeline_executions.ListPipelineExecutionsInput) paginator.ListPipelineExecutionsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listPipelinesPaginator(self: *Self, params: list_pipelines.ListPipelinesInput) paginator.ListPipelinesPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listPortalsPaginator(self: *Self, params: list_portals.ListPortalsInput) paginator.ListPortalsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listProjectAssetsPaginator(self: *Self, params: list_project_assets.ListProjectAssetsInput) paginator.ListProjectAssetsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listProjectsPaginator(self: *Self, params: list_projects.ListProjectsInput) paginator.ListProjectsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listQueriesPaginator(self: *Self, params: list_queries.ListQueriesInput) paginator.ListQueriesPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listSearchesPaginator(self: *Self, params: list_searches.ListSearchesInput) paginator.ListSearchesPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listTasksPaginator(self: *Self, params: list_tasks.ListTasksInput) paginator.ListTasksPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listTimeSeriesPaginator(self: *Self, params: list_time_series.ListTimeSeriesInput) paginator.ListTimeSeriesPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listWorkspacesPaginator(self: *Self, params: list_workspaces.ListWorkspacesInput) paginator.ListWorkspacesPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn waitUntilAssetActive(self: *Self, params: describe_asset.DescribeAssetInput) aws.waiter.WaiterError!void {
        var w = waiters.AssetActiveWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilAssetModelActive(self: *Self, params: describe_asset_model.DescribeAssetModelInput) aws.waiter.WaiterError!void {
        var w = waiters.AssetModelActiveWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilAssetModelNotExists(self: *Self, params: describe_asset_model.DescribeAssetModelInput) aws.waiter.WaiterError!void {
        var w = waiters.AssetModelNotExistsWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilAssetNotExists(self: *Self, params: describe_asset.DescribeAssetInput) aws.waiter.WaiterError!void {
        var w = waiters.AssetNotExistsWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilPortalActive(self: *Self, params: describe_portal.DescribePortalInput) aws.waiter.WaiterError!void {
        var w = waiters.PortalActiveWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilPortalNotExists(self: *Self, params: describe_portal.DescribePortalInput) aws.waiter.WaiterError!void {
        var w = waiters.PortalNotExistsWaiter{ .client = self, .params = params };
        return w.wait();
    }
};
