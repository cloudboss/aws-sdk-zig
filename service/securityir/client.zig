const aws = @import("aws");
const std = @import("std");

const batch_get_member_account_details = @import("batch_get_member_account_details.zig");
const cancel_membership = @import("cancel_membership.zig");
const close_case = @import("close_case.zig");
const create_case = @import("create_case.zig");
const create_case_comment = @import("create_case_comment.zig");
const create_membership = @import("create_membership.zig");
const get_case = @import("get_case.zig");
const get_case_attachment_download_url = @import("get_case_attachment_download_url.zig");
const get_case_attachment_upload_url = @import("get_case_attachment_upload_url.zig");
const get_membership = @import("get_membership.zig");
const list_case_edits = @import("list_case_edits.zig");
const list_cases = @import("list_cases.zig");
const list_comments = @import("list_comments.zig");
const list_investigations = @import("list_investigations.zig");
const list_memberships = @import("list_memberships.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const send_feedback = @import("send_feedback.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_case = @import("update_case.zig");
const update_case_comment = @import("update_case_comment.zig");
const update_case_status = @import("update_case_status.zig");
const update_membership = @import("update_membership.zig");
const update_resolver_type = @import("update_resolver_type.zig");
const CallOptions = @import("call_options.zig").CallOptions;
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "Security IR";

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

    /// Provides information on whether the supplied account IDs are associated with
    /// a membership.
    ///
    /// AWS account ID's may appear less than 12 characters and need to be
    /// zero-prepended. An example would be `123123123` which is nine digits, and
    /// with zero-prepend would be `000123123123`. Not zero-prepending to 12 digits
    /// could result in errors.
    pub fn batchGetMemberAccountDetails(self: *Self, allocator: std.mem.Allocator, input: batch_get_member_account_details.BatchGetMemberAccountDetailsInput, options: CallOptions) !batch_get_member_account_details.BatchGetMemberAccountDetailsOutput {
        return batch_get_member_account_details.execute(self, allocator, input, options);
    }

    /// Cancels an existing membership.
    pub fn cancelMembership(self: *Self, allocator: std.mem.Allocator, input: cancel_membership.CancelMembershipInput, options: CallOptions) !cancel_membership.CancelMembershipOutput {
        return cancel_membership.execute(self, allocator, input, options);
    }

    /// Closes an existing case.
    pub fn closeCase(self: *Self, allocator: std.mem.Allocator, input: close_case.CloseCaseInput, options: CallOptions) !close_case.CloseCaseOutput {
        return close_case.execute(self, allocator, input, options);
    }

    /// Creates a new case.
    pub fn createCase(self: *Self, allocator: std.mem.Allocator, input: create_case.CreateCaseInput, options: CallOptions) !create_case.CreateCaseOutput {
        return create_case.execute(self, allocator, input, options);
    }

    /// Adds a comment to an existing case.
    pub fn createCaseComment(self: *Self, allocator: std.mem.Allocator, input: create_case_comment.CreateCaseCommentInput, options: CallOptions) !create_case_comment.CreateCaseCommentOutput {
        return create_case_comment.execute(self, allocator, input, options);
    }

    /// Creates a new membership.
    pub fn createMembership(self: *Self, allocator: std.mem.Allocator, input: create_membership.CreateMembershipInput, options: CallOptions) !create_membership.CreateMembershipOutput {
        return create_membership.execute(self, allocator, input, options);
    }

    /// Returns the attributes of a case.
    pub fn getCase(self: *Self, allocator: std.mem.Allocator, input: get_case.GetCaseInput, options: CallOptions) !get_case.GetCaseOutput {
        return get_case.execute(self, allocator, input, options);
    }

    /// Returns a Pre-Signed URL for uploading attachments into a case.
    pub fn getCaseAttachmentDownloadUrl(self: *Self, allocator: std.mem.Allocator, input: get_case_attachment_download_url.GetCaseAttachmentDownloadUrlInput, options: CallOptions) !get_case_attachment_download_url.GetCaseAttachmentDownloadUrlOutput {
        return get_case_attachment_download_url.execute(self, allocator, input, options);
    }

    /// Uploads an attachment to a case.
    pub fn getCaseAttachmentUploadUrl(self: *Self, allocator: std.mem.Allocator, input: get_case_attachment_upload_url.GetCaseAttachmentUploadUrlInput, options: CallOptions) !get_case_attachment_upload_url.GetCaseAttachmentUploadUrlOutput {
        return get_case_attachment_upload_url.execute(self, allocator, input, options);
    }

    /// Returns the attributes of a membership.
    pub fn getMembership(self: *Self, allocator: std.mem.Allocator, input: get_membership.GetMembershipInput, options: CallOptions) !get_membership.GetMembershipOutput {
        return get_membership.execute(self, allocator, input, options);
    }

    /// Views the case history for edits made to a designated case.
    pub fn listCaseEdits(self: *Self, allocator: std.mem.Allocator, input: list_case_edits.ListCaseEditsInput, options: CallOptions) !list_case_edits.ListCaseEditsOutput {
        return list_case_edits.execute(self, allocator, input, options);
    }

    /// Lists all cases the requester has access to.
    pub fn listCases(self: *Self, allocator: std.mem.Allocator, input: list_cases.ListCasesInput, options: CallOptions) !list_cases.ListCasesOutput {
        return list_cases.execute(self, allocator, input, options);
    }

    /// Returns comments for a designated case.
    pub fn listComments(self: *Self, allocator: std.mem.Allocator, input: list_comments.ListCommentsInput, options: CallOptions) !list_comments.ListCommentsOutput {
        return list_comments.execute(self, allocator, input, options);
    }

    /// Investigation performed by an agent for a security incident...
    pub fn listInvestigations(self: *Self, allocator: std.mem.Allocator, input: list_investigations.ListInvestigationsInput, options: CallOptions) !list_investigations.ListInvestigationsOutput {
        return list_investigations.execute(self, allocator, input, options);
    }

    /// Returns the memberships that the calling principal can access.
    pub fn listMemberships(self: *Self, allocator: std.mem.Allocator, input: list_memberships.ListMembershipsInput, options: CallOptions) !list_memberships.ListMembershipsOutput {
        return list_memberships.execute(self, allocator, input, options);
    }

    /// Returns currently configured tags on a resource.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: CallOptions) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Send feedback based on response investigation action
    pub fn sendFeedback(self: *Self, allocator: std.mem.Allocator, input: send_feedback.SendFeedbackInput, options: CallOptions) !send_feedback.SendFeedbackOutput {
        return send_feedback.execute(self, allocator, input, options);
    }

    /// Adds a tag(s) to a designated resource.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: CallOptions) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Removes a tag(s) from a designate resource.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: CallOptions) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Updates an existing case.
    pub fn updateCase(self: *Self, allocator: std.mem.Allocator, input: update_case.UpdateCaseInput, options: CallOptions) !update_case.UpdateCaseOutput {
        return update_case.execute(self, allocator, input, options);
    }

    /// Updates an existing case comment.
    pub fn updateCaseComment(self: *Self, allocator: std.mem.Allocator, input: update_case_comment.UpdateCaseCommentInput, options: CallOptions) !update_case_comment.UpdateCaseCommentOutput {
        return update_case_comment.execute(self, allocator, input, options);
    }

    /// Updates the state transitions for a designated cases.
    ///
    /// **Self-managed**: the following states are available for self-managed cases.
    ///
    /// * Submitted → Detection and Analysis
    /// * Detection and Analysis → Containment, Eradication, and Recovery
    /// * Detection and Analysis → Post-incident Activities
    /// * Containment, Eradication, and Recovery → Detection and Analysis
    /// * Containment, Eradication, and Recovery → Post-incident Activities
    /// * Post-incident Activities → Containment, Eradication, and Recovery
    /// * Post-incident Activities → Detection and Analysis
    /// * Any → Closed
    ///
    /// **AWS supported**: You must use the `CloseCase` API to close.
    pub fn updateCaseStatus(self: *Self, allocator: std.mem.Allocator, input: update_case_status.UpdateCaseStatusInput, options: CallOptions) !update_case_status.UpdateCaseStatusOutput {
        return update_case_status.execute(self, allocator, input, options);
    }

    /// Updates membership configuration.
    pub fn updateMembership(self: *Self, allocator: std.mem.Allocator, input: update_membership.UpdateMembershipInput, options: CallOptions) !update_membership.UpdateMembershipOutput {
        return update_membership.execute(self, allocator, input, options);
    }

    /// Updates the resolver type for a case.
    ///
    /// This is a one-way action and cannot be reversed.
    pub fn updateResolverType(self: *Self, allocator: std.mem.Allocator, input: update_resolver_type.UpdateResolverTypeInput, options: CallOptions) !update_resolver_type.UpdateResolverTypeOutput {
        return update_resolver_type.execute(self, allocator, input, options);
    }

    pub fn listCaseEditsPaginator(self: *Self, params: list_case_edits.ListCaseEditsInput) paginator.ListCaseEditsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listCasesPaginator(self: *Self, params: list_cases.ListCasesInput) paginator.ListCasesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listCommentsPaginator(self: *Self, params: list_comments.ListCommentsInput) paginator.ListCommentsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listInvestigationsPaginator(self: *Self, params: list_investigations.ListInvestigationsInput) paginator.ListInvestigationsPaginator {
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
};
