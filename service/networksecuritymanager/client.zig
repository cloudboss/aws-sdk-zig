const aws = @import("aws");
const std = @import("std");

const create_deployment = @import("create_deployment.zig");
const create_deployment_snapshot = @import("create_deployment_snapshot.zig");
const create_policy = @import("create_policy.zig");
const create_policy_snapshot = @import("create_policy_snapshot.zig");
const create_rule = @import("create_rule.zig");
const create_rule_snapshot = @import("create_rule_snapshot.zig");
const create_scope = @import("create_scope.zig");
const create_scope_snapshot = @import("create_scope_snapshot.zig");
const create_template = @import("create_template.zig");
const create_template_snapshot = @import("create_template_snapshot.zig");
const delete_admin_account = @import("delete_admin_account.zig");
const delete_deployment = @import("delete_deployment.zig");
const delete_policy = @import("delete_policy.zig");
const delete_rule = @import("delete_rule.zig");
const delete_scope = @import("delete_scope.zig");
const delete_template = @import("delete_template.zig");
const generate_rule_configuration = @import("generate_rule_configuration.zig");
const get_admin_account = @import("get_admin_account.zig");
const get_deployment = @import("get_deployment.zig");
const get_policy = @import("get_policy.zig");
const get_rule = @import("get_rule.zig");
const get_scope = @import("get_scope.zig");
const get_template = @import("get_template.zig");
const list_admin_accounts = @import("list_admin_accounts.zig");
const list_aggregate_resource_synchronization_statuses = @import("list_aggregate_resource_synchronization_statuses.zig");
const list_deployment_snapshots = @import("list_deployment_snapshots.zig");
const list_deployments = @import("list_deployments.zig");
const list_policies = @import("list_policies.zig");
const list_policy_snapshots = @import("list_policy_snapshots.zig");
const list_resource_associations = @import("list_resource_associations.zig");
const list_resource_synchronization_statuses = @import("list_resource_synchronization_statuses.zig");
const list_rule_snapshots = @import("list_rule_snapshots.zig");
const list_rules = @import("list_rules.zig");
const list_scope_snapshots = @import("list_scope_snapshots.zig");
const list_scopes = @import("list_scopes.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const list_template_snapshots = @import("list_template_snapshots.zig");
const list_templates = @import("list_templates.zig");
const put_admin_account = @import("put_admin_account.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_deployment = @import("update_deployment.zig");
const update_policy = @import("update_policy.zig");
const update_rule = @import("update_rule.zig");
const update_scope = @import("update_scope.zig");
const update_template = @import("update_template.zig");
const CallOptions = @import("call_options.zig").CallOptions;
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    options: aws.http.RequestOptions = .{},

    const Self = @This();
    pub const sdk_id = "Network Security Manager";

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

    /// Creates a deployment. A deployment applies one or more policies to the
    /// accounts and resources selected by a scope. Use `isPublished` to create the
    /// deployment in published (`ACTIVE`) or draft (`DRAFT`) state. The response
    /// includes coverage information and any warnings about the deployment.
    pub fn createDeployment(self: *Self, allocator: std.mem.Allocator, input: create_deployment.CreateDeploymentInput, options: CallOptions) !create_deployment.CreateDeploymentOutput {
        return create_deployment.execute(self, allocator, input, options);
    }

    /// Creates a snapshot of the current published version of the specified
    /// deployment.
    pub fn createDeploymentSnapshot(self: *Self, allocator: std.mem.Allocator, input: create_deployment_snapshot.CreateDeploymentSnapshotInput, options: CallOptions) !create_deployment_snapshot.CreateDeploymentSnapshotOutput {
        return create_deployment_snapshot.execute(self, allocator, input, options);
    }

    /// Creates a policy. A policy combines templates and rules with enforcement
    /// settings for a firewall type, such as AWS WAF or AWS Shield Advanced. Use
    /// `isPublished` to create the policy in published (`ACTIVE`) or draft
    /// (`DRAFT`) state.
    pub fn createPolicy(self: *Self, allocator: std.mem.Allocator, input: create_policy.CreatePolicyInput, options: CallOptions) !create_policy.CreatePolicyOutput {
        return create_policy.execute(self, allocator, input, options);
    }

    /// Creates a snapshot of the current published version of the specified policy.
    pub fn createPolicySnapshot(self: *Self, allocator: std.mem.Allocator, input: create_policy_snapshot.CreatePolicySnapshotInput, options: CallOptions) !create_policy_snapshot.CreatePolicySnapshotOutput {
        return create_policy_snapshot.execute(self, allocator, input, options);
    }

    /// Creates a rule. A rule defines a network security configuration to enforce,
    /// such as an AWS WAF rule group or configuration data. Use `isPublished` to
    /// create the rule in published (`ACTIVE`) or draft (`DRAFT`) state.
    pub fn createRule(self: *Self, allocator: std.mem.Allocator, input: create_rule.CreateRuleInput, options: CallOptions) !create_rule.CreateRuleOutput {
        return create_rule.execute(self, allocator, input, options);
    }

    /// Creates a snapshot of the current published version of the specified rule. A
    /// snapshot is an immutable, versioned copy that other resources can reference.
    pub fn createRuleSnapshot(self: *Self, allocator: std.mem.Allocator, input: create_rule_snapshot.CreateRuleSnapshotInput, options: CallOptions) !create_rule_snapshot.CreateRuleSnapshotOutput {
        return create_rule_snapshot.execute(self, allocator, input, options);
    }

    /// Creates a scope. A scope selects the accounts and resources that a
    /// deployment applies to. Use `isPublished` to create the scope in published
    /// (`ACTIVE`) or draft (`DRAFT`) state.
    pub fn createScope(self: *Self, allocator: std.mem.Allocator, input: create_scope.CreateScopeInput, options: CallOptions) !create_scope.CreateScopeOutput {
        return create_scope.execute(self, allocator, input, options);
    }

    /// Creates a snapshot of the current published version of the specified scope.
    pub fn createScopeSnapshot(self: *Self, allocator: std.mem.Allocator, input: create_scope_snapshot.CreateScopeSnapshotInput, options: CallOptions) !create_scope_snapshot.CreateScopeSnapshotOutput {
        return create_scope_snapshot.execute(self, allocator, input, options);
    }

    /// Creates a template. A template groups one or more rules to simplify reuse
    /// across policies. You can also associate rules with a policy directly,
    /// without a template. Use `isPublished` to create the template in published
    /// (`ACTIVE`) or draft (`DRAFT`) state.
    pub fn createTemplate(self: *Self, allocator: std.mem.Allocator, input: create_template.CreateTemplateInput, options: CallOptions) !create_template.CreateTemplateOutput {
        return create_template.execute(self, allocator, input, options);
    }

    /// Creates a snapshot of the current published version of the specified
    /// template.
    pub fn createTemplateSnapshot(self: *Self, allocator: std.mem.Allocator, input: create_template_snapshot.CreateTemplateSnapshotInput, options: CallOptions) !create_template_snapshot.CreateTemplateSnapshotOutput {
        return create_template_snapshot.execute(self, allocator, input, options);
    }

    /// Removes the specified AWS Network Security Manager administrator account.
    pub fn deleteAdminAccount(self: *Self, allocator: std.mem.Allocator, input: delete_admin_account.DeleteAdminAccountInput, options: CallOptions) !delete_admin_account.DeleteAdminAccountOutput {
        return delete_admin_account.execute(self, allocator, input, options);
    }

    /// Deletes the specified deployment.
    pub fn deleteDeployment(self: *Self, allocator: std.mem.Allocator, input: delete_deployment.DeleteDeploymentInput, options: CallOptions) !delete_deployment.DeleteDeploymentOutput {
        return delete_deployment.execute(self, allocator, input, options);
    }

    /// Deletes the specified policy.
    pub fn deletePolicy(self: *Self, allocator: std.mem.Allocator, input: delete_policy.DeletePolicyInput, options: CallOptions) !delete_policy.DeletePolicyOutput {
        return delete_policy.execute(self, allocator, input, options);
    }

    /// Deletes the specified rule.
    pub fn deleteRule(self: *Self, allocator: std.mem.Allocator, input: delete_rule.DeleteRuleInput, options: CallOptions) !delete_rule.DeleteRuleOutput {
        return delete_rule.execute(self, allocator, input, options);
    }

    /// Deletes the specified scope.
    pub fn deleteScope(self: *Self, allocator: std.mem.Allocator, input: delete_scope.DeleteScopeInput, options: CallOptions) !delete_scope.DeleteScopeOutput {
        return delete_scope.execute(self, allocator, input, options);
    }

    /// Deletes the specified template.
    pub fn deleteTemplate(self: *Self, allocator: std.mem.Allocator, input: delete_template.DeleteTemplateInput, options: CallOptions) !delete_template.DeleteTemplateOutput {
        return delete_template.execute(self, allocator, input, options);
    }

    /// Generates a rule configuration from a natural-language description. Provide
    /// a prompt along with the rule's firewall type and rule type. The service
    /// returns a configuration that you can use when you create or update a rule.
    /// If you also provide an existing configuration, the service edits that
    /// configuration instead of generating a new one.
    pub fn generateRuleConfiguration(self: *Self, allocator: std.mem.Allocator, input: generate_rule_configuration.GenerateRuleConfigurationInput, options: CallOptions) !generate_rule_configuration.GenerateRuleConfigurationOutput {
        return generate_rule_configuration.execute(self, allocator, input, options);
    }

    /// Retrieves the details of the specified AWS Network Security Manager
    /// administrator account.
    pub fn getAdminAccount(self: *Self, allocator: std.mem.Allocator, input: get_admin_account.GetAdminAccountInput, options: CallOptions) !get_admin_account.GetAdminAccountOutput {
        return get_admin_account.execute(self, allocator, input, options);
    }

    /// Retrieves the details of the specified deployment, including coverage
    /// information and any warnings.
    pub fn getDeployment(self: *Self, allocator: std.mem.Allocator, input: get_deployment.GetDeploymentInput, options: CallOptions) !get_deployment.GetDeploymentOutput {
        return get_deployment.execute(self, allocator, input, options);
    }

    /// Retrieves the details of the specified policy.
    pub fn getPolicy(self: *Self, allocator: std.mem.Allocator, input: get_policy.GetPolicyInput, options: CallOptions) !get_policy.GetPolicyOutput {
        return get_policy.execute(self, allocator, input, options);
    }

    /// Retrieves the details of the specified rule.
    pub fn getRule(self: *Self, allocator: std.mem.Allocator, input: get_rule.GetRuleInput, options: CallOptions) !get_rule.GetRuleOutput {
        return get_rule.execute(self, allocator, input, options);
    }

    /// Retrieves the details of the specified scope.
    pub fn getScope(self: *Self, allocator: std.mem.Allocator, input: get_scope.GetScopeInput, options: CallOptions) !get_scope.GetScopeOutput {
        return get_scope.execute(self, allocator, input, options);
    }

    /// Retrieves the details of the specified template.
    pub fn getTemplate(self: *Self, allocator: std.mem.Allocator, input: get_template.GetTemplateInput, options: CallOptions) !get_template.GetTemplateOutput {
        return get_template.execute(self, allocator, input, options);
    }

    /// Lists the AWS Network Security Manager administrator accounts in the
    /// organization.
    pub fn listAdminAccounts(self: *Self, allocator: std.mem.Allocator, input: list_admin_accounts.ListAdminAccountsInput, options: CallOptions) !list_admin_accounts.ListAdminAccountsOutput {
        return list_admin_accounts.execute(self, allocator, input, options);
    }

    /// Lists the aggregated synchronization statuses of resources across the
    /// deployments in your administrator account. You can filter the results by
    /// synchronization status and page through them.
    pub fn listAggregateResourceSynchronizationStatuses(self: *Self, allocator: std.mem.Allocator, input: list_aggregate_resource_synchronization_statuses.ListAggregateResourceSynchronizationStatusesInput, options: CallOptions) !list_aggregate_resource_synchronization_statuses.ListAggregateResourceSynchronizationStatusesOutput {
        return list_aggregate_resource_synchronization_statuses.execute(self, allocator, input, options);
    }

    /// Lists the snapshots of the specified deployment.
    pub fn listDeploymentSnapshots(self: *Self, allocator: std.mem.Allocator, input: list_deployment_snapshots.ListDeploymentSnapshotsInput, options: CallOptions) !list_deployment_snapshots.ListDeploymentSnapshotsOutput {
        return list_deployment_snapshots.execute(self, allocator, input, options);
    }

    /// Lists the deployments in the account. You can filter the results by status
    /// and page through them using `maxResults` and `nextToken`.
    pub fn listDeployments(self: *Self, allocator: std.mem.Allocator, input: list_deployments.ListDeploymentsInput, options: CallOptions) !list_deployments.ListDeploymentsOutput {
        return list_deployments.execute(self, allocator, input, options);
    }

    /// Lists the policies in the account. You can filter the results by status and
    /// page through them using `maxResults` and `nextToken`.
    pub fn listPolicies(self: *Self, allocator: std.mem.Allocator, input: list_policies.ListPoliciesInput, options: CallOptions) !list_policies.ListPoliciesOutput {
        return list_policies.execute(self, allocator, input, options);
    }

    /// Lists the snapshots of the specified policy.
    pub fn listPolicySnapshots(self: *Self, allocator: std.mem.Allocator, input: list_policy_snapshots.ListPolicySnapshotsInput, options: CallOptions) !list_policy_snapshots.ListPolicySnapshotsOutput {
        return list_policy_snapshots.execute(self, allocator, input, options);
    }

    /// Lists the resources associated with the specified resource.
    pub fn listResourceAssociations(self: *Self, allocator: std.mem.Allocator, input: list_resource_associations.ListResourceAssociationsInput, options: CallOptions) !list_resource_associations.ListResourceAssociationsOutput {
        return list_resource_associations.execute(self, allocator, input, options);
    }

    /// Lists the synchronization statuses of the resources covered by the specified
    /// deployment. You can filter the results by synchronization status and page
    /// through them.
    pub fn listResourceSynchronizationStatuses(self: *Self, allocator: std.mem.Allocator, input: list_resource_synchronization_statuses.ListResourceSynchronizationStatusesInput, options: CallOptions) !list_resource_synchronization_statuses.ListResourceSynchronizationStatusesOutput {
        return list_resource_synchronization_statuses.execute(self, allocator, input, options);
    }

    /// Lists the snapshots of the specified rule.
    pub fn listRuleSnapshots(self: *Self, allocator: std.mem.Allocator, input: list_rule_snapshots.ListRuleSnapshotsInput, options: CallOptions) !list_rule_snapshots.ListRuleSnapshotsOutput {
        return list_rule_snapshots.execute(self, allocator, input, options);
    }

    /// Lists the rules in the account. You can filter the results by status and
    /// page through them using `maxResults` and `nextToken`.
    pub fn listRules(self: *Self, allocator: std.mem.Allocator, input: list_rules.ListRulesInput, options: CallOptions) !list_rules.ListRulesOutput {
        return list_rules.execute(self, allocator, input, options);
    }

    /// Lists the snapshots of the specified scope.
    pub fn listScopeSnapshots(self: *Self, allocator: std.mem.Allocator, input: list_scope_snapshots.ListScopeSnapshotsInput, options: CallOptions) !list_scope_snapshots.ListScopeSnapshotsOutput {
        return list_scope_snapshots.execute(self, allocator, input, options);
    }

    /// Lists the scopes in the account. You can filter the results by status and
    /// page through them using `maxResults` and `nextToken`.
    pub fn listScopes(self: *Self, allocator: std.mem.Allocator, input: list_scopes.ListScopesInput, options: CallOptions) !list_scopes.ListScopesOutput {
        return list_scopes.execute(self, allocator, input, options);
    }

    /// Lists the tags associated with the specified resource.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: CallOptions) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Lists the snapshots of the specified template.
    pub fn listTemplateSnapshots(self: *Self, allocator: std.mem.Allocator, input: list_template_snapshots.ListTemplateSnapshotsInput, options: CallOptions) !list_template_snapshots.ListTemplateSnapshotsOutput {
        return list_template_snapshots.execute(self, allocator, input, options);
    }

    /// Lists the templates in the account. You can filter the results by status and
    /// page through them using `maxResults` and `nextToken`.
    pub fn listTemplates(self: *Self, allocator: std.mem.Allocator, input: list_templates.ListTemplatesInput, options: CallOptions) !list_templates.ListTemplatesOutput {
        return list_templates.execute(self, allocator, input, options);
    }

    /// Sets the AWS account that serves as an AWS Network Security Manager
    /// administrator account, and optionally configures the scope of resources that
    /// the administrator can manage.
    ///
    /// You can't set an administrator account again immediately after you remove
    /// it, or while the service creates its service-linked role. Retry the request
    /// after a few minutes.
    pub fn putAdminAccount(self: *Self, allocator: std.mem.Allocator, input: put_admin_account.PutAdminAccountInput, options: CallOptions) !put_admin_account.PutAdminAccountOutput {
        return put_admin_account.execute(self, allocator, input, options);
    }

    /// Adds or overwrites the specified tags on the given resource.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: CallOptions) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Removes the specified tags from the given resource.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: CallOptions) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Updates the specified deployment. To prevent conflicting concurrent updates,
    /// provide the current `updateToken`. Use `isPublished` to publish the update
    /// or keep the deployment as a draft.
    pub fn updateDeployment(self: *Self, allocator: std.mem.Allocator, input: update_deployment.UpdateDeploymentInput, options: CallOptions) !update_deployment.UpdateDeploymentOutput {
        return update_deployment.execute(self, allocator, input, options);
    }

    /// Updates the specified policy. To prevent conflicting concurrent updates,
    /// provide the current `updateToken`. Use `isPublished` to publish the update
    /// or keep the policy as a draft.
    pub fn updatePolicy(self: *Self, allocator: std.mem.Allocator, input: update_policy.UpdatePolicyInput, options: CallOptions) !update_policy.UpdatePolicyOutput {
        return update_policy.execute(self, allocator, input, options);
    }

    /// Updates the specified rule. To prevent conflicting concurrent updates,
    /// provide the current `updateToken`. Use `isPublished` to publish the update
    /// or keep the rule as a draft.
    pub fn updateRule(self: *Self, allocator: std.mem.Allocator, input: update_rule.UpdateRuleInput, options: CallOptions) !update_rule.UpdateRuleOutput {
        return update_rule.execute(self, allocator, input, options);
    }

    /// Updates the specified scope. To prevent conflicting concurrent updates,
    /// provide the current `updateToken`. Use `isPublished` to publish the update
    /// or keep the scope as a draft.
    pub fn updateScope(self: *Self, allocator: std.mem.Allocator, input: update_scope.UpdateScopeInput, options: CallOptions) !update_scope.UpdateScopeOutput {
        return update_scope.execute(self, allocator, input, options);
    }

    /// Updates the specified template. To prevent conflicting concurrent updates,
    /// provide the current `updateToken`. Use `isPublished` to publish the update
    /// or keep the template as a draft.
    pub fn updateTemplate(self: *Self, allocator: std.mem.Allocator, input: update_template.UpdateTemplateInput, options: CallOptions) !update_template.UpdateTemplateOutput {
        return update_template.execute(self, allocator, input, options);
    }

    pub fn listAdminAccountsPaginator(self: *Self, params: list_admin_accounts.ListAdminAccountsInput) paginator.ListAdminAccountsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listAggregateResourceSynchronizationStatusesPaginator(self: *Self, params: list_aggregate_resource_synchronization_statuses.ListAggregateResourceSynchronizationStatusesInput) paginator.ListAggregateResourceSynchronizationStatusesPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listDeploymentSnapshotsPaginator(self: *Self, params: list_deployment_snapshots.ListDeploymentSnapshotsInput) paginator.ListDeploymentSnapshotsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listDeploymentsPaginator(self: *Self, params: list_deployments.ListDeploymentsInput) paginator.ListDeploymentsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listPoliciesPaginator(self: *Self, params: list_policies.ListPoliciesInput) paginator.ListPoliciesPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listPolicySnapshotsPaginator(self: *Self, params: list_policy_snapshots.ListPolicySnapshotsInput) paginator.ListPolicySnapshotsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listResourceAssociationsPaginator(self: *Self, params: list_resource_associations.ListResourceAssociationsInput) paginator.ListResourceAssociationsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listResourceSynchronizationStatusesPaginator(self: *Self, params: list_resource_synchronization_statuses.ListResourceSynchronizationStatusesInput) paginator.ListResourceSynchronizationStatusesPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listRuleSnapshotsPaginator(self: *Self, params: list_rule_snapshots.ListRuleSnapshotsInput) paginator.ListRuleSnapshotsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listRulesPaginator(self: *Self, params: list_rules.ListRulesInput) paginator.ListRulesPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listScopeSnapshotsPaginator(self: *Self, params: list_scope_snapshots.ListScopeSnapshotsInput) paginator.ListScopeSnapshotsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listScopesPaginator(self: *Self, params: list_scopes.ListScopesInput) paginator.ListScopesPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listTemplateSnapshotsPaginator(self: *Self, params: list_template_snapshots.ListTemplateSnapshotsInput) paginator.ListTemplateSnapshotsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listTemplatesPaginator(self: *Self, params: list_templates.ListTemplatesInput) paginator.ListTemplatesPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }
};
