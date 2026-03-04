const aws = @import("aws");
const std = @import("std");

const associate_lenses = @import("associate_lenses.zig");
const associate_profiles = @import("associate_profiles.zig");
const create_lens_share = @import("create_lens_share.zig");
const create_lens_version = @import("create_lens_version.zig");
const create_milestone = @import("create_milestone.zig");
const create_profile = @import("create_profile.zig");
const create_profile_share = @import("create_profile_share.zig");
const create_review_template = @import("create_review_template.zig");
const create_template_share = @import("create_template_share.zig");
const create_workload = @import("create_workload.zig");
const create_workload_share = @import("create_workload_share.zig");
const delete_lens = @import("delete_lens.zig");
const delete_lens_share = @import("delete_lens_share.zig");
const delete_profile = @import("delete_profile.zig");
const delete_profile_share = @import("delete_profile_share.zig");
const delete_review_template = @import("delete_review_template.zig");
const delete_template_share = @import("delete_template_share.zig");
const delete_workload = @import("delete_workload.zig");
const delete_workload_share = @import("delete_workload_share.zig");
const disassociate_lenses = @import("disassociate_lenses.zig");
const disassociate_profiles = @import("disassociate_profiles.zig");
const export_lens = @import("export_lens.zig");
const get_answer = @import("get_answer.zig");
const get_consolidated_report = @import("get_consolidated_report.zig");
const get_global_settings = @import("get_global_settings.zig");
const get_lens = @import("get_lens.zig");
const get_lens_review = @import("get_lens_review.zig");
const get_lens_review_report = @import("get_lens_review_report.zig");
const get_lens_version_difference = @import("get_lens_version_difference.zig");
const get_milestone = @import("get_milestone.zig");
const get_profile = @import("get_profile.zig");
const get_profile_template = @import("get_profile_template.zig");
const get_review_template = @import("get_review_template.zig");
const get_review_template_answer = @import("get_review_template_answer.zig");
const get_review_template_lens_review = @import("get_review_template_lens_review.zig");
const get_workload = @import("get_workload.zig");
const import_lens = @import("import_lens.zig");
const list_answers = @import("list_answers.zig");
const list_check_details = @import("list_check_details.zig");
const list_check_summaries = @import("list_check_summaries.zig");
const list_lens_review_improvements = @import("list_lens_review_improvements.zig");
const list_lens_reviews = @import("list_lens_reviews.zig");
const list_lens_shares = @import("list_lens_shares.zig");
const list_lenses = @import("list_lenses.zig");
const list_milestones = @import("list_milestones.zig");
const list_notifications = @import("list_notifications.zig");
const list_profile_notifications = @import("list_profile_notifications.zig");
const list_profile_shares = @import("list_profile_shares.zig");
const list_profiles = @import("list_profiles.zig");
const list_review_template_answers = @import("list_review_template_answers.zig");
const list_review_templates = @import("list_review_templates.zig");
const list_share_invitations = @import("list_share_invitations.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const list_template_shares = @import("list_template_shares.zig");
const list_workload_shares = @import("list_workload_shares.zig");
const list_workloads = @import("list_workloads.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_answer = @import("update_answer.zig");
const update_global_settings = @import("update_global_settings.zig");
const update_integration = @import("update_integration.zig");
const update_lens_review = @import("update_lens_review.zig");
const update_profile = @import("update_profile.zig");
const update_review_template = @import("update_review_template.zig");
const update_review_template_answer = @import("update_review_template_answer.zig");
const update_review_template_lens_review = @import("update_review_template_lens_review.zig");
const update_share_invitation = @import("update_share_invitation.zig");
const update_workload = @import("update_workload.zig");
const update_workload_share = @import("update_workload_share.zig");
const upgrade_lens_review = @import("upgrade_lens_review.zig");
const upgrade_profile_version = @import("upgrade_profile_version.zig");
const upgrade_review_template_lens_review = @import("upgrade_review_template_lens_review.zig");
const CallOptions = @import("call_options.zig").CallOptions;
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "WellArchitected";

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

    /// Associate a lens to a workload.
    ///
    /// Up to 10 lenses can be associated with a workload in a single API operation.
    /// A
    /// maximum of 20 lenses can be associated with a workload.
    ///
    /// **Disclaimer**
    ///
    /// By accessing and/or applying custom lenses created by another Amazon Web
    /// Services user or account,
    /// you acknowledge that custom lenses created by other users and shared with
    /// you are
    /// Third Party Content as defined in the Amazon Web Services Customer
    /// Agreement.
    pub fn associateLenses(self: *Self, allocator: std.mem.Allocator, input: associate_lenses.AssociateLensesInput, options: CallOptions) !associate_lenses.AssociateLensesOutput {
        return associate_lenses.execute(self, allocator, input, options);
    }

    /// Associate a profile with a workload.
    pub fn associateProfiles(self: *Self, allocator: std.mem.Allocator, input: associate_profiles.AssociateProfilesInput, options: CallOptions) !associate_profiles.AssociateProfilesOutput {
        return associate_profiles.execute(self, allocator, input, options);
    }

    /// Create a lens share.
    ///
    /// The owner of a lens can share it with other Amazon Web Services accounts,
    /// users, an organization,
    /// and organizational units (OUs) in the same Amazon Web Services Region.
    /// Lenses provided by Amazon Web Services (Amazon Web Services Official
    /// Content) cannot be shared.
    ///
    /// Shared access to a lens is not removed until the lens invitation is deleted.
    ///
    /// If you share a lens with an organization or OU, all accounts in the
    /// organization or OU
    /// are granted access to the lens.
    ///
    /// For more information, see [Sharing a custom
    /// lens](https://docs.aws.amazon.com/wellarchitected/latest/userguide/lenses-sharing.html) in the
    /// *Well-Architected Tool User Guide*.
    ///
    /// **Disclaimer**
    ///
    /// By sharing your custom lenses with other Amazon Web Services accounts,
    /// you acknowledge that Amazon Web Services will make your custom lenses
    /// available to those
    /// other accounts. Those other accounts may continue to access and use your
    /// shared custom lenses even if you delete the custom lenses
    /// from your own Amazon Web Services account or terminate
    /// your Amazon Web Services account.
    pub fn createLensShare(self: *Self, allocator: std.mem.Allocator, input: create_lens_share.CreateLensShareInput, options: CallOptions) !create_lens_share.CreateLensShareOutput {
        return create_lens_share.execute(self, allocator, input, options);
    }

    /// Create a new lens version.
    ///
    /// A lens can have up to 100 versions.
    ///
    /// Use this operation to publish a new lens version after you have imported a
    /// lens. The `LensAlias`
    /// is used to identify the lens to be published.
    /// The owner of a lens can share the lens with other
    /// Amazon Web Services accounts and users in the same Amazon Web Services
    /// Region. Only the owner of a lens can delete it.
    pub fn createLensVersion(self: *Self, allocator: std.mem.Allocator, input: create_lens_version.CreateLensVersionInput, options: CallOptions) !create_lens_version.CreateLensVersionOutput {
        return create_lens_version.execute(self, allocator, input, options);
    }

    /// Create a milestone for an existing workload.
    pub fn createMilestone(self: *Self, allocator: std.mem.Allocator, input: create_milestone.CreateMilestoneInput, options: CallOptions) !create_milestone.CreateMilestoneOutput {
        return create_milestone.execute(self, allocator, input, options);
    }

    /// Create a profile.
    pub fn createProfile(self: *Self, allocator: std.mem.Allocator, input: create_profile.CreateProfileInput, options: CallOptions) !create_profile.CreateProfileOutput {
        return create_profile.execute(self, allocator, input, options);
    }

    /// Create a profile share.
    pub fn createProfileShare(self: *Self, allocator: std.mem.Allocator, input: create_profile_share.CreateProfileShareInput, options: CallOptions) !create_profile_share.CreateProfileShareOutput {
        return create_profile_share.execute(self, allocator, input, options);
    }

    /// Create a review template.
    ///
    /// **Disclaimer**
    ///
    /// Do not include or gather personal identifiable information (PII) of end
    /// users or
    /// other identifiable individuals in or via your review templates. If your
    /// review
    /// template or those shared with you and used in your account do include or
    /// collect PII
    /// you are responsible for: ensuring that the included PII is processed in
    /// accordance
    /// with applicable law, providing adequate privacy notices, and obtaining
    /// necessary
    /// consents for processing such data.
    pub fn createReviewTemplate(self: *Self, allocator: std.mem.Allocator, input: create_review_template.CreateReviewTemplateInput, options: CallOptions) !create_review_template.CreateReviewTemplateOutput {
        return create_review_template.execute(self, allocator, input, options);
    }

    /// Create a review template share.
    ///
    /// The owner of a review template can share it with other Amazon Web Services
    /// accounts,
    /// users, an organization, and organizational units (OUs) in the same Amazon
    /// Web Services Region.
    ///
    /// Shared access to a review template is not removed until the review template
    /// share
    /// invitation is deleted.
    ///
    /// If you share a review template with an organization or OU, all accounts in
    /// the
    /// organization or OU are granted access to the review template.
    ///
    /// **Disclaimer**
    ///
    /// By sharing your review template with other Amazon Web Services accounts, you
    /// acknowledge that Amazon Web Services will make your review template
    /// available to
    /// those other accounts.
    pub fn createTemplateShare(self: *Self, allocator: std.mem.Allocator, input: create_template_share.CreateTemplateShareInput, options: CallOptions) !create_template_share.CreateTemplateShareOutput {
        return create_template_share.execute(self, allocator, input, options);
    }

    /// Create a new workload.
    ///
    /// The owner of a workload can share the workload with other Amazon Web
    /// Services accounts, users,
    /// an organization, and organizational units (OUs)
    /// in the same Amazon Web Services Region. Only the owner of a workload can
    /// delete it.
    ///
    /// For more information, see [Defining a
    /// Workload](https://docs.aws.amazon.com/wellarchitected/latest/userguide/define-workload.html) in the
    /// *Well-Architected Tool User Guide*.
    ///
    /// Either `AwsRegions`, `NonAwsRegions`, or both must be specified when
    /// creating a workload.
    ///
    /// You also must specify `ReviewOwner`, even though the
    /// parameter is listed as not being required in the following section.
    ///
    /// When creating a workload using a review template, you must have the
    /// following IAM permissions:
    ///
    /// * `wellarchitected:GetReviewTemplate`
    ///
    /// * `wellarchitected:GetReviewTemplateAnswer`
    ///
    /// * `wellarchitected:ListReviewTemplateAnswers`
    ///
    /// * `wellarchitected:GetReviewTemplateLensReview`
    pub fn createWorkload(self: *Self, allocator: std.mem.Allocator, input: create_workload.CreateWorkloadInput, options: CallOptions) !create_workload.CreateWorkloadOutput {
        return create_workload.execute(self, allocator, input, options);
    }

    /// Create a workload share.
    ///
    /// The owner of a workload can share it with other Amazon Web Services accounts
    /// and users in the same
    /// Amazon Web Services Region. Shared access to a workload is not removed until
    /// the workload invitation is
    /// deleted.
    ///
    /// If you share a workload with an organization or OU, all accounts in the
    /// organization or OU
    /// are granted access to the workload.
    ///
    /// For more information, see [Sharing a
    /// workload](https://docs.aws.amazon.com/wellarchitected/latest/userguide/workloads-sharing.html) in the
    /// *Well-Architected Tool User Guide*.
    pub fn createWorkloadShare(self: *Self, allocator: std.mem.Allocator, input: create_workload_share.CreateWorkloadShareInput, options: CallOptions) !create_workload_share.CreateWorkloadShareOutput {
        return create_workload_share.execute(self, allocator, input, options);
    }

    /// Delete an existing lens.
    ///
    /// Only the owner of a lens can delete it. After the lens is deleted, Amazon
    /// Web Services accounts and users
    /// that you shared the lens with can continue to use it, but they will no
    /// longer be able to apply it to new workloads.
    ///
    /// **Disclaimer**
    ///
    /// By sharing your custom lenses with other Amazon Web Services accounts,
    /// you acknowledge that Amazon Web Services will make your custom lenses
    /// available to those
    /// other accounts. Those other accounts may continue to access and use your
    /// shared custom lenses even if you delete the custom lenses
    /// from your own Amazon Web Services account or terminate
    /// your Amazon Web Services account.
    pub fn deleteLens(self: *Self, allocator: std.mem.Allocator, input: delete_lens.DeleteLensInput, options: CallOptions) !delete_lens.DeleteLensOutput {
        return delete_lens.execute(self, allocator, input, options);
    }

    /// Delete a lens share.
    ///
    /// After the lens share is deleted, Amazon Web Services accounts, users,
    /// organizations,
    /// and organizational units (OUs)
    /// that you shared the lens with can continue to use it, but they will no
    /// longer be able to apply it to new workloads.
    ///
    /// **Disclaimer**
    ///
    /// By sharing your custom lenses with other Amazon Web Services accounts,
    /// you acknowledge that Amazon Web Services will make your custom lenses
    /// available to those
    /// other accounts. Those other accounts may continue to access and use your
    /// shared custom lenses even if you delete the custom lenses
    /// from your own Amazon Web Services account or terminate
    /// your Amazon Web Services account.
    pub fn deleteLensShare(self: *Self, allocator: std.mem.Allocator, input: delete_lens_share.DeleteLensShareInput, options: CallOptions) !delete_lens_share.DeleteLensShareOutput {
        return delete_lens_share.execute(self, allocator, input, options);
    }

    /// Delete a profile.
    ///
    /// **Disclaimer**
    ///
    /// By sharing your profile with other Amazon Web Services accounts,
    /// you acknowledge that Amazon Web Services will make your profile available to
    /// those
    /// other accounts. Those other accounts may continue to access and use your
    /// shared profile even if you delete the profile
    /// from your own Amazon Web Services account or terminate
    /// your Amazon Web Services account.
    pub fn deleteProfile(self: *Self, allocator: std.mem.Allocator, input: delete_profile.DeleteProfileInput, options: CallOptions) !delete_profile.DeleteProfileOutput {
        return delete_profile.execute(self, allocator, input, options);
    }

    /// Delete a profile share.
    pub fn deleteProfileShare(self: *Self, allocator: std.mem.Allocator, input: delete_profile_share.DeleteProfileShareInput, options: CallOptions) !delete_profile_share.DeleteProfileShareOutput {
        return delete_profile_share.execute(self, allocator, input, options);
    }

    /// Delete a review template.
    ///
    /// Only the owner of a review template can delete it.
    ///
    /// After the review template is deleted, Amazon Web Services accounts, users,
    /// organizations, and organizational units (OUs) that you shared the review
    /// template with
    /// will no longer be able to apply it to new workloads.
    pub fn deleteReviewTemplate(self: *Self, allocator: std.mem.Allocator, input: delete_review_template.DeleteReviewTemplateInput, options: CallOptions) !delete_review_template.DeleteReviewTemplateOutput {
        return delete_review_template.execute(self, allocator, input, options);
    }

    /// Delete a review template share.
    ///
    /// After the review template share is deleted, Amazon Web Services accounts,
    /// users,
    /// organizations, and organizational units (OUs) that you shared the review
    /// template with
    /// will no longer be able to apply it to new workloads.
    pub fn deleteTemplateShare(self: *Self, allocator: std.mem.Allocator, input: delete_template_share.DeleteTemplateShareInput, options: CallOptions) !delete_template_share.DeleteTemplateShareOutput {
        return delete_template_share.execute(self, allocator, input, options);
    }

    /// Delete an existing workload.
    pub fn deleteWorkload(self: *Self, allocator: std.mem.Allocator, input: delete_workload.DeleteWorkloadInput, options: CallOptions) !delete_workload.DeleteWorkloadOutput {
        return delete_workload.execute(self, allocator, input, options);
    }

    /// Delete a workload share.
    pub fn deleteWorkloadShare(self: *Self, allocator: std.mem.Allocator, input: delete_workload_share.DeleteWorkloadShareInput, options: CallOptions) !delete_workload_share.DeleteWorkloadShareOutput {
        return delete_workload_share.execute(self, allocator, input, options);
    }

    /// Disassociate a lens from a workload.
    ///
    /// Up to 10 lenses can be disassociated from a workload in a single API
    /// operation.
    ///
    /// The Amazon Web Services Well-Architected Framework lens (`wellarchitected`)
    /// cannot be
    /// removed from a workload.
    pub fn disassociateLenses(self: *Self, allocator: std.mem.Allocator, input: disassociate_lenses.DisassociateLensesInput, options: CallOptions) !disassociate_lenses.DisassociateLensesOutput {
        return disassociate_lenses.execute(self, allocator, input, options);
    }

    /// Disassociate a profile from a workload.
    pub fn disassociateProfiles(self: *Self, allocator: std.mem.Allocator, input: disassociate_profiles.DisassociateProfilesInput, options: CallOptions) !disassociate_profiles.DisassociateProfilesOutput {
        return disassociate_profiles.execute(self, allocator, input, options);
    }

    /// Export an existing lens.
    ///
    /// Only the owner of a lens can export it. Lenses provided by Amazon Web
    /// Services (Amazon Web Services Official Content)
    /// cannot be exported.
    ///
    /// Lenses are defined in JSON. For more information, see [JSON format
    /// specification](https://docs.aws.amazon.com/wellarchitected/latest/userguide/lenses-format-specification.html)
    /// in the *Well-Architected Tool User Guide*.
    ///
    /// **Disclaimer**
    ///
    /// Do not include or gather personal identifiable information (PII) of end
    /// users or
    /// other identifiable individuals in or via your custom lenses. If your custom
    /// lens or those shared with you and used in your account do include or collect
    /// PII you are responsible for: ensuring that the included PII is processed in
    /// accordance
    /// with applicable law, providing adequate privacy notices, and obtaining
    /// necessary
    /// consents for processing such data.
    pub fn exportLens(self: *Self, allocator: std.mem.Allocator, input: export_lens.ExportLensInput, options: CallOptions) !export_lens.ExportLensOutput {
        return export_lens.execute(self, allocator, input, options);
    }

    /// Get the answer to a specific question in a workload review.
    pub fn getAnswer(self: *Self, allocator: std.mem.Allocator, input: get_answer.GetAnswerInput, options: CallOptions) !get_answer.GetAnswerOutput {
        return get_answer.execute(self, allocator, input, options);
    }

    /// Get a consolidated report of your workloads.
    ///
    /// You can optionally choose to include workloads that have been shared with
    /// you.
    pub fn getConsolidatedReport(self: *Self, allocator: std.mem.Allocator, input: get_consolidated_report.GetConsolidatedReportInput, options: CallOptions) !get_consolidated_report.GetConsolidatedReportOutput {
        return get_consolidated_report.execute(self, allocator, input, options);
    }

    /// Global settings for all workloads.
    pub fn getGlobalSettings(self: *Self, allocator: std.mem.Allocator, input: get_global_settings.GetGlobalSettingsInput, options: CallOptions) !get_global_settings.GetGlobalSettingsOutput {
        return get_global_settings.execute(self, allocator, input, options);
    }

    /// Get an existing lens.
    pub fn getLens(self: *Self, allocator: std.mem.Allocator, input: get_lens.GetLensInput, options: CallOptions) !get_lens.GetLensOutput {
        return get_lens.execute(self, allocator, input, options);
    }

    /// Get lens review.
    pub fn getLensReview(self: *Self, allocator: std.mem.Allocator, input: get_lens_review.GetLensReviewInput, options: CallOptions) !get_lens_review.GetLensReviewOutput {
        return get_lens_review.execute(self, allocator, input, options);
    }

    /// Get lens review report.
    pub fn getLensReviewReport(self: *Self, allocator: std.mem.Allocator, input: get_lens_review_report.GetLensReviewReportInput, options: CallOptions) !get_lens_review_report.GetLensReviewReportOutput {
        return get_lens_review_report.execute(self, allocator, input, options);
    }

    /// Get lens version differences.
    pub fn getLensVersionDifference(self: *Self, allocator: std.mem.Allocator, input: get_lens_version_difference.GetLensVersionDifferenceInput, options: CallOptions) !get_lens_version_difference.GetLensVersionDifferenceOutput {
        return get_lens_version_difference.execute(self, allocator, input, options);
    }

    /// Get a milestone for an existing workload.
    pub fn getMilestone(self: *Self, allocator: std.mem.Allocator, input: get_milestone.GetMilestoneInput, options: CallOptions) !get_milestone.GetMilestoneOutput {
        return get_milestone.execute(self, allocator, input, options);
    }

    /// Get profile information.
    pub fn getProfile(self: *Self, allocator: std.mem.Allocator, input: get_profile.GetProfileInput, options: CallOptions) !get_profile.GetProfileOutput {
        return get_profile.execute(self, allocator, input, options);
    }

    /// Get profile template.
    pub fn getProfileTemplate(self: *Self, allocator: std.mem.Allocator, input: get_profile_template.GetProfileTemplateInput, options: CallOptions) !get_profile_template.GetProfileTemplateOutput {
        return get_profile_template.execute(self, allocator, input, options);
    }

    /// Get review template.
    pub fn getReviewTemplate(self: *Self, allocator: std.mem.Allocator, input: get_review_template.GetReviewTemplateInput, options: CallOptions) !get_review_template.GetReviewTemplateOutput {
        return get_review_template.execute(self, allocator, input, options);
    }

    /// Get review template answer.
    pub fn getReviewTemplateAnswer(self: *Self, allocator: std.mem.Allocator, input: get_review_template_answer.GetReviewTemplateAnswerInput, options: CallOptions) !get_review_template_answer.GetReviewTemplateAnswerOutput {
        return get_review_template_answer.execute(self, allocator, input, options);
    }

    /// Get a lens review associated with a review template.
    pub fn getReviewTemplateLensReview(self: *Self, allocator: std.mem.Allocator, input: get_review_template_lens_review.GetReviewTemplateLensReviewInput, options: CallOptions) !get_review_template_lens_review.GetReviewTemplateLensReviewOutput {
        return get_review_template_lens_review.execute(self, allocator, input, options);
    }

    /// Get an existing workload.
    pub fn getWorkload(self: *Self, allocator: std.mem.Allocator, input: get_workload.GetWorkloadInput, options: CallOptions) !get_workload.GetWorkloadOutput {
        return get_workload.execute(self, allocator, input, options);
    }

    /// Import a new custom lens or update an existing custom lens.
    ///
    /// To update an existing custom lens, specify its ARN as the `LensAlias`. If
    /// no ARN is specified, a new custom lens is created.
    ///
    /// The new or updated lens will have a status of `DRAFT`. The lens cannot be
    /// applied to workloads or shared with other Amazon Web Services accounts until
    /// it's
    /// published with CreateLensVersion.
    ///
    /// Lenses are defined in JSON. For more information, see [JSON format
    /// specification](https://docs.aws.amazon.com/wellarchitected/latest/userguide/lenses-format-specification.html)
    /// in the *Well-Architected Tool User Guide*.
    ///
    /// A custom lens cannot exceed 500 KB in size.
    ///
    /// **Disclaimer**
    ///
    /// Do not include or gather personal identifiable information (PII) of end
    /// users or
    /// other identifiable individuals in or via your custom lenses. If your custom
    /// lens or those shared with you and used in your account do include or collect
    /// PII you are responsible for: ensuring that the included PII is processed in
    /// accordance
    /// with applicable law, providing adequate privacy notices, and obtaining
    /// necessary
    /// consents for processing such data.
    pub fn importLens(self: *Self, allocator: std.mem.Allocator, input: import_lens.ImportLensInput, options: CallOptions) !import_lens.ImportLensOutput {
        return import_lens.execute(self, allocator, input, options);
    }

    /// List of answers for a particular workload and lens.
    pub fn listAnswers(self: *Self, allocator: std.mem.Allocator, input: list_answers.ListAnswersInput, options: CallOptions) !list_answers.ListAnswersOutput {
        return list_answers.execute(self, allocator, input, options);
    }

    /// List of Trusted Advisor check details by account related to the workload.
    pub fn listCheckDetails(self: *Self, allocator: std.mem.Allocator, input: list_check_details.ListCheckDetailsInput, options: CallOptions) !list_check_details.ListCheckDetailsOutput {
        return list_check_details.execute(self, allocator, input, options);
    }

    /// List of Trusted Advisor checks summarized for all accounts related to the
    /// workload.
    pub fn listCheckSummaries(self: *Self, allocator: std.mem.Allocator, input: list_check_summaries.ListCheckSummariesInput, options: CallOptions) !list_check_summaries.ListCheckSummariesOutput {
        return list_check_summaries.execute(self, allocator, input, options);
    }

    /// List the improvements of a particular lens review.
    pub fn listLensReviewImprovements(self: *Self, allocator: std.mem.Allocator, input: list_lens_review_improvements.ListLensReviewImprovementsInput, options: CallOptions) !list_lens_review_improvements.ListLensReviewImprovementsOutput {
        return list_lens_review_improvements.execute(self, allocator, input, options);
    }

    /// List lens reviews for a particular workload.
    pub fn listLensReviews(self: *Self, allocator: std.mem.Allocator, input: list_lens_reviews.ListLensReviewsInput, options: CallOptions) !list_lens_reviews.ListLensReviewsOutput {
        return list_lens_reviews.execute(self, allocator, input, options);
    }

    /// List the lens shares associated with the lens.
    pub fn listLensShares(self: *Self, allocator: std.mem.Allocator, input: list_lens_shares.ListLensSharesInput, options: CallOptions) !list_lens_shares.ListLensSharesOutput {
        return list_lens_shares.execute(self, allocator, input, options);
    }

    /// List the available lenses.
    pub fn listLenses(self: *Self, allocator: std.mem.Allocator, input: list_lenses.ListLensesInput, options: CallOptions) !list_lenses.ListLensesOutput {
        return list_lenses.execute(self, allocator, input, options);
    }

    /// List all milestones for an existing workload.
    pub fn listMilestones(self: *Self, allocator: std.mem.Allocator, input: list_milestones.ListMilestonesInput, options: CallOptions) !list_milestones.ListMilestonesOutput {
        return list_milestones.execute(self, allocator, input, options);
    }

    /// List lens notifications.
    pub fn listNotifications(self: *Self, allocator: std.mem.Allocator, input: list_notifications.ListNotificationsInput, options: CallOptions) !list_notifications.ListNotificationsOutput {
        return list_notifications.execute(self, allocator, input, options);
    }

    /// List profile notifications.
    pub fn listProfileNotifications(self: *Self, allocator: std.mem.Allocator, input: list_profile_notifications.ListProfileNotificationsInput, options: CallOptions) !list_profile_notifications.ListProfileNotificationsOutput {
        return list_profile_notifications.execute(self, allocator, input, options);
    }

    /// List profile shares.
    pub fn listProfileShares(self: *Self, allocator: std.mem.Allocator, input: list_profile_shares.ListProfileSharesInput, options: CallOptions) !list_profile_shares.ListProfileSharesOutput {
        return list_profile_shares.execute(self, allocator, input, options);
    }

    /// List profiles.
    pub fn listProfiles(self: *Self, allocator: std.mem.Allocator, input: list_profiles.ListProfilesInput, options: CallOptions) !list_profiles.ListProfilesOutput {
        return list_profiles.execute(self, allocator, input, options);
    }

    /// List the answers of a review template.
    pub fn listReviewTemplateAnswers(self: *Self, allocator: std.mem.Allocator, input: list_review_template_answers.ListReviewTemplateAnswersInput, options: CallOptions) !list_review_template_answers.ListReviewTemplateAnswersOutput {
        return list_review_template_answers.execute(self, allocator, input, options);
    }

    /// List review templates.
    pub fn listReviewTemplates(self: *Self, allocator: std.mem.Allocator, input: list_review_templates.ListReviewTemplatesInput, options: CallOptions) !list_review_templates.ListReviewTemplatesOutput {
        return list_review_templates.execute(self, allocator, input, options);
    }

    /// List the share invitations.
    ///
    /// `WorkloadNamePrefix`, `LensNamePrefix`,
    /// `ProfileNamePrefix`, and `TemplateNamePrefix` are mutually
    /// exclusive. Use the parameter that matches your `ShareResourceType`.
    pub fn listShareInvitations(self: *Self, allocator: std.mem.Allocator, input: list_share_invitations.ListShareInvitationsInput, options: CallOptions) !list_share_invitations.ListShareInvitationsOutput {
        return list_share_invitations.execute(self, allocator, input, options);
    }

    /// List the tags for a resource.
    ///
    /// The WorkloadArn parameter can be a workload ARN, a custom lens ARN, a
    /// profile ARN, or review template ARN.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: CallOptions) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// List review template shares.
    pub fn listTemplateShares(self: *Self, allocator: std.mem.Allocator, input: list_template_shares.ListTemplateSharesInput, options: CallOptions) !list_template_shares.ListTemplateSharesOutput {
        return list_template_shares.execute(self, allocator, input, options);
    }

    /// List the workload shares associated with the workload.
    pub fn listWorkloadShares(self: *Self, allocator: std.mem.Allocator, input: list_workload_shares.ListWorkloadSharesInput, options: CallOptions) !list_workload_shares.ListWorkloadSharesOutput {
        return list_workload_shares.execute(self, allocator, input, options);
    }

    /// Paginated list of workloads.
    pub fn listWorkloads(self: *Self, allocator: std.mem.Allocator, input: list_workloads.ListWorkloadsInput, options: CallOptions) !list_workloads.ListWorkloadsOutput {
        return list_workloads.execute(self, allocator, input, options);
    }

    /// Adds one or more tags to the specified resource.
    ///
    /// The WorkloadArn parameter can be a workload ARN, a custom lens ARN, a
    /// profile ARN, or review template ARN.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: CallOptions) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Deletes specified tags from a resource.
    ///
    /// The WorkloadArn parameter can be a workload ARN, a custom lens ARN, a
    /// profile ARN, or review template ARN.
    ///
    /// To specify multiple tags, use separate **tagKeys** parameters, for example:
    ///
    /// `DELETE /tags/WorkloadArn?tagKeys=key1&tagKeys=key2`
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: CallOptions) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Update the answer to a specific question in a workload review.
    pub fn updateAnswer(self: *Self, allocator: std.mem.Allocator, input: update_answer.UpdateAnswerInput, options: CallOptions) !update_answer.UpdateAnswerOutput {
        return update_answer.execute(self, allocator, input, options);
    }

    /// Update whether the Amazon Web Services account is opted into organization
    /// sharing and discovery integration features.
    pub fn updateGlobalSettings(self: *Self, allocator: std.mem.Allocator, input: update_global_settings.UpdateGlobalSettingsInput, options: CallOptions) !update_global_settings.UpdateGlobalSettingsOutput {
        return update_global_settings.execute(self, allocator, input, options);
    }

    /// Update integration features.
    pub fn updateIntegration(self: *Self, allocator: std.mem.Allocator, input: update_integration.UpdateIntegrationInput, options: CallOptions) !update_integration.UpdateIntegrationOutput {
        return update_integration.execute(self, allocator, input, options);
    }

    /// Update lens review for a particular workload.
    pub fn updateLensReview(self: *Self, allocator: std.mem.Allocator, input: update_lens_review.UpdateLensReviewInput, options: CallOptions) !update_lens_review.UpdateLensReviewOutput {
        return update_lens_review.execute(self, allocator, input, options);
    }

    /// Update a profile.
    pub fn updateProfile(self: *Self, allocator: std.mem.Allocator, input: update_profile.UpdateProfileInput, options: CallOptions) !update_profile.UpdateProfileOutput {
        return update_profile.execute(self, allocator, input, options);
    }

    /// Update a review template.
    pub fn updateReviewTemplate(self: *Self, allocator: std.mem.Allocator, input: update_review_template.UpdateReviewTemplateInput, options: CallOptions) !update_review_template.UpdateReviewTemplateOutput {
        return update_review_template.execute(self, allocator, input, options);
    }

    /// Update a review template answer.
    pub fn updateReviewTemplateAnswer(self: *Self, allocator: std.mem.Allocator, input: update_review_template_answer.UpdateReviewTemplateAnswerInput, options: CallOptions) !update_review_template_answer.UpdateReviewTemplateAnswerOutput {
        return update_review_template_answer.execute(self, allocator, input, options);
    }

    /// Update a lens review associated with a review template.
    pub fn updateReviewTemplateLensReview(self: *Self, allocator: std.mem.Allocator, input: update_review_template_lens_review.UpdateReviewTemplateLensReviewInput, options: CallOptions) !update_review_template_lens_review.UpdateReviewTemplateLensReviewOutput {
        return update_review_template_lens_review.execute(self, allocator, input, options);
    }

    /// Update a workload or custom lens share invitation.
    ///
    /// This API operation can be called independently of any resource. Previous
    /// documentation implied that a workload ARN must be specified.
    pub fn updateShareInvitation(self: *Self, allocator: std.mem.Allocator, input: update_share_invitation.UpdateShareInvitationInput, options: CallOptions) !update_share_invitation.UpdateShareInvitationOutput {
        return update_share_invitation.execute(self, allocator, input, options);
    }

    /// Update an existing workload.
    pub fn updateWorkload(self: *Self, allocator: std.mem.Allocator, input: update_workload.UpdateWorkloadInput, options: CallOptions) !update_workload.UpdateWorkloadOutput {
        return update_workload.execute(self, allocator, input, options);
    }

    /// Update a workload share.
    pub fn updateWorkloadShare(self: *Self, allocator: std.mem.Allocator, input: update_workload_share.UpdateWorkloadShareInput, options: CallOptions) !update_workload_share.UpdateWorkloadShareOutput {
        return update_workload_share.execute(self, allocator, input, options);
    }

    /// Upgrade lens review for a particular workload.
    pub fn upgradeLensReview(self: *Self, allocator: std.mem.Allocator, input: upgrade_lens_review.UpgradeLensReviewInput, options: CallOptions) !upgrade_lens_review.UpgradeLensReviewOutput {
        return upgrade_lens_review.execute(self, allocator, input, options);
    }

    /// Upgrade a profile.
    pub fn upgradeProfileVersion(self: *Self, allocator: std.mem.Allocator, input: upgrade_profile_version.UpgradeProfileVersionInput, options: CallOptions) !upgrade_profile_version.UpgradeProfileVersionOutput {
        return upgrade_profile_version.execute(self, allocator, input, options);
    }

    /// Upgrade the lens review of a review template.
    pub fn upgradeReviewTemplateLensReview(self: *Self, allocator: std.mem.Allocator, input: upgrade_review_template_lens_review.UpgradeReviewTemplateLensReviewInput, options: CallOptions) !upgrade_review_template_lens_review.UpgradeReviewTemplateLensReviewOutput {
        return upgrade_review_template_lens_review.execute(self, allocator, input, options);
    }

    pub fn getConsolidatedReportPaginator(self: *Self, params: get_consolidated_report.GetConsolidatedReportInput) paginator.GetConsolidatedReportPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listAnswersPaginator(self: *Self, params: list_answers.ListAnswersInput) paginator.ListAnswersPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listCheckDetailsPaginator(self: *Self, params: list_check_details.ListCheckDetailsInput) paginator.ListCheckDetailsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listCheckSummariesPaginator(self: *Self, params: list_check_summaries.ListCheckSummariesInput) paginator.ListCheckSummariesPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listLensReviewImprovementsPaginator(self: *Self, params: list_lens_review_improvements.ListLensReviewImprovementsInput) paginator.ListLensReviewImprovementsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listLensReviewsPaginator(self: *Self, params: list_lens_reviews.ListLensReviewsInput) paginator.ListLensReviewsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listLensSharesPaginator(self: *Self, params: list_lens_shares.ListLensSharesInput) paginator.ListLensSharesPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listLensesPaginator(self: *Self, params: list_lenses.ListLensesInput) paginator.ListLensesPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listMilestonesPaginator(self: *Self, params: list_milestones.ListMilestonesInput) paginator.ListMilestonesPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listNotificationsPaginator(self: *Self, params: list_notifications.ListNotificationsInput) paginator.ListNotificationsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listProfileNotificationsPaginator(self: *Self, params: list_profile_notifications.ListProfileNotificationsInput) paginator.ListProfileNotificationsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listProfileSharesPaginator(self: *Self, params: list_profile_shares.ListProfileSharesInput) paginator.ListProfileSharesPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listProfilesPaginator(self: *Self, params: list_profiles.ListProfilesInput) paginator.ListProfilesPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listReviewTemplateAnswersPaginator(self: *Self, params: list_review_template_answers.ListReviewTemplateAnswersInput) paginator.ListReviewTemplateAnswersPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listReviewTemplatesPaginator(self: *Self, params: list_review_templates.ListReviewTemplatesInput) paginator.ListReviewTemplatesPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listShareInvitationsPaginator(self: *Self, params: list_share_invitations.ListShareInvitationsInput) paginator.ListShareInvitationsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listTemplateSharesPaginator(self: *Self, params: list_template_shares.ListTemplateSharesInput) paginator.ListTemplateSharesPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listWorkloadSharesPaginator(self: *Self, params: list_workload_shares.ListWorkloadSharesInput) paginator.ListWorkloadSharesPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listWorkloadsPaginator(self: *Self, params: list_workloads.ListWorkloadsInput) paginator.ListWorkloadsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }
};
