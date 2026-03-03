const aws = @import("aws");
const std = @import("std");

const accept_invitation = @import("accept_invitation.zig");
const batch_get_graph_member_datasources = @import("batch_get_graph_member_datasources.zig");
const batch_get_membership_datasources = @import("batch_get_membership_datasources.zig");
const create_graph = @import("create_graph.zig");
const create_members = @import("create_members.zig");
const delete_graph = @import("delete_graph.zig");
const delete_members = @import("delete_members.zig");
const describe_organization_configuration = @import("describe_organization_configuration.zig");
const disable_organization_admin_account = @import("disable_organization_admin_account.zig");
const disassociate_membership = @import("disassociate_membership.zig");
const enable_organization_admin_account = @import("enable_organization_admin_account.zig");
const get_investigation = @import("get_investigation.zig");
const get_members = @import("get_members.zig");
const list_datasource_packages = @import("list_datasource_packages.zig");
const list_graphs = @import("list_graphs.zig");
const list_indicators = @import("list_indicators.zig");
const list_investigations = @import("list_investigations.zig");
const list_invitations = @import("list_invitations.zig");
const list_members = @import("list_members.zig");
const list_organization_admin_accounts = @import("list_organization_admin_accounts.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const reject_invitation = @import("reject_invitation.zig");
const start_investigation = @import("start_investigation.zig");
const start_monitoring_member = @import("start_monitoring_member.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_datasource_packages = @import("update_datasource_packages.zig");
const update_investigation_state = @import("update_investigation_state.zig");
const update_organization_configuration = @import("update_organization_configuration.zig");
const CallOptions = @import("call_options.zig").CallOptions;
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "Detective";

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

    /// Accepts an invitation for the member account to contribute data to a
    /// behavior graph.
    /// This operation can only be called by an invited member account.
    ///
    /// The request provides the ARN of behavior graph.
    ///
    /// The member account status in the graph must be `INVITED`.
    pub fn acceptInvitation(self: *Self, allocator: std.mem.Allocator, input: accept_invitation.AcceptInvitationInput, options: CallOptions) !accept_invitation.AcceptInvitationOutput {
        return accept_invitation.execute(self, allocator, input, options);
    }

    /// Gets data source package information for the behavior graph.
    pub fn batchGetGraphMemberDatasources(self: *Self, allocator: std.mem.Allocator, input: batch_get_graph_member_datasources.BatchGetGraphMemberDatasourcesInput, options: CallOptions) !batch_get_graph_member_datasources.BatchGetGraphMemberDatasourcesOutput {
        return batch_get_graph_member_datasources.execute(self, allocator, input, options);
    }

    /// Gets information on the data source package history for an account.
    pub fn batchGetMembershipDatasources(self: *Self, allocator: std.mem.Allocator, input: batch_get_membership_datasources.BatchGetMembershipDatasourcesInput, options: CallOptions) !batch_get_membership_datasources.BatchGetMembershipDatasourcesOutput {
        return batch_get_membership_datasources.execute(self, allocator, input, options);
    }

    /// Creates a new behavior graph for the calling account, and sets that account
    /// as the
    /// administrator account. This operation is called by the account that is
    /// enabling Detective.
    ///
    /// The operation also enables Detective for the calling account in the
    /// currently
    /// selected Region. It returns the ARN of the new behavior graph.
    ///
    /// `CreateGraph` triggers a process to create the corresponding data tables for
    /// the new behavior graph.
    ///
    /// An account can only be the administrator account for one behavior graph
    /// within a Region.
    /// If the same account calls `CreateGraph` with the same administrator account,
    /// it
    /// always returns the same behavior graph ARN. It does not create a new
    /// behavior graph.
    pub fn createGraph(self: *Self, allocator: std.mem.Allocator, input: create_graph.CreateGraphInput, options: CallOptions) !create_graph.CreateGraphOutput {
        return create_graph.execute(self, allocator, input, options);
    }

    /// `CreateMembers` is used to send invitations to accounts. For the
    /// organization
    /// behavior graph, the Detective administrator account uses
    /// `CreateMembers` to enable organization accounts as member accounts.
    ///
    /// For invited accounts, `CreateMembers` sends a request to invite the
    /// specified
    /// Amazon Web Services accounts to be member accounts in the behavior graph.
    /// This operation
    /// can only be called by the administrator account for a behavior graph.
    ///
    /// `CreateMembers` verifies the accounts and then invites the verified
    /// accounts.
    /// The administrator can optionally specify to not send invitation emails to
    /// the member
    /// accounts. This would be used when the administrator manages their member
    /// accounts
    /// centrally.
    ///
    /// For organization accounts in the organization behavior graph,
    /// `CreateMembers`
    /// attempts to enable the accounts. The organization accounts do not receive
    /// invitations.
    ///
    /// The request provides the behavior graph ARN and the list of accounts to
    /// invite or to
    /// enable.
    ///
    /// The response separates the requested accounts into two lists:
    ///
    /// * The accounts that `CreateMembers` was able to process. For invited
    /// accounts, includes member accounts that are being verified, that have passed
    /// verification and are to be invited, and that have failed verification. For
    /// organization accounts in the organization behavior graph, includes accounts
    /// that can
    /// be enabled and that cannot be enabled.
    ///
    /// * The accounts that `CreateMembers` was unable to process. This list
    /// includes accounts that were already invited to be member accounts in the
    /// behavior
    /// graph.
    pub fn createMembers(self: *Self, allocator: std.mem.Allocator, input: create_members.CreateMembersInput, options: CallOptions) !create_members.CreateMembersOutput {
        return create_members.execute(self, allocator, input, options);
    }

    /// Disables the specified behavior graph and queues it to be deleted. This
    /// operation
    /// removes the behavior graph from each member account's list of behavior
    /// graphs.
    ///
    /// `DeleteGraph` can only be called by the administrator account for a behavior
    /// graph.
    pub fn deleteGraph(self: *Self, allocator: std.mem.Allocator, input: delete_graph.DeleteGraphInput, options: CallOptions) !delete_graph.DeleteGraphOutput {
        return delete_graph.execute(self, allocator, input, options);
    }

    /// Removes the specified member accounts from the behavior graph. The removed
    /// accounts no
    /// longer contribute data to the behavior graph. This operation can only be
    /// called by the
    /// administrator account for the behavior graph.
    ///
    /// For invited accounts, the removed accounts are deleted from the list of
    /// accounts in the
    /// behavior graph. To restore the account, the administrator account must send
    /// another
    /// invitation.
    ///
    /// For organization accounts in the organization behavior graph, the Detective
    /// administrator account can always enable the organization account again.
    /// Organization
    /// accounts that are not enabled as member accounts are not included in the
    /// `ListMembers` results for the organization behavior graph.
    ///
    /// An administrator account cannot use `DeleteMembers` to remove their own
    /// account from the behavior graph. To disable a behavior graph, the
    /// administrator account
    /// uses the `DeleteGraph` API method.
    pub fn deleteMembers(self: *Self, allocator: std.mem.Allocator, input: delete_members.DeleteMembersInput, options: CallOptions) !delete_members.DeleteMembersOutput {
        return delete_members.execute(self, allocator, input, options);
    }

    /// Returns information about the configuration for the organization behavior
    /// graph.
    /// Currently indicates whether to automatically enable new organization
    /// accounts as member
    /// accounts.
    ///
    /// Can only be called by the Detective administrator account for the
    /// organization.
    pub fn describeOrganizationConfiguration(self: *Self, allocator: std.mem.Allocator, input: describe_organization_configuration.DescribeOrganizationConfigurationInput, options: CallOptions) !describe_organization_configuration.DescribeOrganizationConfigurationOutput {
        return describe_organization_configuration.execute(self, allocator, input, options);
    }

    /// Removes the Detective administrator account in the current Region. Deletes
    /// the
    /// organization behavior graph.
    ///
    /// Can only be called by the organization management account.
    ///
    /// Removing the Detective administrator account does not affect the delegated
    /// administrator account for Detective in Organizations.
    ///
    /// To remove the delegated administrator account in Organizations, use the
    /// Organizations API. Removing the delegated administrator account also removes
    /// the Detective administrator account in all Regions, except for Regions where
    /// the Detective administrator account is the organization management account.
    pub fn disableOrganizationAdminAccount(self: *Self, allocator: std.mem.Allocator, input: disable_organization_admin_account.DisableOrganizationAdminAccountInput, options: CallOptions) !disable_organization_admin_account.DisableOrganizationAdminAccountOutput {
        return disable_organization_admin_account.execute(self, allocator, input, options);
    }

    /// Removes the member account from the specified behavior graph. This operation
    /// can only be
    /// called by an invited member account that has the `ENABLED` status.
    ///
    /// `DisassociateMembership` cannot be called by an organization account in the
    /// organization behavior graph. For the organization behavior graph, the
    /// Detective
    /// administrator account determines which organization accounts to enable or
    /// disable as member
    /// accounts.
    pub fn disassociateMembership(self: *Self, allocator: std.mem.Allocator, input: disassociate_membership.DisassociateMembershipInput, options: CallOptions) !disassociate_membership.DisassociateMembershipOutput {
        return disassociate_membership.execute(self, allocator, input, options);
    }

    /// Designates the Detective administrator account for the organization in the
    /// current Region.
    ///
    /// If the account does not have Detective enabled, then enables Detective
    /// for that account and creates a new behavior graph.
    ///
    /// Can only be called by the organization management account.
    ///
    /// If the organization has a delegated administrator account in Organizations,
    /// then the
    /// Detective administrator account must be either the delegated administrator
    /// account or the organization management account.
    ///
    /// If the organization does not have a delegated administrator account in
    /// Organizations, then you can choose any account in the organization. If you
    /// choose an account other
    /// than the organization management account, Detective calls Organizations to
    /// make that account the delegated administrator account for Detective. The
    /// organization management account cannot be the delegated administrator
    /// account.
    pub fn enableOrganizationAdminAccount(self: *Self, allocator: std.mem.Allocator, input: enable_organization_admin_account.EnableOrganizationAdminAccountInput, options: CallOptions) !enable_organization_admin_account.EnableOrganizationAdminAccountOutput {
        return enable_organization_admin_account.execute(self, allocator, input, options);
    }

    /// Detective investigations lets you investigate IAM users and IAM roles using
    /// indicators of compromise. An indicator of compromise (IOC) is an artifact
    /// observed in or on a network, system, or environment that can (with a high
    /// level of confidence) identify malicious activity or a security incident.
    /// `GetInvestigation` returns the investigation results of an investigation for
    /// a behavior graph.
    pub fn getInvestigation(self: *Self, allocator: std.mem.Allocator, input: get_investigation.GetInvestigationInput, options: CallOptions) !get_investigation.GetInvestigationOutput {
        return get_investigation.execute(self, allocator, input, options);
    }

    /// Returns the membership details for specified member accounts for a behavior
    /// graph.
    pub fn getMembers(self: *Self, allocator: std.mem.Allocator, input: get_members.GetMembersInput, options: CallOptions) !get_members.GetMembersOutput {
        return get_members.execute(self, allocator, input, options);
    }

    /// Lists data source packages in the behavior graph.
    pub fn listDatasourcePackages(self: *Self, allocator: std.mem.Allocator, input: list_datasource_packages.ListDatasourcePackagesInput, options: CallOptions) !list_datasource_packages.ListDatasourcePackagesOutput {
        return list_datasource_packages.execute(self, allocator, input, options);
    }

    /// Returns the list of behavior graphs that the calling account is an
    /// administrator account
    /// of. This operation can only be called by an administrator account.
    ///
    /// Because an account can currently only be the administrator of one behavior
    /// graph within
    /// a Region, the results always contain a single behavior graph.
    pub fn listGraphs(self: *Self, allocator: std.mem.Allocator, input: list_graphs.ListGraphsInput, options: CallOptions) !list_graphs.ListGraphsOutput {
        return list_graphs.execute(self, allocator, input, options);
    }

    /// Gets the indicators from an investigation. You can use the information from
    /// the indicators to determine if an IAM user and/or IAM role is involved in an
    /// unusual activity that could indicate malicious behavior and its impact.
    pub fn listIndicators(self: *Self, allocator: std.mem.Allocator, input: list_indicators.ListIndicatorsInput, options: CallOptions) !list_indicators.ListIndicatorsOutput {
        return list_indicators.execute(self, allocator, input, options);
    }

    /// Detective investigations lets you investigate IAM users and
    /// IAM roles using indicators of compromise. An indicator of compromise
    /// (IOC) is an artifact observed in or on a network, system, or environment
    /// that can (with a
    /// high level of confidence) identify malicious activity or a security
    /// incident.
    /// `ListInvestigations` lists all active Detective
    /// investigations.
    pub fn listInvestigations(self: *Self, allocator: std.mem.Allocator, input: list_investigations.ListInvestigationsInput, options: CallOptions) !list_investigations.ListInvestigationsOutput {
        return list_investigations.execute(self, allocator, input, options);
    }

    /// Retrieves the list of open and accepted behavior graph invitations for the
    /// member
    /// account. This operation can only be called by an invited member account.
    ///
    /// Open invitations are invitations that the member account has not responded
    /// to.
    ///
    /// The results do not include behavior graphs for which the member account
    /// declined the
    /// invitation. The results also do not include behavior graphs that the member
    /// account
    /// resigned from or was removed from.
    pub fn listInvitations(self: *Self, allocator: std.mem.Allocator, input: list_invitations.ListInvitationsInput, options: CallOptions) !list_invitations.ListInvitationsOutput {
        return list_invitations.execute(self, allocator, input, options);
    }

    /// Retrieves the list of member accounts for a behavior graph.
    ///
    /// For invited accounts, the results do not include member accounts that were
    /// removed from
    /// the behavior graph.
    ///
    /// For the organization behavior graph, the results do not include organization
    /// accounts
    /// that the Detective administrator account has not enabled as member
    /// accounts.
    pub fn listMembers(self: *Self, allocator: std.mem.Allocator, input: list_members.ListMembersInput, options: CallOptions) !list_members.ListMembersOutput {
        return list_members.execute(self, allocator, input, options);
    }

    /// Returns information about the Detective administrator account for an
    /// organization. Can only be called by the organization management account.
    pub fn listOrganizationAdminAccounts(self: *Self, allocator: std.mem.Allocator, input: list_organization_admin_accounts.ListOrganizationAdminAccountsInput, options: CallOptions) !list_organization_admin_accounts.ListOrganizationAdminAccountsOutput {
        return list_organization_admin_accounts.execute(self, allocator, input, options);
    }

    /// Returns the tag values that are assigned to a behavior graph.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: CallOptions) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Rejects an invitation to contribute the account data to a behavior graph.
    /// This operation
    /// must be called by an invited member account that has the `INVITED`
    /// status.
    ///
    /// `RejectInvitation` cannot be called by an organization account in the
    /// organization behavior graph. In the organization behavior graph,
    /// organization accounts do
    /// not receive an invitation.
    pub fn rejectInvitation(self: *Self, allocator: std.mem.Allocator, input: reject_invitation.RejectInvitationInput, options: CallOptions) !reject_invitation.RejectInvitationOutput {
        return reject_invitation.execute(self, allocator, input, options);
    }

    /// Detective investigations lets you investigate IAM users and IAM roles using
    /// indicators of compromise. An indicator of compromise (IOC) is an artifact
    /// observed in or on a network, system, or environment that can (with a high
    /// level of confidence) identify malicious activity or a security incident.
    /// `StartInvestigation` initiates an investigation on an entity in a behavior
    /// graph.
    pub fn startInvestigation(self: *Self, allocator: std.mem.Allocator, input: start_investigation.StartInvestigationInput, options: CallOptions) !start_investigation.StartInvestigationOutput {
        return start_investigation.execute(self, allocator, input, options);
    }

    /// Sends a request to enable data ingest for a member account that has a status
    /// of
    /// `ACCEPTED_BUT_DISABLED`.
    ///
    /// For valid member accounts, the status is updated as follows.
    ///
    /// * If Detective enabled the member account, then the new status is
    /// `ENABLED`.
    ///
    /// * If Detective cannot enable the member account, the status remains
    /// `ACCEPTED_BUT_DISABLED`.
    pub fn startMonitoringMember(self: *Self, allocator: std.mem.Allocator, input: start_monitoring_member.StartMonitoringMemberInput, options: CallOptions) !start_monitoring_member.StartMonitoringMemberOutput {
        return start_monitoring_member.execute(self, allocator, input, options);
    }

    /// Applies tag values to a behavior graph.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: CallOptions) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Removes tags from a behavior graph.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: CallOptions) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Starts a data source package for the Detective behavior graph.
    pub fn updateDatasourcePackages(self: *Self, allocator: std.mem.Allocator, input: update_datasource_packages.UpdateDatasourcePackagesInput, options: CallOptions) !update_datasource_packages.UpdateDatasourcePackagesOutput {
        return update_datasource_packages.execute(self, allocator, input, options);
    }

    /// Updates the state of an investigation.
    pub fn updateInvestigationState(self: *Self, allocator: std.mem.Allocator, input: update_investigation_state.UpdateInvestigationStateInput, options: CallOptions) !update_investigation_state.UpdateInvestigationStateOutput {
        return update_investigation_state.execute(self, allocator, input, options);
    }

    /// Updates the configuration for the Organizations integration in the current
    /// Region.
    /// Can only be called by the Detective administrator account for the
    /// organization.
    pub fn updateOrganizationConfiguration(self: *Self, allocator: std.mem.Allocator, input: update_organization_configuration.UpdateOrganizationConfigurationInput, options: CallOptions) !update_organization_configuration.UpdateOrganizationConfigurationOutput {
        return update_organization_configuration.execute(self, allocator, input, options);
    }

    pub fn listDatasourcePackagesPaginator(self: *Self, params: list_datasource_packages.ListDatasourcePackagesInput) paginator.ListDatasourcePackagesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listGraphsPaginator(self: *Self, params: list_graphs.ListGraphsInput) paginator.ListGraphsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listInvitationsPaginator(self: *Self, params: list_invitations.ListInvitationsInput) paginator.ListInvitationsPaginator {
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

    pub fn listOrganizationAdminAccountsPaginator(self: *Self, params: list_organization_admin_accounts.ListOrganizationAdminAccountsInput) paginator.ListOrganizationAdminAccountsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};
