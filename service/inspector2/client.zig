const aws = @import("aws");
const std = @import("std");

const associate_member = @import("associate_member.zig");
const batch_associate_code_security_scan_configuration = @import("batch_associate_code_security_scan_configuration.zig");
const batch_disassociate_code_security_scan_configuration = @import("batch_disassociate_code_security_scan_configuration.zig");
const batch_get_account_status = @import("batch_get_account_status.zig");
const batch_get_code_snippet = @import("batch_get_code_snippet.zig");
const batch_get_finding_details = @import("batch_get_finding_details.zig");
const batch_get_free_trial_info = @import("batch_get_free_trial_info.zig");
const batch_get_member_ec_2_deep_inspection_status = @import("batch_get_member_ec_2_deep_inspection_status.zig");
const batch_update_member_ec_2_deep_inspection_status = @import("batch_update_member_ec_2_deep_inspection_status.zig");
const cancel_findings_report = @import("cancel_findings_report.zig");
const cancel_sbom_export = @import("cancel_sbom_export.zig");
const create_cis_scan_configuration = @import("create_cis_scan_configuration.zig");
const create_code_security_integration = @import("create_code_security_integration.zig");
const create_code_security_scan_configuration = @import("create_code_security_scan_configuration.zig");
const create_filter = @import("create_filter.zig");
const create_findings_report = @import("create_findings_report.zig");
const create_sbom_export = @import("create_sbom_export.zig");
const delete_cis_scan_configuration = @import("delete_cis_scan_configuration.zig");
const delete_code_security_integration = @import("delete_code_security_integration.zig");
const delete_code_security_scan_configuration = @import("delete_code_security_scan_configuration.zig");
const delete_filter = @import("delete_filter.zig");
const describe_organization_configuration = @import("describe_organization_configuration.zig");
const disable_ = @import("disable.zig");
const disable_delegated_admin_account = @import("disable_delegated_admin_account.zig");
const disassociate_member = @import("disassociate_member.zig");
const enable_ = @import("enable.zig");
const enable_delegated_admin_account = @import("enable_delegated_admin_account.zig");
const get_cis_scan_report = @import("get_cis_scan_report.zig");
const get_cis_scan_result_details = @import("get_cis_scan_result_details.zig");
const get_clusters_for_image = @import("get_clusters_for_image.zig");
const get_code_security_integration = @import("get_code_security_integration.zig");
const get_code_security_scan = @import("get_code_security_scan.zig");
const get_code_security_scan_configuration = @import("get_code_security_scan_configuration.zig");
const get_configuration = @import("get_configuration.zig");
const get_delegated_admin_account = @import("get_delegated_admin_account.zig");
const get_ec_2_deep_inspection_configuration = @import("get_ec_2_deep_inspection_configuration.zig");
const get_encryption_key = @import("get_encryption_key.zig");
const get_findings_report_status = @import("get_findings_report_status.zig");
const get_member = @import("get_member.zig");
const get_sbom_export = @import("get_sbom_export.zig");
const list_account_permissions = @import("list_account_permissions.zig");
const list_cis_scan_configurations = @import("list_cis_scan_configurations.zig");
const list_cis_scan_results_aggregated_by_checks = @import("list_cis_scan_results_aggregated_by_checks.zig");
const list_cis_scan_results_aggregated_by_target_resource = @import("list_cis_scan_results_aggregated_by_target_resource.zig");
const list_cis_scans = @import("list_cis_scans.zig");
const list_code_security_integrations = @import("list_code_security_integrations.zig");
const list_code_security_scan_configuration_associations = @import("list_code_security_scan_configuration_associations.zig");
const list_code_security_scan_configurations = @import("list_code_security_scan_configurations.zig");
const list_coverage = @import("list_coverage.zig");
const list_coverage_statistics = @import("list_coverage_statistics.zig");
const list_delegated_admin_accounts = @import("list_delegated_admin_accounts.zig");
const list_filters = @import("list_filters.zig");
const list_finding_aggregations = @import("list_finding_aggregations.zig");
const list_findings = @import("list_findings.zig");
const list_members = @import("list_members.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const list_usage_totals = @import("list_usage_totals.zig");
const reset_encryption_key = @import("reset_encryption_key.zig");
const search_vulnerabilities = @import("search_vulnerabilities.zig");
const send_cis_session_health = @import("send_cis_session_health.zig");
const send_cis_session_telemetry = @import("send_cis_session_telemetry.zig");
const start_cis_session = @import("start_cis_session.zig");
const start_code_security_scan = @import("start_code_security_scan.zig");
const stop_cis_session = @import("stop_cis_session.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_cis_scan_configuration = @import("update_cis_scan_configuration.zig");
const update_code_security_integration = @import("update_code_security_integration.zig");
const update_code_security_scan_configuration = @import("update_code_security_scan_configuration.zig");
const update_configuration = @import("update_configuration.zig");
const update_ec_2_deep_inspection_configuration = @import("update_ec_2_deep_inspection_configuration.zig");
const update_encryption_key = @import("update_encryption_key.zig");
const update_filter = @import("update_filter.zig");
const update_org_ec_2_deep_inspection_configuration = @import("update_org_ec_2_deep_inspection_configuration.zig");
const update_organization_configuration = @import("update_organization_configuration.zig");
const CallOptions = @import("call_options.zig").CallOptions;
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "Inspector2";

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

    /// Associates an Amazon Web Services account with an Amazon Inspector delegated
    /// administrator. An HTTP 200 response
    /// indicates the association was successfully started, but doesn’t indicate
    /// whether it was
    /// completed. You can check if the association completed by using
    /// [ListMembers](https://docs.aws.amazon.com/inspector/v2/APIReference/API_ListMembers.html) for multiple
    /// accounts or
    /// [GetMembers](https://docs.aws.amazon.com/inspector/v2/APIReference/API_GetMember.html) for a single account.
    pub fn associateMember(self: *Self, allocator: std.mem.Allocator, input: associate_member.AssociateMemberInput, options: CallOptions) !associate_member.AssociateMemberOutput {
        return associate_member.execute(self, allocator, input, options);
    }

    /// Associates multiple code repositories with an Amazon Inspector code security
    /// scan
    /// configuration.
    pub fn batchAssociateCodeSecurityScanConfiguration(self: *Self, allocator: std.mem.Allocator, input: batch_associate_code_security_scan_configuration.BatchAssociateCodeSecurityScanConfigurationInput, options: CallOptions) !batch_associate_code_security_scan_configuration.BatchAssociateCodeSecurityScanConfigurationOutput {
        return batch_associate_code_security_scan_configuration.execute(self, allocator, input, options);
    }

    /// Disassociates multiple code repositories from an Amazon Inspector code
    /// security scan
    /// configuration.
    pub fn batchDisassociateCodeSecurityScanConfiguration(self: *Self, allocator: std.mem.Allocator, input: batch_disassociate_code_security_scan_configuration.BatchDisassociateCodeSecurityScanConfigurationInput, options: CallOptions) !batch_disassociate_code_security_scan_configuration.BatchDisassociateCodeSecurityScanConfigurationOutput {
        return batch_disassociate_code_security_scan_configuration.execute(self, allocator, input, options);
    }

    /// Retrieves the Amazon Inspector status of multiple Amazon Web Services
    /// accounts within your environment.
    pub fn batchGetAccountStatus(self: *Self, allocator: std.mem.Allocator, input: batch_get_account_status.BatchGetAccountStatusInput, options: CallOptions) !batch_get_account_status.BatchGetAccountStatusOutput {
        return batch_get_account_status.execute(self, allocator, input, options);
    }

    /// Retrieves code snippets from findings that Amazon Inspector detected code
    /// vulnerabilities
    /// in.
    pub fn batchGetCodeSnippet(self: *Self, allocator: std.mem.Allocator, input: batch_get_code_snippet.BatchGetCodeSnippetInput, options: CallOptions) !batch_get_code_snippet.BatchGetCodeSnippetOutput {
        return batch_get_code_snippet.execute(self, allocator, input, options);
    }

    /// Gets vulnerability details for findings.
    pub fn batchGetFindingDetails(self: *Self, allocator: std.mem.Allocator, input: batch_get_finding_details.BatchGetFindingDetailsInput, options: CallOptions) !batch_get_finding_details.BatchGetFindingDetailsOutput {
        return batch_get_finding_details.execute(self, allocator, input, options);
    }

    /// Gets free trial status for multiple Amazon Web Services accounts.
    pub fn batchGetFreeTrialInfo(self: *Self, allocator: std.mem.Allocator, input: batch_get_free_trial_info.BatchGetFreeTrialInfoInput, options: CallOptions) !batch_get_free_trial_info.BatchGetFreeTrialInfoOutput {
        return batch_get_free_trial_info.execute(self, allocator, input, options);
    }

    /// Retrieves Amazon Inspector deep inspection activation status of multiple
    /// member accounts within
    /// your organization. You must be the delegated administrator of an
    /// organization in Amazon Inspector to
    /// use this API.
    pub fn batchGetMemberEc2DeepInspectionStatus(self: *Self, allocator: std.mem.Allocator, input: batch_get_member_ec_2_deep_inspection_status.BatchGetMemberEc2DeepInspectionStatusInput, options: CallOptions) !batch_get_member_ec_2_deep_inspection_status.BatchGetMemberEc2DeepInspectionStatusOutput {
        return batch_get_member_ec_2_deep_inspection_status.execute(self, allocator, input, options);
    }

    /// Activates or deactivates Amazon Inspector deep inspection for the provided
    /// member accounts in your
    /// organization. You must be the delegated administrator of an organization in
    /// Amazon Inspector to use
    /// this API.
    pub fn batchUpdateMemberEc2DeepInspectionStatus(self: *Self, allocator: std.mem.Allocator, input: batch_update_member_ec_2_deep_inspection_status.BatchUpdateMemberEc2DeepInspectionStatusInput, options: CallOptions) !batch_update_member_ec_2_deep_inspection_status.BatchUpdateMemberEc2DeepInspectionStatusOutput {
        return batch_update_member_ec_2_deep_inspection_status.execute(self, allocator, input, options);
    }

    /// Cancels the given findings report.
    pub fn cancelFindingsReport(self: *Self, allocator: std.mem.Allocator, input: cancel_findings_report.CancelFindingsReportInput, options: CallOptions) !cancel_findings_report.CancelFindingsReportOutput {
        return cancel_findings_report.execute(self, allocator, input, options);
    }

    /// Cancels a software bill of materials (SBOM) report.
    pub fn cancelSbomExport(self: *Self, allocator: std.mem.Allocator, input: cancel_sbom_export.CancelSbomExportInput, options: CallOptions) !cancel_sbom_export.CancelSbomExportOutput {
        return cancel_sbom_export.execute(self, allocator, input, options);
    }

    /// Creates a CIS scan configuration.
    pub fn createCisScanConfiguration(self: *Self, allocator: std.mem.Allocator, input: create_cis_scan_configuration.CreateCisScanConfigurationInput, options: CallOptions) !create_cis_scan_configuration.CreateCisScanConfigurationOutput {
        return create_cis_scan_configuration.execute(self, allocator, input, options);
    }

    /// Creates a code security integration with a source code repository provider.
    ///
    /// After calling the `CreateCodeSecurityIntegration` operation, you complete
    /// authentication and authorization with your provider. Next you call the
    /// `UpdateCodeSecurityIntegration` operation to provide the `details`
    /// to complete the integration setup
    pub fn createCodeSecurityIntegration(self: *Self, allocator: std.mem.Allocator, input: create_code_security_integration.CreateCodeSecurityIntegrationInput, options: CallOptions) !create_code_security_integration.CreateCodeSecurityIntegrationOutput {
        return create_code_security_integration.execute(self, allocator, input, options);
    }

    /// Creates a scan configuration for code security scanning.
    pub fn createCodeSecurityScanConfiguration(self: *Self, allocator: std.mem.Allocator, input: create_code_security_scan_configuration.CreateCodeSecurityScanConfigurationInput, options: CallOptions) !create_code_security_scan_configuration.CreateCodeSecurityScanConfigurationOutput {
        return create_code_security_scan_configuration.execute(self, allocator, input, options);
    }

    /// Creates a filter resource using specified filter criteria. When the filter
    /// action is set
    /// to `SUPPRESS` this action creates a suppression rule.
    pub fn createFilter(self: *Self, allocator: std.mem.Allocator, input: create_filter.CreateFilterInput, options: CallOptions) !create_filter.CreateFilterOutput {
        return create_filter.execute(self, allocator, input, options);
    }

    /// Creates a finding report. By default only `ACTIVE` findings are returned in
    /// the report. To see `SUPRESSED` or `CLOSED` findings you must specify
    /// a value for the `findingStatus` filter criteria.
    pub fn createFindingsReport(self: *Self, allocator: std.mem.Allocator, input: create_findings_report.CreateFindingsReportInput, options: CallOptions) !create_findings_report.CreateFindingsReportOutput {
        return create_findings_report.execute(self, allocator, input, options);
    }

    /// Creates a software bill of materials (SBOM) report.
    pub fn createSbomExport(self: *Self, allocator: std.mem.Allocator, input: create_sbom_export.CreateSbomExportInput, options: CallOptions) !create_sbom_export.CreateSbomExportOutput {
        return create_sbom_export.execute(self, allocator, input, options);
    }

    /// Deletes a CIS scan configuration.
    pub fn deleteCisScanConfiguration(self: *Self, allocator: std.mem.Allocator, input: delete_cis_scan_configuration.DeleteCisScanConfigurationInput, options: CallOptions) !delete_cis_scan_configuration.DeleteCisScanConfigurationOutput {
        return delete_cis_scan_configuration.execute(self, allocator, input, options);
    }

    /// Deletes a code security integration.
    pub fn deleteCodeSecurityIntegration(self: *Self, allocator: std.mem.Allocator, input: delete_code_security_integration.DeleteCodeSecurityIntegrationInput, options: CallOptions) !delete_code_security_integration.DeleteCodeSecurityIntegrationOutput {
        return delete_code_security_integration.execute(self, allocator, input, options);
    }

    /// Deletes a code security scan configuration.
    pub fn deleteCodeSecurityScanConfiguration(self: *Self, allocator: std.mem.Allocator, input: delete_code_security_scan_configuration.DeleteCodeSecurityScanConfigurationInput, options: CallOptions) !delete_code_security_scan_configuration.DeleteCodeSecurityScanConfigurationOutput {
        return delete_code_security_scan_configuration.execute(self, allocator, input, options);
    }

    /// Deletes a filter resource.
    pub fn deleteFilter(self: *Self, allocator: std.mem.Allocator, input: delete_filter.DeleteFilterInput, options: CallOptions) !delete_filter.DeleteFilterOutput {
        return delete_filter.execute(self, allocator, input, options);
    }

    /// Describe Amazon Inspector configuration settings for an Amazon Web Services
    /// organization.
    pub fn describeOrganizationConfiguration(self: *Self, allocator: std.mem.Allocator, input: describe_organization_configuration.DescribeOrganizationConfigurationInput, options: CallOptions) !describe_organization_configuration.DescribeOrganizationConfigurationOutput {
        return describe_organization_configuration.execute(self, allocator, input, options);
    }

    /// Disables Amazon Inspector scans for one or more Amazon Web Services
    /// accounts. Disabling all scan types in an
    /// account disables the Amazon Inspector service.
    pub fn disable(self: *Self, allocator: std.mem.Allocator, input: disable_.DisableInput, options: CallOptions) !disable_.DisableOutput {
        return disable_.execute(self, allocator, input, options);
    }

    /// Disables the Amazon Inspector delegated administrator for your organization.
    pub fn disableDelegatedAdminAccount(self: *Self, allocator: std.mem.Allocator, input: disable_delegated_admin_account.DisableDelegatedAdminAccountInput, options: CallOptions) !disable_delegated_admin_account.DisableDelegatedAdminAccountOutput {
        return disable_delegated_admin_account.execute(self, allocator, input, options);
    }

    /// Disassociates a member account from an Amazon Inspector delegated
    /// administrator.
    pub fn disassociateMember(self: *Self, allocator: std.mem.Allocator, input: disassociate_member.DisassociateMemberInput, options: CallOptions) !disassociate_member.DisassociateMemberOutput {
        return disassociate_member.execute(self, allocator, input, options);
    }

    /// Enables Amazon Inspector scans for one or more Amazon Web Services accounts.
    pub fn enable(self: *Self, allocator: std.mem.Allocator, input: enable_.EnableInput, options: CallOptions) !enable_.EnableOutput {
        return enable_.execute(self, allocator, input, options);
    }

    /// Enables the Amazon Inspector delegated administrator for your Organizations
    /// organization.
    pub fn enableDelegatedAdminAccount(self: *Self, allocator: std.mem.Allocator, input: enable_delegated_admin_account.EnableDelegatedAdminAccountInput, options: CallOptions) !enable_delegated_admin_account.EnableDelegatedAdminAccountOutput {
        return enable_delegated_admin_account.execute(self, allocator, input, options);
    }

    /// Retrieves a CIS scan report.
    pub fn getCisScanReport(self: *Self, allocator: std.mem.Allocator, input: get_cis_scan_report.GetCisScanReportInput, options: CallOptions) !get_cis_scan_report.GetCisScanReportOutput {
        return get_cis_scan_report.execute(self, allocator, input, options);
    }

    /// Retrieves CIS scan result details.
    pub fn getCisScanResultDetails(self: *Self, allocator: std.mem.Allocator, input: get_cis_scan_result_details.GetCisScanResultDetailsInput, options: CallOptions) !get_cis_scan_result_details.GetCisScanResultDetailsOutput {
        return get_cis_scan_result_details.execute(self, allocator, input, options);
    }

    /// Returns a list of clusters and metadata associated with an image.
    pub fn getClustersForImage(self: *Self, allocator: std.mem.Allocator, input: get_clusters_for_image.GetClustersForImageInput, options: CallOptions) !get_clusters_for_image.GetClustersForImageOutput {
        return get_clusters_for_image.execute(self, allocator, input, options);
    }

    /// Retrieves information about a code security integration.
    pub fn getCodeSecurityIntegration(self: *Self, allocator: std.mem.Allocator, input: get_code_security_integration.GetCodeSecurityIntegrationInput, options: CallOptions) !get_code_security_integration.GetCodeSecurityIntegrationOutput {
        return get_code_security_integration.execute(self, allocator, input, options);
    }

    /// Retrieves information about a specific code security scan.
    pub fn getCodeSecurityScan(self: *Self, allocator: std.mem.Allocator, input: get_code_security_scan.GetCodeSecurityScanInput, options: CallOptions) !get_code_security_scan.GetCodeSecurityScanOutput {
        return get_code_security_scan.execute(self, allocator, input, options);
    }

    /// Retrieves information about a code security scan configuration.
    pub fn getCodeSecurityScanConfiguration(self: *Self, allocator: std.mem.Allocator, input: get_code_security_scan_configuration.GetCodeSecurityScanConfigurationInput, options: CallOptions) !get_code_security_scan_configuration.GetCodeSecurityScanConfigurationOutput {
        return get_code_security_scan_configuration.execute(self, allocator, input, options);
    }

    /// Retrieves setting configurations for Inspector scans.
    pub fn getConfiguration(self: *Self, allocator: std.mem.Allocator, input: get_configuration.GetConfigurationInput, options: CallOptions) !get_configuration.GetConfigurationOutput {
        return get_configuration.execute(self, allocator, input, options);
    }

    /// Retrieves information about the Amazon Inspector delegated administrator for
    /// your
    /// organization.
    pub fn getDelegatedAdminAccount(self: *Self, allocator: std.mem.Allocator, input: get_delegated_admin_account.GetDelegatedAdminAccountInput, options: CallOptions) !get_delegated_admin_account.GetDelegatedAdminAccountOutput {
        return get_delegated_admin_account.execute(self, allocator, input, options);
    }

    /// Retrieves the activation status of Amazon Inspector deep inspection and
    /// custom paths associated
    /// with your account.
    pub fn getEc2DeepInspectionConfiguration(self: *Self, allocator: std.mem.Allocator, input: get_ec_2_deep_inspection_configuration.GetEc2DeepInspectionConfigurationInput, options: CallOptions) !get_ec_2_deep_inspection_configuration.GetEc2DeepInspectionConfigurationOutput {
        return get_ec_2_deep_inspection_configuration.execute(self, allocator, input, options);
    }

    /// Gets an encryption key.
    pub fn getEncryptionKey(self: *Self, allocator: std.mem.Allocator, input: get_encryption_key.GetEncryptionKeyInput, options: CallOptions) !get_encryption_key.GetEncryptionKeyOutput {
        return get_encryption_key.execute(self, allocator, input, options);
    }

    /// Gets the status of a findings report.
    pub fn getFindingsReportStatus(self: *Self, allocator: std.mem.Allocator, input: get_findings_report_status.GetFindingsReportStatusInput, options: CallOptions) !get_findings_report_status.GetFindingsReportStatusOutput {
        return get_findings_report_status.execute(self, allocator, input, options);
    }

    /// Gets member information for your organization.
    pub fn getMember(self: *Self, allocator: std.mem.Allocator, input: get_member.GetMemberInput, options: CallOptions) !get_member.GetMemberOutput {
        return get_member.execute(self, allocator, input, options);
    }

    /// Gets details of a software bill of materials (SBOM) report.
    pub fn getSbomExport(self: *Self, allocator: std.mem.Allocator, input: get_sbom_export.GetSbomExportInput, options: CallOptions) !get_sbom_export.GetSbomExportOutput {
        return get_sbom_export.execute(self, allocator, input, options);
    }

    /// Lists the permissions an account has to configure Amazon Inspector.
    /// If the account is a member account or standalone account with resources
    /// managed by an Organizations policy, the operation returns fewer permissions.
    pub fn listAccountPermissions(self: *Self, allocator: std.mem.Allocator, input: list_account_permissions.ListAccountPermissionsInput, options: CallOptions) !list_account_permissions.ListAccountPermissionsOutput {
        return list_account_permissions.execute(self, allocator, input, options);
    }

    /// Lists CIS scan configurations.
    pub fn listCisScanConfigurations(self: *Self, allocator: std.mem.Allocator, input: list_cis_scan_configurations.ListCisScanConfigurationsInput, options: CallOptions) !list_cis_scan_configurations.ListCisScanConfigurationsOutput {
        return list_cis_scan_configurations.execute(self, allocator, input, options);
    }

    /// Lists scan results aggregated by checks.
    pub fn listCisScanResultsAggregatedByChecks(self: *Self, allocator: std.mem.Allocator, input: list_cis_scan_results_aggregated_by_checks.ListCisScanResultsAggregatedByChecksInput, options: CallOptions) !list_cis_scan_results_aggregated_by_checks.ListCisScanResultsAggregatedByChecksOutput {
        return list_cis_scan_results_aggregated_by_checks.execute(self, allocator, input, options);
    }

    /// Lists scan results aggregated by a target resource.
    pub fn listCisScanResultsAggregatedByTargetResource(self: *Self, allocator: std.mem.Allocator, input: list_cis_scan_results_aggregated_by_target_resource.ListCisScanResultsAggregatedByTargetResourceInput, options: CallOptions) !list_cis_scan_results_aggregated_by_target_resource.ListCisScanResultsAggregatedByTargetResourceOutput {
        return list_cis_scan_results_aggregated_by_target_resource.execute(self, allocator, input, options);
    }

    /// Returns a CIS scan list.
    pub fn listCisScans(self: *Self, allocator: std.mem.Allocator, input: list_cis_scans.ListCisScansInput, options: CallOptions) !list_cis_scans.ListCisScansOutput {
        return list_cis_scans.execute(self, allocator, input, options);
    }

    /// Lists all code security integrations in your account.
    pub fn listCodeSecurityIntegrations(self: *Self, allocator: std.mem.Allocator, input: list_code_security_integrations.ListCodeSecurityIntegrationsInput, options: CallOptions) !list_code_security_integrations.ListCodeSecurityIntegrationsOutput {
        return list_code_security_integrations.execute(self, allocator, input, options);
    }

    /// Lists the associations between code repositories and Amazon Inspector code
    /// security scan
    /// configurations.
    pub fn listCodeSecurityScanConfigurationAssociations(self: *Self, allocator: std.mem.Allocator, input: list_code_security_scan_configuration_associations.ListCodeSecurityScanConfigurationAssociationsInput, options: CallOptions) !list_code_security_scan_configuration_associations.ListCodeSecurityScanConfigurationAssociationsOutput {
        return list_code_security_scan_configuration_associations.execute(self, allocator, input, options);
    }

    /// Lists all code security scan configurations in your account.
    pub fn listCodeSecurityScanConfigurations(self: *Self, allocator: std.mem.Allocator, input: list_code_security_scan_configurations.ListCodeSecurityScanConfigurationsInput, options: CallOptions) !list_code_security_scan_configurations.ListCodeSecurityScanConfigurationsOutput {
        return list_code_security_scan_configurations.execute(self, allocator, input, options);
    }

    /// Lists coverage details for your environment.
    pub fn listCoverage(self: *Self, allocator: std.mem.Allocator, input: list_coverage.ListCoverageInput, options: CallOptions) !list_coverage.ListCoverageOutput {
        return list_coverage.execute(self, allocator, input, options);
    }

    /// Lists Amazon Inspector coverage statistics for your environment.
    pub fn listCoverageStatistics(self: *Self, allocator: std.mem.Allocator, input: list_coverage_statistics.ListCoverageStatisticsInput, options: CallOptions) !list_coverage_statistics.ListCoverageStatisticsOutput {
        return list_coverage_statistics.execute(self, allocator, input, options);
    }

    /// Lists information about the Amazon Inspector delegated administrator of your
    /// organization.
    pub fn listDelegatedAdminAccounts(self: *Self, allocator: std.mem.Allocator, input: list_delegated_admin_accounts.ListDelegatedAdminAccountsInput, options: CallOptions) !list_delegated_admin_accounts.ListDelegatedAdminAccountsOutput {
        return list_delegated_admin_accounts.execute(self, allocator, input, options);
    }

    /// Lists the filters associated with your account.
    pub fn listFilters(self: *Self, allocator: std.mem.Allocator, input: list_filters.ListFiltersInput, options: CallOptions) !list_filters.ListFiltersOutput {
        return list_filters.execute(self, allocator, input, options);
    }

    /// Lists aggregated finding data for your environment based on specific
    /// criteria.
    pub fn listFindingAggregations(self: *Self, allocator: std.mem.Allocator, input: list_finding_aggregations.ListFindingAggregationsInput, options: CallOptions) !list_finding_aggregations.ListFindingAggregationsOutput {
        return list_finding_aggregations.execute(self, allocator, input, options);
    }

    /// Lists findings for your environment.
    pub fn listFindings(self: *Self, allocator: std.mem.Allocator, input: list_findings.ListFindingsInput, options: CallOptions) !list_findings.ListFindingsOutput {
        return list_findings.execute(self, allocator, input, options);
    }

    /// List members associated with the Amazon Inspector delegated administrator
    /// for your
    /// organization.
    pub fn listMembers(self: *Self, allocator: std.mem.Allocator, input: list_members.ListMembersInput, options: CallOptions) !list_members.ListMembersOutput {
        return list_members.execute(self, allocator, input, options);
    }

    /// Lists all tags attached to a given resource.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: CallOptions) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Lists the Amazon Inspector usage totals over the last 30 days.
    pub fn listUsageTotals(self: *Self, allocator: std.mem.Allocator, input: list_usage_totals.ListUsageTotalsInput, options: CallOptions) !list_usage_totals.ListUsageTotalsOutput {
        return list_usage_totals.execute(self, allocator, input, options);
    }

    /// Resets an encryption key. After the key is reset your resources will be
    /// encrypted by an
    /// Amazon Web Services owned key.
    pub fn resetEncryptionKey(self: *Self, allocator: std.mem.Allocator, input: reset_encryption_key.ResetEncryptionKeyInput, options: CallOptions) !reset_encryption_key.ResetEncryptionKeyOutput {
        return reset_encryption_key.execute(self, allocator, input, options);
    }

    /// Lists Amazon Inspector coverage details for a specific vulnerability.
    pub fn searchVulnerabilities(self: *Self, allocator: std.mem.Allocator, input: search_vulnerabilities.SearchVulnerabilitiesInput, options: CallOptions) !search_vulnerabilities.SearchVulnerabilitiesOutput {
        return search_vulnerabilities.execute(self, allocator, input, options);
    }

    /// Sends a CIS session health. This API is used by the Amazon Inspector SSM
    /// plugin to
    /// communicate with the Amazon Inspector service. The Amazon Inspector SSM
    /// plugin calls
    /// this API to start a CIS scan session for the scan ID supplied by the
    /// service.
    pub fn sendCisSessionHealth(self: *Self, allocator: std.mem.Allocator, input: send_cis_session_health.SendCisSessionHealthInput, options: CallOptions) !send_cis_session_health.SendCisSessionHealthOutput {
        return send_cis_session_health.execute(self, allocator, input, options);
    }

    /// Sends a CIS session telemetry. This API is used by the Amazon Inspector SSM
    /// plugin to
    /// communicate with the Amazon Inspector service. The Amazon Inspector SSM
    /// plugin calls
    /// this API to start a CIS scan session for the scan ID supplied by the
    /// service.
    pub fn sendCisSessionTelemetry(self: *Self, allocator: std.mem.Allocator, input: send_cis_session_telemetry.SendCisSessionTelemetryInput, options: CallOptions) !send_cis_session_telemetry.SendCisSessionTelemetryOutput {
        return send_cis_session_telemetry.execute(self, allocator, input, options);
    }

    /// Starts a CIS session. This API is used by the Amazon Inspector SSM plugin to
    /// communicate with the Amazon Inspector service. The Amazon Inspector SSM
    /// plugin calls
    /// this API to start a CIS scan session for the scan ID supplied by the
    /// service.
    pub fn startCisSession(self: *Self, allocator: std.mem.Allocator, input: start_cis_session.StartCisSessionInput, options: CallOptions) !start_cis_session.StartCisSessionOutput {
        return start_cis_session.execute(self, allocator, input, options);
    }

    /// Initiates a code security scan on a specified repository.
    pub fn startCodeSecurityScan(self: *Self, allocator: std.mem.Allocator, input: start_code_security_scan.StartCodeSecurityScanInput, options: CallOptions) !start_code_security_scan.StartCodeSecurityScanOutput {
        return start_code_security_scan.execute(self, allocator, input, options);
    }

    /// Stops a CIS session. This API is used by the Amazon Inspector SSM plugin to
    /// communicate with the Amazon Inspector service. The Amazon Inspector SSM
    /// plugin calls
    /// this API to stop a CIS scan session for the scan ID supplied by the service.
    pub fn stopCisSession(self: *Self, allocator: std.mem.Allocator, input: stop_cis_session.StopCisSessionInput, options: CallOptions) !stop_cis_session.StopCisSessionOutput {
        return stop_cis_session.execute(self, allocator, input, options);
    }

    /// Adds tags to a resource.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: CallOptions) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Removes tags from a resource.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: CallOptions) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Updates a CIS scan configuration.
    pub fn updateCisScanConfiguration(self: *Self, allocator: std.mem.Allocator, input: update_cis_scan_configuration.UpdateCisScanConfigurationInput, options: CallOptions) !update_cis_scan_configuration.UpdateCisScanConfigurationOutput {
        return update_cis_scan_configuration.execute(self, allocator, input, options);
    }

    /// Updates an existing code security integration.
    ///
    /// After calling the `CreateCodeSecurityIntegration` operation, you complete
    /// authentication and authorization with your provider. Next you call the
    /// `UpdateCodeSecurityIntegration` operation to provide the `details`
    /// to complete the integration setup
    pub fn updateCodeSecurityIntegration(self: *Self, allocator: std.mem.Allocator, input: update_code_security_integration.UpdateCodeSecurityIntegrationInput, options: CallOptions) !update_code_security_integration.UpdateCodeSecurityIntegrationOutput {
        return update_code_security_integration.execute(self, allocator, input, options);
    }

    /// Updates an existing code security scan configuration.
    pub fn updateCodeSecurityScanConfiguration(self: *Self, allocator: std.mem.Allocator, input: update_code_security_scan_configuration.UpdateCodeSecurityScanConfigurationInput, options: CallOptions) !update_code_security_scan_configuration.UpdateCodeSecurityScanConfigurationOutput {
        return update_code_security_scan_configuration.execute(self, allocator, input, options);
    }

    /// Updates setting configurations for your Amazon Inspector account. When you
    /// use this API as an Amazon Inspector
    /// delegated administrator this updates the setting for all accounts you
    /// manage. Member
    /// accounts in an organization cannot update this setting.
    pub fn updateConfiguration(self: *Self, allocator: std.mem.Allocator, input: update_configuration.UpdateConfigurationInput, options: CallOptions) !update_configuration.UpdateConfigurationOutput {
        return update_configuration.execute(self, allocator, input, options);
    }

    /// Activates, deactivates Amazon Inspector deep inspection, or updates custom
    /// paths for your account.
    pub fn updateEc2DeepInspectionConfiguration(self: *Self, allocator: std.mem.Allocator, input: update_ec_2_deep_inspection_configuration.UpdateEc2DeepInspectionConfigurationInput, options: CallOptions) !update_ec_2_deep_inspection_configuration.UpdateEc2DeepInspectionConfigurationOutput {
        return update_ec_2_deep_inspection_configuration.execute(self, allocator, input, options);
    }

    /// Updates an encryption key. A `ResourceNotFoundException` means that an
    /// Amazon Web Services owned key is being used for encryption.
    pub fn updateEncryptionKey(self: *Self, allocator: std.mem.Allocator, input: update_encryption_key.UpdateEncryptionKeyInput, options: CallOptions) !update_encryption_key.UpdateEncryptionKeyOutput {
        return update_encryption_key.execute(self, allocator, input, options);
    }

    /// Specifies the action that is to be applied to the findings that match the
    /// filter.
    pub fn updateFilter(self: *Self, allocator: std.mem.Allocator, input: update_filter.UpdateFilterInput, options: CallOptions) !update_filter.UpdateFilterOutput {
        return update_filter.execute(self, allocator, input, options);
    }

    /// Updates the Amazon Inspector deep inspection custom paths for your
    /// organization. You must be an
    /// Amazon Inspector delegated administrator to use this API.
    pub fn updateOrgEc2DeepInspectionConfiguration(self: *Self, allocator: std.mem.Allocator, input: update_org_ec_2_deep_inspection_configuration.UpdateOrgEc2DeepInspectionConfigurationInput, options: CallOptions) !update_org_ec_2_deep_inspection_configuration.UpdateOrgEc2DeepInspectionConfigurationOutput {
        return update_org_ec_2_deep_inspection_configuration.execute(self, allocator, input, options);
    }

    /// Updates the configurations for your Amazon Inspector organization.
    pub fn updateOrganizationConfiguration(self: *Self, allocator: std.mem.Allocator, input: update_organization_configuration.UpdateOrganizationConfigurationInput, options: CallOptions) !update_organization_configuration.UpdateOrganizationConfigurationOutput {
        return update_organization_configuration.execute(self, allocator, input, options);
    }

    pub fn getCisScanResultDetailsPaginator(self: *Self, params: get_cis_scan_result_details.GetCisScanResultDetailsInput) paginator.GetCisScanResultDetailsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn getClustersForImagePaginator(self: *Self, params: get_clusters_for_image.GetClustersForImageInput) paginator.GetClustersForImagePaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listAccountPermissionsPaginator(self: *Self, params: list_account_permissions.ListAccountPermissionsInput) paginator.ListAccountPermissionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listCisScanConfigurationsPaginator(self: *Self, params: list_cis_scan_configurations.ListCisScanConfigurationsInput) paginator.ListCisScanConfigurationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listCisScanResultsAggregatedByChecksPaginator(self: *Self, params: list_cis_scan_results_aggregated_by_checks.ListCisScanResultsAggregatedByChecksInput) paginator.ListCisScanResultsAggregatedByChecksPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listCisScanResultsAggregatedByTargetResourcePaginator(self: *Self, params: list_cis_scan_results_aggregated_by_target_resource.ListCisScanResultsAggregatedByTargetResourceInput) paginator.ListCisScanResultsAggregatedByTargetResourcePaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listCisScansPaginator(self: *Self, params: list_cis_scans.ListCisScansInput) paginator.ListCisScansPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listCoveragePaginator(self: *Self, params: list_coverage.ListCoverageInput) paginator.ListCoveragePaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listCoverageStatisticsPaginator(self: *Self, params: list_coverage_statistics.ListCoverageStatisticsInput) paginator.ListCoverageStatisticsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listDelegatedAdminAccountsPaginator(self: *Self, params: list_delegated_admin_accounts.ListDelegatedAdminAccountsInput) paginator.ListDelegatedAdminAccountsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listFiltersPaginator(self: *Self, params: list_filters.ListFiltersInput) paginator.ListFiltersPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listFindingAggregationsPaginator(self: *Self, params: list_finding_aggregations.ListFindingAggregationsInput) paginator.ListFindingAggregationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listFindingsPaginator(self: *Self, params: list_findings.ListFindingsInput) paginator.ListFindingsPaginator {
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

    pub fn listUsageTotalsPaginator(self: *Self, params: list_usage_totals.ListUsageTotalsInput) paginator.ListUsageTotalsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn searchVulnerabilitiesPaginator(self: *Self, params: search_vulnerabilities.SearchVulnerabilitiesInput) paginator.SearchVulnerabilitiesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};
