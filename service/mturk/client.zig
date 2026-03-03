const aws = @import("aws");
const std = @import("std");

const accept_qualification_request = @import("accept_qualification_request.zig");
const approve_assignment = @import("approve_assignment.zig");
const associate_qualification_with_worker = @import("associate_qualification_with_worker.zig");
const create_additional_assignments_for_hit = @import("create_additional_assignments_for_hit.zig");
const create_hit = @import("create_hit.zig");
const create_hit_type = @import("create_hit_type.zig");
const create_hit_with_hit_type = @import("create_hit_with_hit_type.zig");
const create_qualification_type = @import("create_qualification_type.zig");
const create_worker_block = @import("create_worker_block.zig");
const delete_hit = @import("delete_hit.zig");
const delete_qualification_type = @import("delete_qualification_type.zig");
const delete_worker_block = @import("delete_worker_block.zig");
const disassociate_qualification_from_worker = @import("disassociate_qualification_from_worker.zig");
const get_account_balance = @import("get_account_balance.zig");
const get_assignment = @import("get_assignment.zig");
const get_file_upload_url = @import("get_file_upload_url.zig");
const get_hit = @import("get_hit.zig");
const get_qualification_score = @import("get_qualification_score.zig");
const get_qualification_type = @import("get_qualification_type.zig");
const list_assignments_for_hit = @import("list_assignments_for_hit.zig");
const list_bonus_payments = @import("list_bonus_payments.zig");
const list_hi_ts = @import("list_hi_ts.zig");
const list_hi_ts_for_qualification_type = @import("list_hi_ts_for_qualification_type.zig");
const list_qualification_requests = @import("list_qualification_requests.zig");
const list_qualification_types = @import("list_qualification_types.zig");
const list_review_policy_results_for_hit = @import("list_review_policy_results_for_hit.zig");
const list_reviewable_hi_ts = @import("list_reviewable_hi_ts.zig");
const list_worker_blocks = @import("list_worker_blocks.zig");
const list_workers_with_qualification_type = @import("list_workers_with_qualification_type.zig");
const notify_workers = @import("notify_workers.zig");
const reject_assignment = @import("reject_assignment.zig");
const reject_qualification_request = @import("reject_qualification_request.zig");
const send_bonus = @import("send_bonus.zig");
const send_test_event_notification = @import("send_test_event_notification.zig");
const update_expiration_for_hit = @import("update_expiration_for_hit.zig");
const update_hit_review_status = @import("update_hit_review_status.zig");
const update_hit_type_of_hit = @import("update_hit_type_of_hit.zig");
const update_notification_settings = @import("update_notification_settings.zig");
const update_qualification_type = @import("update_qualification_type.zig");
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "MTurk";

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

    /// The `AcceptQualificationRequest` operation approves a Worker's request for a
    /// Qualification.
    ///
    /// Only the owner of the Qualification type can grant a Qualification request
    /// for that type.
    ///
    /// A successful request for the `AcceptQualificationRequest` operation
    /// returns with no errors and an empty body.
    pub fn acceptQualificationRequest(self: *Self, allocator: std.mem.Allocator, input: accept_qualification_request.AcceptQualificationRequestInput, options: accept_qualification_request.Options) !accept_qualification_request.AcceptQualificationRequestOutput {
        return accept_qualification_request.execute(self, allocator, input, options);
    }

    /// The `ApproveAssignment` operation approves the results of a completed
    /// assignment.
    ///
    /// Approving an assignment initiates two payments from the Requester's
    /// Amazon.com account
    ///
    /// * The Worker who submitted the results is paid the reward specified in the
    ///   HIT.
    ///
    /// * Amazon Mechanical Turk fees are debited.
    ///
    /// If the Requester's account does not have adequate funds for these payments,
    /// the call to ApproveAssignment returns an exception, and the approval is not
    /// processed.
    /// You can include an optional feedback message with the approval,
    /// which the Worker can see in the Status section of the web site.
    ///
    /// You can also call this operation for assignments that were previous rejected
    /// and approve them by explicitly overriding the previous rejection.
    /// This only works on rejected assignments that were submitted within the
    /// previous 30 days
    /// and only if the assignment's related HIT has not been deleted.
    pub fn approveAssignment(self: *Self, allocator: std.mem.Allocator, input: approve_assignment.ApproveAssignmentInput, options: approve_assignment.Options) !approve_assignment.ApproveAssignmentOutput {
        return approve_assignment.execute(self, allocator, input, options);
    }

    /// The `AssociateQualificationWithWorker` operation gives a Worker a
    /// Qualification. `AssociateQualificationWithWorker` does not require that the
    /// Worker
    /// submit a Qualification request. It gives the Qualification directly to the
    /// Worker.
    ///
    /// You can only assign a Qualification of a Qualification type that you created
    /// (using
    /// the `CreateQualificationType` operation).
    ///
    /// Note: `AssociateQualificationWithWorker` does not affect any pending
    /// Qualification
    /// requests for the Qualification by the Worker. If you assign a Qualification
    /// to a
    /// Worker, then later grant a Qualification request made by the Worker, the
    /// granting of
    /// the request may modify the Qualification score. To resolve a pending
    /// Qualification
    /// request without affecting the Qualification the Worker already has, reject
    /// the
    /// request with the `RejectQualificationRequest` operation.
    pub fn associateQualificationWithWorker(self: *Self, allocator: std.mem.Allocator, input: associate_qualification_with_worker.AssociateQualificationWithWorkerInput, options: associate_qualification_with_worker.Options) !associate_qualification_with_worker.AssociateQualificationWithWorkerOutput {
        return associate_qualification_with_worker.execute(self, allocator, input, options);
    }

    /// The
    /// `CreateAdditionalAssignmentsForHIT`
    /// operation increases the maximum number of assignments of an existing HIT.
    ///
    /// To extend the maximum number of assignments, specify the number of
    /// additional assignments.
    ///
    /// * HITs created with fewer than 10 assignments cannot be extended to have 10
    ///   or more assignments. Attempting to add assignments in a way that brings
    ///   the total number of assignments for a HIT from fewer than 10 assignments
    ///   to 10 or more
    /// assignments will result in an
    /// `AWS.MechanicalTurk.InvalidMaximumAssignmentsIncrease`
    /// exception.
    ///
    /// * HITs that were created before July 22, 2015 cannot be extended. Attempting
    ///   to extend HITs that were created before July 22, 2015 will result in an
    /// `AWS.MechanicalTurk.HITTooOldForExtension`
    /// exception.
    pub fn createAdditionalAssignmentsForHit(self: *Self, allocator: std.mem.Allocator, input: create_additional_assignments_for_hit.CreateAdditionalAssignmentsForHITInput, options: create_additional_assignments_for_hit.Options) !create_additional_assignments_for_hit.CreateAdditionalAssignmentsForHITOutput {
        return create_additional_assignments_for_hit.execute(self, allocator, input, options);
    }

    /// The `CreateHIT` operation creates a new Human Intelligence Task (HIT).
    /// The new HIT is made available for Workers to find and accept on the Amazon
    /// Mechanical
    /// Turk website.
    ///
    /// This operation allows you to specify a new HIT by passing in values for the
    /// properties of the HIT, such as its title, reward amount and number of
    /// assignments. When you pass these values to `CreateHIT`, a new HIT is created
    /// for you, with a new `HITTypeID`. The HITTypeID can be used to create
    /// additional HITs in the future without needing to specify common parameters
    /// such as the title, description and reward amount each time.
    ///
    /// An alternative way to create HITs is to first generate a HITTypeID using the
    /// `CreateHITType` operation and then call the `CreateHITWithHITType`
    /// operation. This is the recommended best practice for Requesters who are
    /// creating large numbers of HITs.
    ///
    /// CreateHIT also supports several ways to provide question data: by providing
    /// a value
    /// for the `Question` parameter that fully specifies the contents of the HIT,
    /// or by providing
    /// a `HitLayoutId` and associated `HitLayoutParameters`.
    ///
    /// If a HIT is created with 10 or more maximum assignments, there is an
    /// additional fee. For more information, see
    /// [Amazon Mechanical Turk Pricing](https://requester.mturk.com/pricing).
    pub fn createHit(self: *Self, allocator: std.mem.Allocator, input: create_hit.CreateHITInput, options: create_hit.Options) !create_hit.CreateHITOutput {
        return create_hit.execute(self, allocator, input, options);
    }

    /// The `CreateHITType` operation creates a new HIT type. This operation
    /// allows you to define a standard set of HIT properties to use when creating
    /// HITs.
    /// If you register a HIT type with values that match an existing HIT type, the
    /// HIT type
    /// ID of the existing type will be returned.
    pub fn createHitType(self: *Self, allocator: std.mem.Allocator, input: create_hit_type.CreateHITTypeInput, options: create_hit_type.Options) !create_hit_type.CreateHITTypeOutput {
        return create_hit_type.execute(self, allocator, input, options);
    }

    /// The `CreateHITWithHITType` operation creates a new Human Intelligence Task
    /// (HIT)
    /// using an existing HITTypeID generated by the `CreateHITType` operation.
    ///
    /// This is an alternative way to create HITs from the `CreateHIT` operation.
    /// This is the recommended best practice for Requesters who are creating large
    /// numbers of HITs.
    ///
    /// CreateHITWithHITType also supports several ways to provide question data:
    /// by providing a value for the `Question` parameter that fully specifies the
    /// contents of the HIT,
    /// or by providing a `HitLayoutId` and associated `HitLayoutParameters`.
    ///
    /// If a HIT is created with 10 or more maximum assignments, there is an
    /// additional fee.
    /// For more information, see [Amazon Mechanical Turk
    /// Pricing](https://requester.mturk.com/pricing).
    pub fn createHitWithHitType(self: *Self, allocator: std.mem.Allocator, input: create_hit_with_hit_type.CreateHITWithHITTypeInput, options: create_hit_with_hit_type.Options) !create_hit_with_hit_type.CreateHITWithHITTypeOutput {
        return create_hit_with_hit_type.execute(self, allocator, input, options);
    }

    /// The
    /// `CreateQualificationType`
    /// operation creates a new Qualification type, which is represented by a
    /// `QualificationType`
    /// data structure.
    pub fn createQualificationType(self: *Self, allocator: std.mem.Allocator, input: create_qualification_type.CreateQualificationTypeInput, options: create_qualification_type.Options) !create_qualification_type.CreateQualificationTypeOutput {
        return create_qualification_type.execute(self, allocator, input, options);
    }

    /// The `CreateWorkerBlock` operation allows you to prevent a Worker from
    /// working on your HITs. For example, you can block a Worker who is producing
    /// poor quality work. You can block up to 100,000 Workers.
    pub fn createWorkerBlock(self: *Self, allocator: std.mem.Allocator, input: create_worker_block.CreateWorkerBlockInput, options: create_worker_block.Options) !create_worker_block.CreateWorkerBlockOutput {
        return create_worker_block.execute(self, allocator, input, options);
    }

    /// The `DeleteHIT` operation is used to delete HIT that is no longer needed.
    /// Only the Requester who created the HIT can delete it.
    ///
    /// You can only dispose of HITs that are in the `Reviewable` state,
    /// with all of their submitted assignments already either approved or rejected.
    /// If you call the DeleteHIT operation on a HIT that is not in the `Reviewable`
    /// state
    /// (for example, that has not expired, or still has active assignments),
    /// or on a HIT that is Reviewable but without all of its submitted assignments
    /// already approved or rejected, the service will return an error.
    ///
    /// * HITs are automatically disposed of after 120 days.
    ///
    /// * After you dispose of a HIT, you can no longer approve the HIT's rejected
    ///   assignments.
    ///
    /// * Disposed HITs are not returned in results for the ListHITs operation.
    ///
    /// * Disposing HITs can improve the performance of operations such as
    ///   ListReviewableHITs and ListHITs.
    pub fn deleteHit(self: *Self, allocator: std.mem.Allocator, input: delete_hit.DeleteHITInput, options: delete_hit.Options) !delete_hit.DeleteHITOutput {
        return delete_hit.execute(self, allocator, input, options);
    }

    /// The
    /// `DeleteQualificationType`
    /// deletes a Qualification type and deletes any HIT types that are
    /// associated with the Qualification type.
    ///
    /// This operation does not revoke Qualifications already assigned
    /// to Workers because the Qualifications might be needed for active HITs.
    /// If there are any pending requests for the Qualification type, Amazon
    /// Mechanical Turk rejects those requests. After you delete a
    /// Qualification type, you can no longer use it to create HITs or HIT
    /// types.
    ///
    /// DeleteQualificationType must wait for all the HITs that use
    /// the deleted Qualification type to be deleted before completing. It
    /// may take up to 48 hours before DeleteQualificationType completes and
    /// the unique name of the Qualification type is available for reuse with
    /// CreateQualificationType.
    pub fn deleteQualificationType(self: *Self, allocator: std.mem.Allocator, input: delete_qualification_type.DeleteQualificationTypeInput, options: delete_qualification_type.Options) !delete_qualification_type.DeleteQualificationTypeOutput {
        return delete_qualification_type.execute(self, allocator, input, options);
    }

    /// The `DeleteWorkerBlock` operation allows you to reinstate a blocked Worker
    /// to work on your HITs. This operation reverses the effects of the
    /// CreateWorkerBlock operation. You need the Worker ID to use this operation.
    /// If the Worker ID is missing or invalid, this operation fails and returns the
    /// message “WorkerId is invalid.” If the specified Worker is not blocked, this
    /// operation returns successfully.
    pub fn deleteWorkerBlock(self: *Self, allocator: std.mem.Allocator, input: delete_worker_block.DeleteWorkerBlockInput, options: delete_worker_block.Options) !delete_worker_block.DeleteWorkerBlockOutput {
        return delete_worker_block.execute(self, allocator, input, options);
    }

    /// The `DisassociateQualificationFromWorker`
    /// revokes a previously granted Qualification from a user.
    ///
    /// You can provide a text message explaining why the Qualification was
    /// revoked. The user who had the Qualification can see this message.
    pub fn disassociateQualificationFromWorker(self: *Self, allocator: std.mem.Allocator, input: disassociate_qualification_from_worker.DisassociateQualificationFromWorkerInput, options: disassociate_qualification_from_worker.Options) !disassociate_qualification_from_worker.DisassociateQualificationFromWorkerOutput {
        return disassociate_qualification_from_worker.execute(self, allocator, input, options);
    }

    /// The `GetAccountBalance` operation retrieves the Prepaid HITs balance in your
    /// Amazon Mechanical Turk account if you are a Prepaid Requester.
    /// Alternatively, this operation will retrieve the remaining available AWS
    /// Billing usage if you have enabled AWS Billing.
    /// Note: If you have enabled AWS Billing and still have a remaining Prepaid
    /// HITs balance, this balance can be viewed on the My Account page in the
    /// Requester console.
    pub fn getAccountBalance(self: *Self, allocator: std.mem.Allocator, input: get_account_balance.GetAccountBalanceInput, options: get_account_balance.Options) !get_account_balance.GetAccountBalanceOutput {
        return get_account_balance.execute(self, allocator, input, options);
    }

    /// The `GetAssignment` operation retrieves the details of the specified
    /// Assignment.
    pub fn getAssignment(self: *Self, allocator: std.mem.Allocator, input: get_assignment.GetAssignmentInput, options: get_assignment.Options) !get_assignment.GetAssignmentOutput {
        return get_assignment.execute(self, allocator, input, options);
    }

    /// The
    /// `GetFileUploadURL`
    /// operation generates and returns a temporary URL. You use the
    /// temporary URL to retrieve a file uploaded by a Worker as an answer to
    /// a FileUploadAnswer question for a HIT. The temporary URL is generated
    /// the instant the GetFileUploadURL operation is called, and is valid
    /// for 60 seconds. You can get a temporary file upload URL any time
    /// until the HIT is disposed. After the HIT is disposed, any uploaded
    /// files are deleted, and cannot be retrieved.
    ///
    /// Pending Deprecation on December 12, 2017. The Answer Specification
    /// structure will no longer support the `FileUploadAnswer`
    /// element to be used for the QuestionForm data structure.
    /// Instead, we recommend that Requesters who want to create HITs asking
    /// Workers to upload files to use Amazon S3.
    pub fn getFileUploadUrl(self: *Self, allocator: std.mem.Allocator, input: get_file_upload_url.GetFileUploadURLInput, options: get_file_upload_url.Options) !get_file_upload_url.GetFileUploadURLOutput {
        return get_file_upload_url.execute(self, allocator, input, options);
    }

    /// The `GetHIT` operation retrieves the details of the specified HIT.
    pub fn getHit(self: *Self, allocator: std.mem.Allocator, input: get_hit.GetHITInput, options: get_hit.Options) !get_hit.GetHITOutput {
        return get_hit.execute(self, allocator, input, options);
    }

    /// The
    /// `GetQualificationScore`
    /// operation returns the value of a Worker's Qualification for a given
    /// Qualification type.
    ///
    /// To get a Worker's Qualification, you must know the Worker's ID. The
    /// Worker's ID is included in the assignment data returned by the
    /// `ListAssignmentsForHIT`
    /// operation.
    ///
    /// Only the owner of a Qualification type can query the value of
    /// a Worker's Qualification of that type.
    pub fn getQualificationScore(self: *Self, allocator: std.mem.Allocator, input: get_qualification_score.GetQualificationScoreInput, options: get_qualification_score.Options) !get_qualification_score.GetQualificationScoreOutput {
        return get_qualification_score.execute(self, allocator, input, options);
    }

    /// The `GetQualificationType`operation retrieves information about a
    /// Qualification type using its ID.
    pub fn getQualificationType(self: *Self, allocator: std.mem.Allocator, input: get_qualification_type.GetQualificationTypeInput, options: get_qualification_type.Options) !get_qualification_type.GetQualificationTypeOutput {
        return get_qualification_type.execute(self, allocator, input, options);
    }

    /// The
    /// `ListAssignmentsForHIT`
    /// operation retrieves completed assignments for a HIT. You can use this
    /// operation to retrieve the results for a HIT.
    ///
    /// You can get assignments for a HIT at any time, even if the
    /// HIT is not yet Reviewable. If a HIT requested multiple assignments,
    /// and has received some results but has not yet become Reviewable, you
    /// can still retrieve the partial results with this operation.
    ///
    /// Use the AssignmentStatus parameter to control which set of
    /// assignments for a HIT are returned. The ListAssignmentsForHIT
    /// operation
    /// can return submitted assignments awaiting approval, or it can return
    /// assignments that have already been approved or rejected. You can set
    /// AssignmentStatus=Approved,Rejected to get assignments that have
    /// already been approved and rejected together in one result set.
    ///
    /// Only the Requester who created the HIT can retrieve the
    /// assignments for that HIT.
    ///
    /// Results are sorted and divided into numbered pages and the
    /// operation returns a single page of results. You can use the
    /// parameters
    /// of the operation to control sorting and pagination.
    pub fn listAssignmentsForHit(self: *Self, allocator: std.mem.Allocator, input: list_assignments_for_hit.ListAssignmentsForHITInput, options: list_assignments_for_hit.Options) !list_assignments_for_hit.ListAssignmentsForHITOutput {
        return list_assignments_for_hit.execute(self, allocator, input, options);
    }

    /// The
    /// `ListBonusPayments`
    /// operation retrieves the amounts of bonuses you have paid to Workers
    /// for a given HIT or assignment.
    pub fn listBonusPayments(self: *Self, allocator: std.mem.Allocator, input: list_bonus_payments.ListBonusPaymentsInput, options: list_bonus_payments.Options) !list_bonus_payments.ListBonusPaymentsOutput {
        return list_bonus_payments.execute(self, allocator, input, options);
    }

    /// The
    /// `ListHITs`
    /// operation returns all of a Requester's HITs. The operation returns
    /// HITs of any status, except for HITs that have been deleted of with
    /// the DeleteHIT operation or that have been auto-deleted.
    pub fn listHiTs(self: *Self, allocator: std.mem.Allocator, input: list_hi_ts.ListHITsInput, options: list_hi_ts.Options) !list_hi_ts.ListHITsOutput {
        return list_hi_ts.execute(self, allocator, input, options);
    }

    /// The `ListHITsForQualificationType` operation returns the HITs that use
    /// the given Qualification type for a Qualification requirement.
    /// The operation returns HITs of any status, except for HITs that have been
    /// deleted
    /// with the `DeleteHIT` operation or that have been auto-deleted.
    pub fn listHiTsForQualificationType(self: *Self, allocator: std.mem.Allocator, input: list_hi_ts_for_qualification_type.ListHITsForQualificationTypeInput, options: list_hi_ts_for_qualification_type.Options) !list_hi_ts_for_qualification_type.ListHITsForQualificationTypeOutput {
        return list_hi_ts_for_qualification_type.execute(self, allocator, input, options);
    }

    /// The
    /// `ListQualificationRequests`
    /// operation retrieves requests for Qualifications of a particular
    /// Qualification type. The owner of the Qualification type calls this
    /// operation to poll for pending requests, and accepts them using the
    /// AcceptQualification operation.
    pub fn listQualificationRequests(self: *Self, allocator: std.mem.Allocator, input: list_qualification_requests.ListQualificationRequestsInput, options: list_qualification_requests.Options) !list_qualification_requests.ListQualificationRequestsOutput {
        return list_qualification_requests.execute(self, allocator, input, options);
    }

    /// The
    /// `ListQualificationTypes`
    /// operation returns a list of Qualification types, filtered by
    /// an optional search term.
    pub fn listQualificationTypes(self: *Self, allocator: std.mem.Allocator, input: list_qualification_types.ListQualificationTypesInput, options: list_qualification_types.Options) !list_qualification_types.ListQualificationTypesOutput {
        return list_qualification_types.execute(self, allocator, input, options);
    }

    /// The `ListReviewPolicyResultsForHIT` operation retrieves the computed results
    /// and the actions taken in the course of executing your Review Policies for a
    /// given HIT.
    /// For information about how to specify Review Policies when you call
    /// CreateHIT,
    /// see Review Policies. The ListReviewPolicyResultsForHIT operation can return
    /// results for both
    /// Assignment-level and HIT-level review results.
    pub fn listReviewPolicyResultsForHit(self: *Self, allocator: std.mem.Allocator, input: list_review_policy_results_for_hit.ListReviewPolicyResultsForHITInput, options: list_review_policy_results_for_hit.Options) !list_review_policy_results_for_hit.ListReviewPolicyResultsForHITOutput {
        return list_review_policy_results_for_hit.execute(self, allocator, input, options);
    }

    /// The `ListReviewableHITs` operation retrieves the HITs with Status equal to
    /// Reviewable or Status equal to Reviewing that belong to the Requester calling
    /// the operation.
    pub fn listReviewableHiTs(self: *Self, allocator: std.mem.Allocator, input: list_reviewable_hi_ts.ListReviewableHITsInput, options: list_reviewable_hi_ts.Options) !list_reviewable_hi_ts.ListReviewableHITsOutput {
        return list_reviewable_hi_ts.execute(self, allocator, input, options);
    }

    /// The `ListWorkersBlocks` operation retrieves a list of Workers who are
    /// blocked from working on your HITs.
    pub fn listWorkerBlocks(self: *Self, allocator: std.mem.Allocator, input: list_worker_blocks.ListWorkerBlocksInput, options: list_worker_blocks.Options) !list_worker_blocks.ListWorkerBlocksOutput {
        return list_worker_blocks.execute(self, allocator, input, options);
    }

    /// The `ListWorkersWithQualificationType` operation returns all of the Workers
    /// that have been associated with a given Qualification type.
    pub fn listWorkersWithQualificationType(self: *Self, allocator: std.mem.Allocator, input: list_workers_with_qualification_type.ListWorkersWithQualificationTypeInput, options: list_workers_with_qualification_type.Options) !list_workers_with_qualification_type.ListWorkersWithQualificationTypeOutput {
        return list_workers_with_qualification_type.execute(self, allocator, input, options);
    }

    /// The
    /// `NotifyWorkers`
    /// operation sends an email to one or more Workers that you specify with
    /// the Worker ID. You can specify up to 100 Worker IDs to send the same
    /// message with a single call to the NotifyWorkers operation. The
    /// NotifyWorkers operation will send a notification email to a Worker
    /// only if you have previously approved or rejected work from the
    /// Worker.
    pub fn notifyWorkers(self: *Self, allocator: std.mem.Allocator, input: notify_workers.NotifyWorkersInput, options: notify_workers.Options) !notify_workers.NotifyWorkersOutput {
        return notify_workers.execute(self, allocator, input, options);
    }

    /// The `RejectAssignment` operation rejects the results of a completed
    /// assignment.
    ///
    /// You can include an optional feedback message with the rejection,
    /// which the Worker can see in the Status section of the web site.
    /// When you include a feedback message with the rejection,
    /// it helps the Worker understand why the assignment was rejected,
    /// and can improve the quality of the results the Worker submits in the future.
    ///
    /// Only the Requester who created the HIT can reject an assignment for the HIT.
    pub fn rejectAssignment(self: *Self, allocator: std.mem.Allocator, input: reject_assignment.RejectAssignmentInput, options: reject_assignment.Options) !reject_assignment.RejectAssignmentOutput {
        return reject_assignment.execute(self, allocator, input, options);
    }

    /// The
    /// `RejectQualificationRequest`
    /// operation rejects a user's request for a Qualification.
    ///
    /// You can provide a text message explaining why the request was
    /// rejected. The Worker who made the request can see this message.
    pub fn rejectQualificationRequest(self: *Self, allocator: std.mem.Allocator, input: reject_qualification_request.RejectQualificationRequestInput, options: reject_qualification_request.Options) !reject_qualification_request.RejectQualificationRequestOutput {
        return reject_qualification_request.execute(self, allocator, input, options);
    }

    /// The
    /// `SendBonus`
    /// operation issues a payment of money from your account to a Worker.
    /// This payment happens separately from the reward you pay to the Worker
    /// when you approve the Worker's assignment. The SendBonus operation
    /// requires the Worker's ID and the assignment ID as parameters to
    /// initiate payment of the bonus. You must include a message that
    /// explains the reason for the bonus payment, as the Worker may not be
    /// expecting the payment. Amazon Mechanical Turk collects a fee for
    /// bonus payments, similar to the HIT listing fee. This operation fails
    /// if your account does not have enough funds to pay for both the bonus
    /// and the fees.
    pub fn sendBonus(self: *Self, allocator: std.mem.Allocator, input: send_bonus.SendBonusInput, options: send_bonus.Options) !send_bonus.SendBonusOutput {
        return send_bonus.execute(self, allocator, input, options);
    }

    /// The `SendTestEventNotification` operation causes Amazon Mechanical Turk to
    /// send
    /// a notification message as if a HIT event occurred, according to the provided
    /// notification specification. This allows you to test notifications without
    /// setting up notifications for a real HIT type and trying to trigger them
    /// using the website.
    /// When you call this operation, the service attempts to send the test
    /// notification immediately.
    pub fn sendTestEventNotification(self: *Self, allocator: std.mem.Allocator, input: send_test_event_notification.SendTestEventNotificationInput, options: send_test_event_notification.Options) !send_test_event_notification.SendTestEventNotificationOutput {
        return send_test_event_notification.execute(self, allocator, input, options);
    }

    /// The `UpdateExpirationForHIT` operation allows you update the expiration time
    /// of a HIT.
    /// If you update it to a time in the past, the HIT will be immediately expired.
    pub fn updateExpirationForHit(self: *Self, allocator: std.mem.Allocator, input: update_expiration_for_hit.UpdateExpirationForHITInput, options: update_expiration_for_hit.Options) !update_expiration_for_hit.UpdateExpirationForHITOutput {
        return update_expiration_for_hit.execute(self, allocator, input, options);
    }

    /// The `UpdateHITReviewStatus` operation updates the status of a HIT.
    /// If the status is Reviewable, this operation can update the status to
    /// Reviewing,
    /// or it can revert a Reviewing HIT back to the Reviewable status.
    pub fn updateHitReviewStatus(self: *Self, allocator: std.mem.Allocator, input: update_hit_review_status.UpdateHITReviewStatusInput, options: update_hit_review_status.Options) !update_hit_review_status.UpdateHITReviewStatusOutput {
        return update_hit_review_status.execute(self, allocator, input, options);
    }

    /// The
    /// `UpdateHITTypeOfHIT`
    /// operation allows you to change the HITType properties of a HIT. This
    /// operation disassociates the HIT from its old HITType properties and
    /// associates it with the new HITType properties. The HIT takes on the
    /// properties of the new HITType in place of the old ones.
    pub fn updateHitTypeOfHit(self: *Self, allocator: std.mem.Allocator, input: update_hit_type_of_hit.UpdateHITTypeOfHITInput, options: update_hit_type_of_hit.Options) !update_hit_type_of_hit.UpdateHITTypeOfHITOutput {
        return update_hit_type_of_hit.execute(self, allocator, input, options);
    }

    /// The `UpdateNotificationSettings` operation creates, updates,
    /// disables or re-enables notifications for a HIT type.
    /// If you call the UpdateNotificationSettings operation for a HIT type that
    /// already has a
    /// notification specification, the operation replaces the old specification
    /// with a new one.
    /// You can call the UpdateNotificationSettings operation to enable or disable
    /// notifications
    /// for the HIT type, without having to modify the notification specification
    /// itself by providing
    /// updates to the Active status without specifying a new notification
    /// specification.
    /// To change the Active status of a HIT type's notifications,
    /// the HIT type must already have a notification specification,
    /// or one must be provided in the same call to `UpdateNotificationSettings`.
    pub fn updateNotificationSettings(self: *Self, allocator: std.mem.Allocator, input: update_notification_settings.UpdateNotificationSettingsInput, options: update_notification_settings.Options) !update_notification_settings.UpdateNotificationSettingsOutput {
        return update_notification_settings.execute(self, allocator, input, options);
    }

    /// The
    /// `UpdateQualificationType`
    /// operation modifies the attributes of an existing Qualification type,
    /// which is represented by a QualificationType data structure. Only the
    /// owner of a Qualification type can modify its attributes.
    ///
    /// Most attributes of a Qualification type can be changed after
    /// the type has been created. However, the Name and Keywords fields
    /// cannot be modified. The RetryDelayInSeconds parameter can be modified
    /// or added to change the delay or to enable retries, but
    /// RetryDelayInSeconds cannot be used to disable retries.
    ///
    /// You can use this operation to update the test for a
    /// Qualification type. The test is updated based on the values specified
    /// for the Test, TestDurationInSeconds and AnswerKey parameters. All
    /// three parameters specify the updated test. If you are updating the
    /// test for a type, you must specify the Test and TestDurationInSeconds
    /// parameters. The AnswerKey parameter is optional; omitting it specifies
    /// that the updated test does not have an answer key.
    ///
    /// If you omit the Test parameter, the test for the
    /// Qualification type is unchanged. There is no way to remove a test from
    /// a Qualification type that has one. If the type already has a test, you
    /// cannot update it to be AutoGranted. If the Qualification type does not
    /// have a test and one is provided by an update, the type will henceforth
    /// have a test.
    ///
    /// If you want to update the test duration or answer key for an
    /// existing test without changing the questions, you must specify a Test
    /// parameter with the original questions, along with the updated values.
    ///
    /// If you provide an updated Test but no AnswerKey, the new test
    /// will not have an answer key. Requests for such Qualifications must be
    /// granted manually.
    ///
    /// You can also update the AutoGranted and AutoGrantedValue
    /// attributes of the Qualification type.
    pub fn updateQualificationType(self: *Self, allocator: std.mem.Allocator, input: update_qualification_type.UpdateQualificationTypeInput, options: update_qualification_type.Options) !update_qualification_type.UpdateQualificationTypeOutput {
        return update_qualification_type.execute(self, allocator, input, options);
    }

    pub fn listAssignmentsForHitPaginator(self: *Self, params: list_assignments_for_hit.ListAssignmentsForHITInput) paginator.ListAssignmentsForHITPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listBonusPaymentsPaginator(self: *Self, params: list_bonus_payments.ListBonusPaymentsInput) paginator.ListBonusPaymentsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listHiTsPaginator(self: *Self, params: list_hi_ts.ListHITsInput) paginator.ListHITsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listHiTsForQualificationTypePaginator(self: *Self, params: list_hi_ts_for_qualification_type.ListHITsForQualificationTypeInput) paginator.ListHITsForQualificationTypePaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listQualificationRequestsPaginator(self: *Self, params: list_qualification_requests.ListQualificationRequestsInput) paginator.ListQualificationRequestsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listQualificationTypesPaginator(self: *Self, params: list_qualification_types.ListQualificationTypesInput) paginator.ListQualificationTypesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listReviewPolicyResultsForHitPaginator(self: *Self, params: list_review_policy_results_for_hit.ListReviewPolicyResultsForHITInput) paginator.ListReviewPolicyResultsForHITPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listReviewableHiTsPaginator(self: *Self, params: list_reviewable_hi_ts.ListReviewableHITsInput) paginator.ListReviewableHITsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listWorkerBlocksPaginator(self: *Self, params: list_worker_blocks.ListWorkerBlocksInput) paginator.ListWorkerBlocksPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listWorkersWithQualificationTypePaginator(self: *Self, params: list_workers_with_qualification_type.ListWorkersWithQualificationTypeInput) paginator.ListWorkersWithQualificationTypePaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};
