const aws = @import("aws");
const std = @import("std");

const create_pipeline = @import("create_pipeline.zig");
const create_pipeline_endpoint = @import("create_pipeline_endpoint.zig");
const delete_pipeline = @import("delete_pipeline.zig");
const delete_pipeline_endpoint = @import("delete_pipeline_endpoint.zig");
const delete_resource_policy = @import("delete_resource_policy.zig");
const get_pipeline = @import("get_pipeline.zig");
const get_pipeline_blueprint = @import("get_pipeline_blueprint.zig");
const get_pipeline_change_progress = @import("get_pipeline_change_progress.zig");
const get_resource_policy = @import("get_resource_policy.zig");
const list_pipeline_blueprints = @import("list_pipeline_blueprints.zig");
const list_pipeline_endpoint_connections = @import("list_pipeline_endpoint_connections.zig");
const list_pipeline_endpoints = @import("list_pipeline_endpoints.zig");
const list_pipelines = @import("list_pipelines.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const put_resource_policy = @import("put_resource_policy.zig");
const revoke_pipeline_endpoint_connections = @import("revoke_pipeline_endpoint_connections.zig");
const start_pipeline = @import("start_pipeline.zig");
const stop_pipeline = @import("stop_pipeline.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_pipeline = @import("update_pipeline.zig");
const validate_pipeline = @import("validate_pipeline.zig");
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "OSIS";

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

    /// Creates an OpenSearch Ingestion pipeline. For more information, see
    /// [Creating Amazon OpenSearch
    /// Ingestion
    /// pipelines](https://docs.aws.amazon.com/opensearch-service/latest/developerguide/creating-pipeline.html).
    pub fn createPipeline(self: *Self, allocator: std.mem.Allocator, input: create_pipeline.CreatePipelineInput, options: create_pipeline.Options) !create_pipeline.CreatePipelineOutput {
        return create_pipeline.execute(self, allocator, input, options);
    }

    /// Creates a VPC endpoint for an OpenSearch Ingestion pipeline. Pipeline
    /// endpoints allow you to
    /// ingest data from your VPC into pipelines that you have access to.
    pub fn createPipelineEndpoint(self: *Self, allocator: std.mem.Allocator, input: create_pipeline_endpoint.CreatePipelineEndpointInput, options: create_pipeline_endpoint.Options) !create_pipeline_endpoint.CreatePipelineEndpointOutput {
        return create_pipeline_endpoint.execute(self, allocator, input, options);
    }

    /// Deletes an OpenSearch Ingestion pipeline. For more information, see
    /// [Deleting Amazon OpenSearch
    /// Ingestion
    /// pipelines](https://docs.aws.amazon.com/opensearch-service/latest/developerguide/delete-pipeline.html).
    pub fn deletePipeline(self: *Self, allocator: std.mem.Allocator, input: delete_pipeline.DeletePipelineInput, options: delete_pipeline.Options) !delete_pipeline.DeletePipelineOutput {
        return delete_pipeline.execute(self, allocator, input, options);
    }

    /// Deletes a VPC endpoint for an OpenSearch Ingestion pipeline.
    pub fn deletePipelineEndpoint(self: *Self, allocator: std.mem.Allocator, input: delete_pipeline_endpoint.DeletePipelineEndpointInput, options: delete_pipeline_endpoint.Options) !delete_pipeline_endpoint.DeletePipelineEndpointOutput {
        return delete_pipeline_endpoint.execute(self, allocator, input, options);
    }

    /// Deletes a resource-based policy from an OpenSearch Ingestion resource.
    pub fn deleteResourcePolicy(self: *Self, allocator: std.mem.Allocator, input: delete_resource_policy.DeleteResourcePolicyInput, options: delete_resource_policy.Options) !delete_resource_policy.DeleteResourcePolicyOutput {
        return delete_resource_policy.execute(self, allocator, input, options);
    }

    /// Retrieves information about an OpenSearch Ingestion pipeline.
    pub fn getPipeline(self: *Self, allocator: std.mem.Allocator, input: get_pipeline.GetPipelineInput, options: get_pipeline.Options) !get_pipeline.GetPipelineOutput {
        return get_pipeline.execute(self, allocator, input, options);
    }

    /// Retrieves information about a specific blueprint for OpenSearch Ingestion.
    /// Blueprints are
    /// templates for the configuration needed for a `CreatePipeline` request. For
    /// more
    /// information, see [Using
    /// blueprints to create a
    /// pipeline](https://docs.aws.amazon.com/opensearch-service/latest/developerguide/creating-pipeline.html#pipeline-blueprint).
    pub fn getPipelineBlueprint(self: *Self, allocator: std.mem.Allocator, input: get_pipeline_blueprint.GetPipelineBlueprintInput, options: get_pipeline_blueprint.Options) !get_pipeline_blueprint.GetPipelineBlueprintOutput {
        return get_pipeline_blueprint.execute(self, allocator, input, options);
    }

    /// Returns progress information for the current change happening on an
    /// OpenSearch Ingestion
    /// pipeline. Currently, this operation only returns information when a pipeline
    /// is being
    /// created.
    ///
    /// For more information, see [Tracking the status of pipeline
    /// creation](https://docs.aws.amazon.com/opensearch-service/latest/developerguide/creating-pipeline.html#get-pipeline-progress).
    pub fn getPipelineChangeProgress(self: *Self, allocator: std.mem.Allocator, input: get_pipeline_change_progress.GetPipelineChangeProgressInput, options: get_pipeline_change_progress.Options) !get_pipeline_change_progress.GetPipelineChangeProgressOutput {
        return get_pipeline_change_progress.execute(self, allocator, input, options);
    }

    /// Retrieves the resource-based policy attached to an OpenSearch Ingestion
    /// resource.
    pub fn getResourcePolicy(self: *Self, allocator: std.mem.Allocator, input: get_resource_policy.GetResourcePolicyInput, options: get_resource_policy.Options) !get_resource_policy.GetResourcePolicyOutput {
        return get_resource_policy.execute(self, allocator, input, options);
    }

    /// Retrieves a list of all available blueprints for Data Prepper. For more
    /// information, see
    /// [Using
    /// blueprints to create a
    /// pipeline](https://docs.aws.amazon.com/opensearch-service/latest/developerguide/creating-pipeline.html#pipeline-blueprint).
    pub fn listPipelineBlueprints(self: *Self, allocator: std.mem.Allocator, input: list_pipeline_blueprints.ListPipelineBlueprintsInput, options: list_pipeline_blueprints.Options) !list_pipeline_blueprints.ListPipelineBlueprintsOutput {
        return list_pipeline_blueprints.execute(self, allocator, input, options);
    }

    /// Lists the pipeline endpoints connected to pipelines in your account.
    pub fn listPipelineEndpointConnections(self: *Self, allocator: std.mem.Allocator, input: list_pipeline_endpoint_connections.ListPipelineEndpointConnectionsInput, options: list_pipeline_endpoint_connections.Options) !list_pipeline_endpoint_connections.ListPipelineEndpointConnectionsOutput {
        return list_pipeline_endpoint_connections.execute(self, allocator, input, options);
    }

    /// Lists all pipeline endpoints in your account.
    pub fn listPipelineEndpoints(self: *Self, allocator: std.mem.Allocator, input: list_pipeline_endpoints.ListPipelineEndpointsInput, options: list_pipeline_endpoints.Options) !list_pipeline_endpoints.ListPipelineEndpointsOutput {
        return list_pipeline_endpoints.execute(self, allocator, input, options);
    }

    /// Lists all OpenSearch Ingestion pipelines in the current Amazon Web Services
    /// account and Region.
    /// For more information, see [Viewing Amazon OpenSearch
    /// Ingestion
    /// pipelines](https://docs.aws.amazon.com/opensearch-service/latest/developerguide/list-pipeline.html).
    pub fn listPipelines(self: *Self, allocator: std.mem.Allocator, input: list_pipelines.ListPipelinesInput, options: list_pipelines.Options) !list_pipelines.ListPipelinesOutput {
        return list_pipelines.execute(self, allocator, input, options);
    }

    /// Lists all resource tags associated with an OpenSearch Ingestion pipeline.
    /// For more information,
    /// see [Tagging Amazon OpenSearch Ingestion
    /// pipelines](https://docs.aws.amazon.com/opensearch-service/latest/developerguide/tag-pipeline.html).
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: list_tags_for_resource.Options) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Attaches a resource-based policy to an OpenSearch Ingestion resource.
    /// Resource-based
    /// policies grant permissions to principals to perform actions on the resource.
    pub fn putResourcePolicy(self: *Self, allocator: std.mem.Allocator, input: put_resource_policy.PutResourcePolicyInput, options: put_resource_policy.Options) !put_resource_policy.PutResourcePolicyOutput {
        return put_resource_policy.execute(self, allocator, input, options);
    }

    /// Revokes pipeline endpoints from specified endpoint IDs.
    pub fn revokePipelineEndpointConnections(self: *Self, allocator: std.mem.Allocator, input: revoke_pipeline_endpoint_connections.RevokePipelineEndpointConnectionsInput, options: revoke_pipeline_endpoint_connections.Options) !revoke_pipeline_endpoint_connections.RevokePipelineEndpointConnectionsOutput {
        return revoke_pipeline_endpoint_connections.execute(self, allocator, input, options);
    }

    /// Starts an OpenSearch Ingestion pipeline. For more information, see [Starting
    /// an OpenSearch Ingestion
    /// pipeline](https://docs.aws.amazon.com/opensearch-service/latest/developerguide/pipeline--stop-start.html#pipeline--start).
    pub fn startPipeline(self: *Self, allocator: std.mem.Allocator, input: start_pipeline.StartPipelineInput, options: start_pipeline.Options) !start_pipeline.StartPipelineOutput {
        return start_pipeline.execute(self, allocator, input, options);
    }

    /// Stops an OpenSearch Ingestion pipeline. For more information, see [Stopping
    /// an OpenSearch Ingestion
    /// pipeline](https://docs.aws.amazon.com/opensearch-service/latest/developerguide/pipeline--stop-start.html#pipeline--stop).
    pub fn stopPipeline(self: *Self, allocator: std.mem.Allocator, input: stop_pipeline.StopPipelineInput, options: stop_pipeline.Options) !stop_pipeline.StopPipelineOutput {
        return stop_pipeline.execute(self, allocator, input, options);
    }

    /// Tags an OpenSearch Ingestion pipeline. For more information, see [Tagging
    /// Amazon OpenSearch
    /// Ingestion
    /// pipelines](https://docs.aws.amazon.com/opensearch-service/latest/developerguide/tag-pipeline.html).
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: tag_resource.Options) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Removes one or more tags from an OpenSearch Ingestion pipeline. For more
    /// information, see [Tagging
    /// Amazon OpenSearch Ingestion
    /// pipelines](https://docs.aws.amazon.com/opensearch-service/latest/developerguide/tag-pipeline.html).
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: untag_resource.Options) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Updates an OpenSearch Ingestion pipeline. For more information, see
    /// [Updating Amazon OpenSearch
    /// Ingestion
    /// pipelines](https://docs.aws.amazon.com/opensearch-service/latest/developerguide/update-pipeline.html).
    pub fn updatePipeline(self: *Self, allocator: std.mem.Allocator, input: update_pipeline.UpdatePipelineInput, options: update_pipeline.Options) !update_pipeline.UpdatePipelineOutput {
        return update_pipeline.execute(self, allocator, input, options);
    }

    /// Checks whether an OpenSearch Ingestion pipeline configuration is valid prior
    /// to creation. For
    /// more information, see [Creating Amazon OpenSearch
    /// Ingestion
    /// pipelines](https://docs.aws.amazon.com/opensearch-service/latest/developerguide/creating-pipeline.html).
    pub fn validatePipeline(self: *Self, allocator: std.mem.Allocator, input: validate_pipeline.ValidatePipelineInput, options: validate_pipeline.Options) !validate_pipeline.ValidatePipelineOutput {
        return validate_pipeline.execute(self, allocator, input, options);
    }

    pub fn listPipelineEndpointConnectionsPaginator(self: *Self, params: list_pipeline_endpoint_connections.ListPipelineEndpointConnectionsInput) paginator.ListPipelineEndpointConnectionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listPipelineEndpointsPaginator(self: *Self, params: list_pipeline_endpoints.ListPipelineEndpointsInput) paginator.ListPipelineEndpointsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listPipelinesPaginator(self: *Self, params: list_pipelines.ListPipelinesInput) paginator.ListPipelinesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};
