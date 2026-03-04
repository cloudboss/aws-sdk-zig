const aws = @import("aws");
const std = @import("std");

const accept_engagement_invitation = @import("accept_engagement_invitation.zig");
const assign_opportunity = @import("assign_opportunity.zig");
const associate_opportunity = @import("associate_opportunity.zig");
const create_engagement = @import("create_engagement.zig");
const create_engagement_context = @import("create_engagement_context.zig");
const create_engagement_invitation = @import("create_engagement_invitation.zig");
const create_opportunity = @import("create_opportunity.zig");
const create_resource_snapshot = @import("create_resource_snapshot.zig");
const create_resource_snapshot_job = @import("create_resource_snapshot_job.zig");
const delete_resource_snapshot_job = @import("delete_resource_snapshot_job.zig");
const disassociate_opportunity = @import("disassociate_opportunity.zig");
const get_aws_opportunity_summary = @import("get_aws_opportunity_summary.zig");
const get_engagement = @import("get_engagement.zig");
const get_engagement_invitation = @import("get_engagement_invitation.zig");
const get_opportunity = @import("get_opportunity.zig");
const get_resource_snapshot = @import("get_resource_snapshot.zig");
const get_resource_snapshot_job = @import("get_resource_snapshot_job.zig");
const get_selling_system_settings = @import("get_selling_system_settings.zig");
const list_engagement_by_accepting_invitation_tasks = @import("list_engagement_by_accepting_invitation_tasks.zig");
const list_engagement_from_opportunity_tasks = @import("list_engagement_from_opportunity_tasks.zig");
const list_engagement_invitations = @import("list_engagement_invitations.zig");
const list_engagement_members = @import("list_engagement_members.zig");
const list_engagement_resource_associations = @import("list_engagement_resource_associations.zig");
const list_engagements = @import("list_engagements.zig");
const list_opportunities = @import("list_opportunities.zig");
const list_opportunity_from_engagement_tasks = @import("list_opportunity_from_engagement_tasks.zig");
const list_resource_snapshot_jobs = @import("list_resource_snapshot_jobs.zig");
const list_resource_snapshots = @import("list_resource_snapshots.zig");
const list_solutions = @import("list_solutions.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const put_selling_system_settings = @import("put_selling_system_settings.zig");
const reject_engagement_invitation = @import("reject_engagement_invitation.zig");
const start_engagement_by_accepting_invitation_task = @import("start_engagement_by_accepting_invitation_task.zig");
const start_engagement_from_opportunity_task = @import("start_engagement_from_opportunity_task.zig");
const start_opportunity_from_engagement_task = @import("start_opportunity_from_engagement_task.zig");
const start_resource_snapshot_job = @import("start_resource_snapshot_job.zig");
const stop_resource_snapshot_job = @import("stop_resource_snapshot_job.zig");
const submit_opportunity = @import("submit_opportunity.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_engagement_context = @import("update_engagement_context.zig");
const update_opportunity = @import("update_opportunity.zig");
const CallOptions = @import("call_options.zig").CallOptions;
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "PartnerCentral Selling";

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

    /// Use the `AcceptEngagementInvitation` action to accept an engagement
    /// invitation shared by AWS. Accepting the invitation indicates your
    /// willingness to participate in the engagement, granting you access to all
    /// engagement-related data.
    pub fn acceptEngagementInvitation(self: *Self, allocator: std.mem.Allocator, input: accept_engagement_invitation.AcceptEngagementInvitationInput, options: CallOptions) !accept_engagement_invitation.AcceptEngagementInvitationOutput {
        return accept_engagement_invitation.execute(self, allocator, input, options);
    }

    /// Enables you to reassign an existing `Opportunity` to another user within
    /// your Partner Central account. The specified user receives the opportunity,
    /// and it appears on their Partner Central dashboard, allowing them to take
    /// necessary actions or proceed with the opportunity.
    ///
    /// This is useful for distributing opportunities to the appropriate team
    /// members or departments within your organization, ensuring that each
    /// opportunity is handled by the right person. By default, the opportunity
    /// owner is the one who creates it. Currently, there's no API to enumerate the
    /// list of available users.
    pub fn assignOpportunity(self: *Self, allocator: std.mem.Allocator, input: assign_opportunity.AssignOpportunityInput, options: CallOptions) !assign_opportunity.AssignOpportunityOutput {
        return assign_opportunity.execute(self, allocator, input, options);
    }

    /// Enables you to create a formal association between an `Opportunity` and
    /// various related entities, enriching the context and details of the
    /// opportunity for better collaboration and decision making. You can associate
    /// an opportunity with the following entity types:
    ///
    /// * Partner Solution: A software product or consulting practice created and
    ///   delivered by Partners. Partner Solutions help customers address business
    ///   challenges using Amazon Web Services services.
    /// * Amazon Web Services Products: Amazon Web Services offers many products and
    ///   services that provide scalable, reliable, and cost-effective
    ///   infrastructure solutions. For the latest list of Amazon Web Services
    ///   products, see [Amazon Web Services
    ///   products](https://github.com/aws-samples/partner-crm-integration-samples/blob/main/resources/aws_products.json).
    /// * Amazon Web Services Marketplace private offer: Allows Amazon Web Services
    ///   Marketplace sellers to extend custom pricing and terms to individual
    ///   Amazon Web Services customers. Sellers can negotiate custom prices,
    ///   payment schedules, and end user license terms through private offers,
    ///   enabling Amazon Web Services customers to acquire software solutions
    ///   tailored to their specific needs. For more information, see [Private
    ///   offers in Amazon Web Services
    ///   Marketplace](https://docs.aws.amazon.com/marketplace/latest/buyerguide/buyer-private-offers.html).
    ///
    /// To obtain identifiers for these entities, use the following methods:
    ///
    /// * Solution: Use the `ListSolutions` operation.
    /// * AWS Products: For the latest list of Amazon Web Services products, see
    ///   [Amazon Web Services
    ///   products](https://github.com/aws-samples/partner-crm-integration-samples/blob/main/resources/aws_products.json).
    /// * Amazon Web Services Marketplace private offer: Use the [Using the Amazon
    ///   Web Services Marketplace Catalog
    ///   API](https://docs.aws.amazon.com/marketplace/latest/APIReference/catalog-apis.html) to list entities. Specifically, use the `ListEntities` operation to retrieve a list of private offers. The request returns the details of available private offers. For more information, see [ListEntities](https://docs.aws.amazon.com/marketplace-catalog/latest/api-reference/API_ListEntities.html).
    pub fn associateOpportunity(self: *Self, allocator: std.mem.Allocator, input: associate_opportunity.AssociateOpportunityInput, options: CallOptions) !associate_opportunity.AssociateOpportunityOutput {
        return associate_opportunity.execute(self, allocator, input, options);
    }

    /// The `CreateEngagement` action allows you to create an `Engagement`, which
    /// serves as a collaborative space between different parties such as AWS
    /// Partners and AWS Sellers. This action automatically adds the caller's AWS
    /// account as an active member of the newly created `Engagement`.
    pub fn createEngagement(self: *Self, allocator: std.mem.Allocator, input: create_engagement.CreateEngagementInput, options: CallOptions) !create_engagement.CreateEngagementOutput {
        return create_engagement.execute(self, allocator, input, options);
    }

    /// Creates a new context within an existing engagement. This action allows you
    /// to add contextual information such as customer projects or documents to an
    /// engagement, providing additional details that help facilitate collaboration
    /// between engagement members.
    pub fn createEngagementContext(self: *Self, allocator: std.mem.Allocator, input: create_engagement_context.CreateEngagementContextInput, options: CallOptions) !create_engagement_context.CreateEngagementContextOutput {
        return create_engagement_context.execute(self, allocator, input, options);
    }

    /// This action creates an invitation from a sender to a single receiver to join
    /// an engagement.
    pub fn createEngagementInvitation(self: *Self, allocator: std.mem.Allocator, input: create_engagement_invitation.CreateEngagementInvitationInput, options: CallOptions) !create_engagement_invitation.CreateEngagementInvitationOutput {
        return create_engagement_invitation.execute(self, allocator, input, options);
    }

    /// Creates an `Opportunity` record in Partner Central. Use this operation to
    /// create a potential business opportunity for submission to Amazon Web
    /// Services. Creating an opportunity sets `Lifecycle.ReviewStatus` to `Pending
    /// Submission`.
    ///
    /// To submit an opportunity, follow these steps:
    ///
    /// * To create the opportunity, use `CreateOpportunity`.
    /// * To associate a solution with the opportunity, use `AssociateOpportunity`.
    /// * To start the engagement with AWS, use `StartEngagementFromOpportunity`.
    ///
    /// After submission, you can't edit the opportunity until the review is
    /// complete. But opportunities in the `Pending Submission` state must have
    /// complete details. You can update the opportunity while it's in the `Pending
    /// Submission` state.
    ///
    /// There's a set of mandatory fields to create opportunities, but consider
    /// providing optional fields to enrich the opportunity record.
    pub fn createOpportunity(self: *Self, allocator: std.mem.Allocator, input: create_opportunity.CreateOpportunityInput, options: CallOptions) !create_opportunity.CreateOpportunityOutput {
        return create_opportunity.execute(self, allocator, input, options);
    }

    /// This action allows you to create an immutable snapshot of a specific
    /// resource, such as an opportunity, within the context of an engagement. The
    /// snapshot captures a subset of the resource's data based on the schema
    /// defined by the provided template.
    pub fn createResourceSnapshot(self: *Self, allocator: std.mem.Allocator, input: create_resource_snapshot.CreateResourceSnapshotInput, options: CallOptions) !create_resource_snapshot.CreateResourceSnapshotOutput {
        return create_resource_snapshot.execute(self, allocator, input, options);
    }

    /// Use this action to create a job to generate a snapshot of the specified
    /// resource within an engagement. It initiates an asynchronous process to
    /// create a resource snapshot. The job creates a new snapshot only if the
    /// resource state has changed, adhering to the same access control and
    /// immutability rules as direct snapshot creation.
    pub fn createResourceSnapshotJob(self: *Self, allocator: std.mem.Allocator, input: create_resource_snapshot_job.CreateResourceSnapshotJobInput, options: CallOptions) !create_resource_snapshot_job.CreateResourceSnapshotJobOutput {
        return create_resource_snapshot_job.execute(self, allocator, input, options);
    }

    /// Use this action to deletes a previously created resource snapshot job. The
    /// job must be in a stopped state before it can be deleted.
    pub fn deleteResourceSnapshotJob(self: *Self, allocator: std.mem.Allocator, input: delete_resource_snapshot_job.DeleteResourceSnapshotJobInput, options: CallOptions) !delete_resource_snapshot_job.DeleteResourceSnapshotJobOutput {
        return delete_resource_snapshot_job.execute(self, allocator, input, options);
    }

    /// Allows you to remove an existing association between an `Opportunity` and
    /// related entities, such as a Partner Solution, Amazon Web Services product,
    /// or an Amazon Web Services Marketplace offer. This operation is the
    /// counterpart to `AssociateOpportunity`, and it provides flexibility to manage
    /// associations as business needs change.
    ///
    /// Use this operation to update the associations of an `Opportunity` due to
    /// changes in the related entities, or if an association was made in error.
    /// Ensuring accurate associations helps maintain clarity and accuracy to track
    /// and manage business opportunities. When you replace an entity, first attach
    /// the new entity and then disassociate the one to be removed, especially if
    /// it's the last remaining entity that's required.
    pub fn disassociateOpportunity(self: *Self, allocator: std.mem.Allocator, input: disassociate_opportunity.DisassociateOpportunityInput, options: CallOptions) !disassociate_opportunity.DisassociateOpportunityOutput {
        return disassociate_opportunity.execute(self, allocator, input, options);
    }

    /// Retrieves a summary of an AWS Opportunity. This summary includes high-level
    /// details about the opportunity sourced from AWS, such as lifecycle
    /// information, customer details, and involvement type. It is useful for
    /// tracking updates on the AWS opportunity corresponding to an opportunity in
    /// the partner's account.
    pub fn getAwsOpportunitySummary(self: *Self, allocator: std.mem.Allocator, input: get_aws_opportunity_summary.GetAwsOpportunitySummaryInput, options: CallOptions) !get_aws_opportunity_summary.GetAwsOpportunitySummaryOutput {
        return get_aws_opportunity_summary.execute(self, allocator, input, options);
    }

    /// Use this action to retrieve the engagement record for a given
    /// `EngagementIdentifier`.
    pub fn getEngagement(self: *Self, allocator: std.mem.Allocator, input: get_engagement.GetEngagementInput, options: CallOptions) !get_engagement.GetEngagementOutput {
        return get_engagement.execute(self, allocator, input, options);
    }

    /// Retrieves the details of an engagement invitation shared by AWS with a
    /// partner. The information includes aspects such as customer, project details,
    /// and lifecycle information. To connect an engagement invitation with an
    /// opportunity, match the invitation’s `Payload.Project.Title` with opportunity
    /// `Project.Title`.
    pub fn getEngagementInvitation(self: *Self, allocator: std.mem.Allocator, input: get_engagement_invitation.GetEngagementInvitationInput, options: CallOptions) !get_engagement_invitation.GetEngagementInvitationOutput {
        return get_engagement_invitation.execute(self, allocator, input, options);
    }

    /// Fetches the `Opportunity` record from Partner Central by a given
    /// `Identifier`.
    ///
    /// Use the `ListOpportunities` action or the event notification (from Amazon
    /// EventBridge) to obtain this identifier.
    pub fn getOpportunity(self: *Self, allocator: std.mem.Allocator, input: get_opportunity.GetOpportunityInput, options: CallOptions) !get_opportunity.GetOpportunityOutput {
        return get_opportunity.execute(self, allocator, input, options);
    }

    /// Use this action to retrieve a specific snapshot record.
    pub fn getResourceSnapshot(self: *Self, allocator: std.mem.Allocator, input: get_resource_snapshot.GetResourceSnapshotInput, options: CallOptions) !get_resource_snapshot.GetResourceSnapshotOutput {
        return get_resource_snapshot.execute(self, allocator, input, options);
    }

    /// Use this action to retrieves information about a specific resource snapshot
    /// job.
    pub fn getResourceSnapshotJob(self: *Self, allocator: std.mem.Allocator, input: get_resource_snapshot_job.GetResourceSnapshotJobInput, options: CallOptions) !get_resource_snapshot_job.GetResourceSnapshotJobOutput {
        return get_resource_snapshot_job.execute(self, allocator, input, options);
    }

    /// Retrieves the currently set system settings, which include the IAM Role used
    /// for resource snapshot jobs.
    pub fn getSellingSystemSettings(self: *Self, allocator: std.mem.Allocator, input: get_selling_system_settings.GetSellingSystemSettingsInput, options: CallOptions) !get_selling_system_settings.GetSellingSystemSettingsOutput {
        return get_selling_system_settings.execute(self, allocator, input, options);
    }

    /// Lists all in-progress, completed, or failed
    /// StartEngagementByAcceptingInvitationTask tasks that were initiated by the
    /// caller's account.
    pub fn listEngagementByAcceptingInvitationTasks(self: *Self, allocator: std.mem.Allocator, input: list_engagement_by_accepting_invitation_tasks.ListEngagementByAcceptingInvitationTasksInput, options: CallOptions) !list_engagement_by_accepting_invitation_tasks.ListEngagementByAcceptingInvitationTasksOutput {
        return list_engagement_by_accepting_invitation_tasks.execute(self, allocator, input, options);
    }

    /// Lists all in-progress, completed, or failed `EngagementFromOpportunity`
    /// tasks that were initiated by the caller's account.
    pub fn listEngagementFromOpportunityTasks(self: *Self, allocator: std.mem.Allocator, input: list_engagement_from_opportunity_tasks.ListEngagementFromOpportunityTasksInput, options: CallOptions) !list_engagement_from_opportunity_tasks.ListEngagementFromOpportunityTasksOutput {
        return list_engagement_from_opportunity_tasks.execute(self, allocator, input, options);
    }

    /// Retrieves a list of engagement invitations sent to the partner. This allows
    /// partners to view all pending or past engagement invitations, helping them
    /// track opportunities shared by AWS.
    pub fn listEngagementInvitations(self: *Self, allocator: std.mem.Allocator, input: list_engagement_invitations.ListEngagementInvitationsInput, options: CallOptions) !list_engagement_invitations.ListEngagementInvitationsOutput {
        return list_engagement_invitations.execute(self, allocator, input, options);
    }

    /// Retrieves the details of member partners in an Engagement. This operation
    /// can only be invoked by members of the Engagement. The
    /// `ListEngagementMembers` operation allows you to fetch information about the
    /// members of a specific Engagement. This action is restricted to members of
    /// the Engagement being queried.
    pub fn listEngagementMembers(self: *Self, allocator: std.mem.Allocator, input: list_engagement_members.ListEngagementMembersInput, options: CallOptions) !list_engagement_members.ListEngagementMembersOutput {
        return list_engagement_members.execute(self, allocator, input, options);
    }

    /// Lists the associations between resources and engagements where the caller is
    /// a member and has at least one snapshot in the engagement.
    pub fn listEngagementResourceAssociations(self: *Self, allocator: std.mem.Allocator, input: list_engagement_resource_associations.ListEngagementResourceAssociationsInput, options: CallOptions) !list_engagement_resource_associations.ListEngagementResourceAssociationsOutput {
        return list_engagement_resource_associations.execute(self, allocator, input, options);
    }

    /// This action allows users to retrieve a list of Engagement records from
    /// Partner Central. This action can be used to manage and track various
    /// engagements across different stages of the partner selling process.
    pub fn listEngagements(self: *Self, allocator: std.mem.Allocator, input: list_engagements.ListEngagementsInput, options: CallOptions) !list_engagements.ListEngagementsOutput {
        return list_engagements.execute(self, allocator, input, options);
    }

    /// This request accepts a list of filters that retrieve opportunity subsets as
    /// well as sort options. This feature is available to partners from [Partner
    /// Central](https://partnercentral.awspartner.com/) using the
    /// `ListOpportunities` API action.
    ///
    /// To synchronize your system with Amazon Web Services, list only the
    /// opportunities that were newly created or updated. We recommend you rely on
    /// events emitted by the service into your Amazon Web Services account’s Amazon
    /// EventBridge default event bus. You can also use the `ListOpportunities`
    /// action.
    ///
    /// We recommend the following approach:
    ///
    /// * Find the latest `LastModifiedDate` that you stored, and only use the
    ///   values that came from Amazon Web Services. Don’t use values generated by
    ///   your system.
    /// * When you send a `ListOpportunities` request, submit the date in ISO 8601
    ///   format in the `AfterLastModifiedDate` filter.
    /// * Amazon Web Services only returns opportunities created or updated on or
    ///   after that date and time. Use `NextToken` to iterate over all pages.
    pub fn listOpportunities(self: *Self, allocator: std.mem.Allocator, input: list_opportunities.ListOpportunitiesInput, options: CallOptions) !list_opportunities.ListOpportunitiesOutput {
        return list_opportunities.execute(self, allocator, input, options);
    }

    /// Lists all in-progress, completed, or failed opportunity creation tasks from
    /// engagements that were initiated by the caller's account.
    pub fn listOpportunityFromEngagementTasks(self: *Self, allocator: std.mem.Allocator, input: list_opportunity_from_engagement_tasks.ListOpportunityFromEngagementTasksInput, options: CallOptions) !list_opportunity_from_engagement_tasks.ListOpportunityFromEngagementTasksOutput {
        return list_opportunity_from_engagement_tasks.execute(self, allocator, input, options);
    }

    /// Lists resource snapshot jobs owned by the customer. This operation supports
    /// various filtering scenarios, including listing all jobs owned by the caller,
    /// jobs for a specific engagement, jobs with a specific status, or any
    /// combination of these filters.
    pub fn listResourceSnapshotJobs(self: *Self, allocator: std.mem.Allocator, input: list_resource_snapshot_jobs.ListResourceSnapshotJobsInput, options: CallOptions) !list_resource_snapshot_jobs.ListResourceSnapshotJobsOutput {
        return list_resource_snapshot_jobs.execute(self, allocator, input, options);
    }

    /// Retrieves a list of resource view snapshots based on specified criteria.
    /// This operation supports various use cases, including:
    ///
    /// * Fetching all snapshots associated with an engagement.
    /// * Retrieving snapshots of a specific resource type within an engagement.
    /// * Obtaining snapshots for a particular resource using a specified template.
    /// * Accessing the latest snapshot of a resource within an engagement.
    /// * Filtering snapshots by resource owner.
    pub fn listResourceSnapshots(self: *Self, allocator: std.mem.Allocator, input: list_resource_snapshots.ListResourceSnapshotsInput, options: CallOptions) !list_resource_snapshots.ListResourceSnapshotsOutput {
        return list_resource_snapshots.execute(self, allocator, input, options);
    }

    /// Retrieves a list of Partner Solutions that the partner registered on Partner
    /// Central. This API is used to generate a list of solutions that an end user
    /// selects from for association with an opportunity.
    pub fn listSolutions(self: *Self, allocator: std.mem.Allocator, input: list_solutions.ListSolutionsInput, options: CallOptions) !list_solutions.ListSolutionsOutput {
        return list_solutions.execute(self, allocator, input, options);
    }

    /// Returns a list of tags for a resource.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: CallOptions) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Updates the currently set system settings, which include the IAM Role used
    /// for resource snapshot jobs.
    pub fn putSellingSystemSettings(self: *Self, allocator: std.mem.Allocator, input: put_selling_system_settings.PutSellingSystemSettingsInput, options: CallOptions) !put_selling_system_settings.PutSellingSystemSettingsOutput {
        return put_selling_system_settings.execute(self, allocator, input, options);
    }

    /// This action rejects an `EngagementInvitation` that AWS shared. Rejecting an
    /// invitation indicates that the partner doesn't want to pursue the
    /// opportunity, and all related data will become inaccessible thereafter.
    pub fn rejectEngagementInvitation(self: *Self, allocator: std.mem.Allocator, input: reject_engagement_invitation.RejectEngagementInvitationInput, options: CallOptions) !reject_engagement_invitation.RejectEngagementInvitationOutput {
        return reject_engagement_invitation.execute(self, allocator, input, options);
    }

    /// This action starts the engagement by accepting an `EngagementInvitation`.
    /// The task is asynchronous and involves the following steps: accepting the
    /// invitation, creating an opportunity in the partner’s account from the AWS
    /// opportunity, and copying details for tracking. When completed, an
    /// `Opportunity Created` event is generated, indicating that the opportunity
    /// has been successfully created in the partner's account.
    pub fn startEngagementByAcceptingInvitationTask(self: *Self, allocator: std.mem.Allocator, input: start_engagement_by_accepting_invitation_task.StartEngagementByAcceptingInvitationTaskInput, options: CallOptions) !start_engagement_by_accepting_invitation_task.StartEngagementByAcceptingInvitationTaskOutput {
        return start_engagement_by_accepting_invitation_task.execute(self, allocator, input, options);
    }

    /// Similar to `StartEngagementByAcceptingInvitationTask`, this action is
    /// asynchronous and performs multiple steps before completion. This action
    /// orchestrates a comprehensive workflow that combines multiple API operations
    /// into a single task to create and initiate an engagement from an existing
    /// opportunity. It automatically executes a sequence of operations including
    /// `GetOpportunity`, `CreateEngagement` (if it doesn't exist),
    /// `CreateResourceSnapshot`, `CreateResourceSnapshotJob`,
    /// `CreateEngagementInvitation` (if not already invited/accepted), and
    /// `SubmitOpportunity`.
    pub fn startEngagementFromOpportunityTask(self: *Self, allocator: std.mem.Allocator, input: start_engagement_from_opportunity_task.StartEngagementFromOpportunityTaskInput, options: CallOptions) !start_engagement_from_opportunity_task.StartEngagementFromOpportunityTaskOutput {
        return start_engagement_from_opportunity_task.execute(self, allocator, input, options);
    }

    /// This action creates an opportunity from an existing engagement context. The
    /// task is asynchronous and orchestrates the process of converting engagement
    /// contextual information into a structured opportunity record within the
    /// partner's account.
    pub fn startOpportunityFromEngagementTask(self: *Self, allocator: std.mem.Allocator, input: start_opportunity_from_engagement_task.StartOpportunityFromEngagementTaskInput, options: CallOptions) !start_opportunity_from_engagement_task.StartOpportunityFromEngagementTaskOutput {
        return start_opportunity_from_engagement_task.execute(self, allocator, input, options);
    }

    /// Starts a resource snapshot job that has been previously created.
    pub fn startResourceSnapshotJob(self: *Self, allocator: std.mem.Allocator, input: start_resource_snapshot_job.StartResourceSnapshotJobInput, options: CallOptions) !start_resource_snapshot_job.StartResourceSnapshotJobOutput {
        return start_resource_snapshot_job.execute(self, allocator, input, options);
    }

    /// Stops a resource snapshot job. The job must be started prior to being
    /// stopped.
    pub fn stopResourceSnapshotJob(self: *Self, allocator: std.mem.Allocator, input: stop_resource_snapshot_job.StopResourceSnapshotJobInput, options: CallOptions) !stop_resource_snapshot_job.StopResourceSnapshotJobOutput {
        return stop_resource_snapshot_job.execute(self, allocator, input, options);
    }

    /// Use this action to submit an Opportunity that was previously created by
    /// partner for AWS review. After you perform this action, the Opportunity
    /// becomes non-editable until it is reviewed by AWS and has `
    /// LifeCycle.ReviewStatus ` as either `Approved` or `Action Required`.
    pub fn submitOpportunity(self: *Self, allocator: std.mem.Allocator, input: submit_opportunity.SubmitOpportunityInput, options: CallOptions) !submit_opportunity.SubmitOpportunityOutput {
        return submit_opportunity.execute(self, allocator, input, options);
    }

    /// Assigns one or more tags (key-value pairs) to the specified resource.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: CallOptions) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Removes a tag or tags from a resource.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: CallOptions) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Updates the context information for an existing engagement with new or
    /// modified data.
    pub fn updateEngagementContext(self: *Self, allocator: std.mem.Allocator, input: update_engagement_context.UpdateEngagementContextInput, options: CallOptions) !update_engagement_context.UpdateEngagementContextOutput {
        return update_engagement_context.execute(self, allocator, input, options);
    }

    /// Updates the `Opportunity` record identified by a given `Identifier`. This
    /// operation allows you to modify the details of an existing opportunity to
    /// reflect the latest information and progress. Use this action to keep the
    /// opportunity record up-to-date and accurate.
    ///
    /// When you perform updates, include the entire payload with each request. If
    /// any field is omitted, the API assumes that the field is set to `null`. The
    /// best practice is to always perform a `GetOpportunity` to retrieve the latest
    /// values, then send the complete payload with the updated values to be
    /// changed.
    pub fn updateOpportunity(self: *Self, allocator: std.mem.Allocator, input: update_opportunity.UpdateOpportunityInput, options: CallOptions) !update_opportunity.UpdateOpportunityOutput {
        return update_opportunity.execute(self, allocator, input, options);
    }

    pub fn listEngagementByAcceptingInvitationTasksPaginator(self: *Self, params: list_engagement_by_accepting_invitation_tasks.ListEngagementByAcceptingInvitationTasksInput) paginator.ListEngagementByAcceptingInvitationTasksPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listEngagementFromOpportunityTasksPaginator(self: *Self, params: list_engagement_from_opportunity_tasks.ListEngagementFromOpportunityTasksInput) paginator.ListEngagementFromOpportunityTasksPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listEngagementInvitationsPaginator(self: *Self, params: list_engagement_invitations.ListEngagementInvitationsInput) paginator.ListEngagementInvitationsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listEngagementMembersPaginator(self: *Self, params: list_engagement_members.ListEngagementMembersInput) paginator.ListEngagementMembersPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listEngagementResourceAssociationsPaginator(self: *Self, params: list_engagement_resource_associations.ListEngagementResourceAssociationsInput) paginator.ListEngagementResourceAssociationsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listEngagementsPaginator(self: *Self, params: list_engagements.ListEngagementsInput) paginator.ListEngagementsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listOpportunitiesPaginator(self: *Self, params: list_opportunities.ListOpportunitiesInput) paginator.ListOpportunitiesPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listOpportunityFromEngagementTasksPaginator(self: *Self, params: list_opportunity_from_engagement_tasks.ListOpportunityFromEngagementTasksInput) paginator.ListOpportunityFromEngagementTasksPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listResourceSnapshotJobsPaginator(self: *Self, params: list_resource_snapshot_jobs.ListResourceSnapshotJobsInput) paginator.ListResourceSnapshotJobsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listResourceSnapshotsPaginator(self: *Self, params: list_resource_snapshots.ListResourceSnapshotsInput) paginator.ListResourceSnapshotsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listSolutionsPaginator(self: *Self, params: list_solutions.ListSolutionsInput) paginator.ListSolutionsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }
};
