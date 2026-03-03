const aws = @import("aws");
const std = @import("std");

const accept_invitation = @import("accept_invitation.zig");
const batch_get_custom_data_identifiers = @import("batch_get_custom_data_identifiers.zig");
const batch_update_automated_discovery_accounts = @import("batch_update_automated_discovery_accounts.zig");
const create_allow_list = @import("create_allow_list.zig");
const create_classification_job = @import("create_classification_job.zig");
const create_custom_data_identifier = @import("create_custom_data_identifier.zig");
const create_findings_filter = @import("create_findings_filter.zig");
const create_invitations = @import("create_invitations.zig");
const create_member = @import("create_member.zig");
const create_sample_findings = @import("create_sample_findings.zig");
const decline_invitations = @import("decline_invitations.zig");
const delete_allow_list = @import("delete_allow_list.zig");
const delete_custom_data_identifier = @import("delete_custom_data_identifier.zig");
const delete_findings_filter = @import("delete_findings_filter.zig");
const delete_invitations = @import("delete_invitations.zig");
const delete_member = @import("delete_member.zig");
const describe_buckets = @import("describe_buckets.zig");
const describe_classification_job = @import("describe_classification_job.zig");
const describe_organization_configuration = @import("describe_organization_configuration.zig");
const disable_macie = @import("disable_macie.zig");
const disable_organization_admin_account = @import("disable_organization_admin_account.zig");
const disassociate_from_administrator_account = @import("disassociate_from_administrator_account.zig");
const disassociate_from_master_account = @import("disassociate_from_master_account.zig");
const disassociate_member = @import("disassociate_member.zig");
const enable_macie = @import("enable_macie.zig");
const enable_organization_admin_account = @import("enable_organization_admin_account.zig");
const get_administrator_account = @import("get_administrator_account.zig");
const get_allow_list = @import("get_allow_list.zig");
const get_automated_discovery_configuration = @import("get_automated_discovery_configuration.zig");
const get_bucket_statistics = @import("get_bucket_statistics.zig");
const get_classification_export_configuration = @import("get_classification_export_configuration.zig");
const get_classification_scope = @import("get_classification_scope.zig");
const get_custom_data_identifier = @import("get_custom_data_identifier.zig");
const get_finding_statistics = @import("get_finding_statistics.zig");
const get_findings = @import("get_findings.zig");
const get_findings_filter = @import("get_findings_filter.zig");
const get_findings_publication_configuration = @import("get_findings_publication_configuration.zig");
const get_invitations_count = @import("get_invitations_count.zig");
const get_macie_session = @import("get_macie_session.zig");
const get_master_account = @import("get_master_account.zig");
const get_member = @import("get_member.zig");
const get_resource_profile = @import("get_resource_profile.zig");
const get_reveal_configuration = @import("get_reveal_configuration.zig");
const get_sensitive_data_occurrences = @import("get_sensitive_data_occurrences.zig");
const get_sensitive_data_occurrences_availability = @import("get_sensitive_data_occurrences_availability.zig");
const get_sensitivity_inspection_template = @import("get_sensitivity_inspection_template.zig");
const get_usage_statistics = @import("get_usage_statistics.zig");
const get_usage_totals = @import("get_usage_totals.zig");
const list_allow_lists = @import("list_allow_lists.zig");
const list_automated_discovery_accounts = @import("list_automated_discovery_accounts.zig");
const list_classification_jobs = @import("list_classification_jobs.zig");
const list_classification_scopes = @import("list_classification_scopes.zig");
const list_custom_data_identifiers = @import("list_custom_data_identifiers.zig");
const list_findings = @import("list_findings.zig");
const list_findings_filters = @import("list_findings_filters.zig");
const list_invitations = @import("list_invitations.zig");
const list_managed_data_identifiers = @import("list_managed_data_identifiers.zig");
const list_members = @import("list_members.zig");
const list_organization_admin_accounts = @import("list_organization_admin_accounts.zig");
const list_resource_profile_artifacts = @import("list_resource_profile_artifacts.zig");
const list_resource_profile_detections = @import("list_resource_profile_detections.zig");
const list_sensitivity_inspection_templates = @import("list_sensitivity_inspection_templates.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const put_classification_export_configuration = @import("put_classification_export_configuration.zig");
const put_findings_publication_configuration = @import("put_findings_publication_configuration.zig");
const search_resources = @import("search_resources.zig");
const tag_resource = @import("tag_resource.zig");
const test_custom_data_identifier = @import("test_custom_data_identifier.zig");
const untag_resource = @import("untag_resource.zig");
const update_allow_list = @import("update_allow_list.zig");
const update_automated_discovery_configuration = @import("update_automated_discovery_configuration.zig");
const update_classification_job = @import("update_classification_job.zig");
const update_classification_scope = @import("update_classification_scope.zig");
const update_findings_filter = @import("update_findings_filter.zig");
const update_macie_session = @import("update_macie_session.zig");
const update_member_session = @import("update_member_session.zig");
const update_organization_configuration = @import("update_organization_configuration.zig");
const update_resource_profile = @import("update_resource_profile.zig");
const update_resource_profile_detections = @import("update_resource_profile_detections.zig");
const update_reveal_configuration = @import("update_reveal_configuration.zig");
const update_sensitivity_inspection_template = @import("update_sensitivity_inspection_template.zig");
const paginator = @import("paginator.zig");
const waiters = @import("waiters.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "Macie2";

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

    /// Accepts an Amazon Macie membership invitation that was received from a
    /// specific account.
    pub fn acceptInvitation(self: *Self, allocator: std.mem.Allocator, input: accept_invitation.AcceptInvitationInput, options: accept_invitation.Options) !accept_invitation.AcceptInvitationOutput {
        return accept_invitation.execute(self, allocator, input, options);
    }

    /// Retrieves information about one or more custom data identifiers.
    pub fn batchGetCustomDataIdentifiers(self: *Self, allocator: std.mem.Allocator, input: batch_get_custom_data_identifiers.BatchGetCustomDataIdentifiersInput, options: batch_get_custom_data_identifiers.Options) !batch_get_custom_data_identifiers.BatchGetCustomDataIdentifiersOutput {
        return batch_get_custom_data_identifiers.execute(self, allocator, input, options);
    }

    /// Changes the status of automated sensitive data discovery for one or more
    /// accounts.
    pub fn batchUpdateAutomatedDiscoveryAccounts(self: *Self, allocator: std.mem.Allocator, input: batch_update_automated_discovery_accounts.BatchUpdateAutomatedDiscoveryAccountsInput, options: batch_update_automated_discovery_accounts.Options) !batch_update_automated_discovery_accounts.BatchUpdateAutomatedDiscoveryAccountsOutput {
        return batch_update_automated_discovery_accounts.execute(self, allocator, input, options);
    }

    /// Creates and defines the settings for an allow list.
    pub fn createAllowList(self: *Self, allocator: std.mem.Allocator, input: create_allow_list.CreateAllowListInput, options: create_allow_list.Options) !create_allow_list.CreateAllowListOutput {
        return create_allow_list.execute(self, allocator, input, options);
    }

    /// Creates and defines the settings for a classification job.
    pub fn createClassificationJob(self: *Self, allocator: std.mem.Allocator, input: create_classification_job.CreateClassificationJobInput, options: create_classification_job.Options) !create_classification_job.CreateClassificationJobOutput {
        return create_classification_job.execute(self, allocator, input, options);
    }

    /// Creates and defines the criteria and other settings for a custom data
    /// identifier.
    pub fn createCustomDataIdentifier(self: *Self, allocator: std.mem.Allocator, input: create_custom_data_identifier.CreateCustomDataIdentifierInput, options: create_custom_data_identifier.Options) !create_custom_data_identifier.CreateCustomDataIdentifierOutput {
        return create_custom_data_identifier.execute(self, allocator, input, options);
    }

    /// Creates and defines the criteria and other settings for a findings filter.
    pub fn createFindingsFilter(self: *Self, allocator: std.mem.Allocator, input: create_findings_filter.CreateFindingsFilterInput, options: create_findings_filter.Options) !create_findings_filter.CreateFindingsFilterOutput {
        return create_findings_filter.execute(self, allocator, input, options);
    }

    /// Sends an Amazon Macie membership invitation to one or more accounts.
    pub fn createInvitations(self: *Self, allocator: std.mem.Allocator, input: create_invitations.CreateInvitationsInput, options: create_invitations.Options) !create_invitations.CreateInvitationsOutput {
        return create_invitations.execute(self, allocator, input, options);
    }

    /// Associates an account with an Amazon Macie administrator account.
    pub fn createMember(self: *Self, allocator: std.mem.Allocator, input: create_member.CreateMemberInput, options: create_member.Options) !create_member.CreateMemberOutput {
        return create_member.execute(self, allocator, input, options);
    }

    /// Creates sample findings.
    pub fn createSampleFindings(self: *Self, allocator: std.mem.Allocator, input: create_sample_findings.CreateSampleFindingsInput, options: create_sample_findings.Options) !create_sample_findings.CreateSampleFindingsOutput {
        return create_sample_findings.execute(self, allocator, input, options);
    }

    /// Declines Amazon Macie membership invitations that were received from
    /// specific accounts.
    pub fn declineInvitations(self: *Self, allocator: std.mem.Allocator, input: decline_invitations.DeclineInvitationsInput, options: decline_invitations.Options) !decline_invitations.DeclineInvitationsOutput {
        return decline_invitations.execute(self, allocator, input, options);
    }

    /// Deletes an allow list.
    pub fn deleteAllowList(self: *Self, allocator: std.mem.Allocator, input: delete_allow_list.DeleteAllowListInput, options: delete_allow_list.Options) !delete_allow_list.DeleteAllowListOutput {
        return delete_allow_list.execute(self, allocator, input, options);
    }

    /// Soft deletes a custom data identifier.
    pub fn deleteCustomDataIdentifier(self: *Self, allocator: std.mem.Allocator, input: delete_custom_data_identifier.DeleteCustomDataIdentifierInput, options: delete_custom_data_identifier.Options) !delete_custom_data_identifier.DeleteCustomDataIdentifierOutput {
        return delete_custom_data_identifier.execute(self, allocator, input, options);
    }

    /// Deletes a findings filter.
    pub fn deleteFindingsFilter(self: *Self, allocator: std.mem.Allocator, input: delete_findings_filter.DeleteFindingsFilterInput, options: delete_findings_filter.Options) !delete_findings_filter.DeleteFindingsFilterOutput {
        return delete_findings_filter.execute(self, allocator, input, options);
    }

    /// Deletes Amazon Macie membership invitations that were received from specific
    /// accounts.
    pub fn deleteInvitations(self: *Self, allocator: std.mem.Allocator, input: delete_invitations.DeleteInvitationsInput, options: delete_invitations.Options) !delete_invitations.DeleteInvitationsOutput {
        return delete_invitations.execute(self, allocator, input, options);
    }

    /// Deletes the association between an Amazon Macie administrator account and an
    /// account.
    pub fn deleteMember(self: *Self, allocator: std.mem.Allocator, input: delete_member.DeleteMemberInput, options: delete_member.Options) !delete_member.DeleteMemberOutput {
        return delete_member.execute(self, allocator, input, options);
    }

    /// Retrieves (queries) statistical data and other information about one or more
    /// S3 buckets that Amazon Macie monitors and analyzes for an account.
    pub fn describeBuckets(self: *Self, allocator: std.mem.Allocator, input: describe_buckets.DescribeBucketsInput, options: describe_buckets.Options) !describe_buckets.DescribeBucketsOutput {
        return describe_buckets.execute(self, allocator, input, options);
    }

    /// Retrieves the status and settings for a classification job.
    pub fn describeClassificationJob(self: *Self, allocator: std.mem.Allocator, input: describe_classification_job.DescribeClassificationJobInput, options: describe_classification_job.Options) !describe_classification_job.DescribeClassificationJobOutput {
        return describe_classification_job.execute(self, allocator, input, options);
    }

    /// Retrieves the Amazon Macie configuration settings for an organization in
    /// Organizations.
    pub fn describeOrganizationConfiguration(self: *Self, allocator: std.mem.Allocator, input: describe_organization_configuration.DescribeOrganizationConfigurationInput, options: describe_organization_configuration.Options) !describe_organization_configuration.DescribeOrganizationConfigurationOutput {
        return describe_organization_configuration.execute(self, allocator, input, options);
    }

    /// Disables Amazon Macie and deletes all settings and resources for a Macie
    /// account.
    pub fn disableMacie(self: *Self, allocator: std.mem.Allocator, input: disable_macie.DisableMacieInput, options: disable_macie.Options) !disable_macie.DisableMacieOutput {
        return disable_macie.execute(self, allocator, input, options);
    }

    /// Disables an account as the delegated Amazon Macie administrator account for
    /// an organization in Organizations.
    pub fn disableOrganizationAdminAccount(self: *Self, allocator: std.mem.Allocator, input: disable_organization_admin_account.DisableOrganizationAdminAccountInput, options: disable_organization_admin_account.Options) !disable_organization_admin_account.DisableOrganizationAdminAccountOutput {
        return disable_organization_admin_account.execute(self, allocator, input, options);
    }

    /// Disassociates a member account from its Amazon Macie administrator account.
    pub fn disassociateFromAdministratorAccount(self: *Self, allocator: std.mem.Allocator, input: disassociate_from_administrator_account.DisassociateFromAdministratorAccountInput, options: disassociate_from_administrator_account.Options) !disassociate_from_administrator_account.DisassociateFromAdministratorAccountOutput {
        return disassociate_from_administrator_account.execute(self, allocator, input, options);
    }

    /// (Deprecated) Disassociates a member account from its Amazon Macie
    /// administrator account. This operation has been replaced by the
    /// DisassociateFromAdministratorAccount operation.
    pub fn disassociateFromMasterAccount(self: *Self, allocator: std.mem.Allocator, input: disassociate_from_master_account.DisassociateFromMasterAccountInput, options: disassociate_from_master_account.Options) !disassociate_from_master_account.DisassociateFromMasterAccountOutput {
        return disassociate_from_master_account.execute(self, allocator, input, options);
    }

    /// Disassociates an Amazon Macie administrator account from a member account.
    pub fn disassociateMember(self: *Self, allocator: std.mem.Allocator, input: disassociate_member.DisassociateMemberInput, options: disassociate_member.Options) !disassociate_member.DisassociateMemberOutput {
        return disassociate_member.execute(self, allocator, input, options);
    }

    /// Enables Amazon Macie and specifies the configuration settings for a Macie
    /// account.
    pub fn enableMacie(self: *Self, allocator: std.mem.Allocator, input: enable_macie.EnableMacieInput, options: enable_macie.Options) !enable_macie.EnableMacieOutput {
        return enable_macie.execute(self, allocator, input, options);
    }

    /// Designates an account as the delegated Amazon Macie administrator account
    /// for an organization in Organizations.
    pub fn enableOrganizationAdminAccount(self: *Self, allocator: std.mem.Allocator, input: enable_organization_admin_account.EnableOrganizationAdminAccountInput, options: enable_organization_admin_account.Options) !enable_organization_admin_account.EnableOrganizationAdminAccountOutput {
        return enable_organization_admin_account.execute(self, allocator, input, options);
    }

    /// Retrieves information about the Amazon Macie administrator account for an
    /// account.
    pub fn getAdministratorAccount(self: *Self, allocator: std.mem.Allocator, input: get_administrator_account.GetAdministratorAccountInput, options: get_administrator_account.Options) !get_administrator_account.GetAdministratorAccountOutput {
        return get_administrator_account.execute(self, allocator, input, options);
    }

    /// Retrieves the settings and status of an allow list.
    pub fn getAllowList(self: *Self, allocator: std.mem.Allocator, input: get_allow_list.GetAllowListInput, options: get_allow_list.Options) !get_allow_list.GetAllowListOutput {
        return get_allow_list.execute(self, allocator, input, options);
    }

    /// Retrieves the configuration settings and status of automated sensitive data
    /// discovery for an organization or standalone account.
    pub fn getAutomatedDiscoveryConfiguration(self: *Self, allocator: std.mem.Allocator, input: get_automated_discovery_configuration.GetAutomatedDiscoveryConfigurationInput, options: get_automated_discovery_configuration.Options) !get_automated_discovery_configuration.GetAutomatedDiscoveryConfigurationOutput {
        return get_automated_discovery_configuration.execute(self, allocator, input, options);
    }

    /// Retrieves (queries) aggregated statistical data about all the S3 buckets
    /// that Amazon Macie monitors and analyzes for an account.
    pub fn getBucketStatistics(self: *Self, allocator: std.mem.Allocator, input: get_bucket_statistics.GetBucketStatisticsInput, options: get_bucket_statistics.Options) !get_bucket_statistics.GetBucketStatisticsOutput {
        return get_bucket_statistics.execute(self, allocator, input, options);
    }

    /// Retrieves the configuration settings for storing data classification
    /// results.
    pub fn getClassificationExportConfiguration(self: *Self, allocator: std.mem.Allocator, input: get_classification_export_configuration.GetClassificationExportConfigurationInput, options: get_classification_export_configuration.Options) !get_classification_export_configuration.GetClassificationExportConfigurationOutput {
        return get_classification_export_configuration.execute(self, allocator, input, options);
    }

    /// Retrieves the classification scope settings for an account.
    pub fn getClassificationScope(self: *Self, allocator: std.mem.Allocator, input: get_classification_scope.GetClassificationScopeInput, options: get_classification_scope.Options) !get_classification_scope.GetClassificationScopeOutput {
        return get_classification_scope.execute(self, allocator, input, options);
    }

    /// Retrieves the criteria and other settings for a custom data identifier.
    pub fn getCustomDataIdentifier(self: *Self, allocator: std.mem.Allocator, input: get_custom_data_identifier.GetCustomDataIdentifierInput, options: get_custom_data_identifier.Options) !get_custom_data_identifier.GetCustomDataIdentifierOutput {
        return get_custom_data_identifier.execute(self, allocator, input, options);
    }

    /// Retrieves (queries) aggregated statistical data about findings.
    pub fn getFindingStatistics(self: *Self, allocator: std.mem.Allocator, input: get_finding_statistics.GetFindingStatisticsInput, options: get_finding_statistics.Options) !get_finding_statistics.GetFindingStatisticsOutput {
        return get_finding_statistics.execute(self, allocator, input, options);
    }

    /// Retrieves the details of one or more findings.
    pub fn getFindings(self: *Self, allocator: std.mem.Allocator, input: get_findings.GetFindingsInput, options: get_findings.Options) !get_findings.GetFindingsOutput {
        return get_findings.execute(self, allocator, input, options);
    }

    /// Retrieves the criteria and other settings for a findings filter.
    pub fn getFindingsFilter(self: *Self, allocator: std.mem.Allocator, input: get_findings_filter.GetFindingsFilterInput, options: get_findings_filter.Options) !get_findings_filter.GetFindingsFilterOutput {
        return get_findings_filter.execute(self, allocator, input, options);
    }

    /// Retrieves the configuration settings for publishing findings to Security
    /// Hub.
    pub fn getFindingsPublicationConfiguration(self: *Self, allocator: std.mem.Allocator, input: get_findings_publication_configuration.GetFindingsPublicationConfigurationInput, options: get_findings_publication_configuration.Options) !get_findings_publication_configuration.GetFindingsPublicationConfigurationOutput {
        return get_findings_publication_configuration.execute(self, allocator, input, options);
    }

    /// Retrieves the count of Amazon Macie membership invitations that were
    /// received by an account.
    pub fn getInvitationsCount(self: *Self, allocator: std.mem.Allocator, input: get_invitations_count.GetInvitationsCountInput, options: get_invitations_count.Options) !get_invitations_count.GetInvitationsCountOutput {
        return get_invitations_count.execute(self, allocator, input, options);
    }

    /// Retrieves the status and configuration settings for an Amazon Macie account.
    pub fn getMacieSession(self: *Self, allocator: std.mem.Allocator, input: get_macie_session.GetMacieSessionInput, options: get_macie_session.Options) !get_macie_session.GetMacieSessionOutput {
        return get_macie_session.execute(self, allocator, input, options);
    }

    /// (Deprecated) Retrieves information about the Amazon Macie administrator
    /// account for an account. This operation has been replaced by the
    /// GetAdministratorAccount operation.
    pub fn getMasterAccount(self: *Self, allocator: std.mem.Allocator, input: get_master_account.GetMasterAccountInput, options: get_master_account.Options) !get_master_account.GetMasterAccountOutput {
        return get_master_account.execute(self, allocator, input, options);
    }

    /// Retrieves information about an account that's associated with an Amazon
    /// Macie administrator account.
    pub fn getMember(self: *Self, allocator: std.mem.Allocator, input: get_member.GetMemberInput, options: get_member.Options) !get_member.GetMemberOutput {
        return get_member.execute(self, allocator, input, options);
    }

    /// Retrieves (queries) sensitive data discovery statistics and the sensitivity
    /// score for an S3 bucket.
    pub fn getResourceProfile(self: *Self, allocator: std.mem.Allocator, input: get_resource_profile.GetResourceProfileInput, options: get_resource_profile.Options) !get_resource_profile.GetResourceProfileOutput {
        return get_resource_profile.execute(self, allocator, input, options);
    }

    /// Retrieves the status and configuration settings for retrieving occurrences
    /// of sensitive data reported by findings.
    pub fn getRevealConfiguration(self: *Self, allocator: std.mem.Allocator, input: get_reveal_configuration.GetRevealConfigurationInput, options: get_reveal_configuration.Options) !get_reveal_configuration.GetRevealConfigurationOutput {
        return get_reveal_configuration.execute(self, allocator, input, options);
    }

    /// Retrieves occurrences of sensitive data reported by a finding.
    pub fn getSensitiveDataOccurrences(self: *Self, allocator: std.mem.Allocator, input: get_sensitive_data_occurrences.GetSensitiveDataOccurrencesInput, options: get_sensitive_data_occurrences.Options) !get_sensitive_data_occurrences.GetSensitiveDataOccurrencesOutput {
        return get_sensitive_data_occurrences.execute(self, allocator, input, options);
    }

    /// Checks whether occurrences of sensitive data can be retrieved for a finding.
    pub fn getSensitiveDataOccurrencesAvailability(self: *Self, allocator: std.mem.Allocator, input: get_sensitive_data_occurrences_availability.GetSensitiveDataOccurrencesAvailabilityInput, options: get_sensitive_data_occurrences_availability.Options) !get_sensitive_data_occurrences_availability.GetSensitiveDataOccurrencesAvailabilityOutput {
        return get_sensitive_data_occurrences_availability.execute(self, allocator, input, options);
    }

    /// Retrieves the settings for the sensitivity inspection template for an
    /// account.
    pub fn getSensitivityInspectionTemplate(self: *Self, allocator: std.mem.Allocator, input: get_sensitivity_inspection_template.GetSensitivityInspectionTemplateInput, options: get_sensitivity_inspection_template.Options) !get_sensitivity_inspection_template.GetSensitivityInspectionTemplateOutput {
        return get_sensitivity_inspection_template.execute(self, allocator, input, options);
    }

    /// Retrieves (queries) quotas and aggregated usage data for one or more
    /// accounts.
    pub fn getUsageStatistics(self: *Self, allocator: std.mem.Allocator, input: get_usage_statistics.GetUsageStatisticsInput, options: get_usage_statistics.Options) !get_usage_statistics.GetUsageStatisticsOutput {
        return get_usage_statistics.execute(self, allocator, input, options);
    }

    /// Retrieves (queries) aggregated usage data for an account.
    pub fn getUsageTotals(self: *Self, allocator: std.mem.Allocator, input: get_usage_totals.GetUsageTotalsInput, options: get_usage_totals.Options) !get_usage_totals.GetUsageTotalsOutput {
        return get_usage_totals.execute(self, allocator, input, options);
    }

    /// Retrieves a subset of information about all the allow lists for an account.
    pub fn listAllowLists(self: *Self, allocator: std.mem.Allocator, input: list_allow_lists.ListAllowListsInput, options: list_allow_lists.Options) !list_allow_lists.ListAllowListsOutput {
        return list_allow_lists.execute(self, allocator, input, options);
    }

    /// Retrieves the status of automated sensitive data discovery for one or more
    /// accounts.
    pub fn listAutomatedDiscoveryAccounts(self: *Self, allocator: std.mem.Allocator, input: list_automated_discovery_accounts.ListAutomatedDiscoveryAccountsInput, options: list_automated_discovery_accounts.Options) !list_automated_discovery_accounts.ListAutomatedDiscoveryAccountsOutput {
        return list_automated_discovery_accounts.execute(self, allocator, input, options);
    }

    /// Retrieves a subset of information about one or more classification jobs.
    pub fn listClassificationJobs(self: *Self, allocator: std.mem.Allocator, input: list_classification_jobs.ListClassificationJobsInput, options: list_classification_jobs.Options) !list_classification_jobs.ListClassificationJobsOutput {
        return list_classification_jobs.execute(self, allocator, input, options);
    }

    /// Retrieves a subset of information about the classification scope for an
    /// account.
    pub fn listClassificationScopes(self: *Self, allocator: std.mem.Allocator, input: list_classification_scopes.ListClassificationScopesInput, options: list_classification_scopes.Options) !list_classification_scopes.ListClassificationScopesOutput {
        return list_classification_scopes.execute(self, allocator, input, options);
    }

    /// Retrieves a subset of information about the custom data identifiers for an
    /// account.
    pub fn listCustomDataIdentifiers(self: *Self, allocator: std.mem.Allocator, input: list_custom_data_identifiers.ListCustomDataIdentifiersInput, options: list_custom_data_identifiers.Options) !list_custom_data_identifiers.ListCustomDataIdentifiersOutput {
        return list_custom_data_identifiers.execute(self, allocator, input, options);
    }

    /// Retrieves a subset of information about one or more findings.
    pub fn listFindings(self: *Self, allocator: std.mem.Allocator, input: list_findings.ListFindingsInput, options: list_findings.Options) !list_findings.ListFindingsOutput {
        return list_findings.execute(self, allocator, input, options);
    }

    /// Retrieves a subset of information about all the findings filters for an
    /// account.
    pub fn listFindingsFilters(self: *Self, allocator: std.mem.Allocator, input: list_findings_filters.ListFindingsFiltersInput, options: list_findings_filters.Options) !list_findings_filters.ListFindingsFiltersOutput {
        return list_findings_filters.execute(self, allocator, input, options);
    }

    /// Retrieves information about Amazon Macie membership invitations that were
    /// received by an account.
    pub fn listInvitations(self: *Self, allocator: std.mem.Allocator, input: list_invitations.ListInvitationsInput, options: list_invitations.Options) !list_invitations.ListInvitationsOutput {
        return list_invitations.execute(self, allocator, input, options);
    }

    /// Retrieves information about all the managed data identifiers that Amazon
    /// Macie currently provides.
    pub fn listManagedDataIdentifiers(self: *Self, allocator: std.mem.Allocator, input: list_managed_data_identifiers.ListManagedDataIdentifiersInput, options: list_managed_data_identifiers.Options) !list_managed_data_identifiers.ListManagedDataIdentifiersOutput {
        return list_managed_data_identifiers.execute(self, allocator, input, options);
    }

    /// Retrieves information about the accounts that are associated with an Amazon
    /// Macie administrator account.
    pub fn listMembers(self: *Self, allocator: std.mem.Allocator, input: list_members.ListMembersInput, options: list_members.Options) !list_members.ListMembersOutput {
        return list_members.execute(self, allocator, input, options);
    }

    /// Retrieves information about the delegated Amazon Macie administrator account
    /// for an organization in Organizations.
    pub fn listOrganizationAdminAccounts(self: *Self, allocator: std.mem.Allocator, input: list_organization_admin_accounts.ListOrganizationAdminAccountsInput, options: list_organization_admin_accounts.Options) !list_organization_admin_accounts.ListOrganizationAdminAccountsOutput {
        return list_organization_admin_accounts.execute(self, allocator, input, options);
    }

    /// Retrieves information about objects that Amazon Macie selected from an S3
    /// bucket for automated sensitive data discovery.
    pub fn listResourceProfileArtifacts(self: *Self, allocator: std.mem.Allocator, input: list_resource_profile_artifacts.ListResourceProfileArtifactsInput, options: list_resource_profile_artifacts.Options) !list_resource_profile_artifacts.ListResourceProfileArtifactsOutput {
        return list_resource_profile_artifacts.execute(self, allocator, input, options);
    }

    /// Retrieves information about the types and amount of sensitive data that
    /// Amazon Macie found in an S3 bucket.
    pub fn listResourceProfileDetections(self: *Self, allocator: std.mem.Allocator, input: list_resource_profile_detections.ListResourceProfileDetectionsInput, options: list_resource_profile_detections.Options) !list_resource_profile_detections.ListResourceProfileDetectionsOutput {
        return list_resource_profile_detections.execute(self, allocator, input, options);
    }

    /// Retrieves a subset of information about the sensitivity inspection template
    /// for an account.
    pub fn listSensitivityInspectionTemplates(self: *Self, allocator: std.mem.Allocator, input: list_sensitivity_inspection_templates.ListSensitivityInspectionTemplatesInput, options: list_sensitivity_inspection_templates.Options) !list_sensitivity_inspection_templates.ListSensitivityInspectionTemplatesOutput {
        return list_sensitivity_inspection_templates.execute(self, allocator, input, options);
    }

    /// Retrieves the tags (keys and values) that are associated with an Amazon
    /// Macie resource.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: list_tags_for_resource.Options) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Adds or updates the configuration settings for storing data classification
    /// results.
    pub fn putClassificationExportConfiguration(self: *Self, allocator: std.mem.Allocator, input: put_classification_export_configuration.PutClassificationExportConfigurationInput, options: put_classification_export_configuration.Options) !put_classification_export_configuration.PutClassificationExportConfigurationOutput {
        return put_classification_export_configuration.execute(self, allocator, input, options);
    }

    /// Updates the configuration settings for publishing findings to Security Hub.
    pub fn putFindingsPublicationConfiguration(self: *Self, allocator: std.mem.Allocator, input: put_findings_publication_configuration.PutFindingsPublicationConfigurationInput, options: put_findings_publication_configuration.Options) !put_findings_publication_configuration.PutFindingsPublicationConfigurationOutput {
        return put_findings_publication_configuration.execute(self, allocator, input, options);
    }

    /// Retrieves (queries) statistical data and other information about Amazon Web
    /// Services resources that Amazon Macie monitors and analyzes for an account.
    pub fn searchResources(self: *Self, allocator: std.mem.Allocator, input: search_resources.SearchResourcesInput, options: search_resources.Options) !search_resources.SearchResourcesOutput {
        return search_resources.execute(self, allocator, input, options);
    }

    /// Adds or updates one or more tags (keys and values) that are associated with
    /// an Amazon Macie resource.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: tag_resource.Options) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Tests criteria for a custom data identifier.
    pub fn testCustomDataIdentifier(self: *Self, allocator: std.mem.Allocator, input: test_custom_data_identifier.TestCustomDataIdentifierInput, options: test_custom_data_identifier.Options) !test_custom_data_identifier.TestCustomDataIdentifierOutput {
        return test_custom_data_identifier.execute(self, allocator, input, options);
    }

    /// Removes one or more tags (keys and values) from an Amazon Macie resource.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: untag_resource.Options) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Updates the settings for an allow list.
    pub fn updateAllowList(self: *Self, allocator: std.mem.Allocator, input: update_allow_list.UpdateAllowListInput, options: update_allow_list.Options) !update_allow_list.UpdateAllowListOutput {
        return update_allow_list.execute(self, allocator, input, options);
    }

    /// Changes the configuration settings and status of automated sensitive data
    /// discovery for an organization or standalone account.
    pub fn updateAutomatedDiscoveryConfiguration(self: *Self, allocator: std.mem.Allocator, input: update_automated_discovery_configuration.UpdateAutomatedDiscoveryConfigurationInput, options: update_automated_discovery_configuration.Options) !update_automated_discovery_configuration.UpdateAutomatedDiscoveryConfigurationOutput {
        return update_automated_discovery_configuration.execute(self, allocator, input, options);
    }

    /// Changes the status of a classification job.
    pub fn updateClassificationJob(self: *Self, allocator: std.mem.Allocator, input: update_classification_job.UpdateClassificationJobInput, options: update_classification_job.Options) !update_classification_job.UpdateClassificationJobOutput {
        return update_classification_job.execute(self, allocator, input, options);
    }

    /// Updates the classification scope settings for an account.
    pub fn updateClassificationScope(self: *Self, allocator: std.mem.Allocator, input: update_classification_scope.UpdateClassificationScopeInput, options: update_classification_scope.Options) !update_classification_scope.UpdateClassificationScopeOutput {
        return update_classification_scope.execute(self, allocator, input, options);
    }

    /// Updates the criteria and other settings for a findings filter.
    pub fn updateFindingsFilter(self: *Self, allocator: std.mem.Allocator, input: update_findings_filter.UpdateFindingsFilterInput, options: update_findings_filter.Options) !update_findings_filter.UpdateFindingsFilterOutput {
        return update_findings_filter.execute(self, allocator, input, options);
    }

    /// Suspends or re-enables Amazon Macie, or updates the configuration settings
    /// for a Macie account.
    pub fn updateMacieSession(self: *Self, allocator: std.mem.Allocator, input: update_macie_session.UpdateMacieSessionInput, options: update_macie_session.Options) !update_macie_session.UpdateMacieSessionOutput {
        return update_macie_session.execute(self, allocator, input, options);
    }

    /// Enables an Amazon Macie administrator to suspend or re-enable Macie for a
    /// member account.
    pub fn updateMemberSession(self: *Self, allocator: std.mem.Allocator, input: update_member_session.UpdateMemberSessionInput, options: update_member_session.Options) !update_member_session.UpdateMemberSessionOutput {
        return update_member_session.execute(self, allocator, input, options);
    }

    /// Updates the Amazon Macie configuration settings for an organization in
    /// Organizations.
    pub fn updateOrganizationConfiguration(self: *Self, allocator: std.mem.Allocator, input: update_organization_configuration.UpdateOrganizationConfigurationInput, options: update_organization_configuration.Options) !update_organization_configuration.UpdateOrganizationConfigurationOutput {
        return update_organization_configuration.execute(self, allocator, input, options);
    }

    /// Updates the sensitivity score for an S3 bucket.
    pub fn updateResourceProfile(self: *Self, allocator: std.mem.Allocator, input: update_resource_profile.UpdateResourceProfileInput, options: update_resource_profile.Options) !update_resource_profile.UpdateResourceProfileOutput {
        return update_resource_profile.execute(self, allocator, input, options);
    }

    /// Updates the sensitivity scoring settings for an S3 bucket.
    pub fn updateResourceProfileDetections(self: *Self, allocator: std.mem.Allocator, input: update_resource_profile_detections.UpdateResourceProfileDetectionsInput, options: update_resource_profile_detections.Options) !update_resource_profile_detections.UpdateResourceProfileDetectionsOutput {
        return update_resource_profile_detections.execute(self, allocator, input, options);
    }

    /// Updates the status and configuration settings for retrieving occurrences of
    /// sensitive data reported by findings.
    pub fn updateRevealConfiguration(self: *Self, allocator: std.mem.Allocator, input: update_reveal_configuration.UpdateRevealConfigurationInput, options: update_reveal_configuration.Options) !update_reveal_configuration.UpdateRevealConfigurationOutput {
        return update_reveal_configuration.execute(self, allocator, input, options);
    }

    /// Updates the settings for the sensitivity inspection template for an account.
    pub fn updateSensitivityInspectionTemplate(self: *Self, allocator: std.mem.Allocator, input: update_sensitivity_inspection_template.UpdateSensitivityInspectionTemplateInput, options: update_sensitivity_inspection_template.Options) !update_sensitivity_inspection_template.UpdateSensitivityInspectionTemplateOutput {
        return update_sensitivity_inspection_template.execute(self, allocator, input, options);
    }

    pub fn describeBucketsPaginator(self: *Self, params: describe_buckets.DescribeBucketsInput) paginator.DescribeBucketsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn getUsageStatisticsPaginator(self: *Self, params: get_usage_statistics.GetUsageStatisticsInput) paginator.GetUsageStatisticsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listAllowListsPaginator(self: *Self, params: list_allow_lists.ListAllowListsInput) paginator.ListAllowListsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listAutomatedDiscoveryAccountsPaginator(self: *Self, params: list_automated_discovery_accounts.ListAutomatedDiscoveryAccountsInput) paginator.ListAutomatedDiscoveryAccountsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listClassificationJobsPaginator(self: *Self, params: list_classification_jobs.ListClassificationJobsInput) paginator.ListClassificationJobsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listClassificationScopesPaginator(self: *Self, params: list_classification_scopes.ListClassificationScopesInput) paginator.ListClassificationScopesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listCustomDataIdentifiersPaginator(self: *Self, params: list_custom_data_identifiers.ListCustomDataIdentifiersInput) paginator.ListCustomDataIdentifiersPaginator {
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

    pub fn listFindingsFiltersPaginator(self: *Self, params: list_findings_filters.ListFindingsFiltersInput) paginator.ListFindingsFiltersPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listInvitationsPaginator(self: *Self, params: list_invitations.ListInvitationsInput) paginator.ListInvitationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listManagedDataIdentifiersPaginator(self: *Self, params: list_managed_data_identifiers.ListManagedDataIdentifiersInput) paginator.ListManagedDataIdentifiersPaginator {
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

    pub fn listOrganizationAdminAccountsPaginator(self: *Self, params: list_organization_admin_accounts.ListOrganizationAdminAccountsInput) paginator.ListOrganizationAdminAccountsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listResourceProfileArtifactsPaginator(self: *Self, params: list_resource_profile_artifacts.ListResourceProfileArtifactsInput) paginator.ListResourceProfileArtifactsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listResourceProfileDetectionsPaginator(self: *Self, params: list_resource_profile_detections.ListResourceProfileDetectionsInput) paginator.ListResourceProfileDetectionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listSensitivityInspectionTemplatesPaginator(self: *Self, params: list_sensitivity_inspection_templates.ListSensitivityInspectionTemplatesInput) paginator.ListSensitivityInspectionTemplatesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn searchResourcesPaginator(self: *Self, params: search_resources.SearchResourcesInput) paginator.SearchResourcesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn waitUntilFindingRevealed(self: *Self, params: get_sensitive_data_occurrences.GetSensitiveDataOccurrencesInput) aws.waiter.WaiterError!void {
        var w = waiters.FindingRevealedWaiter{ .client = self, .params = params };
        return w.wait();
    }
};
