const aws = @import("aws");
const std = @import("std");

const associate_assessment_report_evidence_folder = @import("associate_assessment_report_evidence_folder.zig");
const batch_associate_assessment_report_evidence = @import("batch_associate_assessment_report_evidence.zig");
const batch_create_delegation_by_assessment = @import("batch_create_delegation_by_assessment.zig");
const batch_delete_delegation_by_assessment = @import("batch_delete_delegation_by_assessment.zig");
const batch_disassociate_assessment_report_evidence = @import("batch_disassociate_assessment_report_evidence.zig");
const batch_import_evidence_to_assessment_control = @import("batch_import_evidence_to_assessment_control.zig");
const create_assessment = @import("create_assessment.zig");
const create_assessment_framework = @import("create_assessment_framework.zig");
const create_assessment_report = @import("create_assessment_report.zig");
const create_control = @import("create_control.zig");
const delete_assessment = @import("delete_assessment.zig");
const delete_assessment_framework = @import("delete_assessment_framework.zig");
const delete_assessment_framework_share = @import("delete_assessment_framework_share.zig");
const delete_assessment_report = @import("delete_assessment_report.zig");
const delete_control = @import("delete_control.zig");
const deregister_account = @import("deregister_account.zig");
const deregister_organization_admin_account = @import("deregister_organization_admin_account.zig");
const disassociate_assessment_report_evidence_folder = @import("disassociate_assessment_report_evidence_folder.zig");
const get_account_status = @import("get_account_status.zig");
const get_assessment = @import("get_assessment.zig");
const get_assessment_framework = @import("get_assessment_framework.zig");
const get_assessment_report_url = @import("get_assessment_report_url.zig");
const get_change_logs = @import("get_change_logs.zig");
const get_control = @import("get_control.zig");
const get_delegations = @import("get_delegations.zig");
const get_evidence = @import("get_evidence.zig");
const get_evidence_by_evidence_folder = @import("get_evidence_by_evidence_folder.zig");
const get_evidence_file_upload_url = @import("get_evidence_file_upload_url.zig");
const get_evidence_folder = @import("get_evidence_folder.zig");
const get_evidence_folders_by_assessment = @import("get_evidence_folders_by_assessment.zig");
const get_evidence_folders_by_assessment_control = @import("get_evidence_folders_by_assessment_control.zig");
const get_insights = @import("get_insights.zig");
const get_insights_by_assessment = @import("get_insights_by_assessment.zig");
const get_organization_admin_account = @import("get_organization_admin_account.zig");
const get_services_in_scope = @import("get_services_in_scope.zig");
const get_settings = @import("get_settings.zig");
const list_assessment_control_insights_by_control_domain = @import("list_assessment_control_insights_by_control_domain.zig");
const list_assessment_framework_share_requests = @import("list_assessment_framework_share_requests.zig");
const list_assessment_frameworks = @import("list_assessment_frameworks.zig");
const list_assessment_reports = @import("list_assessment_reports.zig");
const list_assessments = @import("list_assessments.zig");
const list_control_domain_insights = @import("list_control_domain_insights.zig");
const list_control_domain_insights_by_assessment = @import("list_control_domain_insights_by_assessment.zig");
const list_control_insights_by_control_domain = @import("list_control_insights_by_control_domain.zig");
const list_controls = @import("list_controls.zig");
const list_keywords_for_data_source = @import("list_keywords_for_data_source.zig");
const list_notifications = @import("list_notifications.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const register_account = @import("register_account.zig");
const register_organization_admin_account = @import("register_organization_admin_account.zig");
const start_assessment_framework_share = @import("start_assessment_framework_share.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_assessment = @import("update_assessment.zig");
const update_assessment_control = @import("update_assessment_control.zig");
const update_assessment_control_set_status = @import("update_assessment_control_set_status.zig");
const update_assessment_framework = @import("update_assessment_framework.zig");
const update_assessment_framework_share = @import("update_assessment_framework_share.zig");
const update_assessment_status = @import("update_assessment_status.zig");
const update_control = @import("update_control.zig");
const update_settings = @import("update_settings.zig");
const validate_assessment_report_integrity = @import("validate_assessment_report_integrity.zig");
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "AuditManager";

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

    /// Associates an evidence folder to an assessment report in an Audit Manager
    /// assessment.
    pub fn associateAssessmentReportEvidenceFolder(self: *Self, allocator: std.mem.Allocator, input: associate_assessment_report_evidence_folder.AssociateAssessmentReportEvidenceFolderInput, options: associate_assessment_report_evidence_folder.Options) !associate_assessment_report_evidence_folder.AssociateAssessmentReportEvidenceFolderOutput {
        return associate_assessment_report_evidence_folder.execute(self, allocator, input, options);
    }

    /// Associates a list of evidence to an assessment report in an Audit Manager
    /// assessment.
    pub fn batchAssociateAssessmentReportEvidence(self: *Self, allocator: std.mem.Allocator, input: batch_associate_assessment_report_evidence.BatchAssociateAssessmentReportEvidenceInput, options: batch_associate_assessment_report_evidence.Options) !batch_associate_assessment_report_evidence.BatchAssociateAssessmentReportEvidenceOutput {
        return batch_associate_assessment_report_evidence.execute(self, allocator, input, options);
    }

    /// Creates a batch of delegations for an assessment in Audit Manager.
    pub fn batchCreateDelegationByAssessment(self: *Self, allocator: std.mem.Allocator, input: batch_create_delegation_by_assessment.BatchCreateDelegationByAssessmentInput, options: batch_create_delegation_by_assessment.Options) !batch_create_delegation_by_assessment.BatchCreateDelegationByAssessmentOutput {
        return batch_create_delegation_by_assessment.execute(self, allocator, input, options);
    }

    /// Deletes a batch of delegations for an assessment in Audit Manager.
    pub fn batchDeleteDelegationByAssessment(self: *Self, allocator: std.mem.Allocator, input: batch_delete_delegation_by_assessment.BatchDeleteDelegationByAssessmentInput, options: batch_delete_delegation_by_assessment.Options) !batch_delete_delegation_by_assessment.BatchDeleteDelegationByAssessmentOutput {
        return batch_delete_delegation_by_assessment.execute(self, allocator, input, options);
    }

    /// Disassociates a list of evidence from an assessment report in Audit Manager.
    pub fn batchDisassociateAssessmentReportEvidence(self: *Self, allocator: std.mem.Allocator, input: batch_disassociate_assessment_report_evidence.BatchDisassociateAssessmentReportEvidenceInput, options: batch_disassociate_assessment_report_evidence.Options) !batch_disassociate_assessment_report_evidence.BatchDisassociateAssessmentReportEvidenceOutput {
        return batch_disassociate_assessment_report_evidence.execute(self, allocator, input, options);
    }

    /// Adds one or more pieces of evidence to a control in an Audit Manager
    /// assessment.
    ///
    /// You can import manual evidence from any S3 bucket by specifying the S3 URI
    /// of the
    /// object. You can also upload a file from your browser, or enter plain text in
    /// response to a
    /// risk assessment question.
    ///
    /// The following restrictions apply to this action:
    ///
    /// * `manualEvidence` can be only one of the following:
    /// `evidenceFileName`, `s3ResourcePath`, or
    /// `textResponse`
    ///
    /// * Maximum size of an individual evidence file: 100 MB
    ///
    /// * Number of daily manual evidence uploads per control: 100
    ///
    /// * Supported file formats: See [Supported file types for manual
    ///   evidence](https://docs.aws.amazon.com/audit-manager/latest/userguide/upload-evidence.html#supported-manual-evidence-files) in the *Audit Manager User Guide*
    ///
    /// For more information about Audit Manager service restrictions, see [Quotas
    /// and
    /// restrictions for Audit
    /// Manager](https://docs.aws.amazon.com/audit-manager/latest/userguide/service-quotas.html).
    pub fn batchImportEvidenceToAssessmentControl(self: *Self, allocator: std.mem.Allocator, input: batch_import_evidence_to_assessment_control.BatchImportEvidenceToAssessmentControlInput, options: batch_import_evidence_to_assessment_control.Options) !batch_import_evidence_to_assessment_control.BatchImportEvidenceToAssessmentControlOutput {
        return batch_import_evidence_to_assessment_control.execute(self, allocator, input, options);
    }

    /// Creates an assessment in Audit Manager.
    pub fn createAssessment(self: *Self, allocator: std.mem.Allocator, input: create_assessment.CreateAssessmentInput, options: create_assessment.Options) !create_assessment.CreateAssessmentOutput {
        return create_assessment.execute(self, allocator, input, options);
    }

    /// Creates a custom framework in Audit Manager.
    pub fn createAssessmentFramework(self: *Self, allocator: std.mem.Allocator, input: create_assessment_framework.CreateAssessmentFrameworkInput, options: create_assessment_framework.Options) !create_assessment_framework.CreateAssessmentFrameworkOutput {
        return create_assessment_framework.execute(self, allocator, input, options);
    }

    /// Creates an assessment report for the specified assessment.
    pub fn createAssessmentReport(self: *Self, allocator: std.mem.Allocator, input: create_assessment_report.CreateAssessmentReportInput, options: create_assessment_report.Options) !create_assessment_report.CreateAssessmentReportOutput {
        return create_assessment_report.execute(self, allocator, input, options);
    }

    /// Creates a new custom control in Audit Manager.
    pub fn createControl(self: *Self, allocator: std.mem.Allocator, input: create_control.CreateControlInput, options: create_control.Options) !create_control.CreateControlOutput {
        return create_control.execute(self, allocator, input, options);
    }

    /// Deletes an assessment in Audit Manager.
    pub fn deleteAssessment(self: *Self, allocator: std.mem.Allocator, input: delete_assessment.DeleteAssessmentInput, options: delete_assessment.Options) !delete_assessment.DeleteAssessmentOutput {
        return delete_assessment.execute(self, allocator, input, options);
    }

    /// Deletes a custom framework in Audit Manager.
    pub fn deleteAssessmentFramework(self: *Self, allocator: std.mem.Allocator, input: delete_assessment_framework.DeleteAssessmentFrameworkInput, options: delete_assessment_framework.Options) !delete_assessment_framework.DeleteAssessmentFrameworkOutput {
        return delete_assessment_framework.execute(self, allocator, input, options);
    }

    /// Deletes a share request for a custom framework in Audit Manager.
    pub fn deleteAssessmentFrameworkShare(self: *Self, allocator: std.mem.Allocator, input: delete_assessment_framework_share.DeleteAssessmentFrameworkShareInput, options: delete_assessment_framework_share.Options) !delete_assessment_framework_share.DeleteAssessmentFrameworkShareOutput {
        return delete_assessment_framework_share.execute(self, allocator, input, options);
    }

    /// Deletes an assessment report in Audit Manager.
    ///
    /// When you run the `DeleteAssessmentReport` operation, Audit Manager
    /// attempts to delete the following data:
    ///
    /// * The specified assessment report that’s stored in your S3 bucket
    ///
    /// * The associated metadata that’s stored in Audit Manager
    ///
    /// If Audit Manager can’t access the assessment report in your S3 bucket, the
    /// report
    /// isn’t deleted. In this event, the `DeleteAssessmentReport` operation doesn’t
    /// fail. Instead, it proceeds to delete the associated metadata only. You must
    /// then delete the
    /// assessment report from the S3 bucket yourself.
    ///
    /// This scenario happens when Audit Manager receives a `403 (Forbidden)` or
    /// `404 (Not Found)` error from Amazon S3. To avoid this, make sure that
    /// your S3 bucket is available, and that you configured the correct permissions
    /// for Audit Manager to delete resources in your S3 bucket. For an example
    /// permissions policy that
    /// you can use, see [Assessment report destination
    /// permissions](https://docs.aws.amazon.com/audit-manager/latest/userguide/security_iam_id-based-policy-examples.html#full-administrator-access-assessment-report-destination) in the *Audit Manager User Guide*. For information about the issues that could cause a `403
    /// (Forbidden)` or `404 (Not Found`) error from Amazon S3, see
    /// [List of Error
    /// Codes](https://docs.aws.amazon.com/AmazonS3/latest/API/ErrorResponses.html#ErrorCodeList) in the *Amazon Simple Storage Service API
    /// Reference*.
    pub fn deleteAssessmentReport(self: *Self, allocator: std.mem.Allocator, input: delete_assessment_report.DeleteAssessmentReportInput, options: delete_assessment_report.Options) !delete_assessment_report.DeleteAssessmentReportOutput {
        return delete_assessment_report.execute(self, allocator, input, options);
    }

    /// Deletes a custom control in Audit Manager.
    ///
    /// When you invoke this operation, the custom control is deleted from any
    /// frameworks or
    /// assessments that it’s currently part of. As a result, Audit Manager will
    /// stop
    /// collecting evidence for that custom control in all of your assessments. This
    /// includes
    /// assessments that you previously created before you deleted the custom
    /// control.
    pub fn deleteControl(self: *Self, allocator: std.mem.Allocator, input: delete_control.DeleteControlInput, options: delete_control.Options) !delete_control.DeleteControlOutput {
        return delete_control.execute(self, allocator, input, options);
    }

    /// Deregisters an account in Audit Manager.
    ///
    /// Before you deregister, you can use the
    /// [UpdateSettings](https://docs.aws.amazon.com/audit-manager/latest/APIReference/API_UpdateSettings.html) API operation to set your preferred data retention policy. By
    /// default, Audit Manager retains your data. If you want to delete your data,
    /// you can
    /// use the `DeregistrationPolicy` attribute to request the deletion of your
    /// data.
    ///
    /// For more information about data retention, see [Data
    /// Protection](https://docs.aws.amazon.com/audit-manager/latest/userguide/data-protection.html) in the *Audit Manager User Guide*.
    pub fn deregisterAccount(self: *Self, allocator: std.mem.Allocator, input: deregister_account.DeregisterAccountInput, options: deregister_account.Options) !deregister_account.DeregisterAccountOutput {
        return deregister_account.execute(self, allocator, input, options);
    }

    /// Removes the specified Amazon Web Services account as a delegated
    /// administrator for
    /// Audit Manager.
    ///
    /// When you remove a delegated administrator from your Audit Manager settings,
    /// you
    /// continue to have access to the evidence that you previously collected under
    /// that account.
    /// This is also the case when you deregister a delegated administrator from
    /// Organizations. However, Audit Manager stops collecting and attaching
    /// evidence to
    /// that delegated administrator account moving forward.
    ///
    /// Keep in mind the following cleanup task if you use evidence finder:
    ///
    /// Before you use your management account to remove a delegated administrator,
    /// make sure
    /// that the current delegated administrator account signs in to Audit Manager
    /// and
    /// disables evidence finder first. Disabling evidence finder automatically
    /// deletes the
    /// event data store that was created in their account when they enabled
    /// evidence finder. If
    /// this task isn’t completed, the event data store remains in their account. In
    /// this case,
    /// we recommend that the original delegated administrator goes to CloudTrail
    /// Lake
    /// and manually [deletes the
    /// event data
    /// store](https://docs.aws.amazon.com/awscloudtrail/latest/userguide/query-eds-disable-termination.html).
    ///
    /// This cleanup task is necessary to ensure that you don't end up with multiple
    /// event
    /// data stores. Audit Manager ignores an unused event data store after you
    /// remove or
    /// change a delegated administrator account. However, the unused event data
    /// store continues
    /// to incur storage costs from CloudTrail Lake if you don't delete it.
    ///
    /// When you deregister a delegated administrator account for Audit Manager, the
    /// data
    /// for that account isn’t deleted. If you want to delete resource data for a
    /// delegated
    /// administrator account, you must perform that task separately before you
    /// deregister the
    /// account. Either, you can do this in the Audit Manager console. Or, you can
    /// use one of
    /// the delete API operations that are provided by Audit Manager.
    ///
    /// To delete your Audit Manager resource data, see the following instructions:
    ///
    /// *
    ///   [DeleteAssessment](https://docs.aws.amazon.com/audit-manager/latest/APIReference/API_DeleteAssessment.html) (see also: [Deleting an
    /// assessment](https://docs.aws.amazon.com/audit-manager/latest/userguide/delete-assessment.html) in the *Audit Manager User
    /// Guide*)
    ///
    /// *
    ///   [DeleteAssessmentFramework](https://docs.aws.amazon.com/audit-manager/latest/APIReference/API_DeleteAssessmentFramework.html) (see also: [Deleting a
    /// custom
    /// framework](https://docs.aws.amazon.com/audit-manager/latest/userguide/delete-custom-framework.html) in the *Audit Manager User
    /// Guide*)
    ///
    /// *
    ///   [DeleteAssessmentFrameworkShare](https://docs.aws.amazon.com/audit-manager/latest/APIReference/API_DeleteAssessmentFrameworkShare.html) (see also: [Deleting a share request](https://docs.aws.amazon.com/audit-manager/latest/userguide/deleting-shared-framework-requests.html) in the *Audit Manager User
    /// Guide*)
    ///
    /// *
    ///   [DeleteAssessmentReport](https://docs.aws.amazon.com/audit-manager/latest/APIReference/API_DeleteAssessmentReport.html) (see also: [Deleting an assessment report](https://docs.aws.amazon.com/audit-manager/latest/userguide/generate-assessment-report.html#delete-assessment-report-steps) in the *Audit Manager User
    /// Guide*)
    ///
    /// *
    ///   [DeleteControl](https://docs.aws.amazon.com/audit-manager/latest/APIReference/API_DeleteControl.html) (see also: [Deleting a custom
    /// control](https://docs.aws.amazon.com/audit-manager/latest/userguide/delete-controls.html) in the *Audit Manager User
    /// Guide*)
    ///
    /// At this time, Audit Manager doesn't provide an option to delete evidence for
    /// a
    /// specific delegated administrator. Instead, when your management account
    /// deregisters Audit Manager, we perform a cleanup for the current delegated
    /// administrator account at the
    /// time of deregistration.
    pub fn deregisterOrganizationAdminAccount(self: *Self, allocator: std.mem.Allocator, input: deregister_organization_admin_account.DeregisterOrganizationAdminAccountInput, options: deregister_organization_admin_account.Options) !deregister_organization_admin_account.DeregisterOrganizationAdminAccountOutput {
        return deregister_organization_admin_account.execute(self, allocator, input, options);
    }

    /// Disassociates an evidence folder from the specified assessment report in
    /// Audit Manager.
    pub fn disassociateAssessmentReportEvidenceFolder(self: *Self, allocator: std.mem.Allocator, input: disassociate_assessment_report_evidence_folder.DisassociateAssessmentReportEvidenceFolderInput, options: disassociate_assessment_report_evidence_folder.Options) !disassociate_assessment_report_evidence_folder.DisassociateAssessmentReportEvidenceFolderOutput {
        return disassociate_assessment_report_evidence_folder.execute(self, allocator, input, options);
    }

    /// Gets the registration status of an account in Audit Manager.
    pub fn getAccountStatus(self: *Self, allocator: std.mem.Allocator, input: get_account_status.GetAccountStatusInput, options: get_account_status.Options) !get_account_status.GetAccountStatusOutput {
        return get_account_status.execute(self, allocator, input, options);
    }

    /// Gets information about a specified assessment.
    pub fn getAssessment(self: *Self, allocator: std.mem.Allocator, input: get_assessment.GetAssessmentInput, options: get_assessment.Options) !get_assessment.GetAssessmentOutput {
        return get_assessment.execute(self, allocator, input, options);
    }

    /// Gets information about a specified framework.
    pub fn getAssessmentFramework(self: *Self, allocator: std.mem.Allocator, input: get_assessment_framework.GetAssessmentFrameworkInput, options: get_assessment_framework.Options) !get_assessment_framework.GetAssessmentFrameworkOutput {
        return get_assessment_framework.execute(self, allocator, input, options);
    }

    /// Gets the URL of an assessment report in Audit Manager.
    pub fn getAssessmentReportUrl(self: *Self, allocator: std.mem.Allocator, input: get_assessment_report_url.GetAssessmentReportUrlInput, options: get_assessment_report_url.Options) !get_assessment_report_url.GetAssessmentReportUrlOutput {
        return get_assessment_report_url.execute(self, allocator, input, options);
    }

    /// Gets a list of changelogs from Audit Manager.
    pub fn getChangeLogs(self: *Self, allocator: std.mem.Allocator, input: get_change_logs.GetChangeLogsInput, options: get_change_logs.Options) !get_change_logs.GetChangeLogsOutput {
        return get_change_logs.execute(self, allocator, input, options);
    }

    /// Gets information about a specified control.
    pub fn getControl(self: *Self, allocator: std.mem.Allocator, input: get_control.GetControlInput, options: get_control.Options) !get_control.GetControlOutput {
        return get_control.execute(self, allocator, input, options);
    }

    /// Gets a list of delegations from an audit owner to a delegate.
    pub fn getDelegations(self: *Self, allocator: std.mem.Allocator, input: get_delegations.GetDelegationsInput, options: get_delegations.Options) !get_delegations.GetDelegationsOutput {
        return get_delegations.execute(self, allocator, input, options);
    }

    /// Gets information about a specified evidence item.
    pub fn getEvidence(self: *Self, allocator: std.mem.Allocator, input: get_evidence.GetEvidenceInput, options: get_evidence.Options) !get_evidence.GetEvidenceOutput {
        return get_evidence.execute(self, allocator, input, options);
    }

    /// Gets all evidence from a specified evidence folder in Audit Manager.
    pub fn getEvidenceByEvidenceFolder(self: *Self, allocator: std.mem.Allocator, input: get_evidence_by_evidence_folder.GetEvidenceByEvidenceFolderInput, options: get_evidence_by_evidence_folder.Options) !get_evidence_by_evidence_folder.GetEvidenceByEvidenceFolderOutput {
        return get_evidence_by_evidence_folder.execute(self, allocator, input, options);
    }

    /// Creates a presigned Amazon S3 URL that can be used to upload a file as
    /// manual
    /// evidence. For instructions on how to use this operation, see [Upload a file
    /// from your browser
    /// ](https://docs.aws.amazon.com/audit-manager/latest/userguide/upload-evidence.html#how-to-upload-manual-evidence-files) in the *Audit Manager User
    /// Guide*.
    ///
    /// The following restrictions apply to this operation:
    ///
    /// * Maximum size of an individual evidence file: 100 MB
    ///
    /// * Number of daily manual evidence uploads per control: 100
    ///
    /// * Supported file formats: See [Supported file types for manual
    ///   evidence](https://docs.aws.amazon.com/audit-manager/latest/userguide/upload-evidence.html#supported-manual-evidence-files) in the *Audit Manager User Guide*
    ///
    /// For more information about Audit Manager service restrictions, see [Quotas
    /// and
    /// restrictions for Audit
    /// Manager](https://docs.aws.amazon.com/audit-manager/latest/userguide/service-quotas.html).
    pub fn getEvidenceFileUploadUrl(self: *Self, allocator: std.mem.Allocator, input: get_evidence_file_upload_url.GetEvidenceFileUploadUrlInput, options: get_evidence_file_upload_url.Options) !get_evidence_file_upload_url.GetEvidenceFileUploadUrlOutput {
        return get_evidence_file_upload_url.execute(self, allocator, input, options);
    }

    /// Gets an evidence folder from a specified assessment in Audit Manager.
    pub fn getEvidenceFolder(self: *Self, allocator: std.mem.Allocator, input: get_evidence_folder.GetEvidenceFolderInput, options: get_evidence_folder.Options) !get_evidence_folder.GetEvidenceFolderOutput {
        return get_evidence_folder.execute(self, allocator, input, options);
    }

    /// Gets the evidence folders from a specified assessment in Audit Manager.
    pub fn getEvidenceFoldersByAssessment(self: *Self, allocator: std.mem.Allocator, input: get_evidence_folders_by_assessment.GetEvidenceFoldersByAssessmentInput, options: get_evidence_folders_by_assessment.Options) !get_evidence_folders_by_assessment.GetEvidenceFoldersByAssessmentOutput {
        return get_evidence_folders_by_assessment.execute(self, allocator, input, options);
    }

    /// Gets a list of evidence folders that are associated with a specified control
    /// in an
    /// Audit Manager assessment.
    pub fn getEvidenceFoldersByAssessmentControl(self: *Self, allocator: std.mem.Allocator, input: get_evidence_folders_by_assessment_control.GetEvidenceFoldersByAssessmentControlInput, options: get_evidence_folders_by_assessment_control.Options) !get_evidence_folders_by_assessment_control.GetEvidenceFoldersByAssessmentControlOutput {
        return get_evidence_folders_by_assessment_control.execute(self, allocator, input, options);
    }

    /// Gets the latest analytics data for all your current active assessments.
    pub fn getInsights(self: *Self, allocator: std.mem.Allocator, input: get_insights.GetInsightsInput, options: get_insights.Options) !get_insights.GetInsightsOutput {
        return get_insights.execute(self, allocator, input, options);
    }

    /// Gets the latest analytics data for a specific active assessment.
    pub fn getInsightsByAssessment(self: *Self, allocator: std.mem.Allocator, input: get_insights_by_assessment.GetInsightsByAssessmentInput, options: get_insights_by_assessment.Options) !get_insights_by_assessment.GetInsightsByAssessmentOutput {
        return get_insights_by_assessment.execute(self, allocator, input, options);
    }

    /// Gets the name of the delegated Amazon Web Services administrator account for
    /// a specified
    /// organization.
    pub fn getOrganizationAdminAccount(self: *Self, allocator: std.mem.Allocator, input: get_organization_admin_account.GetOrganizationAdminAccountInput, options: get_organization_admin_account.Options) !get_organization_admin_account.GetOrganizationAdminAccountOutput {
        return get_organization_admin_account.execute(self, allocator, input, options);
    }

    /// Gets a list of the Amazon Web Services services from which Audit Manager can
    /// collect
    /// evidence.
    ///
    /// Audit Manager defines which Amazon Web Services services are in scope for an
    /// assessment. Audit Manager infers this scope by examining the assessment’s
    /// controls and
    /// their data sources, and then mapping this information to one or more of the
    /// corresponding
    /// Amazon Web Services services that are in this list.
    ///
    /// For information about why it's no longer possible to specify services in
    /// scope manually, see
    /// [I can't edit the services in scope for my
    /// assessment](https://docs.aws.amazon.com/audit-manager/latest/userguide/evidence-collection-issues.html#unable-to-edit-services) in
    /// the *Troubleshooting* section of the Audit Manager user
    /// guide.
    pub fn getServicesInScope(self: *Self, allocator: std.mem.Allocator, input: get_services_in_scope.GetServicesInScopeInput, options: get_services_in_scope.Options) !get_services_in_scope.GetServicesInScopeOutput {
        return get_services_in_scope.execute(self, allocator, input, options);
    }

    /// Gets the settings for a specified Amazon Web Services account.
    pub fn getSettings(self: *Self, allocator: std.mem.Allocator, input: get_settings.GetSettingsInput, options: get_settings.Options) !get_settings.GetSettingsOutput {
        return get_settings.execute(self, allocator, input, options);
    }

    /// Lists the latest analytics data for controls within a specific control
    /// domain and a
    /// specific active assessment.
    ///
    /// Control insights are listed only if the control belongs to the control
    /// domain and
    /// assessment that was specified. Moreover, the control must have collected
    /// evidence on the
    /// `lastUpdated` date of `controlInsightsByAssessment`. If neither
    /// of these conditions are met, no data is listed for that control.
    pub fn listAssessmentControlInsightsByControlDomain(self: *Self, allocator: std.mem.Allocator, input: list_assessment_control_insights_by_control_domain.ListAssessmentControlInsightsByControlDomainInput, options: list_assessment_control_insights_by_control_domain.Options) !list_assessment_control_insights_by_control_domain.ListAssessmentControlInsightsByControlDomainOutput {
        return list_assessment_control_insights_by_control_domain.execute(self, allocator, input, options);
    }

    /// Returns a list of sent or received share requests for custom frameworks in
    /// Audit Manager.
    pub fn listAssessmentFrameworkShareRequests(self: *Self, allocator: std.mem.Allocator, input: list_assessment_framework_share_requests.ListAssessmentFrameworkShareRequestsInput, options: list_assessment_framework_share_requests.Options) !list_assessment_framework_share_requests.ListAssessmentFrameworkShareRequestsOutput {
        return list_assessment_framework_share_requests.execute(self, allocator, input, options);
    }

    /// Returns a list of the frameworks that are available in the Audit Manager
    /// framework
    /// library.
    pub fn listAssessmentFrameworks(self: *Self, allocator: std.mem.Allocator, input: list_assessment_frameworks.ListAssessmentFrameworksInput, options: list_assessment_frameworks.Options) !list_assessment_frameworks.ListAssessmentFrameworksOutput {
        return list_assessment_frameworks.execute(self, allocator, input, options);
    }

    /// Returns a list of assessment reports created in Audit Manager.
    pub fn listAssessmentReports(self: *Self, allocator: std.mem.Allocator, input: list_assessment_reports.ListAssessmentReportsInput, options: list_assessment_reports.Options) !list_assessment_reports.ListAssessmentReportsOutput {
        return list_assessment_reports.execute(self, allocator, input, options);
    }

    /// Returns a list of current and past assessments from Audit Manager.
    pub fn listAssessments(self: *Self, allocator: std.mem.Allocator, input: list_assessments.ListAssessmentsInput, options: list_assessments.Options) !list_assessments.ListAssessmentsOutput {
        return list_assessments.execute(self, allocator, input, options);
    }

    /// Lists the latest analytics data for control domains across all of your
    /// active
    /// assessments.
    ///
    /// Audit Manager supports the control domains that are provided by Amazon Web
    /// Services
    /// Control Catalog. For information about how to find a list of available
    /// control domains, see
    /// [
    /// `ListDomains`
    /// ](https://docs.aws.amazon.com/controlcatalog/latest/APIReference/API_ListDomains.html) in the Amazon Web Services Control
    /// Catalog API Reference.
    ///
    /// A control domain is listed only if at least one of the controls within that
    /// domain
    /// collected evidence on the `lastUpdated` date of
    /// `controlDomainInsights`. If this condition isn’t met, no data is listed
    /// for that control domain.
    pub fn listControlDomainInsights(self: *Self, allocator: std.mem.Allocator, input: list_control_domain_insights.ListControlDomainInsightsInput, options: list_control_domain_insights.Options) !list_control_domain_insights.ListControlDomainInsightsOutput {
        return list_control_domain_insights.execute(self, allocator, input, options);
    }

    /// Lists analytics data for control domains within a specified active
    /// assessment.
    ///
    /// Audit Manager supports the control domains that are provided by Amazon Web
    /// Services
    /// Control Catalog. For information about how to find a list of available
    /// control domains, see
    /// [
    /// `ListDomains`
    /// ](https://docs.aws.amazon.com/controlcatalog/latest/APIReference/API_ListDomains.html) in the Amazon Web Services Control
    /// Catalog API Reference.
    ///
    /// A control domain is listed only if at least one of the controls within that
    /// domain
    /// collected evidence on the `lastUpdated` date of
    /// `controlDomainInsights`. If this condition isn’t met, no data is listed
    /// for that domain.
    pub fn listControlDomainInsightsByAssessment(self: *Self, allocator: std.mem.Allocator, input: list_control_domain_insights_by_assessment.ListControlDomainInsightsByAssessmentInput, options: list_control_domain_insights_by_assessment.Options) !list_control_domain_insights_by_assessment.ListControlDomainInsightsByAssessmentOutput {
        return list_control_domain_insights_by_assessment.execute(self, allocator, input, options);
    }

    /// Lists the latest analytics data for controls within a specific control
    /// domain across all
    /// active assessments.
    ///
    /// Control insights are listed only if the control belongs to the control
    /// domain that
    /// was specified and the control collected evidence on the `lastUpdated` date
    /// of
    /// `controlInsightsMetadata`. If neither of these conditions are met, no data
    /// is listed for that control.
    pub fn listControlInsightsByControlDomain(self: *Self, allocator: std.mem.Allocator, input: list_control_insights_by_control_domain.ListControlInsightsByControlDomainInput, options: list_control_insights_by_control_domain.Options) !list_control_insights_by_control_domain.ListControlInsightsByControlDomainOutput {
        return list_control_insights_by_control_domain.execute(self, allocator, input, options);
    }

    /// Returns a list of controls from Audit Manager.
    pub fn listControls(self: *Self, allocator: std.mem.Allocator, input: list_controls.ListControlsInput, options: list_controls.Options) !list_controls.ListControlsOutput {
        return list_controls.execute(self, allocator, input, options);
    }

    /// Returns a list of keywords that are pre-mapped to the specified control data
    /// source.
    pub fn listKeywordsForDataSource(self: *Self, allocator: std.mem.Allocator, input: list_keywords_for_data_source.ListKeywordsForDataSourceInput, options: list_keywords_for_data_source.Options) !list_keywords_for_data_source.ListKeywordsForDataSourceOutput {
        return list_keywords_for_data_source.execute(self, allocator, input, options);
    }

    /// Returns a list of all Audit Manager notifications.
    pub fn listNotifications(self: *Self, allocator: std.mem.Allocator, input: list_notifications.ListNotificationsInput, options: list_notifications.Options) !list_notifications.ListNotificationsOutput {
        return list_notifications.execute(self, allocator, input, options);
    }

    /// Returns a list of tags for the specified resource in Audit Manager.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: list_tags_for_resource.Options) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Enables Audit Manager for the specified Amazon Web Services account.
    pub fn registerAccount(self: *Self, allocator: std.mem.Allocator, input: register_account.RegisterAccountInput, options: register_account.Options) !register_account.RegisterAccountOutput {
        return register_account.execute(self, allocator, input, options);
    }

    /// Enables an Amazon Web Services account within the organization as the
    /// delegated
    /// administrator for Audit Manager.
    pub fn registerOrganizationAdminAccount(self: *Self, allocator: std.mem.Allocator, input: register_organization_admin_account.RegisterOrganizationAdminAccountInput, options: register_organization_admin_account.Options) !register_organization_admin_account.RegisterOrganizationAdminAccountOutput {
        return register_organization_admin_account.execute(self, allocator, input, options);
    }

    /// Creates a share request for a custom framework in Audit Manager.
    ///
    /// The share request specifies a recipient and notifies them that a custom
    /// framework is
    /// available. Recipients have 120 days to accept or decline the request. If no
    /// action is
    /// taken, the share request expires.
    ///
    /// When you create a share request, Audit Manager stores a snapshot of your
    /// custom
    /// framework in the US East (N. Virginia) Amazon Web Services Region. Audit
    /// Manager also
    /// stores a backup of the same snapshot in the US West (Oregon) Amazon Web
    /// Services Region.
    ///
    /// Audit Manager deletes the snapshot and the backup snapshot when one of the
    /// following
    /// events occurs:
    ///
    /// * The sender revokes the share request.
    ///
    /// * The recipient declines the share request.
    ///
    /// * The recipient encounters an error and doesn't successfully accept the
    ///   share
    /// request.
    ///
    /// * The share request expires before the recipient responds to the request.
    ///
    /// When a sender [resends a share
    /// request](https://docs.aws.amazon.com/audit-manager/latest/userguide/framework-sharing.html#framework-sharing-resend), the snapshot is replaced with an updated version that
    /// corresponds with the latest version of the custom framework.
    ///
    /// When a recipient accepts a share request, the snapshot is replicated into
    /// their Amazon Web Services account under the Amazon Web Services Region that
    /// was specified in the share
    /// request.
    ///
    /// When you invoke the `StartAssessmentFrameworkShare` API, you are about to
    /// share a custom framework with another Amazon Web Services account. You may
    /// not share a
    /// custom framework that is derived from a standard framework if the standard
    /// framework is
    /// designated as not eligible for sharing by Amazon Web Services, unless you
    /// have obtained
    /// permission to do so from the owner of the standard framework. To learn more
    /// about which
    /// standard frameworks are eligible for sharing, see [Framework sharing
    /// eligibility](https://docs.aws.amazon.com/audit-manager/latest/userguide/share-custom-framework-concepts-and-terminology.html#eligibility) in the *Audit Manager User
    /// Guide*.
    pub fn startAssessmentFrameworkShare(self: *Self, allocator: std.mem.Allocator, input: start_assessment_framework_share.StartAssessmentFrameworkShareInput, options: start_assessment_framework_share.Options) !start_assessment_framework_share.StartAssessmentFrameworkShareOutput {
        return start_assessment_framework_share.execute(self, allocator, input, options);
    }

    /// Tags the specified resource in Audit Manager.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: tag_resource.Options) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Removes a tag from a resource in Audit Manager.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: untag_resource.Options) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Edits an Audit Manager assessment.
    pub fn updateAssessment(self: *Self, allocator: std.mem.Allocator, input: update_assessment.UpdateAssessmentInput, options: update_assessment.Options) !update_assessment.UpdateAssessmentOutput {
        return update_assessment.execute(self, allocator, input, options);
    }

    /// Updates a control within an assessment in Audit Manager.
    pub fn updateAssessmentControl(self: *Self, allocator: std.mem.Allocator, input: update_assessment_control.UpdateAssessmentControlInput, options: update_assessment_control.Options) !update_assessment_control.UpdateAssessmentControlOutput {
        return update_assessment_control.execute(self, allocator, input, options);
    }

    /// Updates the status of a control set in an Audit Manager assessment.
    pub fn updateAssessmentControlSetStatus(self: *Self, allocator: std.mem.Allocator, input: update_assessment_control_set_status.UpdateAssessmentControlSetStatusInput, options: update_assessment_control_set_status.Options) !update_assessment_control_set_status.UpdateAssessmentControlSetStatusOutput {
        return update_assessment_control_set_status.execute(self, allocator, input, options);
    }

    /// Updates a custom framework in Audit Manager.
    pub fn updateAssessmentFramework(self: *Self, allocator: std.mem.Allocator, input: update_assessment_framework.UpdateAssessmentFrameworkInput, options: update_assessment_framework.Options) !update_assessment_framework.UpdateAssessmentFrameworkOutput {
        return update_assessment_framework.execute(self, allocator, input, options);
    }

    /// Updates a share request for a custom framework in Audit Manager.
    pub fn updateAssessmentFrameworkShare(self: *Self, allocator: std.mem.Allocator, input: update_assessment_framework_share.UpdateAssessmentFrameworkShareInput, options: update_assessment_framework_share.Options) !update_assessment_framework_share.UpdateAssessmentFrameworkShareOutput {
        return update_assessment_framework_share.execute(self, allocator, input, options);
    }

    /// Updates the status of an assessment in Audit Manager.
    pub fn updateAssessmentStatus(self: *Self, allocator: std.mem.Allocator, input: update_assessment_status.UpdateAssessmentStatusInput, options: update_assessment_status.Options) !update_assessment_status.UpdateAssessmentStatusOutput {
        return update_assessment_status.execute(self, allocator, input, options);
    }

    /// Updates a custom control in Audit Manager.
    pub fn updateControl(self: *Self, allocator: std.mem.Allocator, input: update_control.UpdateControlInput, options: update_control.Options) !update_control.UpdateControlOutput {
        return update_control.execute(self, allocator, input, options);
    }

    /// Updates Audit Manager settings for the current account.
    pub fn updateSettings(self: *Self, allocator: std.mem.Allocator, input: update_settings.UpdateSettingsInput, options: update_settings.Options) !update_settings.UpdateSettingsOutput {
        return update_settings.execute(self, allocator, input, options);
    }

    /// Validates the integrity of an assessment report in Audit Manager.
    pub fn validateAssessmentReportIntegrity(self: *Self, allocator: std.mem.Allocator, input: validate_assessment_report_integrity.ValidateAssessmentReportIntegrityInput, options: validate_assessment_report_integrity.Options) !validate_assessment_report_integrity.ValidateAssessmentReportIntegrityOutput {
        return validate_assessment_report_integrity.execute(self, allocator, input, options);
    }

    pub fn getChangeLogsPaginator(self: *Self, params: get_change_logs.GetChangeLogsInput) paginator.GetChangeLogsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn getDelegationsPaginator(self: *Self, params: get_delegations.GetDelegationsInput) paginator.GetDelegationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn getEvidenceByEvidenceFolderPaginator(self: *Self, params: get_evidence_by_evidence_folder.GetEvidenceByEvidenceFolderInput) paginator.GetEvidenceByEvidenceFolderPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn getEvidenceFoldersByAssessmentPaginator(self: *Self, params: get_evidence_folders_by_assessment.GetEvidenceFoldersByAssessmentInput) paginator.GetEvidenceFoldersByAssessmentPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn getEvidenceFoldersByAssessmentControlPaginator(self: *Self, params: get_evidence_folders_by_assessment_control.GetEvidenceFoldersByAssessmentControlInput) paginator.GetEvidenceFoldersByAssessmentControlPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listAssessmentControlInsightsByControlDomainPaginator(self: *Self, params: list_assessment_control_insights_by_control_domain.ListAssessmentControlInsightsByControlDomainInput) paginator.ListAssessmentControlInsightsByControlDomainPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listAssessmentFrameworkShareRequestsPaginator(self: *Self, params: list_assessment_framework_share_requests.ListAssessmentFrameworkShareRequestsInput) paginator.ListAssessmentFrameworkShareRequestsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listAssessmentFrameworksPaginator(self: *Self, params: list_assessment_frameworks.ListAssessmentFrameworksInput) paginator.ListAssessmentFrameworksPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listAssessmentReportsPaginator(self: *Self, params: list_assessment_reports.ListAssessmentReportsInput) paginator.ListAssessmentReportsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listAssessmentsPaginator(self: *Self, params: list_assessments.ListAssessmentsInput) paginator.ListAssessmentsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listControlDomainInsightsPaginator(self: *Self, params: list_control_domain_insights.ListControlDomainInsightsInput) paginator.ListControlDomainInsightsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listControlDomainInsightsByAssessmentPaginator(self: *Self, params: list_control_domain_insights_by_assessment.ListControlDomainInsightsByAssessmentInput) paginator.ListControlDomainInsightsByAssessmentPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listControlInsightsByControlDomainPaginator(self: *Self, params: list_control_insights_by_control_domain.ListControlInsightsByControlDomainInput) paginator.ListControlInsightsByControlDomainPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listControlsPaginator(self: *Self, params: list_controls.ListControlsInput) paginator.ListControlsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listKeywordsForDataSourcePaginator(self: *Self, params: list_keywords_for_data_source.ListKeywordsForDataSourceInput) paginator.ListKeywordsForDataSourcePaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listNotificationsPaginator(self: *Self, params: list_notifications.ListNotificationsInput) paginator.ListNotificationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};
