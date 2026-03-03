const aws = @import("aws");
const std = @import("std");

const associate_approval_rule_template_with_repository = @import("associate_approval_rule_template_with_repository.zig");
const batch_associate_approval_rule_template_with_repositories = @import("batch_associate_approval_rule_template_with_repositories.zig");
const batch_describe_merge_conflicts = @import("batch_describe_merge_conflicts.zig");
const batch_disassociate_approval_rule_template_from_repositories = @import("batch_disassociate_approval_rule_template_from_repositories.zig");
const batch_get_commits = @import("batch_get_commits.zig");
const batch_get_repositories = @import("batch_get_repositories.zig");
const create_approval_rule_template = @import("create_approval_rule_template.zig");
const create_branch = @import("create_branch.zig");
const create_commit = @import("create_commit.zig");
const create_pull_request = @import("create_pull_request.zig");
const create_pull_request_approval_rule = @import("create_pull_request_approval_rule.zig");
const create_repository = @import("create_repository.zig");
const create_unreferenced_merge_commit = @import("create_unreferenced_merge_commit.zig");
const delete_approval_rule_template = @import("delete_approval_rule_template.zig");
const delete_branch = @import("delete_branch.zig");
const delete_comment_content = @import("delete_comment_content.zig");
const delete_file = @import("delete_file.zig");
const delete_pull_request_approval_rule = @import("delete_pull_request_approval_rule.zig");
const delete_repository = @import("delete_repository.zig");
const describe_merge_conflicts = @import("describe_merge_conflicts.zig");
const describe_pull_request_events = @import("describe_pull_request_events.zig");
const disassociate_approval_rule_template_from_repository = @import("disassociate_approval_rule_template_from_repository.zig");
const evaluate_pull_request_approval_rules = @import("evaluate_pull_request_approval_rules.zig");
const get_approval_rule_template = @import("get_approval_rule_template.zig");
const get_blob = @import("get_blob.zig");
const get_branch = @import("get_branch.zig");
const get_comment = @import("get_comment.zig");
const get_comment_reactions = @import("get_comment_reactions.zig");
const get_comments_for_compared_commit = @import("get_comments_for_compared_commit.zig");
const get_comments_for_pull_request = @import("get_comments_for_pull_request.zig");
const get_commit = @import("get_commit.zig");
const get_differences = @import("get_differences.zig");
const get_file = @import("get_file.zig");
const get_folder = @import("get_folder.zig");
const get_merge_commit = @import("get_merge_commit.zig");
const get_merge_conflicts = @import("get_merge_conflicts.zig");
const get_merge_options = @import("get_merge_options.zig");
const get_pull_request = @import("get_pull_request.zig");
const get_pull_request_approval_states = @import("get_pull_request_approval_states.zig");
const get_pull_request_override_state = @import("get_pull_request_override_state.zig");
const get_repository = @import("get_repository.zig");
const get_repository_triggers = @import("get_repository_triggers.zig");
const list_approval_rule_templates = @import("list_approval_rule_templates.zig");
const list_associated_approval_rule_templates_for_repository = @import("list_associated_approval_rule_templates_for_repository.zig");
const list_branches = @import("list_branches.zig");
const list_file_commit_history = @import("list_file_commit_history.zig");
const list_pull_requests = @import("list_pull_requests.zig");
const list_repositories = @import("list_repositories.zig");
const list_repositories_for_approval_rule_template = @import("list_repositories_for_approval_rule_template.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const merge_branches_by_fast_forward = @import("merge_branches_by_fast_forward.zig");
const merge_branches_by_squash = @import("merge_branches_by_squash.zig");
const merge_branches_by_three_way = @import("merge_branches_by_three_way.zig");
const merge_pull_request_by_fast_forward = @import("merge_pull_request_by_fast_forward.zig");
const merge_pull_request_by_squash = @import("merge_pull_request_by_squash.zig");
const merge_pull_request_by_three_way = @import("merge_pull_request_by_three_way.zig");
const override_pull_request_approval_rules = @import("override_pull_request_approval_rules.zig");
const post_comment_for_compared_commit = @import("post_comment_for_compared_commit.zig");
const post_comment_for_pull_request = @import("post_comment_for_pull_request.zig");
const post_comment_reply = @import("post_comment_reply.zig");
const put_comment_reaction = @import("put_comment_reaction.zig");
const put_file = @import("put_file.zig");
const put_repository_triggers = @import("put_repository_triggers.zig");
const tag_resource = @import("tag_resource.zig");
const test_repository_triggers = @import("test_repository_triggers.zig");
const untag_resource = @import("untag_resource.zig");
const update_approval_rule_template_content = @import("update_approval_rule_template_content.zig");
const update_approval_rule_template_description = @import("update_approval_rule_template_description.zig");
const update_approval_rule_template_name = @import("update_approval_rule_template_name.zig");
const update_comment = @import("update_comment.zig");
const update_default_branch = @import("update_default_branch.zig");
const update_pull_request_approval_rule_content = @import("update_pull_request_approval_rule_content.zig");
const update_pull_request_approval_state = @import("update_pull_request_approval_state.zig");
const update_pull_request_description = @import("update_pull_request_description.zig");
const update_pull_request_status = @import("update_pull_request_status.zig");
const update_pull_request_title = @import("update_pull_request_title.zig");
const update_repository_description = @import("update_repository_description.zig");
const update_repository_encryption_key = @import("update_repository_encryption_key.zig");
const update_repository_name = @import("update_repository_name.zig");
const CallOptions = @import("call_options.zig").CallOptions;
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "CodeCommit";

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

    /// Creates an association between an approval rule template and a specified
    /// repository.
    /// Then, the next time a pull request is created in the repository where the
    /// destination
    /// reference (if specified) matches the destination reference (branch) for the
    /// pull
    /// request, an approval rule that matches the template conditions is
    /// automatically created
    /// for that pull request. If no destination references are specified in the
    /// template, an
    /// approval rule that matches the template contents is created for all pull
    /// requests in
    /// that repository.
    pub fn associateApprovalRuleTemplateWithRepository(self: *Self, allocator: std.mem.Allocator, input: associate_approval_rule_template_with_repository.AssociateApprovalRuleTemplateWithRepositoryInput, options: CallOptions) !associate_approval_rule_template_with_repository.AssociateApprovalRuleTemplateWithRepositoryOutput {
        return associate_approval_rule_template_with_repository.execute(self, allocator, input, options);
    }

    /// Creates an association between an approval rule template and one or more
    /// specified repositories.
    pub fn batchAssociateApprovalRuleTemplateWithRepositories(self: *Self, allocator: std.mem.Allocator, input: batch_associate_approval_rule_template_with_repositories.BatchAssociateApprovalRuleTemplateWithRepositoriesInput, options: CallOptions) !batch_associate_approval_rule_template_with_repositories.BatchAssociateApprovalRuleTemplateWithRepositoriesOutput {
        return batch_associate_approval_rule_template_with_repositories.execute(self, allocator, input, options);
    }

    /// Returns information about one or more merge conflicts in the attempted merge
    /// of two commit specifiers using the squash or three-way merge strategy.
    pub fn batchDescribeMergeConflicts(self: *Self, allocator: std.mem.Allocator, input: batch_describe_merge_conflicts.BatchDescribeMergeConflictsInput, options: CallOptions) !batch_describe_merge_conflicts.BatchDescribeMergeConflictsOutput {
        return batch_describe_merge_conflicts.execute(self, allocator, input, options);
    }

    /// Removes the association between an approval rule template and one or more
    /// specified repositories.
    pub fn batchDisassociateApprovalRuleTemplateFromRepositories(self: *Self, allocator: std.mem.Allocator, input: batch_disassociate_approval_rule_template_from_repositories.BatchDisassociateApprovalRuleTemplateFromRepositoriesInput, options: CallOptions) !batch_disassociate_approval_rule_template_from_repositories.BatchDisassociateApprovalRuleTemplateFromRepositoriesOutput {
        return batch_disassociate_approval_rule_template_from_repositories.execute(self, allocator, input, options);
    }

    /// Returns information about the contents of one or more commits in a
    /// repository.
    pub fn batchGetCommits(self: *Self, allocator: std.mem.Allocator, input: batch_get_commits.BatchGetCommitsInput, options: CallOptions) !batch_get_commits.BatchGetCommitsOutput {
        return batch_get_commits.execute(self, allocator, input, options);
    }

    /// Returns information about one or more repositories.
    ///
    /// The description field for a repository accepts all HTML characters and all
    /// valid
    /// Unicode characters. Applications that do not HTML-encode the description and
    /// display
    /// it in a webpage can expose users to potentially malicious code. Make sure
    /// that you
    /// HTML-encode the description field in any application that uses this API to
    /// display
    /// the repository description on a webpage.
    pub fn batchGetRepositories(self: *Self, allocator: std.mem.Allocator, input: batch_get_repositories.BatchGetRepositoriesInput, options: CallOptions) !batch_get_repositories.BatchGetRepositoriesOutput {
        return batch_get_repositories.execute(self, allocator, input, options);
    }

    /// Creates a template for approval rules that can then be associated with one
    /// or more
    /// repositories in your Amazon Web Services account. When you associate a
    /// template with a repository,
    /// CodeCommit creates an approval rule that matches the conditions of the
    /// template for all
    /// pull requests that meet the conditions of the template. For more
    /// information, see
    /// AssociateApprovalRuleTemplateWithRepository.
    pub fn createApprovalRuleTemplate(self: *Self, allocator: std.mem.Allocator, input: create_approval_rule_template.CreateApprovalRuleTemplateInput, options: CallOptions) !create_approval_rule_template.CreateApprovalRuleTemplateOutput {
        return create_approval_rule_template.execute(self, allocator, input, options);
    }

    /// Creates a branch in a repository and points the branch to a commit.
    ///
    /// Calling the create branch operation does not set a repository's default
    /// branch. To do this, call the update default branch operation.
    pub fn createBranch(self: *Self, allocator: std.mem.Allocator, input: create_branch.CreateBranchInput, options: CallOptions) !create_branch.CreateBranchOutput {
        return create_branch.execute(self, allocator, input, options);
    }

    /// Creates a commit for a repository on the tip of a specified branch.
    pub fn createCommit(self: *Self, allocator: std.mem.Allocator, input: create_commit.CreateCommitInput, options: CallOptions) !create_commit.CreateCommitOutput {
        return create_commit.execute(self, allocator, input, options);
    }

    /// Creates a pull request in the specified repository.
    pub fn createPullRequest(self: *Self, allocator: std.mem.Allocator, input: create_pull_request.CreatePullRequestInput, options: CallOptions) !create_pull_request.CreatePullRequestOutput {
        return create_pull_request.execute(self, allocator, input, options);
    }

    /// Creates an approval rule for a pull request.
    pub fn createPullRequestApprovalRule(self: *Self, allocator: std.mem.Allocator, input: create_pull_request_approval_rule.CreatePullRequestApprovalRuleInput, options: CallOptions) !create_pull_request_approval_rule.CreatePullRequestApprovalRuleOutput {
        return create_pull_request_approval_rule.execute(self, allocator, input, options);
    }

    /// Creates a new, empty repository.
    pub fn createRepository(self: *Self, allocator: std.mem.Allocator, input: create_repository.CreateRepositoryInput, options: CallOptions) !create_repository.CreateRepositoryOutput {
        return create_repository.execute(self, allocator, input, options);
    }

    /// Creates an unreferenced commit that represents the result of merging two
    /// branches
    /// using a specified merge strategy. This can help you determine the outcome of
    /// a potential
    /// merge. This API cannot be used with the fast-forward merge strategy because
    /// that
    /// strategy does not create a merge commit.
    ///
    /// This unreferenced merge commit
    /// can only be accessed using the GetCommit API or through git commands such as
    /// git fetch. To retrieve this commit, you must specify its commit ID or
    /// otherwise reference it.
    pub fn createUnreferencedMergeCommit(self: *Self, allocator: std.mem.Allocator, input: create_unreferenced_merge_commit.CreateUnreferencedMergeCommitInput, options: CallOptions) !create_unreferenced_merge_commit.CreateUnreferencedMergeCommitOutput {
        return create_unreferenced_merge_commit.execute(self, allocator, input, options);
    }

    /// Deletes a specified approval rule template. Deleting a template does not
    /// remove approval rules on pull requests already created with the template.
    pub fn deleteApprovalRuleTemplate(self: *Self, allocator: std.mem.Allocator, input: delete_approval_rule_template.DeleteApprovalRuleTemplateInput, options: CallOptions) !delete_approval_rule_template.DeleteApprovalRuleTemplateOutput {
        return delete_approval_rule_template.execute(self, allocator, input, options);
    }

    /// Deletes a branch from a repository, unless that branch is the default branch
    /// for the repository.
    pub fn deleteBranch(self: *Self, allocator: std.mem.Allocator, input: delete_branch.DeleteBranchInput, options: CallOptions) !delete_branch.DeleteBranchOutput {
        return delete_branch.execute(self, allocator, input, options);
    }

    /// Deletes the content of a comment made on a change, file, or commit in a
    /// repository.
    pub fn deleteCommentContent(self: *Self, allocator: std.mem.Allocator, input: delete_comment_content.DeleteCommentContentInput, options: CallOptions) !delete_comment_content.DeleteCommentContentOutput {
        return delete_comment_content.execute(self, allocator, input, options);
    }

    /// Deletes a specified file from a specified branch. A commit is created on the
    /// branch
    /// that contains the revision. The file still exists in the commits earlier to
    /// the commit
    /// that contains the deletion.
    pub fn deleteFile(self: *Self, allocator: std.mem.Allocator, input: delete_file.DeleteFileInput, options: CallOptions) !delete_file.DeleteFileOutput {
        return delete_file.execute(self, allocator, input, options);
    }

    /// Deletes an approval rule from a specified pull request. Approval rules can
    /// be deleted from a pull request only if the pull request is open, and if the
    /// approval rule was created specifically for a pull request and not generated
    /// from an approval rule template associated with the repository where the
    /// pull request was created. You cannot delete an approval rule from a merged
    /// or closed pull request.
    pub fn deletePullRequestApprovalRule(self: *Self, allocator: std.mem.Allocator, input: delete_pull_request_approval_rule.DeletePullRequestApprovalRuleInput, options: CallOptions) !delete_pull_request_approval_rule.DeletePullRequestApprovalRuleOutput {
        return delete_pull_request_approval_rule.execute(self, allocator, input, options);
    }

    /// Deletes a repository. If a specified repository was already deleted, a null
    /// repository
    /// ID is returned.
    ///
    /// Deleting a repository also deletes all associated objects and metadata.
    /// After a repository is
    /// deleted, all future push calls to the deleted repository fail.
    pub fn deleteRepository(self: *Self, allocator: std.mem.Allocator, input: delete_repository.DeleteRepositoryInput, options: CallOptions) !delete_repository.DeleteRepositoryOutput {
        return delete_repository.execute(self, allocator, input, options);
    }

    /// Returns information about one or more merge conflicts in the attempted merge
    /// of two
    /// commit specifiers using the squash or three-way merge strategy. If the merge
    /// option for
    /// the attempted merge is specified as FAST_FORWARD_MERGE, an exception is
    /// thrown.
    pub fn describeMergeConflicts(self: *Self, allocator: std.mem.Allocator, input: describe_merge_conflicts.DescribeMergeConflictsInput, options: CallOptions) !describe_merge_conflicts.DescribeMergeConflictsOutput {
        return describe_merge_conflicts.execute(self, allocator, input, options);
    }

    /// Returns information about one or more pull request events.
    pub fn describePullRequestEvents(self: *Self, allocator: std.mem.Allocator, input: describe_pull_request_events.DescribePullRequestEventsInput, options: CallOptions) !describe_pull_request_events.DescribePullRequestEventsOutput {
        return describe_pull_request_events.execute(self, allocator, input, options);
    }

    /// Removes the association between a template and a repository so that approval
    /// rules
    /// based on the template are not automatically created when pull requests are
    /// created in
    /// the specified repository. This does not delete any approval rules previously
    /// created for
    /// pull requests through the template association.
    pub fn disassociateApprovalRuleTemplateFromRepository(self: *Self, allocator: std.mem.Allocator, input: disassociate_approval_rule_template_from_repository.DisassociateApprovalRuleTemplateFromRepositoryInput, options: CallOptions) !disassociate_approval_rule_template_from_repository.DisassociateApprovalRuleTemplateFromRepositoryOutput {
        return disassociate_approval_rule_template_from_repository.execute(self, allocator, input, options);
    }

    /// Evaluates whether a pull request has met all the conditions specified in its
    /// associated approval rules.
    pub fn evaluatePullRequestApprovalRules(self: *Self, allocator: std.mem.Allocator, input: evaluate_pull_request_approval_rules.EvaluatePullRequestApprovalRulesInput, options: CallOptions) !evaluate_pull_request_approval_rules.EvaluatePullRequestApprovalRulesOutput {
        return evaluate_pull_request_approval_rules.execute(self, allocator, input, options);
    }

    /// Returns information about a specified approval rule template.
    pub fn getApprovalRuleTemplate(self: *Self, allocator: std.mem.Allocator, input: get_approval_rule_template.GetApprovalRuleTemplateInput, options: CallOptions) !get_approval_rule_template.GetApprovalRuleTemplateOutput {
        return get_approval_rule_template.execute(self, allocator, input, options);
    }

    /// Returns the base-64 encoded content of an individual blob in a repository.
    pub fn getBlob(self: *Self, allocator: std.mem.Allocator, input: get_blob.GetBlobInput, options: CallOptions) !get_blob.GetBlobOutput {
        return get_blob.execute(self, allocator, input, options);
    }

    /// Returns information about a repository branch, including its name and the
    /// last commit ID.
    pub fn getBranch(self: *Self, allocator: std.mem.Allocator, input: get_branch.GetBranchInput, options: CallOptions) !get_branch.GetBranchOutput {
        return get_branch.execute(self, allocator, input, options);
    }

    /// Returns the content of a comment made on a change, file, or commit in a
    /// repository.
    ///
    /// Reaction counts might include numbers from user identities who were deleted
    /// after the reaction was made. For a count of
    /// reactions from active identities, use GetCommentReactions.
    pub fn getComment(self: *Self, allocator: std.mem.Allocator, input: get_comment.GetCommentInput, options: CallOptions) !get_comment.GetCommentOutput {
        return get_comment.execute(self, allocator, input, options);
    }

    /// Returns information about reactions to a specified comment ID. Reactions
    /// from users who have been deleted will not be included in the count.
    pub fn getCommentReactions(self: *Self, allocator: std.mem.Allocator, input: get_comment_reactions.GetCommentReactionsInput, options: CallOptions) !get_comment_reactions.GetCommentReactionsOutput {
        return get_comment_reactions.execute(self, allocator, input, options);
    }

    /// Returns information about comments made on the comparison between two
    /// commits.
    ///
    /// Reaction counts might include numbers from user identities who were deleted
    /// after the reaction was made. For a count of
    /// reactions from active identities, use GetCommentReactions.
    pub fn getCommentsForComparedCommit(self: *Self, allocator: std.mem.Allocator, input: get_comments_for_compared_commit.GetCommentsForComparedCommitInput, options: CallOptions) !get_comments_for_compared_commit.GetCommentsForComparedCommitOutput {
        return get_comments_for_compared_commit.execute(self, allocator, input, options);
    }

    /// Returns comments made on a pull request.
    ///
    /// Reaction counts might include numbers from user identities who were deleted
    /// after the reaction was made. For a count of
    /// reactions from active identities, use GetCommentReactions.
    pub fn getCommentsForPullRequest(self: *Self, allocator: std.mem.Allocator, input: get_comments_for_pull_request.GetCommentsForPullRequestInput, options: CallOptions) !get_comments_for_pull_request.GetCommentsForPullRequestOutput {
        return get_comments_for_pull_request.execute(self, allocator, input, options);
    }

    /// Returns information about a commit, including commit message and committer
    /// information.
    pub fn getCommit(self: *Self, allocator: std.mem.Allocator, input: get_commit.GetCommitInput, options: CallOptions) !get_commit.GetCommitOutput {
        return get_commit.execute(self, allocator, input, options);
    }

    /// Returns information about the differences in a valid commit specifier (such
    /// as a
    /// branch, tag, HEAD, commit ID, or other fully qualified reference). Results
    /// can be
    /// limited to a specified path.
    pub fn getDifferences(self: *Self, allocator: std.mem.Allocator, input: get_differences.GetDifferencesInput, options: CallOptions) !get_differences.GetDifferencesOutput {
        return get_differences.execute(self, allocator, input, options);
    }

    /// Returns the base-64 encoded contents of a specified file and its metadata.
    pub fn getFile(self: *Self, allocator: std.mem.Allocator, input: get_file.GetFileInput, options: CallOptions) !get_file.GetFileOutput {
        return get_file.execute(self, allocator, input, options);
    }

    /// Returns the contents of a specified folder in a repository.
    pub fn getFolder(self: *Self, allocator: std.mem.Allocator, input: get_folder.GetFolderInput, options: CallOptions) !get_folder.GetFolderOutput {
        return get_folder.execute(self, allocator, input, options);
    }

    /// Returns information about a specified merge commit.
    pub fn getMergeCommit(self: *Self, allocator: std.mem.Allocator, input: get_merge_commit.GetMergeCommitInput, options: CallOptions) !get_merge_commit.GetMergeCommitOutput {
        return get_merge_commit.execute(self, allocator, input, options);
    }

    /// Returns information about merge conflicts between the before and after
    /// commit IDs for a pull request in a repository.
    pub fn getMergeConflicts(self: *Self, allocator: std.mem.Allocator, input: get_merge_conflicts.GetMergeConflictsInput, options: CallOptions) !get_merge_conflicts.GetMergeConflictsOutput {
        return get_merge_conflicts.execute(self, allocator, input, options);
    }

    /// Returns information about the merge options available for merging two
    /// specified
    /// branches. For details about why a merge option is not available, use
    /// GetMergeConflicts
    /// or DescribeMergeConflicts.
    pub fn getMergeOptions(self: *Self, allocator: std.mem.Allocator, input: get_merge_options.GetMergeOptionsInput, options: CallOptions) !get_merge_options.GetMergeOptionsOutput {
        return get_merge_options.execute(self, allocator, input, options);
    }

    /// Gets information about a pull request in a specified repository.
    pub fn getPullRequest(self: *Self, allocator: std.mem.Allocator, input: get_pull_request.GetPullRequestInput, options: CallOptions) !get_pull_request.GetPullRequestOutput {
        return get_pull_request.execute(self, allocator, input, options);
    }

    /// Gets information about the approval states for a specified pull request.
    /// Approval states only apply to pull requests that have one or more
    /// approval rules applied to them.
    pub fn getPullRequestApprovalStates(self: *Self, allocator: std.mem.Allocator, input: get_pull_request_approval_states.GetPullRequestApprovalStatesInput, options: CallOptions) !get_pull_request_approval_states.GetPullRequestApprovalStatesOutput {
        return get_pull_request_approval_states.execute(self, allocator, input, options);
    }

    /// Returns information about whether approval rules have been set aside
    /// (overridden) for a
    /// pull request, and if so, the Amazon Resource Name (ARN) of the user or
    /// identity that overrode the rules and their requirements for the pull
    /// request.
    pub fn getPullRequestOverrideState(self: *Self, allocator: std.mem.Allocator, input: get_pull_request_override_state.GetPullRequestOverrideStateInput, options: CallOptions) !get_pull_request_override_state.GetPullRequestOverrideStateOutput {
        return get_pull_request_override_state.execute(self, allocator, input, options);
    }

    /// Returns information about a repository.
    ///
    /// The description field for a repository accepts all HTML characters and all
    /// valid
    /// Unicode characters. Applications that do not HTML-encode the description and
    /// display
    /// it in a webpage can expose users to potentially malicious code. Make sure
    /// that you
    /// HTML-encode the description field in any application that uses this API to
    /// display
    /// the repository description on a webpage.
    pub fn getRepository(self: *Self, allocator: std.mem.Allocator, input: get_repository.GetRepositoryInput, options: CallOptions) !get_repository.GetRepositoryOutput {
        return get_repository.execute(self, allocator, input, options);
    }

    /// Gets information about triggers configured for a repository.
    pub fn getRepositoryTriggers(self: *Self, allocator: std.mem.Allocator, input: get_repository_triggers.GetRepositoryTriggersInput, options: CallOptions) !get_repository_triggers.GetRepositoryTriggersOutput {
        return get_repository_triggers.execute(self, allocator, input, options);
    }

    /// Lists all approval rule templates in the specified Amazon Web Services
    /// Region in your Amazon Web Services account. If
    /// an Amazon Web Services Region is not specified, the Amazon Web Services
    /// Region where you are signed in is used.
    pub fn listApprovalRuleTemplates(self: *Self, allocator: std.mem.Allocator, input: list_approval_rule_templates.ListApprovalRuleTemplatesInput, options: CallOptions) !list_approval_rule_templates.ListApprovalRuleTemplatesOutput {
        return list_approval_rule_templates.execute(self, allocator, input, options);
    }

    /// Lists all approval rule templates that are associated with a specified
    /// repository.
    pub fn listAssociatedApprovalRuleTemplatesForRepository(self: *Self, allocator: std.mem.Allocator, input: list_associated_approval_rule_templates_for_repository.ListAssociatedApprovalRuleTemplatesForRepositoryInput, options: CallOptions) !list_associated_approval_rule_templates_for_repository.ListAssociatedApprovalRuleTemplatesForRepositoryOutput {
        return list_associated_approval_rule_templates_for_repository.execute(self, allocator, input, options);
    }

    /// Gets information about one or more branches in a repository.
    pub fn listBranches(self: *Self, allocator: std.mem.Allocator, input: list_branches.ListBranchesInput, options: CallOptions) !list_branches.ListBranchesOutput {
        return list_branches.execute(self, allocator, input, options);
    }

    /// Retrieves a list of commits and changes to a specified file.
    pub fn listFileCommitHistory(self: *Self, allocator: std.mem.Allocator, input: list_file_commit_history.ListFileCommitHistoryInput, options: CallOptions) !list_file_commit_history.ListFileCommitHistoryOutput {
        return list_file_commit_history.execute(self, allocator, input, options);
    }

    /// Returns a list of pull requests for a specified repository. The return list
    /// can be refined by pull request
    /// status or pull request author ARN.
    pub fn listPullRequests(self: *Self, allocator: std.mem.Allocator, input: list_pull_requests.ListPullRequestsInput, options: CallOptions) !list_pull_requests.ListPullRequestsOutput {
        return list_pull_requests.execute(self, allocator, input, options);
    }

    /// Gets information about one or more repositories.
    pub fn listRepositories(self: *Self, allocator: std.mem.Allocator, input: list_repositories.ListRepositoriesInput, options: CallOptions) !list_repositories.ListRepositoriesOutput {
        return list_repositories.execute(self, allocator, input, options);
    }

    /// Lists all repositories associated with the specified approval rule template.
    pub fn listRepositoriesForApprovalRuleTemplate(self: *Self, allocator: std.mem.Allocator, input: list_repositories_for_approval_rule_template.ListRepositoriesForApprovalRuleTemplateInput, options: CallOptions) !list_repositories_for_approval_rule_template.ListRepositoriesForApprovalRuleTemplateOutput {
        return list_repositories_for_approval_rule_template.execute(self, allocator, input, options);
    }

    /// Gets information about Amazon Web Servicestags for a specified Amazon
    /// Resource Name (ARN) in CodeCommit. For a list of valid resources in
    /// CodeCommit, see [CodeCommit Resources and
    /// Operations](https://docs.aws.amazon.com/codecommit/latest/userguide/auth-and-access-control-iam-access-control-identity-based.html#arn-formats) in the* CodeCommit User
    /// Guide*.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: CallOptions) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Merges two branches using the fast-forward merge strategy.
    pub fn mergeBranchesByFastForward(self: *Self, allocator: std.mem.Allocator, input: merge_branches_by_fast_forward.MergeBranchesByFastForwardInput, options: CallOptions) !merge_branches_by_fast_forward.MergeBranchesByFastForwardOutput {
        return merge_branches_by_fast_forward.execute(self, allocator, input, options);
    }

    /// Merges two branches using the squash merge strategy.
    pub fn mergeBranchesBySquash(self: *Self, allocator: std.mem.Allocator, input: merge_branches_by_squash.MergeBranchesBySquashInput, options: CallOptions) !merge_branches_by_squash.MergeBranchesBySquashOutput {
        return merge_branches_by_squash.execute(self, allocator, input, options);
    }

    /// Merges two specified branches using the three-way merge strategy.
    pub fn mergeBranchesByThreeWay(self: *Self, allocator: std.mem.Allocator, input: merge_branches_by_three_way.MergeBranchesByThreeWayInput, options: CallOptions) !merge_branches_by_three_way.MergeBranchesByThreeWayOutput {
        return merge_branches_by_three_way.execute(self, allocator, input, options);
    }

    /// Attempts to merge the source commit of a pull request into the specified
    /// destination
    /// branch for that pull request at the specified commit using the fast-forward
    /// merge strategy. If the merge is successful, it closes the pull request.
    pub fn mergePullRequestByFastForward(self: *Self, allocator: std.mem.Allocator, input: merge_pull_request_by_fast_forward.MergePullRequestByFastForwardInput, options: CallOptions) !merge_pull_request_by_fast_forward.MergePullRequestByFastForwardOutput {
        return merge_pull_request_by_fast_forward.execute(self, allocator, input, options);
    }

    /// Attempts to merge the source commit of a pull request into the specified
    /// destination
    /// branch for that pull request at the specified commit using the squash merge
    /// strategy. If the merge is successful, it closes the pull request.
    pub fn mergePullRequestBySquash(self: *Self, allocator: std.mem.Allocator, input: merge_pull_request_by_squash.MergePullRequestBySquashInput, options: CallOptions) !merge_pull_request_by_squash.MergePullRequestBySquashOutput {
        return merge_pull_request_by_squash.execute(self, allocator, input, options);
    }

    /// Attempts to merge the source commit of a pull request into the specified
    /// destination
    /// branch for that pull request at the specified commit using the three-way
    /// merge strategy. If the merge is successful, it closes the pull request.
    pub fn mergePullRequestByThreeWay(self: *Self, allocator: std.mem.Allocator, input: merge_pull_request_by_three_way.MergePullRequestByThreeWayInput, options: CallOptions) !merge_pull_request_by_three_way.MergePullRequestByThreeWayOutput {
        return merge_pull_request_by_three_way.execute(self, allocator, input, options);
    }

    /// Sets aside (overrides) all approval rule requirements for a specified pull
    /// request.
    pub fn overridePullRequestApprovalRules(self: *Self, allocator: std.mem.Allocator, input: override_pull_request_approval_rules.OverridePullRequestApprovalRulesInput, options: CallOptions) !override_pull_request_approval_rules.OverridePullRequestApprovalRulesOutput {
        return override_pull_request_approval_rules.execute(self, allocator, input, options);
    }

    /// Posts a comment on the comparison between two commits.
    pub fn postCommentForComparedCommit(self: *Self, allocator: std.mem.Allocator, input: post_comment_for_compared_commit.PostCommentForComparedCommitInput, options: CallOptions) !post_comment_for_compared_commit.PostCommentForComparedCommitOutput {
        return post_comment_for_compared_commit.execute(self, allocator, input, options);
    }

    /// Posts a comment on a pull request.
    pub fn postCommentForPullRequest(self: *Self, allocator: std.mem.Allocator, input: post_comment_for_pull_request.PostCommentForPullRequestInput, options: CallOptions) !post_comment_for_pull_request.PostCommentForPullRequestOutput {
        return post_comment_for_pull_request.execute(self, allocator, input, options);
    }

    /// Posts a comment in reply to an existing comment on a comparison between
    /// commits or a pull request.
    pub fn postCommentReply(self: *Self, allocator: std.mem.Allocator, input: post_comment_reply.PostCommentReplyInput, options: CallOptions) !post_comment_reply.PostCommentReplyOutput {
        return post_comment_reply.execute(self, allocator, input, options);
    }

    /// Adds or updates a reaction to a specified comment for the user whose
    /// identity is used to make the request. You can only add or
    /// update a reaction for yourself. You cannot add, modify, or delete a reaction
    /// for another user.
    pub fn putCommentReaction(self: *Self, allocator: std.mem.Allocator, input: put_comment_reaction.PutCommentReactionInput, options: CallOptions) !put_comment_reaction.PutCommentReactionOutput {
        return put_comment_reaction.execute(self, allocator, input, options);
    }

    /// Adds or updates a file in a branch in an CodeCommit repository, and
    /// generates a commit for the addition in the specified branch.
    pub fn putFile(self: *Self, allocator: std.mem.Allocator, input: put_file.PutFileInput, options: CallOptions) !put_file.PutFileOutput {
        return put_file.execute(self, allocator, input, options);
    }

    /// Replaces all triggers for a repository. Used to create or delete triggers.
    pub fn putRepositoryTriggers(self: *Self, allocator: std.mem.Allocator, input: put_repository_triggers.PutRepositoryTriggersInput, options: CallOptions) !put_repository_triggers.PutRepositoryTriggersOutput {
        return put_repository_triggers.execute(self, allocator, input, options);
    }

    /// Adds or updates tags for a resource in CodeCommit. For a list of valid
    /// resources
    /// in CodeCommit, see [CodeCommit Resources and
    /// Operations](https://docs.aws.amazon.com/codecommit/latest/userguide/auth-and-access-control-iam-access-control-identity-based.html#arn-formats) in the *CodeCommit User
    /// Guide*.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: CallOptions) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Tests the functionality of repository triggers by sending information to the
    /// trigger
    /// target. If real data is available in the repository, the test sends data
    /// from the last
    /// commit. If no data is available, sample data is generated.
    pub fn testRepositoryTriggers(self: *Self, allocator: std.mem.Allocator, input: test_repository_triggers.TestRepositoryTriggersInput, options: CallOptions) !test_repository_triggers.TestRepositoryTriggersOutput {
        return test_repository_triggers.execute(self, allocator, input, options);
    }

    /// Removes tags for a resource in CodeCommit. For a list of valid resources in
    /// CodeCommit, see [CodeCommit Resources and
    /// Operations](https://docs.aws.amazon.com/codecommit/latest/userguide/auth-and-access-control-iam-access-control-identity-based.html#arn-formats) in the *CodeCommit User
    /// Guide*.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: CallOptions) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Updates the content of an approval rule template. You can change the number
    /// of
    /// required approvals, the membership of the approval rule, and whether an
    /// approval pool is
    /// defined.
    pub fn updateApprovalRuleTemplateContent(self: *Self, allocator: std.mem.Allocator, input: update_approval_rule_template_content.UpdateApprovalRuleTemplateContentInput, options: CallOptions) !update_approval_rule_template_content.UpdateApprovalRuleTemplateContentOutput {
        return update_approval_rule_template_content.execute(self, allocator, input, options);
    }

    /// Updates the description for a specified approval rule template.
    pub fn updateApprovalRuleTemplateDescription(self: *Self, allocator: std.mem.Allocator, input: update_approval_rule_template_description.UpdateApprovalRuleTemplateDescriptionInput, options: CallOptions) !update_approval_rule_template_description.UpdateApprovalRuleTemplateDescriptionOutput {
        return update_approval_rule_template_description.execute(self, allocator, input, options);
    }

    /// Updates the name of a specified approval rule template.
    pub fn updateApprovalRuleTemplateName(self: *Self, allocator: std.mem.Allocator, input: update_approval_rule_template_name.UpdateApprovalRuleTemplateNameInput, options: CallOptions) !update_approval_rule_template_name.UpdateApprovalRuleTemplateNameOutput {
        return update_approval_rule_template_name.execute(self, allocator, input, options);
    }

    /// Replaces the contents of a comment.
    pub fn updateComment(self: *Self, allocator: std.mem.Allocator, input: update_comment.UpdateCommentInput, options: CallOptions) !update_comment.UpdateCommentOutput {
        return update_comment.execute(self, allocator, input, options);
    }

    /// Sets or changes the default branch name for the specified repository.
    ///
    /// If you use this operation to change the default branch name to the current
    /// default branch name, a success message is returned even though the default
    /// branch did not change.
    pub fn updateDefaultBranch(self: *Self, allocator: std.mem.Allocator, input: update_default_branch.UpdateDefaultBranchInput, options: CallOptions) !update_default_branch.UpdateDefaultBranchOutput {
        return update_default_branch.execute(self, allocator, input, options);
    }

    /// Updates the structure of an approval rule created specifically for a pull
    /// request. For example, you can change the number of required approvers and
    /// the approval pool for approvers.
    pub fn updatePullRequestApprovalRuleContent(self: *Self, allocator: std.mem.Allocator, input: update_pull_request_approval_rule_content.UpdatePullRequestApprovalRuleContentInput, options: CallOptions) !update_pull_request_approval_rule_content.UpdatePullRequestApprovalRuleContentOutput {
        return update_pull_request_approval_rule_content.execute(self, allocator, input, options);
    }

    /// Updates the state of a user's approval on a pull request. The user is
    /// derived from the signed-in account when the request is made.
    pub fn updatePullRequestApprovalState(self: *Self, allocator: std.mem.Allocator, input: update_pull_request_approval_state.UpdatePullRequestApprovalStateInput, options: CallOptions) !update_pull_request_approval_state.UpdatePullRequestApprovalStateOutput {
        return update_pull_request_approval_state.execute(self, allocator, input, options);
    }

    /// Replaces the contents of the description of a pull request.
    pub fn updatePullRequestDescription(self: *Self, allocator: std.mem.Allocator, input: update_pull_request_description.UpdatePullRequestDescriptionInput, options: CallOptions) !update_pull_request_description.UpdatePullRequestDescriptionOutput {
        return update_pull_request_description.execute(self, allocator, input, options);
    }

    /// Updates the status of a pull request.
    pub fn updatePullRequestStatus(self: *Self, allocator: std.mem.Allocator, input: update_pull_request_status.UpdatePullRequestStatusInput, options: CallOptions) !update_pull_request_status.UpdatePullRequestStatusOutput {
        return update_pull_request_status.execute(self, allocator, input, options);
    }

    /// Replaces the title of a pull request.
    pub fn updatePullRequestTitle(self: *Self, allocator: std.mem.Allocator, input: update_pull_request_title.UpdatePullRequestTitleInput, options: CallOptions) !update_pull_request_title.UpdatePullRequestTitleOutput {
        return update_pull_request_title.execute(self, allocator, input, options);
    }

    /// Sets or changes the comment or description for a repository.
    ///
    /// The description field for a repository accepts all HTML characters and all
    /// valid
    /// Unicode characters. Applications that do not HTML-encode the description and
    /// display
    /// it in a webpage can expose users to potentially malicious code. Make sure
    /// that you
    /// HTML-encode the description field in any application that uses this API to
    /// display
    /// the repository description on a webpage.
    pub fn updateRepositoryDescription(self: *Self, allocator: std.mem.Allocator, input: update_repository_description.UpdateRepositoryDescriptionInput, options: CallOptions) !update_repository_description.UpdateRepositoryDescriptionOutput {
        return update_repository_description.execute(self, allocator, input, options);
    }

    /// Updates the Key Management Service encryption key used to encrypt and
    /// decrypt a CodeCommit repository.
    pub fn updateRepositoryEncryptionKey(self: *Self, allocator: std.mem.Allocator, input: update_repository_encryption_key.UpdateRepositoryEncryptionKeyInput, options: CallOptions) !update_repository_encryption_key.UpdateRepositoryEncryptionKeyOutput {
        return update_repository_encryption_key.execute(self, allocator, input, options);
    }

    /// Renames a repository. The repository name must be unique across the calling
    /// Amazon Web Services account.
    /// Repository names are limited to 100 alphanumeric, dash, and underscore
    /// characters, and cannot include certain characters. The suffix .git is
    /// prohibited. For
    /// more information about the limits on repository names, see
    /// [Quotas](https://docs.aws.amazon.com/codecommit/latest/userguide/limits.html) in the CodeCommit
    /// User Guide.
    pub fn updateRepositoryName(self: *Self, allocator: std.mem.Allocator, input: update_repository_name.UpdateRepositoryNameInput, options: CallOptions) !update_repository_name.UpdateRepositoryNameOutput {
        return update_repository_name.execute(self, allocator, input, options);
    }

    pub fn describeMergeConflictsPaginator(self: *Self, params: describe_merge_conflicts.DescribeMergeConflictsInput) paginator.DescribeMergeConflictsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describePullRequestEventsPaginator(self: *Self, params: describe_pull_request_events.DescribePullRequestEventsInput) paginator.DescribePullRequestEventsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn getCommentReactionsPaginator(self: *Self, params: get_comment_reactions.GetCommentReactionsInput) paginator.GetCommentReactionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn getCommentsForComparedCommitPaginator(self: *Self, params: get_comments_for_compared_commit.GetCommentsForComparedCommitInput) paginator.GetCommentsForComparedCommitPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn getCommentsForPullRequestPaginator(self: *Self, params: get_comments_for_pull_request.GetCommentsForPullRequestInput) paginator.GetCommentsForPullRequestPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn getDifferencesPaginator(self: *Self, params: get_differences.GetDifferencesInput) paginator.GetDifferencesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn getMergeConflictsPaginator(self: *Self, params: get_merge_conflicts.GetMergeConflictsInput) paginator.GetMergeConflictsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listApprovalRuleTemplatesPaginator(self: *Self, params: list_approval_rule_templates.ListApprovalRuleTemplatesInput) paginator.ListApprovalRuleTemplatesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listAssociatedApprovalRuleTemplatesForRepositoryPaginator(self: *Self, params: list_associated_approval_rule_templates_for_repository.ListAssociatedApprovalRuleTemplatesForRepositoryInput) paginator.ListAssociatedApprovalRuleTemplatesForRepositoryPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listBranchesPaginator(self: *Self, params: list_branches.ListBranchesInput) paginator.ListBranchesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listFileCommitHistoryPaginator(self: *Self, params: list_file_commit_history.ListFileCommitHistoryInput) paginator.ListFileCommitHistoryPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listPullRequestsPaginator(self: *Self, params: list_pull_requests.ListPullRequestsInput) paginator.ListPullRequestsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listRepositoriesPaginator(self: *Self, params: list_repositories.ListRepositoriesInput) paginator.ListRepositoriesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listRepositoriesForApprovalRuleTemplatePaginator(self: *Self, params: list_repositories_for_approval_rule_template.ListRepositoriesForApprovalRuleTemplateInput) paginator.ListRepositoriesForApprovalRuleTemplatePaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};
