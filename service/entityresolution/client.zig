const aws = @import("aws");
const std = @import("std");

const add_policy_statement = @import("add_policy_statement.zig");
const batch_delete_unique_id = @import("batch_delete_unique_id.zig");
const create_id_mapping_workflow = @import("create_id_mapping_workflow.zig");
const create_id_namespace = @import("create_id_namespace.zig");
const create_matching_workflow = @import("create_matching_workflow.zig");
const create_schema_mapping = @import("create_schema_mapping.zig");
const delete_id_mapping_workflow = @import("delete_id_mapping_workflow.zig");
const delete_id_namespace = @import("delete_id_namespace.zig");
const delete_matching_workflow = @import("delete_matching_workflow.zig");
const delete_policy_statement = @import("delete_policy_statement.zig");
const delete_schema_mapping = @import("delete_schema_mapping.zig");
const generate_match_id = @import("generate_match_id.zig");
const get_id_mapping_job = @import("get_id_mapping_job.zig");
const get_id_mapping_workflow = @import("get_id_mapping_workflow.zig");
const get_id_namespace = @import("get_id_namespace.zig");
const get_match_id = @import("get_match_id.zig");
const get_matching_job = @import("get_matching_job.zig");
const get_matching_workflow = @import("get_matching_workflow.zig");
const get_policy = @import("get_policy.zig");
const get_provider_service = @import("get_provider_service.zig");
const get_schema_mapping = @import("get_schema_mapping.zig");
const list_id_mapping_jobs = @import("list_id_mapping_jobs.zig");
const list_id_mapping_workflows = @import("list_id_mapping_workflows.zig");
const list_id_namespaces = @import("list_id_namespaces.zig");
const list_matching_jobs = @import("list_matching_jobs.zig");
const list_matching_workflows = @import("list_matching_workflows.zig");
const list_provider_services = @import("list_provider_services.zig");
const list_schema_mappings = @import("list_schema_mappings.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const put_policy = @import("put_policy.zig");
const start_id_mapping_job = @import("start_id_mapping_job.zig");
const start_matching_job = @import("start_matching_job.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_id_mapping_workflow = @import("update_id_mapping_workflow.zig");
const update_id_namespace = @import("update_id_namespace.zig");
const update_matching_workflow = @import("update_matching_workflow.zig");
const update_schema_mapping = @import("update_schema_mapping.zig");
const CallOptions = @import("call_options.zig").CallOptions;
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "EntityResolution";

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

    /// Adds a policy statement object. To retrieve a list of existing policy
    /// statements, use the `GetPolicy` API.
    pub fn addPolicyStatement(self: *Self, allocator: std.mem.Allocator, input: add_policy_statement.AddPolicyStatementInput, options: CallOptions) !add_policy_statement.AddPolicyStatementOutput {
        return add_policy_statement.execute(self, allocator, input, options);
    }

    /// Deletes multiple unique IDs in a matching workflow.
    pub fn batchDeleteUniqueId(self: *Self, allocator: std.mem.Allocator, input: batch_delete_unique_id.BatchDeleteUniqueIdInput, options: CallOptions) !batch_delete_unique_id.BatchDeleteUniqueIdOutput {
        return batch_delete_unique_id.execute(self, allocator, input, options);
    }

    /// Creates an `IdMappingWorkflow` object which stores the configuration of the
    /// data processing job to be run. Each `IdMappingWorkflow` must have a unique
    /// workflow name. To modify an existing workflow, use the
    /// UpdateIdMappingWorkflow API.
    ///
    /// Incremental processing is not supported for ID mapping workflows.
    pub fn createIdMappingWorkflow(self: *Self, allocator: std.mem.Allocator, input: create_id_mapping_workflow.CreateIdMappingWorkflowInput, options: CallOptions) !create_id_mapping_workflow.CreateIdMappingWorkflowOutput {
        return create_id_mapping_workflow.execute(self, allocator, input, options);
    }

    /// Creates an ID namespace object which will help customers provide metadata
    /// explaining their dataset and how to use it. Each ID namespace must have a
    /// unique name. To modify an existing ID namespace, use the UpdateIdNamespace
    /// API.
    pub fn createIdNamespace(self: *Self, allocator: std.mem.Allocator, input: create_id_namespace.CreateIdNamespaceInput, options: CallOptions) !create_id_namespace.CreateIdNamespaceOutput {
        return create_id_namespace.execute(self, allocator, input, options);
    }

    /// Creates a matching workflow that defines the configuration for a data
    /// processing job. The workflow name must be unique. To modify an existing
    /// workflow, use `UpdateMatchingWorkflow`.
    ///
    /// For workflows where `resolutionType` is `ML_MATCHING` or `PROVIDER`,
    /// incremental processing is not supported.
    pub fn createMatchingWorkflow(self: *Self, allocator: std.mem.Allocator, input: create_matching_workflow.CreateMatchingWorkflowInput, options: CallOptions) !create_matching_workflow.CreateMatchingWorkflowOutput {
        return create_matching_workflow.execute(self, allocator, input, options);
    }

    /// Creates a schema mapping, which defines the schema of the input customer
    /// records table. The `SchemaMapping` also provides Entity Resolution with some
    /// metadata about the table, such as the attribute types of the columns and
    /// which columns to match on.
    pub fn createSchemaMapping(self: *Self, allocator: std.mem.Allocator, input: create_schema_mapping.CreateSchemaMappingInput, options: CallOptions) !create_schema_mapping.CreateSchemaMappingOutput {
        return create_schema_mapping.execute(self, allocator, input, options);
    }

    /// Deletes the `IdMappingWorkflow` with a given name. This operation will
    /// succeed even if a workflow with the given name does not exist.
    pub fn deleteIdMappingWorkflow(self: *Self, allocator: std.mem.Allocator, input: delete_id_mapping_workflow.DeleteIdMappingWorkflowInput, options: CallOptions) !delete_id_mapping_workflow.DeleteIdMappingWorkflowOutput {
        return delete_id_mapping_workflow.execute(self, allocator, input, options);
    }

    /// Deletes the `IdNamespace` with a given name.
    pub fn deleteIdNamespace(self: *Self, allocator: std.mem.Allocator, input: delete_id_namespace.DeleteIdNamespaceInput, options: CallOptions) !delete_id_namespace.DeleteIdNamespaceOutput {
        return delete_id_namespace.execute(self, allocator, input, options);
    }

    /// Deletes the `MatchingWorkflow` with a given name. This operation will
    /// succeed even if a workflow with the given name does not exist.
    pub fn deleteMatchingWorkflow(self: *Self, allocator: std.mem.Allocator, input: delete_matching_workflow.DeleteMatchingWorkflowInput, options: CallOptions) !delete_matching_workflow.DeleteMatchingWorkflowOutput {
        return delete_matching_workflow.execute(self, allocator, input, options);
    }

    /// Deletes the policy statement.
    pub fn deletePolicyStatement(self: *Self, allocator: std.mem.Allocator, input: delete_policy_statement.DeletePolicyStatementInput, options: CallOptions) !delete_policy_statement.DeletePolicyStatementOutput {
        return delete_policy_statement.execute(self, allocator, input, options);
    }

    /// Deletes the `SchemaMapping` with a given name. This operation will succeed
    /// even if a schema with the given name does not exist. This operation will
    /// fail if there is a `MatchingWorkflow` object that references the
    /// `SchemaMapping` in the workflow's `InputSourceConfig`.
    pub fn deleteSchemaMapping(self: *Self, allocator: std.mem.Allocator, input: delete_schema_mapping.DeleteSchemaMappingInput, options: CallOptions) !delete_schema_mapping.DeleteSchemaMappingOutput {
        return delete_schema_mapping.execute(self, allocator, input, options);
    }

    /// Generates or retrieves Match IDs for records using a rule-based matching
    /// workflow. When you call this operation, it processes your records against
    /// the workflow's matching rules to identify potential matches. For existing
    /// records, it retrieves their Match IDs and associated rules. For records
    /// without matches, it generates new Match IDs. The operation saves results to
    /// Amazon S3.
    ///
    /// The processing type (`processingType`) you choose affects both the accuracy
    /// and response time of the operation. Additional charges apply for each API
    /// call, whether made through the Entity Resolution console or directly via the
    /// API. The rule-based matching workflow must exist and be active before
    /// calling this operation.
    pub fn generateMatchId(self: *Self, allocator: std.mem.Allocator, input: generate_match_id.GenerateMatchIdInput, options: CallOptions) !generate_match_id.GenerateMatchIdOutput {
        return generate_match_id.execute(self, allocator, input, options);
    }

    /// Returns the status, metrics, and errors (if there are any) that are
    /// associated with a job.
    pub fn getIdMappingJob(self: *Self, allocator: std.mem.Allocator, input: get_id_mapping_job.GetIdMappingJobInput, options: CallOptions) !get_id_mapping_job.GetIdMappingJobOutput {
        return get_id_mapping_job.execute(self, allocator, input, options);
    }

    /// Returns the `IdMappingWorkflow` with a given name, if it exists.
    pub fn getIdMappingWorkflow(self: *Self, allocator: std.mem.Allocator, input: get_id_mapping_workflow.GetIdMappingWorkflowInput, options: CallOptions) !get_id_mapping_workflow.GetIdMappingWorkflowOutput {
        return get_id_mapping_workflow.execute(self, allocator, input, options);
    }

    /// Returns the `IdNamespace` with a given name, if it exists.
    pub fn getIdNamespace(self: *Self, allocator: std.mem.Allocator, input: get_id_namespace.GetIdNamespaceInput, options: CallOptions) !get_id_namespace.GetIdNamespaceOutput {
        return get_id_namespace.execute(self, allocator, input, options);
    }

    /// Returns the corresponding Match ID of a customer record if the record has
    /// been processed in a rule-based matching workflow.
    ///
    /// You can call this API as a dry run of an incremental load on the rule-based
    /// matching workflow.
    pub fn getMatchId(self: *Self, allocator: std.mem.Allocator, input: get_match_id.GetMatchIdInput, options: CallOptions) !get_match_id.GetMatchIdOutput {
        return get_match_id.execute(self, allocator, input, options);
    }

    /// Returns the status, metrics, and errors (if there are any) that are
    /// associated with a job.
    pub fn getMatchingJob(self: *Self, allocator: std.mem.Allocator, input: get_matching_job.GetMatchingJobInput, options: CallOptions) !get_matching_job.GetMatchingJobOutput {
        return get_matching_job.execute(self, allocator, input, options);
    }

    /// Returns the `MatchingWorkflow` with a given name, if it exists.
    pub fn getMatchingWorkflow(self: *Self, allocator: std.mem.Allocator, input: get_matching_workflow.GetMatchingWorkflowInput, options: CallOptions) !get_matching_workflow.GetMatchingWorkflowOutput {
        return get_matching_workflow.execute(self, allocator, input, options);
    }

    /// Returns the resource-based policy.
    pub fn getPolicy(self: *Self, allocator: std.mem.Allocator, input: get_policy.GetPolicyInput, options: CallOptions) !get_policy.GetPolicyOutput {
        return get_policy.execute(self, allocator, input, options);
    }

    /// Returns the `ProviderService` of a given name.
    pub fn getProviderService(self: *Self, allocator: std.mem.Allocator, input: get_provider_service.GetProviderServiceInput, options: CallOptions) !get_provider_service.GetProviderServiceOutput {
        return get_provider_service.execute(self, allocator, input, options);
    }

    /// Returns the SchemaMapping of a given name.
    pub fn getSchemaMapping(self: *Self, allocator: std.mem.Allocator, input: get_schema_mapping.GetSchemaMappingInput, options: CallOptions) !get_schema_mapping.GetSchemaMappingOutput {
        return get_schema_mapping.execute(self, allocator, input, options);
    }

    /// Lists all ID mapping jobs for a given workflow.
    pub fn listIdMappingJobs(self: *Self, allocator: std.mem.Allocator, input: list_id_mapping_jobs.ListIdMappingJobsInput, options: CallOptions) !list_id_mapping_jobs.ListIdMappingJobsOutput {
        return list_id_mapping_jobs.execute(self, allocator, input, options);
    }

    /// Returns a list of all the `IdMappingWorkflows` that have been created for an
    /// Amazon Web Services account.
    pub fn listIdMappingWorkflows(self: *Self, allocator: std.mem.Allocator, input: list_id_mapping_workflows.ListIdMappingWorkflowsInput, options: CallOptions) !list_id_mapping_workflows.ListIdMappingWorkflowsOutput {
        return list_id_mapping_workflows.execute(self, allocator, input, options);
    }

    /// Returns a list of all ID namespaces.
    pub fn listIdNamespaces(self: *Self, allocator: std.mem.Allocator, input: list_id_namespaces.ListIdNamespacesInput, options: CallOptions) !list_id_namespaces.ListIdNamespacesOutput {
        return list_id_namespaces.execute(self, allocator, input, options);
    }

    /// Lists all jobs for a given workflow.
    pub fn listMatchingJobs(self: *Self, allocator: std.mem.Allocator, input: list_matching_jobs.ListMatchingJobsInput, options: CallOptions) !list_matching_jobs.ListMatchingJobsOutput {
        return list_matching_jobs.execute(self, allocator, input, options);
    }

    /// Returns a list of all the `MatchingWorkflows` that have been created for an
    /// Amazon Web Services account.
    pub fn listMatchingWorkflows(self: *Self, allocator: std.mem.Allocator, input: list_matching_workflows.ListMatchingWorkflowsInput, options: CallOptions) !list_matching_workflows.ListMatchingWorkflowsOutput {
        return list_matching_workflows.execute(self, allocator, input, options);
    }

    /// Returns a list of all the `ProviderServices` that are available in this
    /// Amazon Web Services Region.
    pub fn listProviderServices(self: *Self, allocator: std.mem.Allocator, input: list_provider_services.ListProviderServicesInput, options: CallOptions) !list_provider_services.ListProviderServicesOutput {
        return list_provider_services.execute(self, allocator, input, options);
    }

    /// Returns a list of all the `SchemaMappings` that have been created for an
    /// Amazon Web Services account.
    pub fn listSchemaMappings(self: *Self, allocator: std.mem.Allocator, input: list_schema_mappings.ListSchemaMappingsInput, options: CallOptions) !list_schema_mappings.ListSchemaMappingsOutput {
        return list_schema_mappings.execute(self, allocator, input, options);
    }

    /// Displays the tags associated with an Entity Resolution resource. In Entity
    /// Resolution, `SchemaMapping`, and `MatchingWorkflow` can be tagged.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: CallOptions) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Updates the resource-based policy.
    pub fn putPolicy(self: *Self, allocator: std.mem.Allocator, input: put_policy.PutPolicyInput, options: CallOptions) !put_policy.PutPolicyOutput {
        return put_policy.execute(self, allocator, input, options);
    }

    /// Starts the `IdMappingJob` of a workflow. The workflow must have previously
    /// been created using the `CreateIdMappingWorkflow` endpoint.
    pub fn startIdMappingJob(self: *Self, allocator: std.mem.Allocator, input: start_id_mapping_job.StartIdMappingJobInput, options: CallOptions) !start_id_mapping_job.StartIdMappingJobOutput {
        return start_id_mapping_job.execute(self, allocator, input, options);
    }

    /// Starts the `MatchingJob` of a workflow. The workflow must have previously
    /// been created using the `CreateMatchingWorkflow` endpoint.
    pub fn startMatchingJob(self: *Self, allocator: std.mem.Allocator, input: start_matching_job.StartMatchingJobInput, options: CallOptions) !start_matching_job.StartMatchingJobOutput {
        return start_matching_job.execute(self, allocator, input, options);
    }

    /// Assigns one or more tags (key-value pairs) to the specified Entity
    /// Resolution resource. Tags can help you organize and categorize your
    /// resources. You can also use them to scope user permissions by granting a
    /// user permission to access or change only resources with certain tag values.
    /// In Entity Resolution, `SchemaMapping` and `MatchingWorkflow` can be tagged.
    /// Tags don't have any semantic meaning to Amazon Web Services and are
    /// interpreted strictly as strings of characters. You can use the `TagResource`
    /// action with a resource that already has tags. If you specify a new tag key,
    /// this tag is appended to the list of tags associated with the resource. If
    /// you specify a tag key that is already associated with the resource, the new
    /// tag value that you specify replaces the previous value for that tag.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: CallOptions) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Removes one or more tags from the specified Entity Resolution resource. In
    /// Entity Resolution, `SchemaMapping`, and `MatchingWorkflow` can be tagged.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: CallOptions) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Updates an existing `IdMappingWorkflow`. This method is identical to
    /// CreateIdMappingWorkflow, except it uses an HTTP `PUT` request instead of a
    /// `POST` request, and the `IdMappingWorkflow` must already exist for the
    /// method to succeed.
    ///
    /// Incremental processing is not supported for ID mapping workflows.
    pub fn updateIdMappingWorkflow(self: *Self, allocator: std.mem.Allocator, input: update_id_mapping_workflow.UpdateIdMappingWorkflowInput, options: CallOptions) !update_id_mapping_workflow.UpdateIdMappingWorkflowOutput {
        return update_id_mapping_workflow.execute(self, allocator, input, options);
    }

    /// Updates an existing ID namespace.
    pub fn updateIdNamespace(self: *Self, allocator: std.mem.Allocator, input: update_id_namespace.UpdateIdNamespaceInput, options: CallOptions) !update_id_namespace.UpdateIdNamespaceOutput {
        return update_id_namespace.execute(self, allocator, input, options);
    }

    /// Updates an existing matching workflow. The workflow must already exist for
    /// this operation to succeed.
    ///
    /// For workflows where `resolutionType` is `ML_MATCHING` or `PROVIDER`,
    /// incremental processing is not supported.
    pub fn updateMatchingWorkflow(self: *Self, allocator: std.mem.Allocator, input: update_matching_workflow.UpdateMatchingWorkflowInput, options: CallOptions) !update_matching_workflow.UpdateMatchingWorkflowOutput {
        return update_matching_workflow.execute(self, allocator, input, options);
    }

    /// Updates a schema mapping.
    ///
    /// A schema is immutable if it is being used by a workflow. Therefore, you
    /// can't update a schema mapping if it's associated with a workflow.
    pub fn updateSchemaMapping(self: *Self, allocator: std.mem.Allocator, input: update_schema_mapping.UpdateSchemaMappingInput, options: CallOptions) !update_schema_mapping.UpdateSchemaMappingOutput {
        return update_schema_mapping.execute(self, allocator, input, options);
    }

    pub fn listIdMappingJobsPaginator(self: *Self, params: list_id_mapping_jobs.ListIdMappingJobsInput) paginator.ListIdMappingJobsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listIdMappingWorkflowsPaginator(self: *Self, params: list_id_mapping_workflows.ListIdMappingWorkflowsInput) paginator.ListIdMappingWorkflowsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listIdNamespacesPaginator(self: *Self, params: list_id_namespaces.ListIdNamespacesInput) paginator.ListIdNamespacesPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listMatchingJobsPaginator(self: *Self, params: list_matching_jobs.ListMatchingJobsInput) paginator.ListMatchingJobsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listMatchingWorkflowsPaginator(self: *Self, params: list_matching_workflows.ListMatchingWorkflowsInput) paginator.ListMatchingWorkflowsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listProviderServicesPaginator(self: *Self, params: list_provider_services.ListProviderServicesInput) paginator.ListProviderServicesPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listSchemaMappingsPaginator(self: *Self, params: list_schema_mappings.ListSchemaMappingsInput) paginator.ListSchemaMappingsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }
};
