const aws = @import("aws");
const std = @import("std");

const create_cell = @import("create_cell.zig");
const create_cross_account_authorization = @import("create_cross_account_authorization.zig");
const create_readiness_check = @import("create_readiness_check.zig");
const create_recovery_group = @import("create_recovery_group.zig");
const create_resource_set = @import("create_resource_set.zig");
const delete_cell = @import("delete_cell.zig");
const delete_cross_account_authorization = @import("delete_cross_account_authorization.zig");
const delete_readiness_check = @import("delete_readiness_check.zig");
const delete_recovery_group = @import("delete_recovery_group.zig");
const delete_resource_set = @import("delete_resource_set.zig");
const get_architecture_recommendations = @import("get_architecture_recommendations.zig");
const get_cell = @import("get_cell.zig");
const get_cell_readiness_summary = @import("get_cell_readiness_summary.zig");
const get_readiness_check = @import("get_readiness_check.zig");
const get_readiness_check_resource_status = @import("get_readiness_check_resource_status.zig");
const get_readiness_check_status = @import("get_readiness_check_status.zig");
const get_recovery_group = @import("get_recovery_group.zig");
const get_recovery_group_readiness_summary = @import("get_recovery_group_readiness_summary.zig");
const get_resource_set = @import("get_resource_set.zig");
const list_cells = @import("list_cells.zig");
const list_cross_account_authorizations = @import("list_cross_account_authorizations.zig");
const list_readiness_checks = @import("list_readiness_checks.zig");
const list_recovery_groups = @import("list_recovery_groups.zig");
const list_resource_sets = @import("list_resource_sets.zig");
const list_rules = @import("list_rules.zig");
const list_tags_for_resources = @import("list_tags_for_resources.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_cell = @import("update_cell.zig");
const update_readiness_check = @import("update_readiness_check.zig");
const update_recovery_group = @import("update_recovery_group.zig");
const update_resource_set = @import("update_resource_set.zig");
const CallOptions = @import("call_options.zig").CallOptions;
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "Route53 Recovery Readiness";

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

    /// Creates a cell in an account.
    pub fn createCell(self: *Self, allocator: std.mem.Allocator, input: create_cell.CreateCellInput, options: CallOptions) !create_cell.CreateCellOutput {
        return create_cell.execute(self, allocator, input, options);
    }

    /// Creates a cross-account readiness authorization. This lets you authorize
    /// another account to work with Route 53 Application Recovery Controller, for
    /// example, to check the readiness status of resources in a separate account.
    pub fn createCrossAccountAuthorization(self: *Self, allocator: std.mem.Allocator, input: create_cross_account_authorization.CreateCrossAccountAuthorizationInput, options: CallOptions) !create_cross_account_authorization.CreateCrossAccountAuthorizationOutput {
        return create_cross_account_authorization.execute(self, allocator, input, options);
    }

    /// Creates a readiness check in an account. A readiness check monitors a
    /// resource set in your application, such as a set of Amazon Aurora instances,
    /// that Application Recovery Controller is auditing recovery readiness for. The
    /// audits run once every minute on every resource that's associated with a
    /// readiness check.
    pub fn createReadinessCheck(self: *Self, allocator: std.mem.Allocator, input: create_readiness_check.CreateReadinessCheckInput, options: CallOptions) !create_readiness_check.CreateReadinessCheckOutput {
        return create_readiness_check.execute(self, allocator, input, options);
    }

    /// Creates a recovery group in an account. A recovery group corresponds to an
    /// application and includes a list of the cells that make up the application.
    pub fn createRecoveryGroup(self: *Self, allocator: std.mem.Allocator, input: create_recovery_group.CreateRecoveryGroupInput, options: CallOptions) !create_recovery_group.CreateRecoveryGroupOutput {
        return create_recovery_group.execute(self, allocator, input, options);
    }

    /// Creates a resource set. A resource set is a set of resources of one type
    /// that span multiple cells. You can associate a resource set with a readiness
    /// check to monitor the resources for failover readiness.
    pub fn createResourceSet(self: *Self, allocator: std.mem.Allocator, input: create_resource_set.CreateResourceSetInput, options: CallOptions) !create_resource_set.CreateResourceSetOutput {
        return create_resource_set.execute(self, allocator, input, options);
    }

    /// Delete a cell. When successful, the response code is 204, with no response
    /// body.
    pub fn deleteCell(self: *Self, allocator: std.mem.Allocator, input: delete_cell.DeleteCellInput, options: CallOptions) !delete_cell.DeleteCellOutput {
        return delete_cell.execute(self, allocator, input, options);
    }

    /// Deletes cross account readiness authorization.
    pub fn deleteCrossAccountAuthorization(self: *Self, allocator: std.mem.Allocator, input: delete_cross_account_authorization.DeleteCrossAccountAuthorizationInput, options: CallOptions) !delete_cross_account_authorization.DeleteCrossAccountAuthorizationOutput {
        return delete_cross_account_authorization.execute(self, allocator, input, options);
    }

    /// Deletes a readiness check.
    pub fn deleteReadinessCheck(self: *Self, allocator: std.mem.Allocator, input: delete_readiness_check.DeleteReadinessCheckInput, options: CallOptions) !delete_readiness_check.DeleteReadinessCheckOutput {
        return delete_readiness_check.execute(self, allocator, input, options);
    }

    /// Deletes a recovery group.
    pub fn deleteRecoveryGroup(self: *Self, allocator: std.mem.Allocator, input: delete_recovery_group.DeleteRecoveryGroupInput, options: CallOptions) !delete_recovery_group.DeleteRecoveryGroupOutput {
        return delete_recovery_group.execute(self, allocator, input, options);
    }

    /// Deletes a resource set.
    pub fn deleteResourceSet(self: *Self, allocator: std.mem.Allocator, input: delete_resource_set.DeleteResourceSetInput, options: CallOptions) !delete_resource_set.DeleteResourceSetOutput {
        return delete_resource_set.execute(self, allocator, input, options);
    }

    /// Gets recommendations about architecture designs for improving resiliency for
    /// an application, based on a recovery group.
    pub fn getArchitectureRecommendations(self: *Self, allocator: std.mem.Allocator, input: get_architecture_recommendations.GetArchitectureRecommendationsInput, options: CallOptions) !get_architecture_recommendations.GetArchitectureRecommendationsOutput {
        return get_architecture_recommendations.execute(self, allocator, input, options);
    }

    /// Gets information about a cell including cell name, cell Amazon Resource Name
    /// (ARN), ARNs of nested cells for this cell, and a list of those cell ARNs
    /// with their associated recovery group ARNs.
    pub fn getCell(self: *Self, allocator: std.mem.Allocator, input: get_cell.GetCellInput, options: CallOptions) !get_cell.GetCellOutput {
        return get_cell.execute(self, allocator, input, options);
    }

    /// Gets readiness for a cell. Aggregates the readiness of all the resources
    /// that are associated with the cell into a single value.
    pub fn getCellReadinessSummary(self: *Self, allocator: std.mem.Allocator, input: get_cell_readiness_summary.GetCellReadinessSummaryInput, options: CallOptions) !get_cell_readiness_summary.GetCellReadinessSummaryOutput {
        return get_cell_readiness_summary.execute(self, allocator, input, options);
    }

    /// Gets details about a readiness check.
    pub fn getReadinessCheck(self: *Self, allocator: std.mem.Allocator, input: get_readiness_check.GetReadinessCheckInput, options: CallOptions) !get_readiness_check.GetReadinessCheckOutput {
        return get_readiness_check.execute(self, allocator, input, options);
    }

    /// Gets individual readiness status for a readiness check. To see the overall
    /// readiness status for a recovery group, that considers the readiness status
    /// for all the readiness checks in the recovery group, use
    /// GetRecoveryGroupReadinessSummary.
    pub fn getReadinessCheckResourceStatus(self: *Self, allocator: std.mem.Allocator, input: get_readiness_check_resource_status.GetReadinessCheckResourceStatusInput, options: CallOptions) !get_readiness_check_resource_status.GetReadinessCheckResourceStatusOutput {
        return get_readiness_check_resource_status.execute(self, allocator, input, options);
    }

    /// Gets the readiness status for an individual readiness check. To see the
    /// overall readiness status for a recovery group, that considers the readiness
    /// status for all the readiness checks in a recovery group, use
    /// GetRecoveryGroupReadinessSummary.
    pub fn getReadinessCheckStatus(self: *Self, allocator: std.mem.Allocator, input: get_readiness_check_status.GetReadinessCheckStatusInput, options: CallOptions) !get_readiness_check_status.GetReadinessCheckStatusOutput {
        return get_readiness_check_status.execute(self, allocator, input, options);
    }

    /// Gets details about a recovery group, including a list of the cells that are
    /// included in it.
    pub fn getRecoveryGroup(self: *Self, allocator: std.mem.Allocator, input: get_recovery_group.GetRecoveryGroupInput, options: CallOptions) !get_recovery_group.GetRecoveryGroupOutput {
        return get_recovery_group.execute(self, allocator, input, options);
    }

    /// Displays a summary of information about a recovery group's readiness status.
    /// Includes the readiness checks for resources in the recovery group and the
    /// readiness status of each one.
    pub fn getRecoveryGroupReadinessSummary(self: *Self, allocator: std.mem.Allocator, input: get_recovery_group_readiness_summary.GetRecoveryGroupReadinessSummaryInput, options: CallOptions) !get_recovery_group_readiness_summary.GetRecoveryGroupReadinessSummaryOutput {
        return get_recovery_group_readiness_summary.execute(self, allocator, input, options);
    }

    /// Displays the details about a resource set, including a list of the resources
    /// in the set.
    pub fn getResourceSet(self: *Self, allocator: std.mem.Allocator, input: get_resource_set.GetResourceSetInput, options: CallOptions) !get_resource_set.GetResourceSetOutput {
        return get_resource_set.execute(self, allocator, input, options);
    }

    /// Lists the cells for an account.
    pub fn listCells(self: *Self, allocator: std.mem.Allocator, input: list_cells.ListCellsInput, options: CallOptions) !list_cells.ListCellsOutput {
        return list_cells.execute(self, allocator, input, options);
    }

    /// Lists the cross-account readiness authorizations that are in place for an
    /// account.
    pub fn listCrossAccountAuthorizations(self: *Self, allocator: std.mem.Allocator, input: list_cross_account_authorizations.ListCrossAccountAuthorizationsInput, options: CallOptions) !list_cross_account_authorizations.ListCrossAccountAuthorizationsOutput {
        return list_cross_account_authorizations.execute(self, allocator, input, options);
    }

    /// Lists the readiness checks for an account.
    pub fn listReadinessChecks(self: *Self, allocator: std.mem.Allocator, input: list_readiness_checks.ListReadinessChecksInput, options: CallOptions) !list_readiness_checks.ListReadinessChecksOutput {
        return list_readiness_checks.execute(self, allocator, input, options);
    }

    /// Lists the recovery groups in an account.
    pub fn listRecoveryGroups(self: *Self, allocator: std.mem.Allocator, input: list_recovery_groups.ListRecoveryGroupsInput, options: CallOptions) !list_recovery_groups.ListRecoveryGroupsOutput {
        return list_recovery_groups.execute(self, allocator, input, options);
    }

    /// Lists the resource sets in an account.
    pub fn listResourceSets(self: *Self, allocator: std.mem.Allocator, input: list_resource_sets.ListResourceSetsInput, options: CallOptions) !list_resource_sets.ListResourceSetsOutput {
        return list_resource_sets.execute(self, allocator, input, options);
    }

    /// Lists all readiness rules, or lists the readiness rules for a specific
    /// resource type.
    pub fn listRules(self: *Self, allocator: std.mem.Allocator, input: list_rules.ListRulesInput, options: CallOptions) !list_rules.ListRulesOutput {
        return list_rules.execute(self, allocator, input, options);
    }

    /// Lists the tags for a resource.
    pub fn listTagsForResources(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resources.ListTagsForResourcesInput, options: CallOptions) !list_tags_for_resources.ListTagsForResourcesOutput {
        return list_tags_for_resources.execute(self, allocator, input, options);
    }

    /// Adds a tag to a resource.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: CallOptions) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Removes a tag from a resource.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: CallOptions) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Updates a cell to replace the list of nested cells with a new list of nested
    /// cells.
    pub fn updateCell(self: *Self, allocator: std.mem.Allocator, input: update_cell.UpdateCellInput, options: CallOptions) !update_cell.UpdateCellOutput {
        return update_cell.execute(self, allocator, input, options);
    }

    /// Updates a readiness check.
    pub fn updateReadinessCheck(self: *Self, allocator: std.mem.Allocator, input: update_readiness_check.UpdateReadinessCheckInput, options: CallOptions) !update_readiness_check.UpdateReadinessCheckOutput {
        return update_readiness_check.execute(self, allocator, input, options);
    }

    /// Updates a recovery group.
    pub fn updateRecoveryGroup(self: *Self, allocator: std.mem.Allocator, input: update_recovery_group.UpdateRecoveryGroupInput, options: CallOptions) !update_recovery_group.UpdateRecoveryGroupOutput {
        return update_recovery_group.execute(self, allocator, input, options);
    }

    /// Updates a resource set.
    pub fn updateResourceSet(self: *Self, allocator: std.mem.Allocator, input: update_resource_set.UpdateResourceSetInput, options: CallOptions) !update_resource_set.UpdateResourceSetOutput {
        return update_resource_set.execute(self, allocator, input, options);
    }

    pub fn getCellReadinessSummaryPaginator(self: *Self, params: get_cell_readiness_summary.GetCellReadinessSummaryInput) paginator.GetCellReadinessSummaryPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn getReadinessCheckResourceStatusPaginator(self: *Self, params: get_readiness_check_resource_status.GetReadinessCheckResourceStatusInput) paginator.GetReadinessCheckResourceStatusPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn getReadinessCheckStatusPaginator(self: *Self, params: get_readiness_check_status.GetReadinessCheckStatusInput) paginator.GetReadinessCheckStatusPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn getRecoveryGroupReadinessSummaryPaginator(self: *Self, params: get_recovery_group_readiness_summary.GetRecoveryGroupReadinessSummaryInput) paginator.GetRecoveryGroupReadinessSummaryPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listCellsPaginator(self: *Self, params: list_cells.ListCellsInput) paginator.ListCellsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listCrossAccountAuthorizationsPaginator(self: *Self, params: list_cross_account_authorizations.ListCrossAccountAuthorizationsInput) paginator.ListCrossAccountAuthorizationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listReadinessChecksPaginator(self: *Self, params: list_readiness_checks.ListReadinessChecksInput) paginator.ListReadinessChecksPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listRecoveryGroupsPaginator(self: *Self, params: list_recovery_groups.ListRecoveryGroupsInput) paginator.ListRecoveryGroupsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listResourceSetsPaginator(self: *Self, params: list_resource_sets.ListResourceSetsInput) paginator.ListResourceSetsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listRulesPaginator(self: *Self, params: list_rules.ListRulesInput) paginator.ListRulesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};
