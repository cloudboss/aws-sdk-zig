const aws = @import("aws");
const std = @import("std");

const batch_get_collaboration_analysis_template = @import("batch_get_collaboration_analysis_template.zig");
const batch_get_schema = @import("batch_get_schema.zig");
const batch_get_schema_analysis_rule = @import("batch_get_schema_analysis_rule.zig");
const create_analysis_template = @import("create_analysis_template.zig");
const create_collaboration = @import("create_collaboration.zig");
const create_collaboration_change_request = @import("create_collaboration_change_request.zig");
const create_configured_audience_model_association = @import("create_configured_audience_model_association.zig");
const create_configured_table = @import("create_configured_table.zig");
const create_configured_table_analysis_rule = @import("create_configured_table_analysis_rule.zig");
const create_configured_table_association = @import("create_configured_table_association.zig");
const create_configured_table_association_analysis_rule = @import("create_configured_table_association_analysis_rule.zig");
const create_id_mapping_table = @import("create_id_mapping_table.zig");
const create_id_namespace_association = @import("create_id_namespace_association.zig");
const create_membership = @import("create_membership.zig");
const create_privacy_budget_template = @import("create_privacy_budget_template.zig");
const delete_analysis_template = @import("delete_analysis_template.zig");
const delete_collaboration = @import("delete_collaboration.zig");
const delete_configured_audience_model_association = @import("delete_configured_audience_model_association.zig");
const delete_configured_table = @import("delete_configured_table.zig");
const delete_configured_table_analysis_rule = @import("delete_configured_table_analysis_rule.zig");
const delete_configured_table_association = @import("delete_configured_table_association.zig");
const delete_configured_table_association_analysis_rule = @import("delete_configured_table_association_analysis_rule.zig");
const delete_id_mapping_table = @import("delete_id_mapping_table.zig");
const delete_id_namespace_association = @import("delete_id_namespace_association.zig");
const delete_member = @import("delete_member.zig");
const delete_membership = @import("delete_membership.zig");
const delete_privacy_budget_template = @import("delete_privacy_budget_template.zig");
const get_analysis_template = @import("get_analysis_template.zig");
const get_collaboration = @import("get_collaboration.zig");
const get_collaboration_analysis_template = @import("get_collaboration_analysis_template.zig");
const get_collaboration_change_request = @import("get_collaboration_change_request.zig");
const get_collaboration_configured_audience_model_association = @import("get_collaboration_configured_audience_model_association.zig");
const get_collaboration_id_namespace_association = @import("get_collaboration_id_namespace_association.zig");
const get_collaboration_privacy_budget_template = @import("get_collaboration_privacy_budget_template.zig");
const get_configured_audience_model_association = @import("get_configured_audience_model_association.zig");
const get_configured_table = @import("get_configured_table.zig");
const get_configured_table_analysis_rule = @import("get_configured_table_analysis_rule.zig");
const get_configured_table_association = @import("get_configured_table_association.zig");
const get_configured_table_association_analysis_rule = @import("get_configured_table_association_analysis_rule.zig");
const get_id_mapping_table = @import("get_id_mapping_table.zig");
const get_id_namespace_association = @import("get_id_namespace_association.zig");
const get_membership = @import("get_membership.zig");
const get_privacy_budget_template = @import("get_privacy_budget_template.zig");
const get_protected_job = @import("get_protected_job.zig");
const get_protected_query = @import("get_protected_query.zig");
const get_schema = @import("get_schema.zig");
const get_schema_analysis_rule = @import("get_schema_analysis_rule.zig");
const list_analysis_templates = @import("list_analysis_templates.zig");
const list_collaboration_analysis_templates = @import("list_collaboration_analysis_templates.zig");
const list_collaboration_change_requests = @import("list_collaboration_change_requests.zig");
const list_collaboration_configured_audience_model_associations = @import("list_collaboration_configured_audience_model_associations.zig");
const list_collaboration_id_namespace_associations = @import("list_collaboration_id_namespace_associations.zig");
const list_collaboration_privacy_budget_templates = @import("list_collaboration_privacy_budget_templates.zig");
const list_collaboration_privacy_budgets = @import("list_collaboration_privacy_budgets.zig");
const list_collaborations = @import("list_collaborations.zig");
const list_configured_audience_model_associations = @import("list_configured_audience_model_associations.zig");
const list_configured_table_associations = @import("list_configured_table_associations.zig");
const list_configured_tables = @import("list_configured_tables.zig");
const list_id_mapping_tables = @import("list_id_mapping_tables.zig");
const list_id_namespace_associations = @import("list_id_namespace_associations.zig");
const list_members = @import("list_members.zig");
const list_memberships = @import("list_memberships.zig");
const list_privacy_budget_templates = @import("list_privacy_budget_templates.zig");
const list_privacy_budgets = @import("list_privacy_budgets.zig");
const list_protected_jobs = @import("list_protected_jobs.zig");
const list_protected_queries = @import("list_protected_queries.zig");
const list_schemas = @import("list_schemas.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const populate_id_mapping_table = @import("populate_id_mapping_table.zig");
const preview_privacy_impact = @import("preview_privacy_impact.zig");
const start_protected_job = @import("start_protected_job.zig");
const start_protected_query = @import("start_protected_query.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_analysis_template = @import("update_analysis_template.zig");
const update_collaboration = @import("update_collaboration.zig");
const update_collaboration_change_request = @import("update_collaboration_change_request.zig");
const update_configured_audience_model_association = @import("update_configured_audience_model_association.zig");
const update_configured_table = @import("update_configured_table.zig");
const update_configured_table_analysis_rule = @import("update_configured_table_analysis_rule.zig");
const update_configured_table_association = @import("update_configured_table_association.zig");
const update_configured_table_association_analysis_rule = @import("update_configured_table_association_analysis_rule.zig");
const update_id_mapping_table = @import("update_id_mapping_table.zig");
const update_id_namespace_association = @import("update_id_namespace_association.zig");
const update_membership = @import("update_membership.zig");
const update_privacy_budget_template = @import("update_privacy_budget_template.zig");
const update_protected_job = @import("update_protected_job.zig");
const update_protected_query = @import("update_protected_query.zig");
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "CleanRooms";

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

    /// Retrieves multiple analysis templates within a collaboration by their Amazon
    /// Resource Names (ARNs).
    pub fn batchGetCollaborationAnalysisTemplate(self: *Self, allocator: std.mem.Allocator, input: batch_get_collaboration_analysis_template.BatchGetCollaborationAnalysisTemplateInput, options: batch_get_collaboration_analysis_template.Options) !batch_get_collaboration_analysis_template.BatchGetCollaborationAnalysisTemplateOutput {
        return batch_get_collaboration_analysis_template.execute(self, allocator, input, options);
    }

    /// Retrieves multiple schemas by their identifiers.
    pub fn batchGetSchema(self: *Self, allocator: std.mem.Allocator, input: batch_get_schema.BatchGetSchemaInput, options: batch_get_schema.Options) !batch_get_schema.BatchGetSchemaOutput {
        return batch_get_schema.execute(self, allocator, input, options);
    }

    /// Retrieves multiple analysis rule schemas.
    pub fn batchGetSchemaAnalysisRule(self: *Self, allocator: std.mem.Allocator, input: batch_get_schema_analysis_rule.BatchGetSchemaAnalysisRuleInput, options: batch_get_schema_analysis_rule.Options) !batch_get_schema_analysis_rule.BatchGetSchemaAnalysisRuleOutput {
        return batch_get_schema_analysis_rule.execute(self, allocator, input, options);
    }

    /// Creates a new analysis template.
    pub fn createAnalysisTemplate(self: *Self, allocator: std.mem.Allocator, input: create_analysis_template.CreateAnalysisTemplateInput, options: create_analysis_template.Options) !create_analysis_template.CreateAnalysisTemplateOutput {
        return create_analysis_template.execute(self, allocator, input, options);
    }

    /// Creates a new collaboration.
    pub fn createCollaboration(self: *Self, allocator: std.mem.Allocator, input: create_collaboration.CreateCollaborationInput, options: create_collaboration.Options) !create_collaboration.CreateCollaborationOutput {
        return create_collaboration.execute(self, allocator, input, options);
    }

    /// Creates a new change request to modify an existing collaboration. This
    /// enables post-creation modifications to collaborations through a structured
    /// API-driven approach.
    pub fn createCollaborationChangeRequest(self: *Self, allocator: std.mem.Allocator, input: create_collaboration_change_request.CreateCollaborationChangeRequestInput, options: create_collaboration_change_request.Options) !create_collaboration_change_request.CreateCollaborationChangeRequestOutput {
        return create_collaboration_change_request.execute(self, allocator, input, options);
    }

    /// Provides the details necessary to create a configured audience model
    /// association.
    pub fn createConfiguredAudienceModelAssociation(self: *Self, allocator: std.mem.Allocator, input: create_configured_audience_model_association.CreateConfiguredAudienceModelAssociationInput, options: create_configured_audience_model_association.Options) !create_configured_audience_model_association.CreateConfiguredAudienceModelAssociationOutput {
        return create_configured_audience_model_association.execute(self, allocator, input, options);
    }

    /// Creates a new configured table resource.
    pub fn createConfiguredTable(self: *Self, allocator: std.mem.Allocator, input: create_configured_table.CreateConfiguredTableInput, options: create_configured_table.Options) !create_configured_table.CreateConfiguredTableOutput {
        return create_configured_table.execute(self, allocator, input, options);
    }

    /// Creates a new analysis rule for a configured table. Currently, only one
    /// analysis rule can be created for a given configured table.
    pub fn createConfiguredTableAnalysisRule(self: *Self, allocator: std.mem.Allocator, input: create_configured_table_analysis_rule.CreateConfiguredTableAnalysisRuleInput, options: create_configured_table_analysis_rule.Options) !create_configured_table_analysis_rule.CreateConfiguredTableAnalysisRuleOutput {
        return create_configured_table_analysis_rule.execute(self, allocator, input, options);
    }

    /// Creates a configured table association. A configured table association links
    /// a configured table with a collaboration.
    pub fn createConfiguredTableAssociation(self: *Self, allocator: std.mem.Allocator, input: create_configured_table_association.CreateConfiguredTableAssociationInput, options: create_configured_table_association.Options) !create_configured_table_association.CreateConfiguredTableAssociationOutput {
        return create_configured_table_association.execute(self, allocator, input, options);
    }

    /// Creates a new analysis rule for an associated configured table.
    pub fn createConfiguredTableAssociationAnalysisRule(self: *Self, allocator: std.mem.Allocator, input: create_configured_table_association_analysis_rule.CreateConfiguredTableAssociationAnalysisRuleInput, options: create_configured_table_association_analysis_rule.Options) !create_configured_table_association_analysis_rule.CreateConfiguredTableAssociationAnalysisRuleOutput {
        return create_configured_table_association_analysis_rule.execute(self, allocator, input, options);
    }

    /// Creates an ID mapping table.
    pub fn createIdMappingTable(self: *Self, allocator: std.mem.Allocator, input: create_id_mapping_table.CreateIdMappingTableInput, options: create_id_mapping_table.Options) !create_id_mapping_table.CreateIdMappingTableOutput {
        return create_id_mapping_table.execute(self, allocator, input, options);
    }

    /// Creates an ID namespace association.
    pub fn createIdNamespaceAssociation(self: *Self, allocator: std.mem.Allocator, input: create_id_namespace_association.CreateIdNamespaceAssociationInput, options: create_id_namespace_association.Options) !create_id_namespace_association.CreateIdNamespaceAssociationOutput {
        return create_id_namespace_association.execute(self, allocator, input, options);
    }

    /// Creates a membership for a specific collaboration identifier and joins the
    /// collaboration.
    pub fn createMembership(self: *Self, allocator: std.mem.Allocator, input: create_membership.CreateMembershipInput, options: create_membership.Options) !create_membership.CreateMembershipOutput {
        return create_membership.execute(self, allocator, input, options);
    }

    /// Creates a privacy budget template for a specified collaboration. Each
    /// collaboration can have only one privacy budget template. If you need to
    /// change the privacy budget template, use the UpdatePrivacyBudgetTemplate
    /// operation.
    pub fn createPrivacyBudgetTemplate(self: *Self, allocator: std.mem.Allocator, input: create_privacy_budget_template.CreatePrivacyBudgetTemplateInput, options: create_privacy_budget_template.Options) !create_privacy_budget_template.CreatePrivacyBudgetTemplateOutput {
        return create_privacy_budget_template.execute(self, allocator, input, options);
    }

    /// Deletes an analysis template.
    pub fn deleteAnalysisTemplate(self: *Self, allocator: std.mem.Allocator, input: delete_analysis_template.DeleteAnalysisTemplateInput, options: delete_analysis_template.Options) !delete_analysis_template.DeleteAnalysisTemplateOutput {
        return delete_analysis_template.execute(self, allocator, input, options);
    }

    /// Deletes a collaboration. It can only be called by the collaboration owner.
    pub fn deleteCollaboration(self: *Self, allocator: std.mem.Allocator, input: delete_collaboration.DeleteCollaborationInput, options: delete_collaboration.Options) !delete_collaboration.DeleteCollaborationOutput {
        return delete_collaboration.execute(self, allocator, input, options);
    }

    /// Provides the information necessary to delete a configured audience model
    /// association.
    pub fn deleteConfiguredAudienceModelAssociation(self: *Self, allocator: std.mem.Allocator, input: delete_configured_audience_model_association.DeleteConfiguredAudienceModelAssociationInput, options: delete_configured_audience_model_association.Options) !delete_configured_audience_model_association.DeleteConfiguredAudienceModelAssociationOutput {
        return delete_configured_audience_model_association.execute(self, allocator, input, options);
    }

    /// Deletes a configured table.
    pub fn deleteConfiguredTable(self: *Self, allocator: std.mem.Allocator, input: delete_configured_table.DeleteConfiguredTableInput, options: delete_configured_table.Options) !delete_configured_table.DeleteConfiguredTableOutput {
        return delete_configured_table.execute(self, allocator, input, options);
    }

    /// Deletes a configured table analysis rule.
    pub fn deleteConfiguredTableAnalysisRule(self: *Self, allocator: std.mem.Allocator, input: delete_configured_table_analysis_rule.DeleteConfiguredTableAnalysisRuleInput, options: delete_configured_table_analysis_rule.Options) !delete_configured_table_analysis_rule.DeleteConfiguredTableAnalysisRuleOutput {
        return delete_configured_table_analysis_rule.execute(self, allocator, input, options);
    }

    /// Deletes a configured table association.
    pub fn deleteConfiguredTableAssociation(self: *Self, allocator: std.mem.Allocator, input: delete_configured_table_association.DeleteConfiguredTableAssociationInput, options: delete_configured_table_association.Options) !delete_configured_table_association.DeleteConfiguredTableAssociationOutput {
        return delete_configured_table_association.execute(self, allocator, input, options);
    }

    /// Deletes an analysis rule for a configured table association.
    pub fn deleteConfiguredTableAssociationAnalysisRule(self: *Self, allocator: std.mem.Allocator, input: delete_configured_table_association_analysis_rule.DeleteConfiguredTableAssociationAnalysisRuleInput, options: delete_configured_table_association_analysis_rule.Options) !delete_configured_table_association_analysis_rule.DeleteConfiguredTableAssociationAnalysisRuleOutput {
        return delete_configured_table_association_analysis_rule.execute(self, allocator, input, options);
    }

    /// Deletes an ID mapping table.
    pub fn deleteIdMappingTable(self: *Self, allocator: std.mem.Allocator, input: delete_id_mapping_table.DeleteIdMappingTableInput, options: delete_id_mapping_table.Options) !delete_id_mapping_table.DeleteIdMappingTableOutput {
        return delete_id_mapping_table.execute(self, allocator, input, options);
    }

    /// Deletes an ID namespace association.
    pub fn deleteIdNamespaceAssociation(self: *Self, allocator: std.mem.Allocator, input: delete_id_namespace_association.DeleteIdNamespaceAssociationInput, options: delete_id_namespace_association.Options) !delete_id_namespace_association.DeleteIdNamespaceAssociationOutput {
        return delete_id_namespace_association.execute(self, allocator, input, options);
    }

    /// Removes the specified member from a collaboration. The removed member is
    /// placed in the Removed status and can't interact with the collaboration. The
    /// removed member's data is inaccessible to active members of the
    /// collaboration.
    pub fn deleteMember(self: *Self, allocator: std.mem.Allocator, input: delete_member.DeleteMemberInput, options: delete_member.Options) !delete_member.DeleteMemberOutput {
        return delete_member.execute(self, allocator, input, options);
    }

    /// Deletes a specified membership. All resources under a membership must be
    /// deleted.
    pub fn deleteMembership(self: *Self, allocator: std.mem.Allocator, input: delete_membership.DeleteMembershipInput, options: delete_membership.Options) !delete_membership.DeleteMembershipOutput {
        return delete_membership.execute(self, allocator, input, options);
    }

    /// Deletes a privacy budget template for a specified collaboration.
    pub fn deletePrivacyBudgetTemplate(self: *Self, allocator: std.mem.Allocator, input: delete_privacy_budget_template.DeletePrivacyBudgetTemplateInput, options: delete_privacy_budget_template.Options) !delete_privacy_budget_template.DeletePrivacyBudgetTemplateOutput {
        return delete_privacy_budget_template.execute(self, allocator, input, options);
    }

    /// Retrieves an analysis template.
    pub fn getAnalysisTemplate(self: *Self, allocator: std.mem.Allocator, input: get_analysis_template.GetAnalysisTemplateInput, options: get_analysis_template.Options) !get_analysis_template.GetAnalysisTemplateOutput {
        return get_analysis_template.execute(self, allocator, input, options);
    }

    /// Returns metadata about a collaboration.
    pub fn getCollaboration(self: *Self, allocator: std.mem.Allocator, input: get_collaboration.GetCollaborationInput, options: get_collaboration.Options) !get_collaboration.GetCollaborationOutput {
        return get_collaboration.execute(self, allocator, input, options);
    }

    /// Retrieves an analysis template within a collaboration.
    pub fn getCollaborationAnalysisTemplate(self: *Self, allocator: std.mem.Allocator, input: get_collaboration_analysis_template.GetCollaborationAnalysisTemplateInput, options: get_collaboration_analysis_template.Options) !get_collaboration_analysis_template.GetCollaborationAnalysisTemplateOutput {
        return get_collaboration_analysis_template.execute(self, allocator, input, options);
    }

    /// Retrieves detailed information about a specific collaboration change
    /// request.
    pub fn getCollaborationChangeRequest(self: *Self, allocator: std.mem.Allocator, input: get_collaboration_change_request.GetCollaborationChangeRequestInput, options: get_collaboration_change_request.Options) !get_collaboration_change_request.GetCollaborationChangeRequestOutput {
        return get_collaboration_change_request.execute(self, allocator, input, options);
    }

    /// Retrieves a configured audience model association within a collaboration.
    pub fn getCollaborationConfiguredAudienceModelAssociation(self: *Self, allocator: std.mem.Allocator, input: get_collaboration_configured_audience_model_association.GetCollaborationConfiguredAudienceModelAssociationInput, options: get_collaboration_configured_audience_model_association.Options) !get_collaboration_configured_audience_model_association.GetCollaborationConfiguredAudienceModelAssociationOutput {
        return get_collaboration_configured_audience_model_association.execute(self, allocator, input, options);
    }

    /// Retrieves an ID namespace association from a specific collaboration.
    pub fn getCollaborationIdNamespaceAssociation(self: *Self, allocator: std.mem.Allocator, input: get_collaboration_id_namespace_association.GetCollaborationIdNamespaceAssociationInput, options: get_collaboration_id_namespace_association.Options) !get_collaboration_id_namespace_association.GetCollaborationIdNamespaceAssociationOutput {
        return get_collaboration_id_namespace_association.execute(self, allocator, input, options);
    }

    /// Returns details about a specified privacy budget template.
    pub fn getCollaborationPrivacyBudgetTemplate(self: *Self, allocator: std.mem.Allocator, input: get_collaboration_privacy_budget_template.GetCollaborationPrivacyBudgetTemplateInput, options: get_collaboration_privacy_budget_template.Options) !get_collaboration_privacy_budget_template.GetCollaborationPrivacyBudgetTemplateOutput {
        return get_collaboration_privacy_budget_template.execute(self, allocator, input, options);
    }

    /// Returns information about a configured audience model association.
    pub fn getConfiguredAudienceModelAssociation(self: *Self, allocator: std.mem.Allocator, input: get_configured_audience_model_association.GetConfiguredAudienceModelAssociationInput, options: get_configured_audience_model_association.Options) !get_configured_audience_model_association.GetConfiguredAudienceModelAssociationOutput {
        return get_configured_audience_model_association.execute(self, allocator, input, options);
    }

    /// Retrieves a configured table.
    pub fn getConfiguredTable(self: *Self, allocator: std.mem.Allocator, input: get_configured_table.GetConfiguredTableInput, options: get_configured_table.Options) !get_configured_table.GetConfiguredTableOutput {
        return get_configured_table.execute(self, allocator, input, options);
    }

    /// Retrieves a configured table analysis rule.
    pub fn getConfiguredTableAnalysisRule(self: *Self, allocator: std.mem.Allocator, input: get_configured_table_analysis_rule.GetConfiguredTableAnalysisRuleInput, options: get_configured_table_analysis_rule.Options) !get_configured_table_analysis_rule.GetConfiguredTableAnalysisRuleOutput {
        return get_configured_table_analysis_rule.execute(self, allocator, input, options);
    }

    /// Retrieves a configured table association.
    pub fn getConfiguredTableAssociation(self: *Self, allocator: std.mem.Allocator, input: get_configured_table_association.GetConfiguredTableAssociationInput, options: get_configured_table_association.Options) !get_configured_table_association.GetConfiguredTableAssociationOutput {
        return get_configured_table_association.execute(self, allocator, input, options);
    }

    /// Retrieves the analysis rule for a configured table association.
    pub fn getConfiguredTableAssociationAnalysisRule(self: *Self, allocator: std.mem.Allocator, input: get_configured_table_association_analysis_rule.GetConfiguredTableAssociationAnalysisRuleInput, options: get_configured_table_association_analysis_rule.Options) !get_configured_table_association_analysis_rule.GetConfiguredTableAssociationAnalysisRuleOutput {
        return get_configured_table_association_analysis_rule.execute(self, allocator, input, options);
    }

    /// Retrieves an ID mapping table.
    pub fn getIdMappingTable(self: *Self, allocator: std.mem.Allocator, input: get_id_mapping_table.GetIdMappingTableInput, options: get_id_mapping_table.Options) !get_id_mapping_table.GetIdMappingTableOutput {
        return get_id_mapping_table.execute(self, allocator, input, options);
    }

    /// Retrieves an ID namespace association.
    pub fn getIdNamespaceAssociation(self: *Self, allocator: std.mem.Allocator, input: get_id_namespace_association.GetIdNamespaceAssociationInput, options: get_id_namespace_association.Options) !get_id_namespace_association.GetIdNamespaceAssociationOutput {
        return get_id_namespace_association.execute(self, allocator, input, options);
    }

    /// Retrieves a specified membership for an identifier.
    pub fn getMembership(self: *Self, allocator: std.mem.Allocator, input: get_membership.GetMembershipInput, options: get_membership.Options) !get_membership.GetMembershipOutput {
        return get_membership.execute(self, allocator, input, options);
    }

    /// Returns details for a specified privacy budget template.
    pub fn getPrivacyBudgetTemplate(self: *Self, allocator: std.mem.Allocator, input: get_privacy_budget_template.GetPrivacyBudgetTemplateInput, options: get_privacy_budget_template.Options) !get_privacy_budget_template.GetPrivacyBudgetTemplateOutput {
        return get_privacy_budget_template.execute(self, allocator, input, options);
    }

    /// Returns job processing metadata.
    pub fn getProtectedJob(self: *Self, allocator: std.mem.Allocator, input: get_protected_job.GetProtectedJobInput, options: get_protected_job.Options) !get_protected_job.GetProtectedJobOutput {
        return get_protected_job.execute(self, allocator, input, options);
    }

    /// Returns query processing metadata.
    pub fn getProtectedQuery(self: *Self, allocator: std.mem.Allocator, input: get_protected_query.GetProtectedQueryInput, options: get_protected_query.Options) !get_protected_query.GetProtectedQueryOutput {
        return get_protected_query.execute(self, allocator, input, options);
    }

    /// Retrieves the schema for a relation within a collaboration.
    pub fn getSchema(self: *Self, allocator: std.mem.Allocator, input: get_schema.GetSchemaInput, options: get_schema.Options) !get_schema.GetSchemaOutput {
        return get_schema.execute(self, allocator, input, options);
    }

    /// Retrieves a schema analysis rule.
    pub fn getSchemaAnalysisRule(self: *Self, allocator: std.mem.Allocator, input: get_schema_analysis_rule.GetSchemaAnalysisRuleInput, options: get_schema_analysis_rule.Options) !get_schema_analysis_rule.GetSchemaAnalysisRuleOutput {
        return get_schema_analysis_rule.execute(self, allocator, input, options);
    }

    /// Lists analysis templates that the caller owns.
    pub fn listAnalysisTemplates(self: *Self, allocator: std.mem.Allocator, input: list_analysis_templates.ListAnalysisTemplatesInput, options: list_analysis_templates.Options) !list_analysis_templates.ListAnalysisTemplatesOutput {
        return list_analysis_templates.execute(self, allocator, input, options);
    }

    /// Lists analysis templates within a collaboration.
    pub fn listCollaborationAnalysisTemplates(self: *Self, allocator: std.mem.Allocator, input: list_collaboration_analysis_templates.ListCollaborationAnalysisTemplatesInput, options: list_collaboration_analysis_templates.Options) !list_collaboration_analysis_templates.ListCollaborationAnalysisTemplatesOutput {
        return list_collaboration_analysis_templates.execute(self, allocator, input, options);
    }

    /// Lists all change requests for a collaboration with pagination support.
    /// Returns change requests sorted by creation time.
    pub fn listCollaborationChangeRequests(self: *Self, allocator: std.mem.Allocator, input: list_collaboration_change_requests.ListCollaborationChangeRequestsInput, options: list_collaboration_change_requests.Options) !list_collaboration_change_requests.ListCollaborationChangeRequestsOutput {
        return list_collaboration_change_requests.execute(self, allocator, input, options);
    }

    /// Lists configured audience model associations within a collaboration.
    pub fn listCollaborationConfiguredAudienceModelAssociations(self: *Self, allocator: std.mem.Allocator, input: list_collaboration_configured_audience_model_associations.ListCollaborationConfiguredAudienceModelAssociationsInput, options: list_collaboration_configured_audience_model_associations.Options) !list_collaboration_configured_audience_model_associations.ListCollaborationConfiguredAudienceModelAssociationsOutput {
        return list_collaboration_configured_audience_model_associations.execute(self, allocator, input, options);
    }

    /// Returns a list of the ID namespace associations in a collaboration.
    pub fn listCollaborationIdNamespaceAssociations(self: *Self, allocator: std.mem.Allocator, input: list_collaboration_id_namespace_associations.ListCollaborationIdNamespaceAssociationsInput, options: list_collaboration_id_namespace_associations.Options) !list_collaboration_id_namespace_associations.ListCollaborationIdNamespaceAssociationsOutput {
        return list_collaboration_id_namespace_associations.execute(self, allocator, input, options);
    }

    /// Returns an array that summarizes each privacy budget template in a specified
    /// collaboration.
    pub fn listCollaborationPrivacyBudgetTemplates(self: *Self, allocator: std.mem.Allocator, input: list_collaboration_privacy_budget_templates.ListCollaborationPrivacyBudgetTemplatesInput, options: list_collaboration_privacy_budget_templates.Options) !list_collaboration_privacy_budget_templates.ListCollaborationPrivacyBudgetTemplatesOutput {
        return list_collaboration_privacy_budget_templates.execute(self, allocator, input, options);
    }

    /// Returns an array that summarizes each privacy budget in a specified
    /// collaboration. The summary includes the collaboration ARN, creation time,
    /// creating account, and privacy budget details.
    pub fn listCollaborationPrivacyBudgets(self: *Self, allocator: std.mem.Allocator, input: list_collaboration_privacy_budgets.ListCollaborationPrivacyBudgetsInput, options: list_collaboration_privacy_budgets.Options) !list_collaboration_privacy_budgets.ListCollaborationPrivacyBudgetsOutput {
        return list_collaboration_privacy_budgets.execute(self, allocator, input, options);
    }

    /// Lists collaborations the caller owns, is active in, or has been invited to.
    pub fn listCollaborations(self: *Self, allocator: std.mem.Allocator, input: list_collaborations.ListCollaborationsInput, options: list_collaborations.Options) !list_collaborations.ListCollaborationsOutput {
        return list_collaborations.execute(self, allocator, input, options);
    }

    /// Lists information about requested configured audience model associations.
    pub fn listConfiguredAudienceModelAssociations(self: *Self, allocator: std.mem.Allocator, input: list_configured_audience_model_associations.ListConfiguredAudienceModelAssociationsInput, options: list_configured_audience_model_associations.Options) !list_configured_audience_model_associations.ListConfiguredAudienceModelAssociationsOutput {
        return list_configured_audience_model_associations.execute(self, allocator, input, options);
    }

    /// Lists configured table associations for a membership.
    pub fn listConfiguredTableAssociations(self: *Self, allocator: std.mem.Allocator, input: list_configured_table_associations.ListConfiguredTableAssociationsInput, options: list_configured_table_associations.Options) !list_configured_table_associations.ListConfiguredTableAssociationsOutput {
        return list_configured_table_associations.execute(self, allocator, input, options);
    }

    /// Lists configured tables.
    pub fn listConfiguredTables(self: *Self, allocator: std.mem.Allocator, input: list_configured_tables.ListConfiguredTablesInput, options: list_configured_tables.Options) !list_configured_tables.ListConfiguredTablesOutput {
        return list_configured_tables.execute(self, allocator, input, options);
    }

    /// Returns a list of ID mapping tables.
    pub fn listIdMappingTables(self: *Self, allocator: std.mem.Allocator, input: list_id_mapping_tables.ListIdMappingTablesInput, options: list_id_mapping_tables.Options) !list_id_mapping_tables.ListIdMappingTablesOutput {
        return list_id_mapping_tables.execute(self, allocator, input, options);
    }

    /// Returns a list of ID namespace associations.
    pub fn listIdNamespaceAssociations(self: *Self, allocator: std.mem.Allocator, input: list_id_namespace_associations.ListIdNamespaceAssociationsInput, options: list_id_namespace_associations.Options) !list_id_namespace_associations.ListIdNamespaceAssociationsOutput {
        return list_id_namespace_associations.execute(self, allocator, input, options);
    }

    /// Lists all members within a collaboration.
    pub fn listMembers(self: *Self, allocator: std.mem.Allocator, input: list_members.ListMembersInput, options: list_members.Options) !list_members.ListMembersOutput {
        return list_members.execute(self, allocator, input, options);
    }

    /// Lists all memberships resources within the caller's account.
    pub fn listMemberships(self: *Self, allocator: std.mem.Allocator, input: list_memberships.ListMembershipsInput, options: list_memberships.Options) !list_memberships.ListMembershipsOutput {
        return list_memberships.execute(self, allocator, input, options);
    }

    /// Returns detailed information about the privacy budget templates in a
    /// specified membership.
    pub fn listPrivacyBudgetTemplates(self: *Self, allocator: std.mem.Allocator, input: list_privacy_budget_templates.ListPrivacyBudgetTemplatesInput, options: list_privacy_budget_templates.Options) !list_privacy_budget_templates.ListPrivacyBudgetTemplatesOutput {
        return list_privacy_budget_templates.execute(self, allocator, input, options);
    }

    /// Returns detailed information about the privacy budgets in a specified
    /// membership.
    pub fn listPrivacyBudgets(self: *Self, allocator: std.mem.Allocator, input: list_privacy_budgets.ListPrivacyBudgetsInput, options: list_privacy_budgets.Options) !list_privacy_budgets.ListPrivacyBudgetsOutput {
        return list_privacy_budgets.execute(self, allocator, input, options);
    }

    /// Lists protected jobs, sorted by most recent job.
    pub fn listProtectedJobs(self: *Self, allocator: std.mem.Allocator, input: list_protected_jobs.ListProtectedJobsInput, options: list_protected_jobs.Options) !list_protected_jobs.ListProtectedJobsOutput {
        return list_protected_jobs.execute(self, allocator, input, options);
    }

    /// Lists protected queries, sorted by the most recent query.
    pub fn listProtectedQueries(self: *Self, allocator: std.mem.Allocator, input: list_protected_queries.ListProtectedQueriesInput, options: list_protected_queries.Options) !list_protected_queries.ListProtectedQueriesOutput {
        return list_protected_queries.execute(self, allocator, input, options);
    }

    /// Lists the schemas for relations within a collaboration.
    pub fn listSchemas(self: *Self, allocator: std.mem.Allocator, input: list_schemas.ListSchemasInput, options: list_schemas.Options) !list_schemas.ListSchemasOutput {
        return list_schemas.execute(self, allocator, input, options);
    }

    /// Lists all of the tags that have been added to a resource.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: list_tags_for_resource.Options) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Defines the information that's necessary to populate an ID mapping table.
    pub fn populateIdMappingTable(self: *Self, allocator: std.mem.Allocator, input: populate_id_mapping_table.PopulateIdMappingTableInput, options: populate_id_mapping_table.Options) !populate_id_mapping_table.PopulateIdMappingTableOutput {
        return populate_id_mapping_table.execute(self, allocator, input, options);
    }

    /// An estimate of the number of aggregation functions that the member who can
    /// query can run given epsilon and noise parameters.
    pub fn previewPrivacyImpact(self: *Self, allocator: std.mem.Allocator, input: preview_privacy_impact.PreviewPrivacyImpactInput, options: preview_privacy_impact.Options) !preview_privacy_impact.PreviewPrivacyImpactOutput {
        return preview_privacy_impact.execute(self, allocator, input, options);
    }

    /// Creates a protected job that is started by Clean Rooms.
    pub fn startProtectedJob(self: *Self, allocator: std.mem.Allocator, input: start_protected_job.StartProtectedJobInput, options: start_protected_job.Options) !start_protected_job.StartProtectedJobOutput {
        return start_protected_job.execute(self, allocator, input, options);
    }

    /// Creates a protected query that is started by Clean Rooms.
    pub fn startProtectedQuery(self: *Self, allocator: std.mem.Allocator, input: start_protected_query.StartProtectedQueryInput, options: start_protected_query.Options) !start_protected_query.StartProtectedQueryOutput {
        return start_protected_query.execute(self, allocator, input, options);
    }

    /// Tags a resource.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: tag_resource.Options) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Removes a tag or list of tags from a resource.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: untag_resource.Options) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Updates the analysis template metadata.
    pub fn updateAnalysisTemplate(self: *Self, allocator: std.mem.Allocator, input: update_analysis_template.UpdateAnalysisTemplateInput, options: update_analysis_template.Options) !update_analysis_template.UpdateAnalysisTemplateOutput {
        return update_analysis_template.execute(self, allocator, input, options);
    }

    /// Updates collaboration metadata and can only be called by the collaboration
    /// owner.
    pub fn updateCollaboration(self: *Self, allocator: std.mem.Allocator, input: update_collaboration.UpdateCollaborationInput, options: update_collaboration.Options) !update_collaboration.UpdateCollaborationOutput {
        return update_collaboration.execute(self, allocator, input, options);
    }

    /// Updates an existing collaboration change request. This operation allows
    /// approval actions for pending change requests in collaborations (APPROVE,
    /// DENY, CANCEL, COMMIT).
    ///
    /// For change requests without automatic approval, a member in the
    /// collaboration can manually APPROVE or DENY a change request. The
    /// collaboration owner can manually CANCEL or COMMIT a change request.
    pub fn updateCollaborationChangeRequest(self: *Self, allocator: std.mem.Allocator, input: update_collaboration_change_request.UpdateCollaborationChangeRequestInput, options: update_collaboration_change_request.Options) !update_collaboration_change_request.UpdateCollaborationChangeRequestOutput {
        return update_collaboration_change_request.execute(self, allocator, input, options);
    }

    /// Provides the details necessary to update a configured audience model
    /// association.
    pub fn updateConfiguredAudienceModelAssociation(self: *Self, allocator: std.mem.Allocator, input: update_configured_audience_model_association.UpdateConfiguredAudienceModelAssociationInput, options: update_configured_audience_model_association.Options) !update_configured_audience_model_association.UpdateConfiguredAudienceModelAssociationOutput {
        return update_configured_audience_model_association.execute(self, allocator, input, options);
    }

    /// Updates a configured table.
    pub fn updateConfiguredTable(self: *Self, allocator: std.mem.Allocator, input: update_configured_table.UpdateConfiguredTableInput, options: update_configured_table.Options) !update_configured_table.UpdateConfiguredTableOutput {
        return update_configured_table.execute(self, allocator, input, options);
    }

    /// Updates a configured table analysis rule.
    pub fn updateConfiguredTableAnalysisRule(self: *Self, allocator: std.mem.Allocator, input: update_configured_table_analysis_rule.UpdateConfiguredTableAnalysisRuleInput, options: update_configured_table_analysis_rule.Options) !update_configured_table_analysis_rule.UpdateConfiguredTableAnalysisRuleOutput {
        return update_configured_table_analysis_rule.execute(self, allocator, input, options);
    }

    /// Updates a configured table association.
    pub fn updateConfiguredTableAssociation(self: *Self, allocator: std.mem.Allocator, input: update_configured_table_association.UpdateConfiguredTableAssociationInput, options: update_configured_table_association.Options) !update_configured_table_association.UpdateConfiguredTableAssociationOutput {
        return update_configured_table_association.execute(self, allocator, input, options);
    }

    /// Updates the analysis rule for a configured table association.
    pub fn updateConfiguredTableAssociationAnalysisRule(self: *Self, allocator: std.mem.Allocator, input: update_configured_table_association_analysis_rule.UpdateConfiguredTableAssociationAnalysisRuleInput, options: update_configured_table_association_analysis_rule.Options) !update_configured_table_association_analysis_rule.UpdateConfiguredTableAssociationAnalysisRuleOutput {
        return update_configured_table_association_analysis_rule.execute(self, allocator, input, options);
    }

    /// Provides the details that are necessary to update an ID mapping table.
    pub fn updateIdMappingTable(self: *Self, allocator: std.mem.Allocator, input: update_id_mapping_table.UpdateIdMappingTableInput, options: update_id_mapping_table.Options) !update_id_mapping_table.UpdateIdMappingTableOutput {
        return update_id_mapping_table.execute(self, allocator, input, options);
    }

    /// Provides the details that are necessary to update an ID namespace
    /// association.
    pub fn updateIdNamespaceAssociation(self: *Self, allocator: std.mem.Allocator, input: update_id_namespace_association.UpdateIdNamespaceAssociationInput, options: update_id_namespace_association.Options) !update_id_namespace_association.UpdateIdNamespaceAssociationOutput {
        return update_id_namespace_association.execute(self, allocator, input, options);
    }

    /// Updates a membership.
    pub fn updateMembership(self: *Self, allocator: std.mem.Allocator, input: update_membership.UpdateMembershipInput, options: update_membership.Options) !update_membership.UpdateMembershipOutput {
        return update_membership.execute(self, allocator, input, options);
    }

    /// Updates the privacy budget template for the specified collaboration.
    pub fn updatePrivacyBudgetTemplate(self: *Self, allocator: std.mem.Allocator, input: update_privacy_budget_template.UpdatePrivacyBudgetTemplateInput, options: update_privacy_budget_template.Options) !update_privacy_budget_template.UpdatePrivacyBudgetTemplateOutput {
        return update_privacy_budget_template.execute(self, allocator, input, options);
    }

    /// Updates the processing of a currently running job.
    pub fn updateProtectedJob(self: *Self, allocator: std.mem.Allocator, input: update_protected_job.UpdateProtectedJobInput, options: update_protected_job.Options) !update_protected_job.UpdateProtectedJobOutput {
        return update_protected_job.execute(self, allocator, input, options);
    }

    /// Updates the processing of a currently running query.
    pub fn updateProtectedQuery(self: *Self, allocator: std.mem.Allocator, input: update_protected_query.UpdateProtectedQueryInput, options: update_protected_query.Options) !update_protected_query.UpdateProtectedQueryOutput {
        return update_protected_query.execute(self, allocator, input, options);
    }

    pub fn listAnalysisTemplatesPaginator(self: *Self, params: list_analysis_templates.ListAnalysisTemplatesInput) paginator.ListAnalysisTemplatesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listCollaborationAnalysisTemplatesPaginator(self: *Self, params: list_collaboration_analysis_templates.ListCollaborationAnalysisTemplatesInput) paginator.ListCollaborationAnalysisTemplatesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listCollaborationChangeRequestsPaginator(self: *Self, params: list_collaboration_change_requests.ListCollaborationChangeRequestsInput) paginator.ListCollaborationChangeRequestsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listCollaborationConfiguredAudienceModelAssociationsPaginator(self: *Self, params: list_collaboration_configured_audience_model_associations.ListCollaborationConfiguredAudienceModelAssociationsInput) paginator.ListCollaborationConfiguredAudienceModelAssociationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listCollaborationIdNamespaceAssociationsPaginator(self: *Self, params: list_collaboration_id_namespace_associations.ListCollaborationIdNamespaceAssociationsInput) paginator.ListCollaborationIdNamespaceAssociationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listCollaborationPrivacyBudgetTemplatesPaginator(self: *Self, params: list_collaboration_privacy_budget_templates.ListCollaborationPrivacyBudgetTemplatesInput) paginator.ListCollaborationPrivacyBudgetTemplatesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listCollaborationPrivacyBudgetsPaginator(self: *Self, params: list_collaboration_privacy_budgets.ListCollaborationPrivacyBudgetsInput) paginator.ListCollaborationPrivacyBudgetsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listCollaborationsPaginator(self: *Self, params: list_collaborations.ListCollaborationsInput) paginator.ListCollaborationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listConfiguredAudienceModelAssociationsPaginator(self: *Self, params: list_configured_audience_model_associations.ListConfiguredAudienceModelAssociationsInput) paginator.ListConfiguredAudienceModelAssociationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listConfiguredTableAssociationsPaginator(self: *Self, params: list_configured_table_associations.ListConfiguredTableAssociationsInput) paginator.ListConfiguredTableAssociationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listConfiguredTablesPaginator(self: *Self, params: list_configured_tables.ListConfiguredTablesInput) paginator.ListConfiguredTablesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listIdMappingTablesPaginator(self: *Self, params: list_id_mapping_tables.ListIdMappingTablesInput) paginator.ListIdMappingTablesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listIdNamespaceAssociationsPaginator(self: *Self, params: list_id_namespace_associations.ListIdNamespaceAssociationsInput) paginator.ListIdNamespaceAssociationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listMembersPaginator(self: *Self, params: list_members.ListMembersInput) paginator.ListMembersPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listMembershipsPaginator(self: *Self, params: list_memberships.ListMembershipsInput) paginator.ListMembershipsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listPrivacyBudgetTemplatesPaginator(self: *Self, params: list_privacy_budget_templates.ListPrivacyBudgetTemplatesInput) paginator.ListPrivacyBudgetTemplatesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listPrivacyBudgetsPaginator(self: *Self, params: list_privacy_budgets.ListPrivacyBudgetsInput) paginator.ListPrivacyBudgetsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listProtectedJobsPaginator(self: *Self, params: list_protected_jobs.ListProtectedJobsInput) paginator.ListProtectedJobsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listProtectedQueriesPaginator(self: *Self, params: list_protected_queries.ListProtectedQueriesInput) paginator.ListProtectedQueriesPaginator {
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
};
