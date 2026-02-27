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
            .http_client = aws.http.HttpClient.init(allocator),
        };
    }

    pub fn initWithOptions(allocator: std.mem.Allocator, config: *aws.Config, options: aws.http.RequestOptions) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.initWithOptions(allocator, options),
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
    pub fn associateMember(self: *Self, allocator: std.mem.Allocator, input: associate_member.AssociateMemberInput, options: associate_member.Options) !associate_member.AssociateMemberOutput {
        return associate_member.execute(self, allocator, input, options);
    }

    /// Associates multiple code repositories with an Amazon Inspector code security
    /// scan
    /// configuration.
    pub fn batchAssociateCodeSecurityScanConfiguration(self: *Self, allocator: std.mem.Allocator, input: batch_associate_code_security_scan_configuration.BatchAssociateCodeSecurityScanConfigurationInput, options: batch_associate_code_security_scan_configuration.Options) !batch_associate_code_security_scan_configuration.BatchAssociateCodeSecurityScanConfigurationOutput {
        return batch_associate_code_security_scan_configuration.execute(self, allocator, input, options);
    }

    /// Disassociates multiple code repositories from an Amazon Inspector code
    /// security scan
    /// configuration.
    pub fn batchDisassociateCodeSecurityScanConfiguration(self: *Self, allocator: std.mem.Allocator, input: batch_disassociate_code_security_scan_configuration.BatchDisassociateCodeSecurityScanConfigurationInput, options: batch_disassociate_code_security_scan_configuration.Options) !batch_disassociate_code_security_scan_configuration.BatchDisassociateCodeSecurityScanConfigurationOutput {
        return batch_disassociate_code_security_scan_configuration.execute(self, allocator, input, options);
    }

    /// Retrieves the Amazon Inspector status of multiple Amazon Web Services
    /// accounts within your environment.
    pub fn batchGetAccountStatus(self: *Self, allocator: std.mem.Allocator, input: batch_get_account_status.BatchGetAccountStatusInput, options: batch_get_account_status.Options) !batch_get_account_status.BatchGetAccountStatusOutput {
        return batch_get_account_status.execute(self, allocator, input, options);
    }

    /// Retrieves code snippets from findings that Amazon Inspector detected code
    /// vulnerabilities
    /// in.
    pub fn batchGetCodeSnippet(self: *Self, allocator: std.mem.Allocator, input: batch_get_code_snippet.BatchGetCodeSnippetInput, options: batch_get_code_snippet.Options) !batch_get_code_snippet.BatchGetCodeSnippetOutput {
        return batch_get_code_snippet.execute(self, allocator, input, options);
    }

    /// Gets vulnerability details for findings.
    pub fn batchGetFindingDetails(self: *Self, allocator: std.mem.Allocator, input: batch_get_finding_details.BatchGetFindingDetailsInput, options: batch_get_finding_details.Options) !batch_get_finding_details.BatchGetFindingDetailsOutput {
        return batch_get_finding_details.execute(self, allocator, input, options);
    }

    /// Gets free trial status for multiple Amazon Web Services accounts.
    pub fn batchGetFreeTrialInfo(self: *Self, allocator: std.mem.Allocator, input: batch_get_free_trial_info.BatchGetFreeTrialInfoInput, options: batch_get_free_trial_info.Options) !batch_get_free_trial_info.BatchGetFreeTrialInfoOutput {
        return batch_get_free_trial_info.execute(self, allocator, input, options);
    }

    /// Retrieves Amazon Inspector deep inspection activation status of multiple
    /// member accounts within
    /// your organization. You must be the delegated administrator of an
    /// organization in Amazon Inspector to
    /// use this API.
    pub fn batchGetMemberEc2DeepInspectionStatus(self: *Self, allocator: std.mem.Allocator, input: batch_get_member_ec_2_deep_inspection_status.BatchGetMemberEc2DeepInspectionStatusInput, options: batch_get_member_ec_2_deep_inspection_status.Options) !batch_get_member_ec_2_deep_inspection_status.BatchGetMemberEc2DeepInspectionStatusOutput {
        return batch_get_member_ec_2_deep_inspection_status.execute(self, allocator, input, options);
    }

    /// Activates or deactivates Amazon Inspector deep inspection for the provided
    /// member accounts in your
    /// organization. You must be the delegated administrator of an organization in
    /// Amazon Inspector to use
    /// this API.
    pub fn batchUpdateMemberEc2DeepInspectionStatus(self: *Self, allocator: std.mem.Allocator, input: batch_update_member_ec_2_deep_inspection_status.BatchUpdateMemberEc2DeepInspectionStatusInput, options: batch_update_member_ec_2_deep_inspection_status.Options) !batch_update_member_ec_2_deep_inspection_status.BatchUpdateMemberEc2DeepInspectionStatusOutput {
        return batch_update_member_ec_2_deep_inspection_status.execute(self, allocator, input, options);
    }

    /// Cancels the given findings report.
    pub fn cancelFindingsReport(self: *Self, allocator: std.mem.Allocator, input: cancel_findings_report.CancelFindingsReportInput, options: cancel_findings_report.Options) !cancel_findings_report.CancelFindingsReportOutput {
        return cancel_findings_report.execute(self, allocator, input, options);
    }

    /// Cancels a software bill of materials (SBOM) report.
    pub fn cancelSbomExport(self: *Self, allocator: std.mem.Allocator, input: cancel_sbom_export.CancelSbomExportInput, options: cancel_sbom_export.Options) !cancel_sbom_export.CancelSbomExportOutput {
        return cancel_sbom_export.execute(self, allocator, input, options);
    }

    /// Creates a CIS scan configuration.
    pub fn createCisScanConfiguration(self: *Self, allocator: std.mem.Allocator, input: create_cis_scan_configuration.CreateCisScanConfigurationInput, options: create_cis_scan_configuration.Options) !create_cis_scan_configuration.CreateCisScanConfigurationOutput {
        return create_cis_scan_configuration.execute(self, allocator, input, options);
    }

    /// Creates a code security integration with a source code repository provider.
    ///
    /// After calling the `CreateCodeSecurityIntegration` operation, you complete
    /// authentication and authorization with your provider. Next you call the
    /// `UpdateCodeSecurityIntegration` operation to provide the `details`
    /// to complete the integration setup
    pub fn createCodeSecurityIntegration(self: *Self, allocator: std.mem.Allocator, input: create_code_security_integration.CreateCodeSecurityIntegrationInput, options: create_code_security_integration.Options) !create_code_security_integration.CreateCodeSecurityIntegrationOutput {
        return create_code_security_integration.execute(self, allocator, input, options);
    }

    /// Creates a scan configuration for code security scanning.
    pub fn createCodeSecurityScanConfiguration(self: *Self, allocator: std.mem.Allocator, input: create_code_security_scan_configuration.CreateCodeSecurityScanConfigurationInput, options: create_code_security_scan_configuration.Options) !create_code_security_scan_configuration.CreateCodeSecurityScanConfigurationOutput {
        return create_code_security_scan_configuration.execute(self, allocator, input, options);
    }

    /// Creates a filter resource using specified filter criteria. When the filter
    /// action is set
    /// to `SUPPRESS` this action creates a suppression rule.
    pub fn createFilter(self: *Self, allocator: std.mem.Allocator, input: create_filter.CreateFilterInput, options: create_filter.Options) !create_filter.CreateFilterOutput {
        return create_filter.execute(self, allocator, input, options);
    }

    /// Creates a finding report. By default only `ACTIVE` findings are returned in
    /// the report. To see `SUPRESSED` or `CLOSED` findings you must specify
    /// a value for the `findingStatus` filter criteria.
    pub fn createFindingsReport(self: *Self, allocator: std.mem.Allocator, input: create_findings_report.CreateFindingsReportInput, options: create_findings_report.Options) !create_findings_report.CreateFindingsReportOutput {
        return create_findings_report.execute(self, allocator, input, options);
    }

    /// Creates a software bill of materials (SBOM) report.
    pub fn createSbomExport(self: *Self, allocator: std.mem.Allocator, input: create_sbom_export.CreateSbomExportInput, options: create_sbom_export.Options) !create_sbom_export.CreateSbomExportOutput {
        return create_sbom_export.execute(self, allocator, input, options);
    }

    /// Deletes a CIS scan configuration.
    pub fn deleteCisScanConfiguration(self: *Self, allocator: std.mem.Allocator, input: delete_cis_scan_configuration.DeleteCisScanConfigurationInput, options: delete_cis_scan_configuration.Options) !delete_cis_scan_configuration.DeleteCisScanConfigurationOutput {
        return delete_cis_scan_configuration.execute(self, allocator, input, options);
    }

    /// Deletes a code security integration.
    pub fn deleteCodeSecurityIntegration(self: *Self, allocator: std.mem.Allocator, input: delete_code_security_integration.DeleteCodeSecurityIntegrationInput, options: delete_code_security_integration.Options) !delete_code_security_integration.DeleteCodeSecurityIntegrationOutput {
        return delete_code_security_integration.execute(self, allocator, input, options);
    }

    /// Deletes a code security scan configuration.
    pub fn deleteCodeSecurityScanConfiguration(self: *Self, allocator: std.mem.Allocator, input: delete_code_security_scan_configuration.DeleteCodeSecurityScanConfigurationInput, options: delete_code_security_scan_configuration.Options) !delete_code_security_scan_configuration.DeleteCodeSecurityScanConfigurationOutput {
        return delete_code_security_scan_configuration.execute(self, allocator, input, options);
    }

    /// Deletes a filter resource.
    pub fn deleteFilter(self: *Self, allocator: std.mem.Allocator, input: delete_filter.DeleteFilterInput, options: delete_filter.Options) !delete_filter.DeleteFilterOutput {
        return delete_filter.execute(self, allocator, input, options);
    }

    /// Describe Amazon Inspector configuration settings for an Amazon Web Services
    /// organization.
    pub fn describeOrganizationConfiguration(self: *Self, allocator: std.mem.Allocator, input: describe_organization_configuration.DescribeOrganizationConfigurationInput, options: describe_organization_configuration.Options) !describe_organization_configuration.DescribeOrganizationConfigurationOutput {
        return describe_organization_configuration.execute(self, allocator, input, options);
    }

    /// Disables Amazon Inspector scans for one or more Amazon Web Services
    /// accounts. Disabling all scan types in an
    /// account disables the Amazon Inspector service.
    pub fn disable(self: *Self, allocator: std.mem.Allocator, input: disable_.DisableInput, options: disable_.Options) !disable_.DisableOutput {
        return disable_.execute(self, allocator, input, options);
    }

    /// Disables the Amazon Inspector delegated administrator for your organization.
    pub fn disableDelegatedAdminAccount(self: *Self, allocator: std.mem.Allocator, input: disable_delegated_admin_account.DisableDelegatedAdminAccountInput, options: disable_delegated_admin_account.Options) !disable_delegated_admin_account.DisableDelegatedAdminAccountOutput {
        return disable_delegated_admin_account.execute(self, allocator, input, options);
    }

    /// Disassociates a member account from an Amazon Inspector delegated
    /// administrator.
    pub fn disassociateMember(self: *Self, allocator: std.mem.Allocator, input: disassociate_member.DisassociateMemberInput, options: disassociate_member.Options) !disassociate_member.DisassociateMemberOutput {
        return disassociate_member.execute(self, allocator, input, options);
    }

    /// Enables Amazon Inspector scans for one or more Amazon Web Services accounts.
    pub fn enable(self: *Self, allocator: std.mem.Allocator, input: enable_.EnableInput, options: enable_.Options) !enable_.EnableOutput {
        return enable_.execute(self, allocator, input, options);
    }

    /// Enables the Amazon Inspector delegated administrator for your Organizations
    /// organization.
    pub fn enableDelegatedAdminAccount(self: *Self, allocator: std.mem.Allocator, input: enable_delegated_admin_account.EnableDelegatedAdminAccountInput, options: enable_delegated_admin_account.Options) !enable_delegated_admin_account.EnableDelegatedAdminAccountOutput {
        return enable_delegated_admin_account.execute(self, allocator, input, options);
    }

    /// Retrieves a CIS scan report.
    pub fn getCisScanReport(self: *Self, allocator: std.mem.Allocator, input: get_cis_scan_report.GetCisScanReportInput, options: get_cis_scan_report.Options) !get_cis_scan_report.GetCisScanReportOutput {
        return get_cis_scan_report.execute(self, allocator, input, options);
    }

    /// Retrieves CIS scan result details.
    pub fn getCisScanResultDetails(self: *Self, allocator: std.mem.Allocator, input: get_cis_scan_result_details.GetCisScanResultDetailsInput, options: get_cis_scan_result_details.Options) !get_cis_scan_result_details.GetCisScanResultDetailsOutput {
        return get_cis_scan_result_details.execute(self, allocator, input, options);
    }

    /// Returns a list of clusters and metadata associated with an image.
    pub fn getClustersForImage(self: *Self, allocator: std.mem.Allocator, input: get_clusters_for_image.GetClustersForImageInput, options: get_clusters_for_image.Options) !get_clusters_for_image.GetClustersForImageOutput {
        return get_clusters_for_image.execute(self, allocator, input, options);
    }

    /// Retrieves information about a code security integration.
    pub fn getCodeSecurityIntegration(self: *Self, allocator: std.mem.Allocator, input: get_code_security_integration.GetCodeSecurityIntegrationInput, options: get_code_security_integration.Options) !get_code_security_integration.GetCodeSecurityIntegrationOutput {
        return get_code_security_integration.execute(self, allocator, input, options);
    }

    /// Retrieves information about a specific code security scan.
    pub fn getCodeSecurityScan(self: *Self, allocator: std.mem.Allocator, input: get_code_security_scan.GetCodeSecurityScanInput, options: get_code_security_scan.Options) !get_code_security_scan.GetCodeSecurityScanOutput {
        return get_code_security_scan.execute(self, allocator, input, options);
    }

    /// Retrieves information about a code security scan configuration.
    pub fn getCodeSecurityScanConfiguration(self: *Self, allocator: std.mem.Allocator, input: get_code_security_scan_configuration.GetCodeSecurityScanConfigurationInput, options: get_code_security_scan_configuration.Options) !get_code_security_scan_configuration.GetCodeSecurityScanConfigurationOutput {
        return get_code_security_scan_configuration.execute(self, allocator, input, options);
    }

    /// Retrieves setting configurations for Inspector scans.
    pub fn getConfiguration(self: *Self, allocator: std.mem.Allocator, input: get_configuration.GetConfigurationInput, options: get_configuration.Options) !get_configuration.GetConfigurationOutput {
        return get_configuration.execute(self, allocator, input, options);
    }

    /// Retrieves information about the Amazon Inspector delegated administrator for
    /// your
    /// organization.
    pub fn getDelegatedAdminAccount(self: *Self, allocator: std.mem.Allocator, input: get_delegated_admin_account.GetDelegatedAdminAccountInput, options: get_delegated_admin_account.Options) !get_delegated_admin_account.GetDelegatedAdminAccountOutput {
        return get_delegated_admin_account.execute(self, allocator, input, options);
    }

    /// Retrieves the activation status of Amazon Inspector deep inspection and
    /// custom paths associated
    /// with your account.
    pub fn getEc2DeepInspectionConfiguration(self: *Self, allocator: std.mem.Allocator, input: get_ec_2_deep_inspection_configuration.GetEc2DeepInspectionConfigurationInput, options: get_ec_2_deep_inspection_configuration.Options) !get_ec_2_deep_inspection_configuration.GetEc2DeepInspectionConfigurationOutput {
        return get_ec_2_deep_inspection_configuration.execute(self, allocator, input, options);
    }

    /// Gets an encryption key.
    pub fn getEncryptionKey(self: *Self, allocator: std.mem.Allocator, input: get_encryption_key.GetEncryptionKeyInput, options: get_encryption_key.Options) !get_encryption_key.GetEncryptionKeyOutput {
        return get_encryption_key.execute(self, allocator, input, options);
    }

    /// Gets the status of a findings report.
    pub fn getFindingsReportStatus(self: *Self, allocator: std.mem.Allocator, input: get_findings_report_status.GetFindingsReportStatusInput, options: get_findings_report_status.Options) !get_findings_report_status.GetFindingsReportStatusOutput {
        return get_findings_report_status.execute(self, allocator, input, options);
    }

    /// Gets member information for your organization.
    pub fn getMember(self: *Self, allocator: std.mem.Allocator, input: get_member.GetMemberInput, options: get_member.Options) !get_member.GetMemberOutput {
        return get_member.execute(self, allocator, input, options);
    }

    /// Gets details of a software bill of materials (SBOM) report.
    pub fn getSbomExport(self: *Self, allocator: std.mem.Allocator, input: get_sbom_export.GetSbomExportInput, options: get_sbom_export.Options) !get_sbom_export.GetSbomExportOutput {
        return get_sbom_export.execute(self, allocator, input, options);
    }

    /// Lists the permissions an account has to configure Amazon Inspector.
    /// If the account is a member account or standalone account with resources
    /// managed by an Organizations policy, the operation returns fewer permissions.
    pub fn listAccountPermissions(self: *Self, allocator: std.mem.Allocator, input: list_account_permissions.ListAccountPermissionsInput, options: list_account_permissions.Options) !list_account_permissions.ListAccountPermissionsOutput {
        return list_account_permissions.execute(self, allocator, input, options);
    }

    /// Lists CIS scan configurations.
    pub fn listCisScanConfigurations(self: *Self, allocator: std.mem.Allocator, input: list_cis_scan_configurations.ListCisScanConfigurationsInput, options: list_cis_scan_configurations.Options) !list_cis_scan_configurations.ListCisScanConfigurationsOutput {
        return list_cis_scan_configurations.execute(self, allocator, input, options);
    }

    /// Lists scan results aggregated by checks.
    pub fn listCisScanResultsAggregatedByChecks(self: *Self, allocator: std.mem.Allocator, input: list_cis_scan_results_aggregated_by_checks.ListCisScanResultsAggregatedByChecksInput, options: list_cis_scan_results_aggregated_by_checks.Options) !list_cis_scan_results_aggregated_by_checks.ListCisScanResultsAggregatedByChecksOutput {
        return list_cis_scan_results_aggregated_by_checks.execute(self, allocator, input, options);
    }

    /// Lists scan results aggregated by a target resource.
    pub fn listCisScanResultsAggregatedByTargetResource(self: *Self, allocator: std.mem.Allocator, input: list_cis_scan_results_aggregated_by_target_resource.ListCisScanResultsAggregatedByTargetResourceInput, options: list_cis_scan_results_aggregated_by_target_resource.Options) !list_cis_scan_results_aggregated_by_target_resource.ListCisScanResultsAggregatedByTargetResourceOutput {
        return list_cis_scan_results_aggregated_by_target_resource.execute(self, allocator, input, options);
    }

    /// Returns a CIS scan list.
    pub fn listCisScans(self: *Self, allocator: std.mem.Allocator, input: list_cis_scans.ListCisScansInput, options: list_cis_scans.Options) !list_cis_scans.ListCisScansOutput {
        return list_cis_scans.execute(self, allocator, input, options);
    }

    /// Lists all code security integrations in your account.
    pub fn listCodeSecurityIntegrations(self: *Self, allocator: std.mem.Allocator, input: list_code_security_integrations.ListCodeSecurityIntegrationsInput, options: list_code_security_integrations.Options) !list_code_security_integrations.ListCodeSecurityIntegrationsOutput {
        return list_code_security_integrations.execute(self, allocator, input, options);
    }

    /// Lists the associations between code repositories and Amazon Inspector code
    /// security scan
    /// configurations.
    pub fn listCodeSecurityScanConfigurationAssociations(self: *Self, allocator: std.mem.Allocator, input: list_code_security_scan_configuration_associations.ListCodeSecurityScanConfigurationAssociationsInput, options: list_code_security_scan_configuration_associations.Options) !list_code_security_scan_configuration_associations.ListCodeSecurityScanConfigurationAssociationsOutput {
        return list_code_security_scan_configuration_associations.execute(self, allocator, input, options);
    }

    /// Lists all code security scan configurations in your account.
    pub fn listCodeSecurityScanConfigurations(self: *Self, allocator: std.mem.Allocator, input: list_code_security_scan_configurations.ListCodeSecurityScanConfigurationsInput, options: list_code_security_scan_configurations.Options) !list_code_security_scan_configurations.ListCodeSecurityScanConfigurationsOutput {
        return list_code_security_scan_configurations.execute(self, allocator, input, options);
    }

    /// Lists coverage details for your environment.
    pub fn listCoverage(self: *Self, allocator: std.mem.Allocator, input: list_coverage.ListCoverageInput, options: list_coverage.Options) !list_coverage.ListCoverageOutput {
        return list_coverage.execute(self, allocator, input, options);
    }

    /// Lists Amazon Inspector coverage statistics for your environment.
    pub fn listCoverageStatistics(self: *Self, allocator: std.mem.Allocator, input: list_coverage_statistics.ListCoverageStatisticsInput, options: list_coverage_statistics.Options) !list_coverage_statistics.ListCoverageStatisticsOutput {
        return list_coverage_statistics.execute(self, allocator, input, options);
    }

    /// Lists information about the Amazon Inspector delegated administrator of your
    /// organization.
    pub fn listDelegatedAdminAccounts(self: *Self, allocator: std.mem.Allocator, input: list_delegated_admin_accounts.ListDelegatedAdminAccountsInput, options: list_delegated_admin_accounts.Options) !list_delegated_admin_accounts.ListDelegatedAdminAccountsOutput {
        return list_delegated_admin_accounts.execute(self, allocator, input, options);
    }

    /// Lists the filters associated with your account.
    pub fn listFilters(self: *Self, allocator: std.mem.Allocator, input: list_filters.ListFiltersInput, options: list_filters.Options) !list_filters.ListFiltersOutput {
        return list_filters.execute(self, allocator, input, options);
    }

    /// Lists aggregated finding data for your environment based on specific
    /// criteria.
    pub fn listFindingAggregations(self: *Self, allocator: std.mem.Allocator, input: list_finding_aggregations.ListFindingAggregationsInput, options: list_finding_aggregations.Options) !list_finding_aggregations.ListFindingAggregationsOutput {
        return list_finding_aggregations.execute(self, allocator, input, options);
    }

    /// Lists findings for your environment.
    pub fn listFindings(self: *Self, allocator: std.mem.Allocator, input: list_findings.ListFindingsInput, options: list_findings.Options) !list_findings.ListFindingsOutput {
        return list_findings.execute(self, allocator, input, options);
    }

    /// List members associated with the Amazon Inspector delegated administrator
    /// for your
    /// organization.
    pub fn listMembers(self: *Self, allocator: std.mem.Allocator, input: list_members.ListMembersInput, options: list_members.Options) !list_members.ListMembersOutput {
        return list_members.execute(self, allocator, input, options);
    }

    /// Lists all tags attached to a given resource.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: list_tags_for_resource.Options) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Lists the Amazon Inspector usage totals over the last 30 days.
    pub fn listUsageTotals(self: *Self, allocator: std.mem.Allocator, input: list_usage_totals.ListUsageTotalsInput, options: list_usage_totals.Options) !list_usage_totals.ListUsageTotalsOutput {
        return list_usage_totals.execute(self, allocator, input, options);
    }

    /// Resets an encryption key. After the key is reset your resources will be
    /// encrypted by an
    /// Amazon Web Services owned key.
    pub fn resetEncryptionKey(self: *Self, allocator: std.mem.Allocator, input: reset_encryption_key.ResetEncryptionKeyInput, options: reset_encryption_key.Options) !reset_encryption_key.ResetEncryptionKeyOutput {
        return reset_encryption_key.execute(self, allocator, input, options);
    }

    /// Lists Amazon Inspector coverage details for a specific vulnerability.
    pub fn searchVulnerabilities(self: *Self, allocator: std.mem.Allocator, input: search_vulnerabilities.SearchVulnerabilitiesInput, options: search_vulnerabilities.Options) !search_vulnerabilities.SearchVulnerabilitiesOutput {
        return search_vulnerabilities.execute(self, allocator, input, options);
    }

    /// Sends a CIS session health. This API is used by the Amazon Inspector SSM
    /// plugin to
    /// communicate with the Amazon Inspector service. The Amazon Inspector SSM
    /// plugin calls
    /// this API to start a CIS scan session for the scan ID supplied by the
    /// service.
    pub fn sendCisSessionHealth(self: *Self, allocator: std.mem.Allocator, input: send_cis_session_health.SendCisSessionHealthInput, options: send_cis_session_health.Options) !send_cis_session_health.SendCisSessionHealthOutput {
        return send_cis_session_health.execute(self, allocator, input, options);
    }

    /// Sends a CIS session telemetry. This API is used by the Amazon Inspector SSM
    /// plugin to
    /// communicate with the Amazon Inspector service. The Amazon Inspector SSM
    /// plugin calls
    /// this API to start a CIS scan session for the scan ID supplied by the
    /// service.
    pub fn sendCisSessionTelemetry(self: *Self, allocator: std.mem.Allocator, input: send_cis_session_telemetry.SendCisSessionTelemetryInput, options: send_cis_session_telemetry.Options) !send_cis_session_telemetry.SendCisSessionTelemetryOutput {
        return send_cis_session_telemetry.execute(self, allocator, input, options);
    }

    /// Starts a CIS session. This API is used by the Amazon Inspector SSM plugin to
    /// communicate with the Amazon Inspector service. The Amazon Inspector SSM
    /// plugin calls
    /// this API to start a CIS scan session for the scan ID supplied by the
    /// service.
    pub fn startCisSession(self: *Self, allocator: std.mem.Allocator, input: start_cis_session.StartCisSessionInput, options: start_cis_session.Options) !start_cis_session.StartCisSessionOutput {
        return start_cis_session.execute(self, allocator, input, options);
    }

    /// Initiates a code security scan on a specified repository.
    pub fn startCodeSecurityScan(self: *Self, allocator: std.mem.Allocator, input: start_code_security_scan.StartCodeSecurityScanInput, options: start_code_security_scan.Options) !start_code_security_scan.StartCodeSecurityScanOutput {
        return start_code_security_scan.execute(self, allocator, input, options);
    }

    /// Stops a CIS session. This API is used by the Amazon Inspector SSM plugin to
    /// communicate with the Amazon Inspector service. The Amazon Inspector SSM
    /// plugin calls
    /// this API to stop a CIS scan session for the scan ID supplied by the service.
    pub fn stopCisSession(self: *Self, allocator: std.mem.Allocator, input: stop_cis_session.StopCisSessionInput, options: stop_cis_session.Options) !stop_cis_session.StopCisSessionOutput {
        return stop_cis_session.execute(self, allocator, input, options);
    }

    /// Adds tags to a resource.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: tag_resource.Options) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Removes tags from a resource.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: untag_resource.Options) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Updates a CIS scan configuration.
    pub fn updateCisScanConfiguration(self: *Self, allocator: std.mem.Allocator, input: update_cis_scan_configuration.UpdateCisScanConfigurationInput, options: update_cis_scan_configuration.Options) !update_cis_scan_configuration.UpdateCisScanConfigurationOutput {
        return update_cis_scan_configuration.execute(self, allocator, input, options);
    }

    /// Updates an existing code security integration.
    ///
    /// After calling the `CreateCodeSecurityIntegration` operation, you complete
    /// authentication and authorization with your provider. Next you call the
    /// `UpdateCodeSecurityIntegration` operation to provide the `details`
    /// to complete the integration setup
    pub fn updateCodeSecurityIntegration(self: *Self, allocator: std.mem.Allocator, input: update_code_security_integration.UpdateCodeSecurityIntegrationInput, options: update_code_security_integration.Options) !update_code_security_integration.UpdateCodeSecurityIntegrationOutput {
        return update_code_security_integration.execute(self, allocator, input, options);
    }

    /// Updates an existing code security scan configuration.
    pub fn updateCodeSecurityScanConfiguration(self: *Self, allocator: std.mem.Allocator, input: update_code_security_scan_configuration.UpdateCodeSecurityScanConfigurationInput, options: update_code_security_scan_configuration.Options) !update_code_security_scan_configuration.UpdateCodeSecurityScanConfigurationOutput {
        return update_code_security_scan_configuration.execute(self, allocator, input, options);
    }

    /// Updates setting configurations for your Amazon Inspector account. When you
    /// use this API as an Amazon Inspector
    /// delegated administrator this updates the setting for all accounts you
    /// manage. Member
    /// accounts in an organization cannot update this setting.
    pub fn updateConfiguration(self: *Self, allocator: std.mem.Allocator, input: update_configuration.UpdateConfigurationInput, options: update_configuration.Options) !update_configuration.UpdateConfigurationOutput {
        return update_configuration.execute(self, allocator, input, options);
    }

    /// Activates, deactivates Amazon Inspector deep inspection, or updates custom
    /// paths for your account.
    pub fn updateEc2DeepInspectionConfiguration(self: *Self, allocator: std.mem.Allocator, input: update_ec_2_deep_inspection_configuration.UpdateEc2DeepInspectionConfigurationInput, options: update_ec_2_deep_inspection_configuration.Options) !update_ec_2_deep_inspection_configuration.UpdateEc2DeepInspectionConfigurationOutput {
        return update_ec_2_deep_inspection_configuration.execute(self, allocator, input, options);
    }

    /// Updates an encryption key. A `ResourceNotFoundException` means that an
    /// Amazon Web Services owned key is being used for encryption.
    pub fn updateEncryptionKey(self: *Self, allocator: std.mem.Allocator, input: update_encryption_key.UpdateEncryptionKeyInput, options: update_encryption_key.Options) !update_encryption_key.UpdateEncryptionKeyOutput {
        return update_encryption_key.execute(self, allocator, input, options);
    }

    /// Specifies the action that is to be applied to the findings that match the
    /// filter.
    pub fn updateFilter(self: *Self, allocator: std.mem.Allocator, input: update_filter.UpdateFilterInput, options: update_filter.Options) !update_filter.UpdateFilterOutput {
        return update_filter.execute(self, allocator, input, options);
    }

    /// Updates the Amazon Inspector deep inspection custom paths for your
    /// organization. You must be an
    /// Amazon Inspector delegated administrator to use this API.
    pub fn updateOrgEc2DeepInspectionConfiguration(self: *Self, allocator: std.mem.Allocator, input: update_org_ec_2_deep_inspection_configuration.UpdateOrgEc2DeepInspectionConfigurationInput, options: update_org_ec_2_deep_inspection_configuration.Options) !update_org_ec_2_deep_inspection_configuration.UpdateOrgEc2DeepInspectionConfigurationOutput {
        return update_org_ec_2_deep_inspection_configuration.execute(self, allocator, input, options);
    }

    /// Updates the configurations for your Amazon Inspector organization.
    pub fn updateOrganizationConfiguration(self: *Self, allocator: std.mem.Allocator, input: update_organization_configuration.UpdateOrganizationConfigurationInput, options: update_organization_configuration.Options) !update_organization_configuration.UpdateOrganizationConfigurationOutput {
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
