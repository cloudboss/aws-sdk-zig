const aws = @import("aws");
const std = @import("std");

const associate_backup_vault_mpa_approval_team = @import("associate_backup_vault_mpa_approval_team.zig");
const cancel_legal_hold = @import("cancel_legal_hold.zig");
const create_backup_plan = @import("create_backup_plan.zig");
const create_backup_selection = @import("create_backup_selection.zig");
const create_backup_vault = @import("create_backup_vault.zig");
const create_framework = @import("create_framework.zig");
const create_legal_hold = @import("create_legal_hold.zig");
const create_logically_air_gapped_backup_vault = @import("create_logically_air_gapped_backup_vault.zig");
const create_report_plan = @import("create_report_plan.zig");
const create_restore_access_backup_vault = @import("create_restore_access_backup_vault.zig");
const create_restore_testing_plan = @import("create_restore_testing_plan.zig");
const create_restore_testing_selection = @import("create_restore_testing_selection.zig");
const create_tiering_configuration = @import("create_tiering_configuration.zig");
const delete_backup_plan = @import("delete_backup_plan.zig");
const delete_backup_selection = @import("delete_backup_selection.zig");
const delete_backup_vault = @import("delete_backup_vault.zig");
const delete_backup_vault_access_policy = @import("delete_backup_vault_access_policy.zig");
const delete_backup_vault_lock_configuration = @import("delete_backup_vault_lock_configuration.zig");
const delete_backup_vault_notifications = @import("delete_backup_vault_notifications.zig");
const delete_framework = @import("delete_framework.zig");
const delete_recovery_point = @import("delete_recovery_point.zig");
const delete_report_plan = @import("delete_report_plan.zig");
const delete_restore_testing_plan = @import("delete_restore_testing_plan.zig");
const delete_restore_testing_selection = @import("delete_restore_testing_selection.zig");
const delete_tiering_configuration = @import("delete_tiering_configuration.zig");
const describe_backup_job = @import("describe_backup_job.zig");
const describe_backup_vault = @import("describe_backup_vault.zig");
const describe_copy_job = @import("describe_copy_job.zig");
const describe_framework = @import("describe_framework.zig");
const describe_global_settings = @import("describe_global_settings.zig");
const describe_protected_resource = @import("describe_protected_resource.zig");
const describe_recovery_point = @import("describe_recovery_point.zig");
const describe_region_settings = @import("describe_region_settings.zig");
const describe_report_job = @import("describe_report_job.zig");
const describe_report_plan = @import("describe_report_plan.zig");
const describe_restore_job = @import("describe_restore_job.zig");
const describe_scan_job = @import("describe_scan_job.zig");
const disassociate_backup_vault_mpa_approval_team = @import("disassociate_backup_vault_mpa_approval_team.zig");
const disassociate_recovery_point = @import("disassociate_recovery_point.zig");
const disassociate_recovery_point_from_parent = @import("disassociate_recovery_point_from_parent.zig");
const export_backup_plan_template = @import("export_backup_plan_template.zig");
const get_backup_plan = @import("get_backup_plan.zig");
const get_backup_plan_from_json = @import("get_backup_plan_from_json.zig");
const get_backup_plan_from_template = @import("get_backup_plan_from_template.zig");
const get_backup_selection = @import("get_backup_selection.zig");
const get_backup_vault_access_policy = @import("get_backup_vault_access_policy.zig");
const get_backup_vault_notifications = @import("get_backup_vault_notifications.zig");
const get_legal_hold = @import("get_legal_hold.zig");
const get_recovery_point_index_details = @import("get_recovery_point_index_details.zig");
const get_recovery_point_restore_metadata = @import("get_recovery_point_restore_metadata.zig");
const get_restore_job_metadata = @import("get_restore_job_metadata.zig");
const get_restore_testing_inferred_metadata = @import("get_restore_testing_inferred_metadata.zig");
const get_restore_testing_plan = @import("get_restore_testing_plan.zig");
const get_restore_testing_selection = @import("get_restore_testing_selection.zig");
const get_supported_resource_types = @import("get_supported_resource_types.zig");
const get_tiering_configuration = @import("get_tiering_configuration.zig");
const list_backup_job_summaries = @import("list_backup_job_summaries.zig");
const list_backup_jobs = @import("list_backup_jobs.zig");
const list_backup_plan_templates = @import("list_backup_plan_templates.zig");
const list_backup_plan_versions = @import("list_backup_plan_versions.zig");
const list_backup_plans = @import("list_backup_plans.zig");
const list_backup_selections = @import("list_backup_selections.zig");
const list_backup_vaults = @import("list_backup_vaults.zig");
const list_copy_job_summaries = @import("list_copy_job_summaries.zig");
const list_copy_jobs = @import("list_copy_jobs.zig");
const list_frameworks = @import("list_frameworks.zig");
const list_indexed_recovery_points = @import("list_indexed_recovery_points.zig");
const list_legal_holds = @import("list_legal_holds.zig");
const list_protected_resources = @import("list_protected_resources.zig");
const list_protected_resources_by_backup_vault = @import("list_protected_resources_by_backup_vault.zig");
const list_recovery_points_by_backup_vault = @import("list_recovery_points_by_backup_vault.zig");
const list_recovery_points_by_legal_hold = @import("list_recovery_points_by_legal_hold.zig");
const list_recovery_points_by_resource = @import("list_recovery_points_by_resource.zig");
const list_report_jobs = @import("list_report_jobs.zig");
const list_report_plans = @import("list_report_plans.zig");
const list_restore_access_backup_vaults = @import("list_restore_access_backup_vaults.zig");
const list_restore_job_summaries = @import("list_restore_job_summaries.zig");
const list_restore_jobs = @import("list_restore_jobs.zig");
const list_restore_jobs_by_protected_resource = @import("list_restore_jobs_by_protected_resource.zig");
const list_restore_testing_plans = @import("list_restore_testing_plans.zig");
const list_restore_testing_selections = @import("list_restore_testing_selections.zig");
const list_scan_job_summaries = @import("list_scan_job_summaries.zig");
const list_scan_jobs = @import("list_scan_jobs.zig");
const list_tags = @import("list_tags.zig");
const list_tiering_configurations = @import("list_tiering_configurations.zig");
const put_backup_vault_access_policy = @import("put_backup_vault_access_policy.zig");
const put_backup_vault_lock_configuration = @import("put_backup_vault_lock_configuration.zig");
const put_backup_vault_notifications = @import("put_backup_vault_notifications.zig");
const put_restore_validation_result = @import("put_restore_validation_result.zig");
const revoke_restore_access_backup_vault = @import("revoke_restore_access_backup_vault.zig");
const start_backup_job = @import("start_backup_job.zig");
const start_copy_job = @import("start_copy_job.zig");
const start_report_job = @import("start_report_job.zig");
const start_restore_job = @import("start_restore_job.zig");
const start_scan_job = @import("start_scan_job.zig");
const stop_backup_job = @import("stop_backup_job.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_backup_plan = @import("update_backup_plan.zig");
const update_framework = @import("update_framework.zig");
const update_global_settings = @import("update_global_settings.zig");
const update_recovery_point_index_settings = @import("update_recovery_point_index_settings.zig");
const update_recovery_point_lifecycle = @import("update_recovery_point_lifecycle.zig");
const update_region_settings = @import("update_region_settings.zig");
const update_report_plan = @import("update_report_plan.zig");
const update_restore_testing_plan = @import("update_restore_testing_plan.zig");
const update_restore_testing_selection = @import("update_restore_testing_selection.zig");
const update_tiering_configuration = @import("update_tiering_configuration.zig");
const CallOptions = @import("call_options.zig").CallOptions;
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "Backup";

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

    /// Associates an MPA approval team with a backup vault.
    pub fn associateBackupVaultMpaApprovalTeam(self: *Self, allocator: std.mem.Allocator, input: associate_backup_vault_mpa_approval_team.AssociateBackupVaultMpaApprovalTeamInput, options: CallOptions) !associate_backup_vault_mpa_approval_team.AssociateBackupVaultMpaApprovalTeamOutput {
        return associate_backup_vault_mpa_approval_team.execute(self, allocator, input, options);
    }

    /// Removes the specified legal hold on a recovery point. This action can only
    /// be performed
    /// by a user with sufficient permissions.
    pub fn cancelLegalHold(self: *Self, allocator: std.mem.Allocator, input: cancel_legal_hold.CancelLegalHoldInput, options: CallOptions) !cancel_legal_hold.CancelLegalHoldOutput {
        return cancel_legal_hold.execute(self, allocator, input, options);
    }

    /// Creates a backup plan using a backup plan name and backup rules. A backup
    /// plan is a
    /// document that contains information that Backup uses to schedule tasks that
    /// create recovery points for resources.
    ///
    /// If you call `CreateBackupPlan` with a plan that already exists, you receive
    /// an `AlreadyExistsException` exception.
    pub fn createBackupPlan(self: *Self, allocator: std.mem.Allocator, input: create_backup_plan.CreateBackupPlanInput, options: CallOptions) !create_backup_plan.CreateBackupPlanOutput {
        return create_backup_plan.execute(self, allocator, input, options);
    }

    /// Creates a JSON document that specifies a set of resources to assign to a
    /// backup plan.
    /// For examples, see [Assigning resources
    /// programmatically](https://docs.aws.amazon.com/aws-backup/latest/devguide/assigning-resources.html#assigning-resources-json).
    pub fn createBackupSelection(self: *Self, allocator: std.mem.Allocator, input: create_backup_selection.CreateBackupSelectionInput, options: CallOptions) !create_backup_selection.CreateBackupSelectionOutput {
        return create_backup_selection.execute(self, allocator, input, options);
    }

    /// Creates a logical container where backups are stored. A `CreateBackupVault`
    /// request includes a name, optionally one or more resource tags, an encryption
    /// key, and a
    /// request ID.
    ///
    /// Do not include sensitive data, such as passport numbers, in the name of a
    /// backup
    /// vault.
    pub fn createBackupVault(self: *Self, allocator: std.mem.Allocator, input: create_backup_vault.CreateBackupVaultInput, options: CallOptions) !create_backup_vault.CreateBackupVaultOutput {
        return create_backup_vault.execute(self, allocator, input, options);
    }

    /// Creates a framework with one or more controls. A framework is a collection
    /// of controls
    /// that you can use to evaluate your backup practices. By using pre-built
    /// customizable
    /// controls to define your policies, you can evaluate whether your backup
    /// practices comply
    /// with your policies and which resources are not yet in compliance.
    pub fn createFramework(self: *Self, allocator: std.mem.Allocator, input: create_framework.CreateFrameworkInput, options: CallOptions) !create_framework.CreateFrameworkOutput {
        return create_framework.execute(self, allocator, input, options);
    }

    /// Creates a legal hold on a recovery point (backup). A legal hold is a
    /// restraint on
    /// altering or deleting a backup until an authorized user cancels the legal
    /// hold. Any actions
    /// to delete or disassociate a recovery point will fail with an error if one or
    /// more active
    /// legal holds are on the recovery point.
    pub fn createLegalHold(self: *Self, allocator: std.mem.Allocator, input: create_legal_hold.CreateLegalHoldInput, options: CallOptions) !create_legal_hold.CreateLegalHoldOutput {
        return create_legal_hold.execute(self, allocator, input, options);
    }

    /// Creates a logical container to where backups may be copied.
    ///
    /// This request includes a name, the Region, the maximum number of retention
    /// days, the
    /// minimum number of retention days, and optionally can include tags and a
    /// creator request
    /// ID.
    ///
    /// Do not include sensitive data, such as passport numbers, in the name of a
    /// backup
    /// vault.
    pub fn createLogicallyAirGappedBackupVault(self: *Self, allocator: std.mem.Allocator, input: create_logically_air_gapped_backup_vault.CreateLogicallyAirGappedBackupVaultInput, options: CallOptions) !create_logically_air_gapped_backup_vault.CreateLogicallyAirGappedBackupVaultOutput {
        return create_logically_air_gapped_backup_vault.execute(self, allocator, input, options);
    }

    /// Creates a report plan. A report plan is a document that contains information
    /// about the
    /// contents of the report and where Backup will deliver it.
    ///
    /// If you call `CreateReportPlan` with a plan that already exists, you receive
    /// an `AlreadyExistsException` exception.
    pub fn createReportPlan(self: *Self, allocator: std.mem.Allocator, input: create_report_plan.CreateReportPlanInput, options: CallOptions) !create_report_plan.CreateReportPlanOutput {
        return create_report_plan.execute(self, allocator, input, options);
    }

    /// Creates a restore access backup vault that provides temporary access to
    /// recovery points in a logically air-gapped backup vault, subject to MPA
    /// approval.
    pub fn createRestoreAccessBackupVault(self: *Self, allocator: std.mem.Allocator, input: create_restore_access_backup_vault.CreateRestoreAccessBackupVaultInput, options: CallOptions) !create_restore_access_backup_vault.CreateRestoreAccessBackupVaultOutput {
        return create_restore_access_backup_vault.execute(self, allocator, input, options);
    }

    /// Creates a restore testing plan.
    ///
    /// The first of two steps to create a restore testing
    /// plan. After this request is successful, finish the procedure using
    /// CreateRestoreTestingSelection.
    pub fn createRestoreTestingPlan(self: *Self, allocator: std.mem.Allocator, input: create_restore_testing_plan.CreateRestoreTestingPlanInput, options: CallOptions) !create_restore_testing_plan.CreateRestoreTestingPlanOutput {
        return create_restore_testing_plan.execute(self, allocator, input, options);
    }

    /// This request can be sent after CreateRestoreTestingPlan request
    /// returns successfully. This is the second part of creating a resource testing
    /// plan, and it must be completed sequentially.
    ///
    /// This consists of `RestoreTestingSelectionName`,
    /// `ProtectedResourceType`, and one of the following:
    ///
    /// * `ProtectedResourceArns`
    ///
    /// * `ProtectedResourceConditions`
    ///
    /// Each protected resource type can have one single value.
    ///
    /// A restore testing selection can include a wildcard value ("*") for
    /// `ProtectedResourceArns` along with `ProtectedResourceConditions`.
    /// Alternatively, you can include up to 30 specific protected resource ARNs in
    /// `ProtectedResourceArns`.
    ///
    /// Cannot select by both protected resource types AND specific ARNs.
    /// Request will fail if both are included.
    pub fn createRestoreTestingSelection(self: *Self, allocator: std.mem.Allocator, input: create_restore_testing_selection.CreateRestoreTestingSelectionInput, options: CallOptions) !create_restore_testing_selection.CreateRestoreTestingSelectionOutput {
        return create_restore_testing_selection.execute(self, allocator, input, options);
    }

    /// Creates a tiering configuration.
    ///
    /// A tiering configuration enables automatic movement of backup data to a
    /// lower-cost storage tier based on the age of backed-up objects in the backup
    /// vault.
    ///
    /// Each vault can only have one vault-specific tiering configuration, in
    /// addition to any global configuration that applies to all vaults.
    pub fn createTieringConfiguration(self: *Self, allocator: std.mem.Allocator, input: create_tiering_configuration.CreateTieringConfigurationInput, options: CallOptions) !create_tiering_configuration.CreateTieringConfigurationOutput {
        return create_tiering_configuration.execute(self, allocator, input, options);
    }

    /// Deletes a backup plan. A backup plan can only be deleted after all
    /// associated selections
    /// of resources have been deleted. Deleting a backup plan deletes the current
    /// version of a
    /// backup plan. Previous versions, if any, will still exist.
    pub fn deleteBackupPlan(self: *Self, allocator: std.mem.Allocator, input: delete_backup_plan.DeleteBackupPlanInput, options: CallOptions) !delete_backup_plan.DeleteBackupPlanOutput {
        return delete_backup_plan.execute(self, allocator, input, options);
    }

    /// Deletes the resource selection associated with a backup plan that is
    /// specified by the
    /// `SelectionId`.
    pub fn deleteBackupSelection(self: *Self, allocator: std.mem.Allocator, input: delete_backup_selection.DeleteBackupSelectionInput, options: CallOptions) !delete_backup_selection.DeleteBackupSelectionOutput {
        return delete_backup_selection.execute(self, allocator, input, options);
    }

    /// Deletes the backup vault identified by its name. A vault can be deleted only
    /// if it is
    /// empty.
    pub fn deleteBackupVault(self: *Self, allocator: std.mem.Allocator, input: delete_backup_vault.DeleteBackupVaultInput, options: CallOptions) !delete_backup_vault.DeleteBackupVaultOutput {
        return delete_backup_vault.execute(self, allocator, input, options);
    }

    /// Deletes the policy document that manages permissions on a backup vault.
    pub fn deleteBackupVaultAccessPolicy(self: *Self, allocator: std.mem.Allocator, input: delete_backup_vault_access_policy.DeleteBackupVaultAccessPolicyInput, options: CallOptions) !delete_backup_vault_access_policy.DeleteBackupVaultAccessPolicyOutput {
        return delete_backup_vault_access_policy.execute(self, allocator, input, options);
    }

    /// Deletes Backup Vault Lock from a backup vault specified by a backup vault
    /// name.
    ///
    /// If the Vault Lock configuration is immutable, then you cannot delete Vault
    /// Lock using
    /// API operations, and you will receive an `InvalidRequestException` if you
    /// attempt
    /// to do so. For more information, see [Vault
    /// Lock](https://docs.aws.amazon.com/aws-backup/latest/devguide/vault-lock.html) in the
    /// *Backup Developer Guide*.
    pub fn deleteBackupVaultLockConfiguration(self: *Self, allocator: std.mem.Allocator, input: delete_backup_vault_lock_configuration.DeleteBackupVaultLockConfigurationInput, options: CallOptions) !delete_backup_vault_lock_configuration.DeleteBackupVaultLockConfigurationOutput {
        return delete_backup_vault_lock_configuration.execute(self, allocator, input, options);
    }

    /// Deletes event notifications for the specified backup vault.
    pub fn deleteBackupVaultNotifications(self: *Self, allocator: std.mem.Allocator, input: delete_backup_vault_notifications.DeleteBackupVaultNotificationsInput, options: CallOptions) !delete_backup_vault_notifications.DeleteBackupVaultNotificationsOutput {
        return delete_backup_vault_notifications.execute(self, allocator, input, options);
    }

    /// Deletes the framework specified by a framework name.
    pub fn deleteFramework(self: *Self, allocator: std.mem.Allocator, input: delete_framework.DeleteFrameworkInput, options: CallOptions) !delete_framework.DeleteFrameworkOutput {
        return delete_framework.execute(self, allocator, input, options);
    }

    /// Deletes the recovery point specified by a recovery point ID.
    ///
    /// If the recovery point ID belongs to a continuous backup, calling this
    /// endpoint deletes
    /// the existing continuous backup and stops future continuous backup.
    ///
    /// When an IAM role's permissions are insufficient to call this API, the
    /// service sends back
    /// an HTTP 200 response with an empty HTTP body, but the recovery point is not
    /// deleted.
    /// Instead, it enters an `EXPIRED` state.
    ///
    /// `EXPIRED` recovery points can be deleted with this API once the IAM role
    /// has the `iam:CreateServiceLinkedRole` action. To learn more about adding
    /// this role, see
    /// [
    /// Troubleshooting manual
    /// deletions](https://docs.aws.amazon.com/aws-backup/latest/devguide/deleting-backups.html#deleting-backups-troubleshooting).
    ///
    /// If the user or role is deleted or the permission within the role is removed,
    /// the deletion will not be successful and will enter an `EXPIRED` state.
    pub fn deleteRecoveryPoint(self: *Self, allocator: std.mem.Allocator, input: delete_recovery_point.DeleteRecoveryPointInput, options: CallOptions) !delete_recovery_point.DeleteRecoveryPointOutput {
        return delete_recovery_point.execute(self, allocator, input, options);
    }

    /// Deletes the report plan specified by a report plan name.
    pub fn deleteReportPlan(self: *Self, allocator: std.mem.Allocator, input: delete_report_plan.DeleteReportPlanInput, options: CallOptions) !delete_report_plan.DeleteReportPlanOutput {
        return delete_report_plan.execute(self, allocator, input, options);
    }

    /// This request deletes the specified restore testing plan.
    ///
    /// Deletion can only successfully occur if all associated
    /// restore testing selections are deleted first.
    pub fn deleteRestoreTestingPlan(self: *Self, allocator: std.mem.Allocator, input: delete_restore_testing_plan.DeleteRestoreTestingPlanInput, options: CallOptions) !delete_restore_testing_plan.DeleteRestoreTestingPlanOutput {
        return delete_restore_testing_plan.execute(self, allocator, input, options);
    }

    /// Input the Restore Testing Plan name and Restore Testing Selection
    /// name.
    ///
    /// All testing selections associated with a restore testing plan must
    /// be deleted before the restore testing plan can be deleted.
    pub fn deleteRestoreTestingSelection(self: *Self, allocator: std.mem.Allocator, input: delete_restore_testing_selection.DeleteRestoreTestingSelectionInput, options: CallOptions) !delete_restore_testing_selection.DeleteRestoreTestingSelectionOutput {
        return delete_restore_testing_selection.execute(self, allocator, input, options);
    }

    /// Deletes the tiering configuration specified by a tiering configuration name.
    pub fn deleteTieringConfiguration(self: *Self, allocator: std.mem.Allocator, input: delete_tiering_configuration.DeleteTieringConfigurationInput, options: CallOptions) !delete_tiering_configuration.DeleteTieringConfigurationOutput {
        return delete_tiering_configuration.execute(self, allocator, input, options);
    }

    /// Returns backup job details for the specified `BackupJobId`.
    pub fn describeBackupJob(self: *Self, allocator: std.mem.Allocator, input: describe_backup_job.DescribeBackupJobInput, options: CallOptions) !describe_backup_job.DescribeBackupJobOutput {
        return describe_backup_job.execute(self, allocator, input, options);
    }

    /// Returns metadata about a backup vault specified by its name.
    pub fn describeBackupVault(self: *Self, allocator: std.mem.Allocator, input: describe_backup_vault.DescribeBackupVaultInput, options: CallOptions) !describe_backup_vault.DescribeBackupVaultOutput {
        return describe_backup_vault.execute(self, allocator, input, options);
    }

    /// Returns metadata associated with creating a copy of a resource.
    pub fn describeCopyJob(self: *Self, allocator: std.mem.Allocator, input: describe_copy_job.DescribeCopyJobInput, options: CallOptions) !describe_copy_job.DescribeCopyJobOutput {
        return describe_copy_job.execute(self, allocator, input, options);
    }

    /// Returns the framework details for the specified `FrameworkName`.
    pub fn describeFramework(self: *Self, allocator: std.mem.Allocator, input: describe_framework.DescribeFrameworkInput, options: CallOptions) !describe_framework.DescribeFrameworkOutput {
        return describe_framework.execute(self, allocator, input, options);
    }

    /// Describes whether the Amazon Web Services account is opted in to
    /// cross-account backup.
    /// Returns an error if the account is not a member of an Organizations
    /// organization.
    /// Example: `describe-global-settings --region us-west-2`
    pub fn describeGlobalSettings(self: *Self, allocator: std.mem.Allocator, input: describe_global_settings.DescribeGlobalSettingsInput, options: CallOptions) !describe_global_settings.DescribeGlobalSettingsOutput {
        return describe_global_settings.execute(self, allocator, input, options);
    }

    /// Returns information about a saved resource, including the last time it was
    /// backed up,
    /// its Amazon Resource Name (ARN), and the Amazon Web Services service type of
    /// the saved
    /// resource.
    pub fn describeProtectedResource(self: *Self, allocator: std.mem.Allocator, input: describe_protected_resource.DescribeProtectedResourceInput, options: CallOptions) !describe_protected_resource.DescribeProtectedResourceOutput {
        return describe_protected_resource.execute(self, allocator, input, options);
    }

    /// Returns metadata associated with a recovery point, including ID, status,
    /// encryption, and
    /// lifecycle.
    pub fn describeRecoveryPoint(self: *Self, allocator: std.mem.Allocator, input: describe_recovery_point.DescribeRecoveryPointInput, options: CallOptions) !describe_recovery_point.DescribeRecoveryPointOutput {
        return describe_recovery_point.execute(self, allocator, input, options);
    }

    /// Returns the current service opt-in settings for the Region. If service
    /// opt-in is enabled
    /// for a service, Backup tries to protect that service's resources in this
    /// Region,
    /// when the resource is included in an on-demand backup or scheduled backup
    /// plan. Otherwise,
    /// Backup does not try to protect that service's resources in this
    /// Region.
    pub fn describeRegionSettings(self: *Self, allocator: std.mem.Allocator, input: describe_region_settings.DescribeRegionSettingsInput, options: CallOptions) !describe_region_settings.DescribeRegionSettingsOutput {
        return describe_region_settings.execute(self, allocator, input, options);
    }

    /// Returns the details associated with creating a report as specified by its
    /// `ReportJobId`.
    pub fn describeReportJob(self: *Self, allocator: std.mem.Allocator, input: describe_report_job.DescribeReportJobInput, options: CallOptions) !describe_report_job.DescribeReportJobOutput {
        return describe_report_job.execute(self, allocator, input, options);
    }

    /// Returns a list of all report plans for an Amazon Web Services account and
    /// Amazon Web Services Region.
    pub fn describeReportPlan(self: *Self, allocator: std.mem.Allocator, input: describe_report_plan.DescribeReportPlanInput, options: CallOptions) !describe_report_plan.DescribeReportPlanOutput {
        return describe_report_plan.execute(self, allocator, input, options);
    }

    /// Returns metadata associated with a restore job that is specified by a job
    /// ID.
    pub fn describeRestoreJob(self: *Self, allocator: std.mem.Allocator, input: describe_restore_job.DescribeRestoreJobInput, options: CallOptions) !describe_restore_job.DescribeRestoreJobOutput {
        return describe_restore_job.execute(self, allocator, input, options);
    }

    /// Returns scan job details for the specified ScanJobID.
    pub fn describeScanJob(self: *Self, allocator: std.mem.Allocator, input: describe_scan_job.DescribeScanJobInput, options: CallOptions) !describe_scan_job.DescribeScanJobOutput {
        return describe_scan_job.execute(self, allocator, input, options);
    }

    /// Removes the association between an MPA approval team and a backup vault,
    /// disabling the MPA approval workflow for restore operations.
    pub fn disassociateBackupVaultMpaApprovalTeam(self: *Self, allocator: std.mem.Allocator, input: disassociate_backup_vault_mpa_approval_team.DisassociateBackupVaultMpaApprovalTeamInput, options: CallOptions) !disassociate_backup_vault_mpa_approval_team.DisassociateBackupVaultMpaApprovalTeamOutput {
        return disassociate_backup_vault_mpa_approval_team.execute(self, allocator, input, options);
    }

    /// Deletes the specified continuous backup recovery point from Backup and
    /// releases control of that continuous backup to the source service, such as
    /// Amazon RDS. The source service will continue to create and retain continuous
    /// backups using the
    /// lifecycle that you specified in your original backup plan.
    ///
    /// Does not support snapshot backup recovery points.
    pub fn disassociateRecoveryPoint(self: *Self, allocator: std.mem.Allocator, input: disassociate_recovery_point.DisassociateRecoveryPointInput, options: CallOptions) !disassociate_recovery_point.DisassociateRecoveryPointOutput {
        return disassociate_recovery_point.execute(self, allocator, input, options);
    }

    /// This action to a specific child (nested) recovery point removes the
    /// relationship
    /// between the specified recovery point and its parent (composite) recovery
    /// point.
    pub fn disassociateRecoveryPointFromParent(self: *Self, allocator: std.mem.Allocator, input: disassociate_recovery_point_from_parent.DisassociateRecoveryPointFromParentInput, options: CallOptions) !disassociate_recovery_point_from_parent.DisassociateRecoveryPointFromParentOutput {
        return disassociate_recovery_point_from_parent.execute(self, allocator, input, options);
    }

    /// Returns the backup plan that is specified by the plan ID as a backup
    /// template.
    pub fn exportBackupPlanTemplate(self: *Self, allocator: std.mem.Allocator, input: export_backup_plan_template.ExportBackupPlanTemplateInput, options: CallOptions) !export_backup_plan_template.ExportBackupPlanTemplateOutput {
        return export_backup_plan_template.execute(self, allocator, input, options);
    }

    /// Returns `BackupPlan` details for the specified `BackupPlanId`. The
    /// details are the body of a backup plan in JSON format, in addition to plan
    /// metadata.
    pub fn getBackupPlan(self: *Self, allocator: std.mem.Allocator, input: get_backup_plan.GetBackupPlanInput, options: CallOptions) !get_backup_plan.GetBackupPlanOutput {
        return get_backup_plan.execute(self, allocator, input, options);
    }

    /// Returns a valid JSON document specifying a backup plan or an error.
    pub fn getBackupPlanFromJson(self: *Self, allocator: std.mem.Allocator, input: get_backup_plan_from_json.GetBackupPlanFromJSONInput, options: CallOptions) !get_backup_plan_from_json.GetBackupPlanFromJSONOutput {
        return get_backup_plan_from_json.execute(self, allocator, input, options);
    }

    /// Returns the template specified by its `templateId` as a backup plan.
    pub fn getBackupPlanFromTemplate(self: *Self, allocator: std.mem.Allocator, input: get_backup_plan_from_template.GetBackupPlanFromTemplateInput, options: CallOptions) !get_backup_plan_from_template.GetBackupPlanFromTemplateOutput {
        return get_backup_plan_from_template.execute(self, allocator, input, options);
    }

    /// Returns selection metadata and a document in JSON format that specifies a
    /// list of
    /// resources that are associated with a backup plan.
    pub fn getBackupSelection(self: *Self, allocator: std.mem.Allocator, input: get_backup_selection.GetBackupSelectionInput, options: CallOptions) !get_backup_selection.GetBackupSelectionOutput {
        return get_backup_selection.execute(self, allocator, input, options);
    }

    /// Returns the access policy document that is associated with the named backup
    /// vault.
    pub fn getBackupVaultAccessPolicy(self: *Self, allocator: std.mem.Allocator, input: get_backup_vault_access_policy.GetBackupVaultAccessPolicyInput, options: CallOptions) !get_backup_vault_access_policy.GetBackupVaultAccessPolicyOutput {
        return get_backup_vault_access_policy.execute(self, allocator, input, options);
    }

    /// Returns event notifications for the specified backup vault.
    pub fn getBackupVaultNotifications(self: *Self, allocator: std.mem.Allocator, input: get_backup_vault_notifications.GetBackupVaultNotificationsInput, options: CallOptions) !get_backup_vault_notifications.GetBackupVaultNotificationsOutput {
        return get_backup_vault_notifications.execute(self, allocator, input, options);
    }

    /// This action returns details for a specified legal hold. The details are the
    /// body of a legal hold in JSON format, in addition to metadata.
    pub fn getLegalHold(self: *Self, allocator: std.mem.Allocator, input: get_legal_hold.GetLegalHoldInput, options: CallOptions) !get_legal_hold.GetLegalHoldOutput {
        return get_legal_hold.execute(self, allocator, input, options);
    }

    /// This operation returns the metadata and details specific to
    /// the backup index associated with the specified recovery point.
    pub fn getRecoveryPointIndexDetails(self: *Self, allocator: std.mem.Allocator, input: get_recovery_point_index_details.GetRecoveryPointIndexDetailsInput, options: CallOptions) !get_recovery_point_index_details.GetRecoveryPointIndexDetailsOutput {
        return get_recovery_point_index_details.execute(self, allocator, input, options);
    }

    /// Returns a set of metadata key-value pairs that were used to create the
    /// backup.
    pub fn getRecoveryPointRestoreMetadata(self: *Self, allocator: std.mem.Allocator, input: get_recovery_point_restore_metadata.GetRecoveryPointRestoreMetadataInput, options: CallOptions) !get_recovery_point_restore_metadata.GetRecoveryPointRestoreMetadataOutput {
        return get_recovery_point_restore_metadata.execute(self, allocator, input, options);
    }

    /// This request returns the metadata for the specified restore job.
    pub fn getRestoreJobMetadata(self: *Self, allocator: std.mem.Allocator, input: get_restore_job_metadata.GetRestoreJobMetadataInput, options: CallOptions) !get_restore_job_metadata.GetRestoreJobMetadataOutput {
        return get_restore_job_metadata.execute(self, allocator, input, options);
    }

    /// This request returns the minimal required set of metadata needed to
    /// start a restore job with secure default settings. `BackupVaultName`
    /// and `RecoveryPointArn` are required parameters.
    /// `BackupVaultAccountId` is an optional parameter.
    pub fn getRestoreTestingInferredMetadata(self: *Self, allocator: std.mem.Allocator, input: get_restore_testing_inferred_metadata.GetRestoreTestingInferredMetadataInput, options: CallOptions) !get_restore_testing_inferred_metadata.GetRestoreTestingInferredMetadataOutput {
        return get_restore_testing_inferred_metadata.execute(self, allocator, input, options);
    }

    /// Returns `RestoreTestingPlan` details for the specified
    /// `RestoreTestingPlanName`. The details are the body of a restore testing plan
    /// in JSON format, in addition to plan metadata.
    pub fn getRestoreTestingPlan(self: *Self, allocator: std.mem.Allocator, input: get_restore_testing_plan.GetRestoreTestingPlanInput, options: CallOptions) !get_restore_testing_plan.GetRestoreTestingPlanOutput {
        return get_restore_testing_plan.execute(self, allocator, input, options);
    }

    /// Returns RestoreTestingSelection, which displays resources
    /// and elements of the restore testing plan.
    pub fn getRestoreTestingSelection(self: *Self, allocator: std.mem.Allocator, input: get_restore_testing_selection.GetRestoreTestingSelectionInput, options: CallOptions) !get_restore_testing_selection.GetRestoreTestingSelectionOutput {
        return get_restore_testing_selection.execute(self, allocator, input, options);
    }

    /// Returns the Amazon Web Services resource types supported by Backup.
    pub fn getSupportedResourceTypes(self: *Self, allocator: std.mem.Allocator, input: get_supported_resource_types.GetSupportedResourceTypesInput, options: CallOptions) !get_supported_resource_types.GetSupportedResourceTypesOutput {
        return get_supported_resource_types.execute(self, allocator, input, options);
    }

    /// Returns `TieringConfiguration` details for the specified
    /// `TieringConfigurationName`. The details are the body of a tiering
    /// configuration
    /// in JSON format, in addition to configuration metadata.
    pub fn getTieringConfiguration(self: *Self, allocator: std.mem.Allocator, input: get_tiering_configuration.GetTieringConfigurationInput, options: CallOptions) !get_tiering_configuration.GetTieringConfigurationOutput {
        return get_tiering_configuration.execute(self, allocator, input, options);
    }

    /// This is a request for a summary of backup jobs created
    /// or running within the most recent 30 days. You can
    /// include parameters AccountID, State, ResourceType, MessageCategory,
    /// AggregationPeriod, MaxResults, or NextToken to filter
    /// results.
    ///
    /// This request returns a summary that contains
    /// Region, Account, State, ResourceType, MessageCategory,
    /// StartTime, EndTime, and Count of included jobs.
    pub fn listBackupJobSummaries(self: *Self, allocator: std.mem.Allocator, input: list_backup_job_summaries.ListBackupJobSummariesInput, options: CallOptions) !list_backup_job_summaries.ListBackupJobSummariesOutput {
        return list_backup_job_summaries.execute(self, allocator, input, options);
    }

    /// Returns a list of existing backup jobs for an authenticated account for the
    /// last 30
    /// days. For a longer period of time, consider using these [monitoring
    /// tools](https://docs.aws.amazon.com/aws-backup/latest/devguide/monitoring.html).
    pub fn listBackupJobs(self: *Self, allocator: std.mem.Allocator, input: list_backup_jobs.ListBackupJobsInput, options: CallOptions) !list_backup_jobs.ListBackupJobsOutput {
        return list_backup_jobs.execute(self, allocator, input, options);
    }

    /// Lists the backup plan templates.
    pub fn listBackupPlanTemplates(self: *Self, allocator: std.mem.Allocator, input: list_backup_plan_templates.ListBackupPlanTemplatesInput, options: CallOptions) !list_backup_plan_templates.ListBackupPlanTemplatesOutput {
        return list_backup_plan_templates.execute(self, allocator, input, options);
    }

    /// Returns version metadata of your backup plans, including Amazon Resource
    /// Names (ARNs),
    /// backup plan IDs, creation and deletion dates, plan names, and version IDs.
    pub fn listBackupPlanVersions(self: *Self, allocator: std.mem.Allocator, input: list_backup_plan_versions.ListBackupPlanVersionsInput, options: CallOptions) !list_backup_plan_versions.ListBackupPlanVersionsOutput {
        return list_backup_plan_versions.execute(self, allocator, input, options);
    }

    /// Lists the active backup plans for the account.
    pub fn listBackupPlans(self: *Self, allocator: std.mem.Allocator, input: list_backup_plans.ListBackupPlansInput, options: CallOptions) !list_backup_plans.ListBackupPlansOutput {
        return list_backup_plans.execute(self, allocator, input, options);
    }

    /// Returns an array containing metadata of the resources associated with the
    /// target backup
    /// plan.
    pub fn listBackupSelections(self: *Self, allocator: std.mem.Allocator, input: list_backup_selections.ListBackupSelectionsInput, options: CallOptions) !list_backup_selections.ListBackupSelectionsOutput {
        return list_backup_selections.execute(self, allocator, input, options);
    }

    /// Returns a list of recovery point storage containers along with information
    /// about
    /// them.
    pub fn listBackupVaults(self: *Self, allocator: std.mem.Allocator, input: list_backup_vaults.ListBackupVaultsInput, options: CallOptions) !list_backup_vaults.ListBackupVaultsOutput {
        return list_backup_vaults.execute(self, allocator, input, options);
    }

    /// This request obtains a list of copy jobs created
    /// or running within the the most recent 30 days. You can
    /// include parameters AccountID, State, ResourceType, MessageCategory,
    /// AggregationPeriod, MaxResults, or NextToken to filter
    /// results.
    ///
    /// This request returns a summary that contains
    /// Region, Account, State, RestourceType, MessageCategory,
    /// StartTime, EndTime, and Count of included jobs.
    pub fn listCopyJobSummaries(self: *Self, allocator: std.mem.Allocator, input: list_copy_job_summaries.ListCopyJobSummariesInput, options: CallOptions) !list_copy_job_summaries.ListCopyJobSummariesOutput {
        return list_copy_job_summaries.execute(self, allocator, input, options);
    }

    /// Returns metadata about your copy jobs.
    pub fn listCopyJobs(self: *Self, allocator: std.mem.Allocator, input: list_copy_jobs.ListCopyJobsInput, options: CallOptions) !list_copy_jobs.ListCopyJobsOutput {
        return list_copy_jobs.execute(self, allocator, input, options);
    }

    /// Returns a list of all frameworks for an Amazon Web Services account and
    /// Amazon Web Services Region.
    pub fn listFrameworks(self: *Self, allocator: std.mem.Allocator, input: list_frameworks.ListFrameworksInput, options: CallOptions) !list_frameworks.ListFrameworksOutput {
        return list_frameworks.execute(self, allocator, input, options);
    }

    /// This operation returns a list of recovery points that have an
    /// associated index, belonging to the specified account.
    ///
    /// Optional parameters you can include are: MaxResults;
    /// NextToken; SourceResourceArns; CreatedBefore; CreatedAfter;
    /// and ResourceType.
    pub fn listIndexedRecoveryPoints(self: *Self, allocator: std.mem.Allocator, input: list_indexed_recovery_points.ListIndexedRecoveryPointsInput, options: CallOptions) !list_indexed_recovery_points.ListIndexedRecoveryPointsOutput {
        return list_indexed_recovery_points.execute(self, allocator, input, options);
    }

    /// This action returns metadata about active and previous legal holds.
    pub fn listLegalHolds(self: *Self, allocator: std.mem.Allocator, input: list_legal_holds.ListLegalHoldsInput, options: CallOptions) !list_legal_holds.ListLegalHoldsOutput {
        return list_legal_holds.execute(self, allocator, input, options);
    }

    /// Returns an array of resources successfully backed up by Backup, including
    /// the time the resource was saved, an Amazon Resource Name (ARN) of the
    /// resource, and a
    /// resource type.
    pub fn listProtectedResources(self: *Self, allocator: std.mem.Allocator, input: list_protected_resources.ListProtectedResourcesInput, options: CallOptions) !list_protected_resources.ListProtectedResourcesOutput {
        return list_protected_resources.execute(self, allocator, input, options);
    }

    /// This request lists the protected resources corresponding to each backup
    /// vault.
    pub fn listProtectedResourcesByBackupVault(self: *Self, allocator: std.mem.Allocator, input: list_protected_resources_by_backup_vault.ListProtectedResourcesByBackupVaultInput, options: CallOptions) !list_protected_resources_by_backup_vault.ListProtectedResourcesByBackupVaultOutput {
        return list_protected_resources_by_backup_vault.execute(self, allocator, input, options);
    }

    /// Returns detailed information about the recovery points stored in a backup
    /// vault.
    pub fn listRecoveryPointsByBackupVault(self: *Self, allocator: std.mem.Allocator, input: list_recovery_points_by_backup_vault.ListRecoveryPointsByBackupVaultInput, options: CallOptions) !list_recovery_points_by_backup_vault.ListRecoveryPointsByBackupVaultOutput {
        return list_recovery_points_by_backup_vault.execute(self, allocator, input, options);
    }

    /// This action returns recovery point ARNs (Amazon Resource Names) of the
    /// specified legal hold.
    pub fn listRecoveryPointsByLegalHold(self: *Self, allocator: std.mem.Allocator, input: list_recovery_points_by_legal_hold.ListRecoveryPointsByLegalHoldInput, options: CallOptions) !list_recovery_points_by_legal_hold.ListRecoveryPointsByLegalHoldOutput {
        return list_recovery_points_by_legal_hold.execute(self, allocator, input, options);
    }

    /// The information about the recovery points of the type specified by a
    /// resource Amazon Resource Name (ARN).
    ///
    /// For Amazon EFS and Amazon EC2, this action only lists recovery points
    /// created by Backup.
    pub fn listRecoveryPointsByResource(self: *Self, allocator: std.mem.Allocator, input: list_recovery_points_by_resource.ListRecoveryPointsByResourceInput, options: CallOptions) !list_recovery_points_by_resource.ListRecoveryPointsByResourceOutput {
        return list_recovery_points_by_resource.execute(self, allocator, input, options);
    }

    /// Returns details about your report jobs.
    pub fn listReportJobs(self: *Self, allocator: std.mem.Allocator, input: list_report_jobs.ListReportJobsInput, options: CallOptions) !list_report_jobs.ListReportJobsOutput {
        return list_report_jobs.execute(self, allocator, input, options);
    }

    /// Returns a list of your report plans. For detailed information about a single
    /// report
    /// plan, use `DescribeReportPlan`.
    pub fn listReportPlans(self: *Self, allocator: std.mem.Allocator, input: list_report_plans.ListReportPlansInput, options: CallOptions) !list_report_plans.ListReportPlansOutput {
        return list_report_plans.execute(self, allocator, input, options);
    }

    /// Returns a list of restore access backup vaults associated with a specified
    /// backup vault.
    pub fn listRestoreAccessBackupVaults(self: *Self, allocator: std.mem.Allocator, input: list_restore_access_backup_vaults.ListRestoreAccessBackupVaultsInput, options: CallOptions) !list_restore_access_backup_vaults.ListRestoreAccessBackupVaultsOutput {
        return list_restore_access_backup_vaults.execute(self, allocator, input, options);
    }

    /// This request obtains a summary of restore jobs created
    /// or running within the the most recent 30 days. You can
    /// include parameters AccountID, State, ResourceType,
    /// AggregationPeriod, MaxResults, or NextToken to filter
    /// results.
    ///
    /// This request returns a summary that contains
    /// Region, Account, State, RestourceType, MessageCategory,
    /// StartTime, EndTime, and Count of included jobs.
    pub fn listRestoreJobSummaries(self: *Self, allocator: std.mem.Allocator, input: list_restore_job_summaries.ListRestoreJobSummariesInput, options: CallOptions) !list_restore_job_summaries.ListRestoreJobSummariesOutput {
        return list_restore_job_summaries.execute(self, allocator, input, options);
    }

    /// Returns a list of jobs that Backup initiated to restore a saved resource,
    /// including details about the recovery process.
    pub fn listRestoreJobs(self: *Self, allocator: std.mem.Allocator, input: list_restore_jobs.ListRestoreJobsInput, options: CallOptions) !list_restore_jobs.ListRestoreJobsOutput {
        return list_restore_jobs.execute(self, allocator, input, options);
    }

    /// This returns restore jobs that contain the specified protected resource.
    ///
    /// You must include `ResourceArn`. You can optionally include
    /// `NextToken`, `ByStatus`, `MaxResults`,
    /// `ByRecoveryPointCreationDateAfter` , and
    /// `ByRecoveryPointCreationDateBefore`.
    pub fn listRestoreJobsByProtectedResource(self: *Self, allocator: std.mem.Allocator, input: list_restore_jobs_by_protected_resource.ListRestoreJobsByProtectedResourceInput, options: CallOptions) !list_restore_jobs_by_protected_resource.ListRestoreJobsByProtectedResourceOutput {
        return list_restore_jobs_by_protected_resource.execute(self, allocator, input, options);
    }

    /// Returns a list of restore testing plans.
    pub fn listRestoreTestingPlans(self: *Self, allocator: std.mem.Allocator, input: list_restore_testing_plans.ListRestoreTestingPlansInput, options: CallOptions) !list_restore_testing_plans.ListRestoreTestingPlansOutput {
        return list_restore_testing_plans.execute(self, allocator, input, options);
    }

    /// Returns a list of restore testing selections. Can be filtered
    /// by `MaxResults` and `RestoreTestingPlanName`.
    pub fn listRestoreTestingSelections(self: *Self, allocator: std.mem.Allocator, input: list_restore_testing_selections.ListRestoreTestingSelectionsInput, options: CallOptions) !list_restore_testing_selections.ListRestoreTestingSelectionsOutput {
        return list_restore_testing_selections.execute(self, allocator, input, options);
    }

    /// This is a request for a summary of scan jobs created or running within the
    /// most recent 30 days.
    pub fn listScanJobSummaries(self: *Self, allocator: std.mem.Allocator, input: list_scan_job_summaries.ListScanJobSummariesInput, options: CallOptions) !list_scan_job_summaries.ListScanJobSummariesOutput {
        return list_scan_job_summaries.execute(self, allocator, input, options);
    }

    /// Returns a list of existing scan jobs for an authenticated account for the
    /// last 30 days.
    pub fn listScanJobs(self: *Self, allocator: std.mem.Allocator, input: list_scan_jobs.ListScanJobsInput, options: CallOptions) !list_scan_jobs.ListScanJobsOutput {
        return list_scan_jobs.execute(self, allocator, input, options);
    }

    /// Returns the tags assigned to the resource, such as a target recovery point,
    /// backup plan,
    /// or backup vault.
    ///
    /// This operation returns results depending on the resource type used in the
    /// value for
    /// `resourceArn`. For example, recovery points of Amazon DynamoDB with
    /// Advanced Settings have an ARN (Amazon Resource Name) that begins with
    /// `arn:aws:backup`. Recovery points (backups) of DynamoDB without
    /// Advanced Settings enabled have an ARN that begins with
    /// `arn:aws:dynamodb`.
    ///
    /// When this operation is called and when you include values of `resourceArn`
    /// that have an ARN other than `arn:aws:backup`, it may return one of the
    /// exceptions listed below. To prevent this exception, include only values
    /// representing
    /// resource types that are fully managed by Backup. These have an ARN that
    /// begins
    /// `arn:aws:backup` and they are noted in the [Feature availability by
    /// resource](https://docs.aws.amazon.com/aws-backup/latest/devguide/backup-feature-availability.html#features-by-resource) table.
    pub fn listTags(self: *Self, allocator: std.mem.Allocator, input: list_tags.ListTagsInput, options: CallOptions) !list_tags.ListTagsOutput {
        return list_tags.execute(self, allocator, input, options);
    }

    /// Returns a list of tiering configurations.
    pub fn listTieringConfigurations(self: *Self, allocator: std.mem.Allocator, input: list_tiering_configurations.ListTieringConfigurationsInput, options: CallOptions) !list_tiering_configurations.ListTieringConfigurationsOutput {
        return list_tiering_configurations.execute(self, allocator, input, options);
    }

    /// Sets a resource-based policy that is used to manage access permissions on
    /// the target
    /// backup vault. Requires a backup vault name and an access policy document in
    /// JSON
    /// format.
    pub fn putBackupVaultAccessPolicy(self: *Self, allocator: std.mem.Allocator, input: put_backup_vault_access_policy.PutBackupVaultAccessPolicyInput, options: CallOptions) !put_backup_vault_access_policy.PutBackupVaultAccessPolicyOutput {
        return put_backup_vault_access_policy.execute(self, allocator, input, options);
    }

    /// Applies Backup Vault Lock to a backup vault, preventing attempts to delete
    /// any recovery point stored in or created in a backup vault. Vault Lock also
    /// prevents
    /// attempts to update the lifecycle policy that controls the retention period
    /// of any recovery
    /// point currently stored in a backup vault. If specified, Vault Lock enforces
    /// a minimum and
    /// maximum retention period for future backup and copy jobs that target a
    /// backup vault.
    ///
    /// Backup Vault Lock has been assessed by Cohasset Associates for use in
    /// environments
    /// that are subject to SEC 17a-4, CFTC, and FINRA regulations. For more
    /// information about
    /// how Backup Vault Lock relates to these regulations, see the
    /// [Cohasset Associates
    /// Compliance
    /// Assessment.](https://docs.aws.amazon.com/aws-backup/latest/devguide/samples/cohassetreport.zip)
    ///
    /// For more information, see [Backup Vault
    /// Lock](https://docs.aws.amazon.com/aws-backup/latest/devguide/vault-lock.html).
    pub fn putBackupVaultLockConfiguration(self: *Self, allocator: std.mem.Allocator, input: put_backup_vault_lock_configuration.PutBackupVaultLockConfigurationInput, options: CallOptions) !put_backup_vault_lock_configuration.PutBackupVaultLockConfigurationOutput {
        return put_backup_vault_lock_configuration.execute(self, allocator, input, options);
    }

    /// Turns on notifications on a backup vault for the specified topic and events.
    pub fn putBackupVaultNotifications(self: *Self, allocator: std.mem.Allocator, input: put_backup_vault_notifications.PutBackupVaultNotificationsInput, options: CallOptions) !put_backup_vault_notifications.PutBackupVaultNotificationsOutput {
        return put_backup_vault_notifications.execute(self, allocator, input, options);
    }

    /// This request allows you to send your independent self-run
    /// restore test validation results.
    /// `RestoreJobId` and `ValidationStatus`
    /// are required. Optionally, you can input a
    /// `ValidationStatusMessage`.
    pub fn putRestoreValidationResult(self: *Self, allocator: std.mem.Allocator, input: put_restore_validation_result.PutRestoreValidationResultInput, options: CallOptions) !put_restore_validation_result.PutRestoreValidationResultOutput {
        return put_restore_validation_result.execute(self, allocator, input, options);
    }

    /// Revokes access to a restore access backup vault, removing the ability to
    /// restore from its recovery points and permanently deleting the vault.
    pub fn revokeRestoreAccessBackupVault(self: *Self, allocator: std.mem.Allocator, input: revoke_restore_access_backup_vault.RevokeRestoreAccessBackupVaultInput, options: CallOptions) !revoke_restore_access_backup_vault.RevokeRestoreAccessBackupVaultOutput {
        return revoke_restore_access_backup_vault.execute(self, allocator, input, options);
    }

    /// Starts an on-demand backup job for the specified resource.
    pub fn startBackupJob(self: *Self, allocator: std.mem.Allocator, input: start_backup_job.StartBackupJobInput, options: CallOptions) !start_backup_job.StartBackupJobOutput {
        return start_backup_job.execute(self, allocator, input, options);
    }

    /// Starts a job to create a one-time copy of the specified resource.
    ///
    /// Does not support continuous backups.
    ///
    /// See [Copy
    /// job
    /// retry](https://docs.aws.amazon.com/aws-backup/latest/devguide/recov-point-create-a-copy.html#backup-copy-retry) for information on how Backup retries copy job
    /// operations.
    pub fn startCopyJob(self: *Self, allocator: std.mem.Allocator, input: start_copy_job.StartCopyJobInput, options: CallOptions) !start_copy_job.StartCopyJobOutput {
        return start_copy_job.execute(self, allocator, input, options);
    }

    /// Starts an on-demand report job for the specified report plan.
    pub fn startReportJob(self: *Self, allocator: std.mem.Allocator, input: start_report_job.StartReportJobInput, options: CallOptions) !start_report_job.StartReportJobOutput {
        return start_report_job.execute(self, allocator, input, options);
    }

    /// Recovers the saved resource identified by an Amazon Resource Name (ARN).
    pub fn startRestoreJob(self: *Self, allocator: std.mem.Allocator, input: start_restore_job.StartRestoreJobInput, options: CallOptions) !start_restore_job.StartRestoreJobOutput {
        return start_restore_job.execute(self, allocator, input, options);
    }

    /// Starts scanning jobs for specific resources.
    pub fn startScanJob(self: *Self, allocator: std.mem.Allocator, input: start_scan_job.StartScanJobInput, options: CallOptions) !start_scan_job.StartScanJobOutput {
        return start_scan_job.execute(self, allocator, input, options);
    }

    /// Attempts to cancel a job to create a one-time backup of a resource.
    ///
    /// This action is not supported for the following services:
    ///
    /// * Amazon Aurora
    ///
    /// * Amazon DocumentDB (with MongoDB compatibility)
    ///
    /// * Amazon FSx for Lustre
    ///
    /// * Amazon FSx for NetApp ONTAP
    ///
    /// * Amazon FSx for OpenZFS
    ///
    /// * Amazon FSx for Windows File Server
    ///
    /// * Amazon Neptune
    ///
    /// * SAP HANA databases on Amazon EC2 instances
    ///
    /// * Amazon RDS
    pub fn stopBackupJob(self: *Self, allocator: std.mem.Allocator, input: stop_backup_job.StopBackupJobInput, options: CallOptions) !stop_backup_job.StopBackupJobOutput {
        return stop_backup_job.execute(self, allocator, input, options);
    }

    /// Assigns a set of key-value pairs to a resource.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: CallOptions) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Removes a set of key-value pairs from a recovery point, backup plan, or
    /// backup vault
    /// identified by an Amazon Resource Name (ARN)
    ///
    /// This API is not supported for recovery points for resource types
    /// including Aurora, Amazon DocumentDB. Amazon EBS,
    /// Amazon FSx, Neptune, and Amazon RDS.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: CallOptions) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Updates the specified backup plan. The new version is uniquely identified by
    /// its ID.
    pub fn updateBackupPlan(self: *Self, allocator: std.mem.Allocator, input: update_backup_plan.UpdateBackupPlanInput, options: CallOptions) !update_backup_plan.UpdateBackupPlanOutput {
        return update_backup_plan.execute(self, allocator, input, options);
    }

    /// Updates the specified framework.
    pub fn updateFramework(self: *Self, allocator: std.mem.Allocator, input: update_framework.UpdateFrameworkInput, options: CallOptions) !update_framework.UpdateFrameworkOutput {
        return update_framework.execute(self, allocator, input, options);
    }

    /// Updates whether the Amazon Web Services account is opted in to cross-account
    /// backup.
    /// Returns an error if the account is not an Organizations management account.
    /// Use the
    /// `DescribeGlobalSettings` API to determine the current settings.
    pub fn updateGlobalSettings(self: *Self, allocator: std.mem.Allocator, input: update_global_settings.UpdateGlobalSettingsInput, options: CallOptions) !update_global_settings.UpdateGlobalSettingsOutput {
        return update_global_settings.execute(self, allocator, input, options);
    }

    /// This operation updates the settings of a recovery point index.
    ///
    /// Required: BackupVaultName, RecoveryPointArn, and IAMRoleArn
    pub fn updateRecoveryPointIndexSettings(self: *Self, allocator: std.mem.Allocator, input: update_recovery_point_index_settings.UpdateRecoveryPointIndexSettingsInput, options: CallOptions) !update_recovery_point_index_settings.UpdateRecoveryPointIndexSettingsOutput {
        return update_recovery_point_index_settings.execute(self, allocator, input, options);
    }

    /// Sets the transition lifecycle of a recovery point.
    ///
    /// The lifecycle defines when a protected resource is transitioned to cold
    /// storage and when
    /// it expires. Backup transitions and expires backups automatically according
    /// to
    /// the lifecycle that you define.
    ///
    /// Resource types that can transition to cold storage are listed in the
    /// [Feature availability by
    /// resource](https://docs.aws.amazon.com/aws-backup/latest/devguide/backup-feature-availability.html#features-by-resource) table. Backup ignores this expression for
    /// other resource types.
    ///
    /// Backups transitioned to cold storage must be stored in cold storage for a
    /// minimum of 90
    /// days. Therefore, the “retention” setting must be 90 days greater than the
    /// “transition to
    /// cold after days” setting. The “transition to cold after days” setting cannot
    /// be changed
    /// after a backup has been transitioned to cold.
    ///
    /// If your lifecycle currently uses the parameters `DeleteAfterDays` and
    /// `MoveToColdStorageAfterDays`, include these parameters and their values when
    /// you call
    /// this operation. Not including them may result in your plan updating with
    /// null values.
    ///
    /// This operation does not support continuous backups.
    pub fn updateRecoveryPointLifecycle(self: *Self, allocator: std.mem.Allocator, input: update_recovery_point_lifecycle.UpdateRecoveryPointLifecycleInput, options: CallOptions) !update_recovery_point_lifecycle.UpdateRecoveryPointLifecycleOutput {
        return update_recovery_point_lifecycle.execute(self, allocator, input, options);
    }

    /// Updates the current service opt-in settings for the Region.
    ///
    /// Use
    /// the `DescribeRegionSettings` API to determine the resource types that are
    /// supported.
    pub fn updateRegionSettings(self: *Self, allocator: std.mem.Allocator, input: update_region_settings.UpdateRegionSettingsInput, options: CallOptions) !update_region_settings.UpdateRegionSettingsOutput {
        return update_region_settings.execute(self, allocator, input, options);
    }

    /// Updates the specified report plan.
    pub fn updateReportPlan(self: *Self, allocator: std.mem.Allocator, input: update_report_plan.UpdateReportPlanInput, options: CallOptions) !update_report_plan.UpdateReportPlanOutput {
        return update_report_plan.execute(self, allocator, input, options);
    }

    /// This request will send changes to your specified restore testing
    /// plan. `RestoreTestingPlanName`
    /// cannot be updated after it is created.
    ///
    /// `RecoveryPointSelection` can contain:
    ///
    /// * `Algorithm`
    ///
    /// * `ExcludeVaults`
    ///
    /// * `IncludeVaults`
    ///
    /// * `RecoveryPointTypes`
    ///
    /// * `SelectionWindowDays`
    pub fn updateRestoreTestingPlan(self: *Self, allocator: std.mem.Allocator, input: update_restore_testing_plan.UpdateRestoreTestingPlanInput, options: CallOptions) !update_restore_testing_plan.UpdateRestoreTestingPlanOutput {
        return update_restore_testing_plan.execute(self, allocator, input, options);
    }

    /// Updates the specified restore testing selection.
    ///
    /// Most elements except the `RestoreTestingSelectionName`
    /// can be updated with this request.
    ///
    /// You can use either protected resource ARNs or conditions, but not both.
    pub fn updateRestoreTestingSelection(self: *Self, allocator: std.mem.Allocator, input: update_restore_testing_selection.UpdateRestoreTestingSelectionInput, options: CallOptions) !update_restore_testing_selection.UpdateRestoreTestingSelectionOutput {
        return update_restore_testing_selection.execute(self, allocator, input, options);
    }

    /// This request will send changes to your specified tiering
    /// configuration. `TieringConfigurationName`
    /// cannot be updated after it is created.
    ///
    /// `ResourceSelection` can contain:
    ///
    /// * `Resources`
    ///
    /// * `TieringDownSettingsInDays`
    ///
    /// * `ResourceType`
    pub fn updateTieringConfiguration(self: *Self, allocator: std.mem.Allocator, input: update_tiering_configuration.UpdateTieringConfigurationInput, options: CallOptions) !update_tiering_configuration.UpdateTieringConfigurationOutput {
        return update_tiering_configuration.execute(self, allocator, input, options);
    }

    pub fn listBackupJobSummariesPaginator(self: *Self, params: list_backup_job_summaries.ListBackupJobSummariesInput) paginator.ListBackupJobSummariesPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listBackupJobsPaginator(self: *Self, params: list_backup_jobs.ListBackupJobsInput) paginator.ListBackupJobsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listBackupPlanTemplatesPaginator(self: *Self, params: list_backup_plan_templates.ListBackupPlanTemplatesInput) paginator.ListBackupPlanTemplatesPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listBackupPlanVersionsPaginator(self: *Self, params: list_backup_plan_versions.ListBackupPlanVersionsInput) paginator.ListBackupPlanVersionsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listBackupPlansPaginator(self: *Self, params: list_backup_plans.ListBackupPlansInput) paginator.ListBackupPlansPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listBackupSelectionsPaginator(self: *Self, params: list_backup_selections.ListBackupSelectionsInput) paginator.ListBackupSelectionsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listBackupVaultsPaginator(self: *Self, params: list_backup_vaults.ListBackupVaultsInput) paginator.ListBackupVaultsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listCopyJobSummariesPaginator(self: *Self, params: list_copy_job_summaries.ListCopyJobSummariesInput) paginator.ListCopyJobSummariesPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listCopyJobsPaginator(self: *Self, params: list_copy_jobs.ListCopyJobsInput) paginator.ListCopyJobsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listFrameworksPaginator(self: *Self, params: list_frameworks.ListFrameworksInput) paginator.ListFrameworksPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listIndexedRecoveryPointsPaginator(self: *Self, params: list_indexed_recovery_points.ListIndexedRecoveryPointsInput) paginator.ListIndexedRecoveryPointsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listLegalHoldsPaginator(self: *Self, params: list_legal_holds.ListLegalHoldsInput) paginator.ListLegalHoldsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listProtectedResourcesPaginator(self: *Self, params: list_protected_resources.ListProtectedResourcesInput) paginator.ListProtectedResourcesPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listProtectedResourcesByBackupVaultPaginator(self: *Self, params: list_protected_resources_by_backup_vault.ListProtectedResourcesByBackupVaultInput) paginator.ListProtectedResourcesByBackupVaultPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listRecoveryPointsByBackupVaultPaginator(self: *Self, params: list_recovery_points_by_backup_vault.ListRecoveryPointsByBackupVaultInput) paginator.ListRecoveryPointsByBackupVaultPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listRecoveryPointsByLegalHoldPaginator(self: *Self, params: list_recovery_points_by_legal_hold.ListRecoveryPointsByLegalHoldInput) paginator.ListRecoveryPointsByLegalHoldPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listRecoveryPointsByResourcePaginator(self: *Self, params: list_recovery_points_by_resource.ListRecoveryPointsByResourceInput) paginator.ListRecoveryPointsByResourcePaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listReportJobsPaginator(self: *Self, params: list_report_jobs.ListReportJobsInput) paginator.ListReportJobsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listReportPlansPaginator(self: *Self, params: list_report_plans.ListReportPlansInput) paginator.ListReportPlansPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listRestoreAccessBackupVaultsPaginator(self: *Self, params: list_restore_access_backup_vaults.ListRestoreAccessBackupVaultsInput) paginator.ListRestoreAccessBackupVaultsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listRestoreJobSummariesPaginator(self: *Self, params: list_restore_job_summaries.ListRestoreJobSummariesInput) paginator.ListRestoreJobSummariesPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listRestoreJobsPaginator(self: *Self, params: list_restore_jobs.ListRestoreJobsInput) paginator.ListRestoreJobsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listRestoreJobsByProtectedResourcePaginator(self: *Self, params: list_restore_jobs_by_protected_resource.ListRestoreJobsByProtectedResourceInput) paginator.ListRestoreJobsByProtectedResourcePaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listRestoreTestingPlansPaginator(self: *Self, params: list_restore_testing_plans.ListRestoreTestingPlansInput) paginator.ListRestoreTestingPlansPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listRestoreTestingSelectionsPaginator(self: *Self, params: list_restore_testing_selections.ListRestoreTestingSelectionsInput) paginator.ListRestoreTestingSelectionsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listScanJobSummariesPaginator(self: *Self, params: list_scan_job_summaries.ListScanJobSummariesInput) paginator.ListScanJobSummariesPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listScanJobsPaginator(self: *Self, params: list_scan_jobs.ListScanJobsInput) paginator.ListScanJobsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listTagsPaginator(self: *Self, params: list_tags.ListTagsInput) paginator.ListTagsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listTieringConfigurationsPaginator(self: *Self, params: list_tiering_configurations.ListTieringConfigurationsInput) paginator.ListTieringConfigurationsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }
};
