const aws = @import("aws");
const std = @import("std");

const cancel_session = @import("cancel_session.zig");
const create_approval_team = @import("create_approval_team.zig");
const create_identity_source = @import("create_identity_source.zig");
const delete_identity_source = @import("delete_identity_source.zig");
const delete_inactive_approval_team_version = @import("delete_inactive_approval_team_version.zig");
const get_approval_team = @import("get_approval_team.zig");
const get_identity_source = @import("get_identity_source.zig");
const get_policy_version = @import("get_policy_version.zig");
const get_resource_policy = @import("get_resource_policy.zig");
const get_session = @import("get_session.zig");
const list_approval_teams = @import("list_approval_teams.zig");
const list_identity_sources = @import("list_identity_sources.zig");
const list_policies = @import("list_policies.zig");
const list_policy_versions = @import("list_policy_versions.zig");
const list_resource_policies = @import("list_resource_policies.zig");
const list_sessions = @import("list_sessions.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const start_active_approval_team_deletion = @import("start_active_approval_team_deletion.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_approval_team = @import("update_approval_team.zig");
const CallOptions = @import("call_options.zig").CallOptions;
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "MPA";

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

    /// Cancels an approval session. For more information, see
    /// [Session](https://docs.aws.amazon.com/mpa/latest/userguide/mpa-concepts.html) in the *Multi-party approval User Guide*.
    pub fn cancelSession(self: *Self, allocator: std.mem.Allocator, input: cancel_session.CancelSessionInput, options: CallOptions) !cancel_session.CancelSessionOutput {
        return cancel_session.execute(self, allocator, input, options);
    }

    /// Creates a new approval team. For more information, see [Approval
    /// team](https://docs.aws.amazon.com/mpa/latest/userguide/mpa-concepts.html) in
    /// the *Multi-party approval User Guide*.
    pub fn createApprovalTeam(self: *Self, allocator: std.mem.Allocator, input: create_approval_team.CreateApprovalTeamInput, options: CallOptions) !create_approval_team.CreateApprovalTeamOutput {
        return create_approval_team.execute(self, allocator, input, options);
    }

    /// Creates a new identity source. For more information, see [Identity
    /// Source](https://docs.aws.amazon.com/mpa/latest/userguide/mpa-concepts.html)
    /// in the *Multi-party approval User Guide*.
    pub fn createIdentitySource(self: *Self, allocator: std.mem.Allocator, input: create_identity_source.CreateIdentitySourceInput, options: CallOptions) !create_identity_source.CreateIdentitySourceOutput {
        return create_identity_source.execute(self, allocator, input, options);
    }

    /// Deletes an identity source. For more information, see [Identity
    /// Source](https://docs.aws.amazon.com/mpa/latest/userguide/mpa-concepts.html)
    /// in the *Multi-party approval User Guide*.
    pub fn deleteIdentitySource(self: *Self, allocator: std.mem.Allocator, input: delete_identity_source.DeleteIdentitySourceInput, options: CallOptions) !delete_identity_source.DeleteIdentitySourceOutput {
        return delete_identity_source.execute(self, allocator, input, options);
    }

    /// Deletes an inactive approval team. For more information, see [Team
    /// health](https://docs.aws.amazon.com/mpa/latest/userguide/mpa-health.html) in
    /// the *Multi-party approval User Guide*.
    ///
    /// You can also use this operation to delete a team draft. For more
    /// information, see [Interacting with
    /// drafts](https://docs.aws.amazon.com/mpa/latest/userguide/update-team.html#update-team-draft-status) in the *Multi-party approval User Guide*.
    pub fn deleteInactiveApprovalTeamVersion(self: *Self, allocator: std.mem.Allocator, input: delete_inactive_approval_team_version.DeleteInactiveApprovalTeamVersionInput, options: CallOptions) !delete_inactive_approval_team_version.DeleteInactiveApprovalTeamVersionOutput {
        return delete_inactive_approval_team_version.execute(self, allocator, input, options);
    }

    /// Returns details for an approval team.
    pub fn getApprovalTeam(self: *Self, allocator: std.mem.Allocator, input: get_approval_team.GetApprovalTeamInput, options: CallOptions) !get_approval_team.GetApprovalTeamOutput {
        return get_approval_team.execute(self, allocator, input, options);
    }

    /// Returns details for an identity source. For more information, see [Identity
    /// Source](https://docs.aws.amazon.com/mpa/latest/userguide/mpa-concepts.html)
    /// in the *Multi-party approval User Guide*.
    pub fn getIdentitySource(self: *Self, allocator: std.mem.Allocator, input: get_identity_source.GetIdentitySourceInput, options: CallOptions) !get_identity_source.GetIdentitySourceOutput {
        return get_identity_source.execute(self, allocator, input, options);
    }

    /// Returns details for the version of a policy. Policies define the permissions
    /// for team resources.
    pub fn getPolicyVersion(self: *Self, allocator: std.mem.Allocator, input: get_policy_version.GetPolicyVersionInput, options: CallOptions) !get_policy_version.GetPolicyVersionOutput {
        return get_policy_version.execute(self, allocator, input, options);
    }

    /// Returns details about a policy for a resource.
    pub fn getResourcePolicy(self: *Self, allocator: std.mem.Allocator, input: get_resource_policy.GetResourcePolicyInput, options: CallOptions) !get_resource_policy.GetResourcePolicyOutput {
        return get_resource_policy.execute(self, allocator, input, options);
    }

    /// Returns details for an approval session. For more information, see
    /// [Session](https://docs.aws.amazon.com/mpa/latest/userguide/mpa-concepts.html) in the *Multi-party approval User Guide*.
    pub fn getSession(self: *Self, allocator: std.mem.Allocator, input: get_session.GetSessionInput, options: CallOptions) !get_session.GetSessionOutput {
        return get_session.execute(self, allocator, input, options);
    }

    /// Returns a list of approval teams.
    pub fn listApprovalTeams(self: *Self, allocator: std.mem.Allocator, input: list_approval_teams.ListApprovalTeamsInput, options: CallOptions) !list_approval_teams.ListApprovalTeamsOutput {
        return list_approval_teams.execute(self, allocator, input, options);
    }

    /// Returns a list of identity sources. For more information, see [Identity
    /// Source](https://docs.aws.amazon.com/mpa/latest/userguide/mpa-concepts.html)
    /// in the *Multi-party approval User Guide*.
    pub fn listIdentitySources(self: *Self, allocator: std.mem.Allocator, input: list_identity_sources.ListIdentitySourcesInput, options: CallOptions) !list_identity_sources.ListIdentitySourcesOutput {
        return list_identity_sources.execute(self, allocator, input, options);
    }

    /// Returns a list of policies. Policies define the permissions for team
    /// resources.
    pub fn listPolicies(self: *Self, allocator: std.mem.Allocator, input: list_policies.ListPoliciesInput, options: CallOptions) !list_policies.ListPoliciesOutput {
        return list_policies.execute(self, allocator, input, options);
    }

    /// Returns a list of the versions for policies. Policies define the permissions
    /// for team resources.
    pub fn listPolicyVersions(self: *Self, allocator: std.mem.Allocator, input: list_policy_versions.ListPolicyVersionsInput, options: CallOptions) !list_policy_versions.ListPolicyVersionsOutput {
        return list_policy_versions.execute(self, allocator, input, options);
    }

    /// Returns a list of policies for a resource.
    pub fn listResourcePolicies(self: *Self, allocator: std.mem.Allocator, input: list_resource_policies.ListResourcePoliciesInput, options: CallOptions) !list_resource_policies.ListResourcePoliciesOutput {
        return list_resource_policies.execute(self, allocator, input, options);
    }

    /// Returns a list of approval sessions. For more information, see
    /// [Session](https://docs.aws.amazon.com/mpa/latest/userguide/mpa-concepts.html) in the *Multi-party approval User Guide*.
    pub fn listSessions(self: *Self, allocator: std.mem.Allocator, input: list_sessions.ListSessionsInput, options: CallOptions) !list_sessions.ListSessionsOutput {
        return list_sessions.execute(self, allocator, input, options);
    }

    /// Returns a list of the tags for a resource.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: CallOptions) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Starts the deletion process for an active approval team.
    ///
    /// **Deletions require team approval**
    ///
    /// Requests to delete an active team must be approved by the team.
    pub fn startActiveApprovalTeamDeletion(self: *Self, allocator: std.mem.Allocator, input: start_active_approval_team_deletion.StartActiveApprovalTeamDeletionInput, options: CallOptions) !start_active_approval_team_deletion.StartActiveApprovalTeamDeletionOutput {
        return start_active_approval_team_deletion.execute(self, allocator, input, options);
    }

    /// Creates or updates a resource tag. Each tag is a label consisting of a
    /// user-defined key and value. Tags can help you manage, identify, organize,
    /// search for, and filter resources.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: CallOptions) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Removes a resource tag. Each tag is a label consisting of a user-defined key
    /// and value. Tags can help you manage, identify, organize, search for, and
    /// filter resources.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: CallOptions) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Updates an approval team. You can request to update the team description,
    /// approval threshold, and approvers in the team.
    ///
    /// **Updates require team approval**
    ///
    /// Updates to an active team must be approved by the team.
    pub fn updateApprovalTeam(self: *Self, allocator: std.mem.Allocator, input: update_approval_team.UpdateApprovalTeamInput, options: CallOptions) !update_approval_team.UpdateApprovalTeamOutput {
        return update_approval_team.execute(self, allocator, input, options);
    }

    pub fn listApprovalTeamsPaginator(self: *Self, params: list_approval_teams.ListApprovalTeamsInput) paginator.ListApprovalTeamsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listIdentitySourcesPaginator(self: *Self, params: list_identity_sources.ListIdentitySourcesInput) paginator.ListIdentitySourcesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listPoliciesPaginator(self: *Self, params: list_policies.ListPoliciesInput) paginator.ListPoliciesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listPolicyVersionsPaginator(self: *Self, params: list_policy_versions.ListPolicyVersionsInput) paginator.ListPolicyVersionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listResourcePoliciesPaginator(self: *Self, params: list_resource_policies.ListResourcePoliciesInput) paginator.ListResourcePoliciesPaginator {
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
};
