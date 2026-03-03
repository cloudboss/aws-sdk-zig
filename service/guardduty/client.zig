const aws = @import("aws");
const std = @import("std");

const accept_administrator_invitation = @import("accept_administrator_invitation.zig");
const accept_invitation = @import("accept_invitation.zig");
const archive_findings = @import("archive_findings.zig");
const create_detector = @import("create_detector.zig");
const create_filter = @import("create_filter.zig");
const create_ip_set = @import("create_ip_set.zig");
const create_malware_protection_plan = @import("create_malware_protection_plan.zig");
const create_members = @import("create_members.zig");
const create_publishing_destination = @import("create_publishing_destination.zig");
const create_sample_findings = @import("create_sample_findings.zig");
const create_threat_entity_set = @import("create_threat_entity_set.zig");
const create_threat_intel_set = @import("create_threat_intel_set.zig");
const create_trusted_entity_set = @import("create_trusted_entity_set.zig");
const decline_invitations = @import("decline_invitations.zig");
const delete_detector = @import("delete_detector.zig");
const delete_filter = @import("delete_filter.zig");
const delete_invitations = @import("delete_invitations.zig");
const delete_ip_set = @import("delete_ip_set.zig");
const delete_malware_protection_plan = @import("delete_malware_protection_plan.zig");
const delete_members = @import("delete_members.zig");
const delete_publishing_destination = @import("delete_publishing_destination.zig");
const delete_threat_entity_set = @import("delete_threat_entity_set.zig");
const delete_threat_intel_set = @import("delete_threat_intel_set.zig");
const delete_trusted_entity_set = @import("delete_trusted_entity_set.zig");
const describe_malware_scans = @import("describe_malware_scans.zig");
const describe_organization_configuration = @import("describe_organization_configuration.zig");
const describe_publishing_destination = @import("describe_publishing_destination.zig");
const disable_organization_admin_account = @import("disable_organization_admin_account.zig");
const disassociate_from_administrator_account = @import("disassociate_from_administrator_account.zig");
const disassociate_from_master_account = @import("disassociate_from_master_account.zig");
const disassociate_members = @import("disassociate_members.zig");
const enable_organization_admin_account = @import("enable_organization_admin_account.zig");
const get_administrator_account = @import("get_administrator_account.zig");
const get_coverage_statistics = @import("get_coverage_statistics.zig");
const get_detector = @import("get_detector.zig");
const get_filter = @import("get_filter.zig");
const get_findings = @import("get_findings.zig");
const get_findings_statistics = @import("get_findings_statistics.zig");
const get_invitations_count = @import("get_invitations_count.zig");
const get_ip_set = @import("get_ip_set.zig");
const get_malware_protection_plan = @import("get_malware_protection_plan.zig");
const get_malware_scan = @import("get_malware_scan.zig");
const get_malware_scan_settings = @import("get_malware_scan_settings.zig");
const get_master_account = @import("get_master_account.zig");
const get_member_detectors = @import("get_member_detectors.zig");
const get_members = @import("get_members.zig");
const get_organization_statistics = @import("get_organization_statistics.zig");
const get_remaining_free_trial_days = @import("get_remaining_free_trial_days.zig");
const get_threat_entity_set = @import("get_threat_entity_set.zig");
const get_threat_intel_set = @import("get_threat_intel_set.zig");
const get_trusted_entity_set = @import("get_trusted_entity_set.zig");
const get_usage_statistics = @import("get_usage_statistics.zig");
const invite_members = @import("invite_members.zig");
const list_coverage = @import("list_coverage.zig");
const list_detectors = @import("list_detectors.zig");
const list_filters = @import("list_filters.zig");
const list_findings = @import("list_findings.zig");
const list_invitations = @import("list_invitations.zig");
const list_ip_sets = @import("list_ip_sets.zig");
const list_malware_protection_plans = @import("list_malware_protection_plans.zig");
const list_malware_scans = @import("list_malware_scans.zig");
const list_members = @import("list_members.zig");
const list_organization_admin_accounts = @import("list_organization_admin_accounts.zig");
const list_publishing_destinations = @import("list_publishing_destinations.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const list_threat_entity_sets = @import("list_threat_entity_sets.zig");
const list_threat_intel_sets = @import("list_threat_intel_sets.zig");
const list_trusted_entity_sets = @import("list_trusted_entity_sets.zig");
const send_object_malware_scan = @import("send_object_malware_scan.zig");
const start_malware_scan = @import("start_malware_scan.zig");
const start_monitoring_members = @import("start_monitoring_members.zig");
const stop_monitoring_members = @import("stop_monitoring_members.zig");
const tag_resource = @import("tag_resource.zig");
const unarchive_findings = @import("unarchive_findings.zig");
const untag_resource = @import("untag_resource.zig");
const update_detector = @import("update_detector.zig");
const update_filter = @import("update_filter.zig");
const update_findings_feedback = @import("update_findings_feedback.zig");
const update_ip_set = @import("update_ip_set.zig");
const update_malware_protection_plan = @import("update_malware_protection_plan.zig");
const update_malware_scan_settings = @import("update_malware_scan_settings.zig");
const update_member_detectors = @import("update_member_detectors.zig");
const update_organization_configuration = @import("update_organization_configuration.zig");
const update_publishing_destination = @import("update_publishing_destination.zig");
const update_threat_entity_set = @import("update_threat_entity_set.zig");
const update_threat_intel_set = @import("update_threat_intel_set.zig");
const update_trusted_entity_set = @import("update_trusted_entity_set.zig");
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "GuardDuty";

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

    /// Accepts the invitation to be a member account and get monitored by a
    /// GuardDuty
    /// administrator account that sent the invitation.
    pub fn acceptAdministratorInvitation(self: *Self, allocator: std.mem.Allocator, input: accept_administrator_invitation.AcceptAdministratorInvitationInput, options: accept_administrator_invitation.Options) !accept_administrator_invitation.AcceptAdministratorInvitationOutput {
        return accept_administrator_invitation.execute(self, allocator, input, options);
    }

    /// Accepts the invitation to be monitored by a GuardDuty administrator account.
    pub fn acceptInvitation(self: *Self, allocator: std.mem.Allocator, input: accept_invitation.AcceptInvitationInput, options: accept_invitation.Options) !accept_invitation.AcceptInvitationOutput {
        return accept_invitation.execute(self, allocator, input, options);
    }

    /// Archives GuardDuty findings that are specified by the list of finding IDs.
    ///
    /// Only the administrator account can archive findings. Member accounts don't
    /// have
    /// permission to archive findings from their accounts.
    pub fn archiveFindings(self: *Self, allocator: std.mem.Allocator, input: archive_findings.ArchiveFindingsInput, options: archive_findings.Options) !archive_findings.ArchiveFindingsOutput {
        return archive_findings.execute(self, allocator, input, options);
    }

    /// Creates a single GuardDuty detector. A detector is a resource that
    /// represents the
    /// GuardDuty service. To start using GuardDuty, you must create a detector in
    /// each Region where
    /// you enable the service. You can have only one detector per account per
    /// Region. All data
    /// sources are enabled in a new detector by default.
    ///
    /// * When you don't specify any `features`, with an
    /// exception to `RUNTIME_MONITORING`, all the optional features are
    /// enabled by default.
    ///
    /// * When you specify some of the `features`, any feature that is not specified
    ///   in the
    /// API call gets enabled by default, with an exception to `RUNTIME_MONITORING`.
    ///
    /// Specifying both EKS Runtime Monitoring (`EKS_RUNTIME_MONITORING`)
    /// and Runtime Monitoring (`RUNTIME_MONITORING`) will cause an error.
    /// You can add only one of these two features because Runtime Monitoring
    /// already includes the
    /// threat detection for Amazon EKS resources. For more information, see
    /// [Runtime
    /// Monitoring](https://docs.aws.amazon.com/guardduty/latest/ug/runtime-monitoring.html).
    ///
    /// There might be regional differences because some data sources might not be
    /// available in all the Amazon Web Services Regions where GuardDuty is
    /// presently supported. For more
    /// information, see [Regions and
    /// endpoints](https://docs.aws.amazon.com/guardduty/latest/ug/guardduty_regions.html).
    pub fn createDetector(self: *Self, allocator: std.mem.Allocator, input: create_detector.CreateDetectorInput, options: create_detector.Options) !create_detector.CreateDetectorOutput {
        return create_detector.execute(self, allocator, input, options);
    }

    /// Creates a filter using the specified finding criteria. The maximum number of
    /// saved filters
    /// per Amazon Web Services account per Region is 100. For more information, see
    /// [Quotas for
    /// GuardDuty](https://docs.aws.amazon.com/guardduty/latest/ug/guardduty_limits.html).
    pub fn createFilter(self: *Self, allocator: std.mem.Allocator, input: create_filter.CreateFilterInput, options: create_filter.Options) !create_filter.CreateFilterOutput {
        return create_filter.execute(self, allocator, input, options);
    }

    /// Creates a new IPSet, which is called a trusted IP list in the console user
    /// interface. An
    /// IPSet is a list of IP addresses that are trusted for secure communication
    /// with Amazon Web Services
    /// infrastructure and applications. GuardDuty doesn't generate findings for IP
    /// addresses that are
    /// included in IPSets. Only users from the administrator account can use this
    /// operation.
    pub fn createIpSet(self: *Self, allocator: std.mem.Allocator, input: create_ip_set.CreateIPSetInput, options: create_ip_set.Options) !create_ip_set.CreateIPSetOutput {
        return create_ip_set.execute(self, allocator, input, options);
    }

    /// Creates a new Malware Protection plan for the protected resource.
    ///
    /// When you create a Malware Protection plan, the Amazon Web Services service
    /// terms for GuardDuty Malware
    /// Protection apply. For more information, see [Amazon Web Services service
    /// terms for GuardDuty Malware
    /// Protection](http://aws.amazon.com/service-terms/#87._Amazon_GuardDuty).
    pub fn createMalwareProtectionPlan(self: *Self, allocator: std.mem.Allocator, input: create_malware_protection_plan.CreateMalwareProtectionPlanInput, options: create_malware_protection_plan.Options) !create_malware_protection_plan.CreateMalwareProtectionPlanOutput {
        return create_malware_protection_plan.execute(self, allocator, input, options);
    }

    /// Creates member accounts of the current Amazon Web Services account by
    /// specifying a list of Amazon Web Services account
    /// IDs. This step is a prerequisite for managing the associated member accounts
    /// either by
    /// invitation or through an organization.
    ///
    /// As a delegated administrator, using `CreateMembers` will enable GuardDuty in
    /// the added member accounts, with the exception of the
    /// organization delegated administrator account. A delegated administrator must
    /// enable GuardDuty
    /// prior to being added as a member.
    ///
    /// When you use CreateMembers as an Organizations delegated
    /// administrator, GuardDuty applies your organization's auto-enable settings to
    /// the member
    /// accounts in this request, irrespective of the accounts being new or existing
    /// members. For
    /// more information about the existing auto-enable settings for your
    /// organization, see
    /// [DescribeOrganizationConfiguration](https://docs.aws.amazon.com/guardduty/latest/APIReference/API_DescribeOrganizationConfiguration.html).
    ///
    /// If you disassociate a member account that was added by invitation, the
    /// member account details
    /// obtained from this API, including the associated email addresses, will be
    /// retained.
    /// This is done so that the delegated administrator can invoke the
    /// [InviteMembers](https://docs.aws.amazon.com/guardduty/latest/APIReference/API_InviteMembers.html) API without the need to invoke the CreateMembers API again. To
    /// remove the details associated with a member account, the delegated
    /// administrator must invoke the
    /// [DeleteMembers](https://docs.aws.amazon.com/guardduty/latest/APIReference/API_DeleteMembers.html) API.
    ///
    /// When the member accounts added through Organizations are later
    /// disassociated, you (administrator)
    /// can't invite them by calling the InviteMembers API. You can create an
    /// association with these
    /// member accounts again only by calling the CreateMembers API.
    pub fn createMembers(self: *Self, allocator: std.mem.Allocator, input: create_members.CreateMembersInput, options: create_members.Options) !create_members.CreateMembersOutput {
        return create_members.execute(self, allocator, input, options);
    }

    /// Creates a publishing destination where you can export your GuardDuty
    /// findings. Before you start exporting the
    /// findings, the destination resource must exist.
    pub fn createPublishingDestination(self: *Self, allocator: std.mem.Allocator, input: create_publishing_destination.CreatePublishingDestinationInput, options: create_publishing_destination.Options) !create_publishing_destination.CreatePublishingDestinationOutput {
        return create_publishing_destination.execute(self, allocator, input, options);
    }

    /// Generates sample findings of types specified by the list of finding types.
    /// If 'NULL' is
    /// specified for `findingTypes`, the API generates sample findings of all
    /// supported
    /// finding types.
    pub fn createSampleFindings(self: *Self, allocator: std.mem.Allocator, input: create_sample_findings.CreateSampleFindingsInput, options: create_sample_findings.Options) !create_sample_findings.CreateSampleFindingsOutput {
        return create_sample_findings.execute(self, allocator, input, options);
    }

    /// Creates a new threat entity set. In a threat entity set, you can provide
    /// known malicious
    /// IP addresses and domains for your Amazon Web Services environment.
    /// GuardDuty generates findings based on the entries in the threat entity sets.
    /// Only users of the administrator account can manage entity sets, which
    /// automatically apply
    /// to member accounts.
    pub fn createThreatEntitySet(self: *Self, allocator: std.mem.Allocator, input: create_threat_entity_set.CreateThreatEntitySetInput, options: create_threat_entity_set.Options) !create_threat_entity_set.CreateThreatEntitySetOutput {
        return create_threat_entity_set.execute(self, allocator, input, options);
    }

    /// Creates a new ThreatIntelSet. ThreatIntelSets consist of known malicious IP
    /// addresses.
    /// GuardDuty generates findings based on ThreatIntelSets. Only users of the
    /// administrator
    /// account can use this operation.
    pub fn createThreatIntelSet(self: *Self, allocator: std.mem.Allocator, input: create_threat_intel_set.CreateThreatIntelSetInput, options: create_threat_intel_set.Options) !create_threat_intel_set.CreateThreatIntelSetOutput {
        return create_threat_intel_set.execute(self, allocator, input, options);
    }

    /// Creates a new trusted entity set. In the trusted entity set, you can provide
    /// IP addresses
    /// and domains that you believe are secure for communication in your Amazon Web
    /// Services environment. GuardDuty
    /// will not generate findings for the entries that are specified in a trusted
    /// entity set. At any
    /// given time, you can have only one trusted entity set.
    ///
    /// Only users of the administrator account can manage the entity sets, which
    /// automatically
    /// apply to member accounts.
    pub fn createTrustedEntitySet(self: *Self, allocator: std.mem.Allocator, input: create_trusted_entity_set.CreateTrustedEntitySetInput, options: create_trusted_entity_set.Options) !create_trusted_entity_set.CreateTrustedEntitySetOutput {
        return create_trusted_entity_set.execute(self, allocator, input, options);
    }

    /// Declines invitations sent to the current member account by Amazon Web
    /// Services accounts specified by
    /// their account IDs.
    pub fn declineInvitations(self: *Self, allocator: std.mem.Allocator, input: decline_invitations.DeclineInvitationsInput, options: decline_invitations.Options) !decline_invitations.DeclineInvitationsOutput {
        return decline_invitations.execute(self, allocator, input, options);
    }

    /// Deletes an Amazon GuardDuty detector that is specified by the detector ID.
    pub fn deleteDetector(self: *Self, allocator: std.mem.Allocator, input: delete_detector.DeleteDetectorInput, options: delete_detector.Options) !delete_detector.DeleteDetectorOutput {
        return delete_detector.execute(self, allocator, input, options);
    }

    /// Deletes the filter specified by the filter name.
    pub fn deleteFilter(self: *Self, allocator: std.mem.Allocator, input: delete_filter.DeleteFilterInput, options: delete_filter.Options) !delete_filter.DeleteFilterOutput {
        return delete_filter.execute(self, allocator, input, options);
    }

    /// Deletes invitations sent to the current member account by Amazon Web
    /// Services accounts specified by
    /// their account IDs.
    pub fn deleteInvitations(self: *Self, allocator: std.mem.Allocator, input: delete_invitations.DeleteInvitationsInput, options: delete_invitations.Options) !delete_invitations.DeleteInvitationsOutput {
        return delete_invitations.execute(self, allocator, input, options);
    }

    /// Deletes the IPSet specified by the `ipSetId`. IPSets are called trusted IP
    /// lists in the console user interface.
    pub fn deleteIpSet(self: *Self, allocator: std.mem.Allocator, input: delete_ip_set.DeleteIPSetInput, options: delete_ip_set.Options) !delete_ip_set.DeleteIPSetOutput {
        return delete_ip_set.execute(self, allocator, input, options);
    }

    /// Deletes the Malware Protection plan ID associated with the Malware
    /// Protection plan resource.
    /// Use this API only when you no longer want to protect the resource associated
    /// with this
    /// Malware Protection plan ID.
    pub fn deleteMalwareProtectionPlan(self: *Self, allocator: std.mem.Allocator, input: delete_malware_protection_plan.DeleteMalwareProtectionPlanInput, options: delete_malware_protection_plan.Options) !delete_malware_protection_plan.DeleteMalwareProtectionPlanOutput {
        return delete_malware_protection_plan.execute(self, allocator, input, options);
    }

    /// Deletes GuardDuty member accounts (to the current GuardDuty administrator
    /// account)
    /// specified by the account IDs.
    ///
    /// With `autoEnableOrganizationMembers` configuration for your organization set
    /// to
    /// `ALL`, you'll receive an error if you attempt to disable GuardDuty for a
    /// member
    /// account in your organization.
    pub fn deleteMembers(self: *Self, allocator: std.mem.Allocator, input: delete_members.DeleteMembersInput, options: delete_members.Options) !delete_members.DeleteMembersOutput {
        return delete_members.execute(self, allocator, input, options);
    }

    /// Deletes the publishing definition with the specified `destinationId`.
    pub fn deletePublishingDestination(self: *Self, allocator: std.mem.Allocator, input: delete_publishing_destination.DeletePublishingDestinationInput, options: delete_publishing_destination.Options) !delete_publishing_destination.DeletePublishingDestinationOutput {
        return delete_publishing_destination.execute(self, allocator, input, options);
    }

    /// Deletes the threat entity set that is associated with the specified
    /// `threatEntitySetId`.
    pub fn deleteThreatEntitySet(self: *Self, allocator: std.mem.Allocator, input: delete_threat_entity_set.DeleteThreatEntitySetInput, options: delete_threat_entity_set.Options) !delete_threat_entity_set.DeleteThreatEntitySetOutput {
        return delete_threat_entity_set.execute(self, allocator, input, options);
    }

    /// Deletes the ThreatIntelSet specified by the ThreatIntelSet ID.
    pub fn deleteThreatIntelSet(self: *Self, allocator: std.mem.Allocator, input: delete_threat_intel_set.DeleteThreatIntelSetInput, options: delete_threat_intel_set.Options) !delete_threat_intel_set.DeleteThreatIntelSetOutput {
        return delete_threat_intel_set.execute(self, allocator, input, options);
    }

    /// Deletes the trusted entity set that is associated with the specified
    /// `trustedEntitySetId`.
    pub fn deleteTrustedEntitySet(self: *Self, allocator: std.mem.Allocator, input: delete_trusted_entity_set.DeleteTrustedEntitySetInput, options: delete_trusted_entity_set.Options) !delete_trusted_entity_set.DeleteTrustedEntitySetOutput {
        return delete_trusted_entity_set.execute(self, allocator, input, options);
    }

    /// Returns a list of malware scans. Each member account can view the malware
    /// scans for their
    /// own accounts. An administrator can view the malware scans for all the member
    /// accounts.
    ///
    /// There might be regional differences because some data sources might not be
    /// available in all the Amazon Web Services Regions where GuardDuty is
    /// presently supported. For more
    /// information, see [Regions and
    /// endpoints](https://docs.aws.amazon.com/guardduty/latest/ug/guardduty_regions.html).
    pub fn describeMalwareScans(self: *Self, allocator: std.mem.Allocator, input: describe_malware_scans.DescribeMalwareScansInput, options: describe_malware_scans.Options) !describe_malware_scans.DescribeMalwareScansOutput {
        return describe_malware_scans.execute(self, allocator, input, options);
    }

    /// Returns information about the account selected as the delegated
    /// administrator for
    /// GuardDuty.
    ///
    /// There might be regional differences because some data sources might not be
    /// available in all the Amazon Web Services Regions where GuardDuty is
    /// presently supported. For more
    /// information, see [Regions and
    /// endpoints](https://docs.aws.amazon.com/guardduty/latest/ug/guardduty_regions.html).
    pub fn describeOrganizationConfiguration(self: *Self, allocator: std.mem.Allocator, input: describe_organization_configuration.DescribeOrganizationConfigurationInput, options: describe_organization_configuration.Options) !describe_organization_configuration.DescribeOrganizationConfigurationOutput {
        return describe_organization_configuration.execute(self, allocator, input, options);
    }

    /// Returns information about the publishing destination specified by the
    /// provided
    /// `destinationId`.
    pub fn describePublishingDestination(self: *Self, allocator: std.mem.Allocator, input: describe_publishing_destination.DescribePublishingDestinationInput, options: describe_publishing_destination.Options) !describe_publishing_destination.DescribePublishingDestinationOutput {
        return describe_publishing_destination.execute(self, allocator, input, options);
    }

    /// Removes the existing GuardDuty delegated
    /// administrator of the organization. Only the organization's management
    /// account can run this
    /// API operation.
    pub fn disableOrganizationAdminAccount(self: *Self, allocator: std.mem.Allocator, input: disable_organization_admin_account.DisableOrganizationAdminAccountInput, options: disable_organization_admin_account.Options) !disable_organization_admin_account.DisableOrganizationAdminAccountOutput {
        return disable_organization_admin_account.execute(self, allocator, input, options);
    }

    /// Disassociates the current GuardDuty member account from its administrator
    /// account.
    ///
    /// When you
    /// disassociate an invited member from a GuardDuty delegated administrator, the
    /// member account details
    /// obtained from the
    /// [CreateMembers](https://docs.aws.amazon.com/guardduty/latest/APIReference/API_CreateMembers.html) API, including the associated email addresses, are retained. This is
    /// done so that the delegated administrator can invoke the
    /// [InviteMembers](https://docs.aws.amazon.com/guardduty/latest/APIReference/API_InviteMembers.html) API without the need to invoke the CreateMembers API again. To
    /// remove the details associated with a member account, the delegated
    /// administrator must invoke the
    /// [DeleteMembers](https://docs.aws.amazon.com/guardduty/latest/APIReference/API_DeleteMembers.html) API.
    ///
    /// With `autoEnableOrganizationMembers` configuration for your organization set
    /// to
    /// `ALL`, you'll receive an error if you attempt to disable GuardDuty in a
    /// member
    /// account.
    pub fn disassociateFromAdministratorAccount(self: *Self, allocator: std.mem.Allocator, input: disassociate_from_administrator_account.DisassociateFromAdministratorAccountInput, options: disassociate_from_administrator_account.Options) !disassociate_from_administrator_account.DisassociateFromAdministratorAccountOutput {
        return disassociate_from_administrator_account.execute(self, allocator, input, options);
    }

    /// Disassociates the current GuardDuty member account from its administrator
    /// account.
    ///
    /// When you
    /// disassociate an invited member from a GuardDuty delegated administrator, the
    /// member account details
    /// obtained from the
    /// [CreateMembers](https://docs.aws.amazon.com/guardduty/latest/APIReference/API_CreateMembers.html) API, including the associated email addresses, are retained. This is
    /// done so that the delegated administrator can invoke the
    /// [InviteMembers](https://docs.aws.amazon.com/guardduty/latest/APIReference/API_InviteMembers.html) API without the need to invoke the CreateMembers API again. To
    /// remove the details associated with a member account, the delegated
    /// administrator must invoke the
    /// [DeleteMembers](https://docs.aws.amazon.com/guardduty/latest/APIReference/API_DeleteMembers.html) API.
    pub fn disassociateFromMasterAccount(self: *Self, allocator: std.mem.Allocator, input: disassociate_from_master_account.DisassociateFromMasterAccountInput, options: disassociate_from_master_account.Options) !disassociate_from_master_account.DisassociateFromMasterAccountOutput {
        return disassociate_from_master_account.execute(self, allocator, input, options);
    }

    /// Disassociates GuardDuty member accounts (from the current administrator
    /// account) specified
    /// by the account IDs.
    ///
    /// When you
    /// disassociate an invited member from a GuardDuty delegated administrator, the
    /// member account details
    /// obtained from the
    /// [CreateMembers](https://docs.aws.amazon.com/guardduty/latest/APIReference/API_CreateMembers.html) API, including the associated email addresses, are retained. This is
    /// done so that the delegated administrator can invoke the
    /// [InviteMembers](https://docs.aws.amazon.com/guardduty/latest/APIReference/API_InviteMembers.html) API without the need to invoke the CreateMembers API again. To
    /// remove the details associated with a member account, the delegated
    /// administrator must invoke the
    /// [DeleteMembers](https://docs.aws.amazon.com/guardduty/latest/APIReference/API_DeleteMembers.html) API.
    ///
    /// With `autoEnableOrganizationMembers` configuration for your organization set
    /// to
    /// `ALL`, you'll receive an error if you attempt to disassociate a member
    /// account
    /// before removing them from your organization.
    ///
    /// If you disassociate a member account that was added by invitation, the
    /// member account details
    /// obtained from this API, including the associated email addresses, will be
    /// retained.
    /// This is done so that the delegated administrator can invoke the
    /// [InviteMembers](https://docs.aws.amazon.com/guardduty/latest/APIReference/API_InviteMembers.html) API without the need to invoke the CreateMembers API again. To
    /// remove the details associated with a member account, the delegated
    /// administrator must invoke the
    /// [DeleteMembers](https://docs.aws.amazon.com/guardduty/latest/APIReference/API_DeleteMembers.html) API.
    ///
    /// When the member accounts added through Organizations are later
    /// disassociated, you (administrator)
    /// can't invite them by calling the InviteMembers API. You can create an
    /// association with these
    /// member accounts again only by calling the CreateMembers API.
    pub fn disassociateMembers(self: *Self, allocator: std.mem.Allocator, input: disassociate_members.DisassociateMembersInput, options: disassociate_members.Options) !disassociate_members.DisassociateMembersOutput {
        return disassociate_members.execute(self, allocator, input, options);
    }

    /// Designates an Amazon Web Services account within the organization as your
    /// GuardDuty delegated
    /// administrator. Only the organization's management account can run this
    /// API operation.
    pub fn enableOrganizationAdminAccount(self: *Self, allocator: std.mem.Allocator, input: enable_organization_admin_account.EnableOrganizationAdminAccountInput, options: enable_organization_admin_account.Options) !enable_organization_admin_account.EnableOrganizationAdminAccountOutput {
        return enable_organization_admin_account.execute(self, allocator, input, options);
    }

    /// Provides the details of the GuardDuty administrator account associated with
    /// the current
    /// GuardDuty member account.
    ///
    /// Based on the type of account that runs this API, the following list shows
    /// how the API behavior varies:
    ///
    /// * When the GuardDuty administrator account runs this API, it will return
    ///   success (`HTTP 200`) but no content.
    ///
    /// * When a member account runs this API, it will return the details of the
    ///   GuardDuty administrator account that is associated
    /// with this calling member account.
    ///
    /// * When an individual account (not associated with an organization) runs this
    ///   API, it will return success (`HTTP 200`)
    /// but no content.
    pub fn getAdministratorAccount(self: *Self, allocator: std.mem.Allocator, input: get_administrator_account.GetAdministratorAccountInput, options: get_administrator_account.Options) !get_administrator_account.GetAdministratorAccountOutput {
        return get_administrator_account.execute(self, allocator, input, options);
    }

    /// Retrieves aggregated statistics for your account. If you are a GuardDuty
    /// administrator, you
    /// can retrieve the statistics for all the resources associated with the active
    /// member accounts
    /// in your organization who have enabled Runtime Monitoring and have the
    /// GuardDuty security agent running
    /// on their resources.
    pub fn getCoverageStatistics(self: *Self, allocator: std.mem.Allocator, input: get_coverage_statistics.GetCoverageStatisticsInput, options: get_coverage_statistics.Options) !get_coverage_statistics.GetCoverageStatisticsOutput {
        return get_coverage_statistics.execute(self, allocator, input, options);
    }

    /// Retrieves a GuardDuty detector specified by the detectorId.
    ///
    /// There might be regional differences because some data sources might not be
    /// available in all the Amazon Web Services Regions where GuardDuty is
    /// presently supported. For more
    /// information, see [Regions and
    /// endpoints](https://docs.aws.amazon.com/guardduty/latest/ug/guardduty_regions.html).
    pub fn getDetector(self: *Self, allocator: std.mem.Allocator, input: get_detector.GetDetectorInput, options: get_detector.Options) !get_detector.GetDetectorOutput {
        return get_detector.execute(self, allocator, input, options);
    }

    /// Returns the details of the filter specified by the filter name.
    pub fn getFilter(self: *Self, allocator: std.mem.Allocator, input: get_filter.GetFilterInput, options: get_filter.Options) !get_filter.GetFilterOutput {
        return get_filter.execute(self, allocator, input, options);
    }

    /// Describes Amazon GuardDuty findings specified by finding IDs.
    pub fn getFindings(self: *Self, allocator: std.mem.Allocator, input: get_findings.GetFindingsInput, options: get_findings.Options) !get_findings.GetFindingsOutput {
        return get_findings.execute(self, allocator, input, options);
    }

    /// Lists GuardDuty findings statistics for the specified detector ID.
    ///
    /// You must provide either `findingStatisticTypes` or
    /// `groupBy` parameter, and not both. You can use the `maxResults` and
    /// `orderBy`
    /// parameters only when using `groupBy`.
    ///
    /// There might be regional differences because some flags might not be
    /// available in all the Regions where GuardDuty
    /// is currently supported. For more information, see [Regions and
    /// endpoints](https://docs.aws.amazon.com/guardduty/latest/ug/guardduty_regions.html).
    pub fn getFindingsStatistics(self: *Self, allocator: std.mem.Allocator, input: get_findings_statistics.GetFindingsStatisticsInput, options: get_findings_statistics.Options) !get_findings_statistics.GetFindingsStatisticsOutput {
        return get_findings_statistics.execute(self, allocator, input, options);
    }

    /// Returns the count of all GuardDuty membership invitations that were sent to
    /// the current
    /// member account except the currently accepted invitation.
    pub fn getInvitationsCount(self: *Self, allocator: std.mem.Allocator, input: get_invitations_count.GetInvitationsCountInput, options: get_invitations_count.Options) !get_invitations_count.GetInvitationsCountOutput {
        return get_invitations_count.execute(self, allocator, input, options);
    }

    /// Retrieves the IPSet specified by the `ipSetId`.
    pub fn getIpSet(self: *Self, allocator: std.mem.Allocator, input: get_ip_set.GetIPSetInput, options: get_ip_set.Options) !get_ip_set.GetIPSetOutput {
        return get_ip_set.execute(self, allocator, input, options);
    }

    /// Retrieves the Malware Protection plan details associated with a Malware
    /// Protection
    /// plan ID.
    pub fn getMalwareProtectionPlan(self: *Self, allocator: std.mem.Allocator, input: get_malware_protection_plan.GetMalwareProtectionPlanInput, options: get_malware_protection_plan.Options) !get_malware_protection_plan.GetMalwareProtectionPlanOutput {
        return get_malware_protection_plan.execute(self, allocator, input, options);
    }

    /// Retrieves the detailed information for a specific malware scan. Each member
    /// account can view the malware scan details for their
    /// own account. An administrator can view malware scan details for all accounts
    /// in the organization.
    ///
    /// There might be regional differences because some data sources might not be
    /// available in all the Amazon Web Services Regions where GuardDuty is
    /// presently supported. For more
    /// information, see [Regions and
    /// endpoints](https://docs.aws.amazon.com/guardduty/latest/ug/guardduty_regions.html).
    pub fn getMalwareScan(self: *Self, allocator: std.mem.Allocator, input: get_malware_scan.GetMalwareScanInput, options: get_malware_scan.Options) !get_malware_scan.GetMalwareScanOutput {
        return get_malware_scan.execute(self, allocator, input, options);
    }

    /// Returns the details of the malware scan settings.
    ///
    /// There might be regional differences because some data sources might not be
    /// available in all the Amazon Web Services Regions where GuardDuty is
    /// presently supported. For more
    /// information, see [Regions and
    /// endpoints](https://docs.aws.amazon.com/guardduty/latest/ug/guardduty_regions.html).
    pub fn getMalwareScanSettings(self: *Self, allocator: std.mem.Allocator, input: get_malware_scan_settings.GetMalwareScanSettingsInput, options: get_malware_scan_settings.Options) !get_malware_scan_settings.GetMalwareScanSettingsOutput {
        return get_malware_scan_settings.execute(self, allocator, input, options);
    }

    /// Provides the details for the GuardDuty administrator account associated with
    /// the current
    /// GuardDuty member account.
    pub fn getMasterAccount(self: *Self, allocator: std.mem.Allocator, input: get_master_account.GetMasterAccountInput, options: get_master_account.Options) !get_master_account.GetMasterAccountOutput {
        return get_master_account.execute(self, allocator, input, options);
    }

    /// Describes which data sources are enabled for the member account's detector.
    ///
    /// There might be regional differences because some data sources might not be
    /// available in all the Amazon Web Services Regions where GuardDuty is
    /// presently supported. For more
    /// information, see [Regions and
    /// endpoints](https://docs.aws.amazon.com/guardduty/latest/ug/guardduty_regions.html).
    pub fn getMemberDetectors(self: *Self, allocator: std.mem.Allocator, input: get_member_detectors.GetMemberDetectorsInput, options: get_member_detectors.Options) !get_member_detectors.GetMemberDetectorsOutput {
        return get_member_detectors.execute(self, allocator, input, options);
    }

    /// Retrieves GuardDuty member accounts (of the current GuardDuty administrator
    /// account)
    /// specified by the account IDs.
    pub fn getMembers(self: *Self, allocator: std.mem.Allocator, input: get_members.GetMembersInput, options: get_members.Options) !get_members.GetMembersOutput {
        return get_members.execute(self, allocator, input, options);
    }

    /// Retrieves how many active member accounts have
    /// each feature enabled within GuardDuty. Only a delegated GuardDuty
    /// administrator of an organization can run this API.
    ///
    /// When you create a new organization, it might take up to 24
    /// hours to generate the statistics for the entire organization.
    pub fn getOrganizationStatistics(self: *Self, allocator: std.mem.Allocator, input: get_organization_statistics.GetOrganizationStatisticsInput, options: get_organization_statistics.Options) !get_organization_statistics.GetOrganizationStatisticsOutput {
        return get_organization_statistics.execute(self, allocator, input, options);
    }

    /// Provides the number of days left for each data source used in the free trial
    /// period.
    pub fn getRemainingFreeTrialDays(self: *Self, allocator: std.mem.Allocator, input: get_remaining_free_trial_days.GetRemainingFreeTrialDaysInput, options: get_remaining_free_trial_days.Options) !get_remaining_free_trial_days.GetRemainingFreeTrialDaysOutput {
        return get_remaining_free_trial_days.execute(self, allocator, input, options);
    }

    /// Retrieves the threat entity set associated with the specified
    /// `threatEntitySetId`.
    pub fn getThreatEntitySet(self: *Self, allocator: std.mem.Allocator, input: get_threat_entity_set.GetThreatEntitySetInput, options: get_threat_entity_set.Options) !get_threat_entity_set.GetThreatEntitySetOutput {
        return get_threat_entity_set.execute(self, allocator, input, options);
    }

    /// Retrieves the ThreatIntelSet that is specified by the ThreatIntelSet ID.
    pub fn getThreatIntelSet(self: *Self, allocator: std.mem.Allocator, input: get_threat_intel_set.GetThreatIntelSetInput, options: get_threat_intel_set.Options) !get_threat_intel_set.GetThreatIntelSetOutput {
        return get_threat_intel_set.execute(self, allocator, input, options);
    }

    /// Retrieves the trusted entity set associated with the specified
    /// `trustedEntitySetId`.
    pub fn getTrustedEntitySet(self: *Self, allocator: std.mem.Allocator, input: get_trusted_entity_set.GetTrustedEntitySetInput, options: get_trusted_entity_set.Options) !get_trusted_entity_set.GetTrustedEntitySetOutput {
        return get_trusted_entity_set.execute(self, allocator, input, options);
    }

    /// Lists Amazon GuardDuty usage statistics over the last 30 days for the
    /// specified detector
    /// ID. For newly enabled detectors or data sources, the cost returned will
    /// include only the usage
    /// so far under 30 days. This may differ from the cost metrics in the console,
    /// which project
    /// usage over 30 days to provide a monthly cost estimate. For more information,
    /// see [Understanding How Usage Costs are
    /// Calculated](https://docs.aws.amazon.com/guardduty/latest/ug/monitoring_costs.html#usage-calculations).
    pub fn getUsageStatistics(self: *Self, allocator: std.mem.Allocator, input: get_usage_statistics.GetUsageStatisticsInput, options: get_usage_statistics.Options) !get_usage_statistics.GetUsageStatisticsOutput {
        return get_usage_statistics.execute(self, allocator, input, options);
    }

    /// Invites Amazon Web Services accounts to become members of an organization
    /// administered by the Amazon Web Services account
    /// that invokes this API. If you are using Amazon Web Services Organizations to
    /// manage your GuardDuty environment, this step is not
    /// needed. For more information, see [Managing accounts with
    /// organizations](https://docs.aws.amazon.com/guardduty/latest/ug/guardduty_organizations.html).
    ///
    /// To invite Amazon Web Services accounts, the first step is
    /// to ensure that GuardDuty has been enabled in the potential member accounts.
    /// You can now invoke this API
    /// to add accounts by invitation. The
    /// invited accounts can either accept or decline the invitation from their
    /// GuardDuty accounts. Each invited Amazon Web Services account can
    /// choose to accept the invitation from only one Amazon Web Services account.
    /// For more information, see
    /// [Managing GuardDuty accounts
    /// by
    /// invitation](https://docs.aws.amazon.com/guardduty/latest/ug/guardduty_invitations.html).
    ///
    /// After the invite has been accepted and you choose to disassociate a member
    /// account
    /// (by using
    /// [DisassociateMembers](https://docs.aws.amazon.com/guardduty/latest/APIReference/API_DisassociateMembers.html)) from your account,
    /// the details of the member account obtained by invoking
    /// [CreateMembers](https://docs.aws.amazon.com/guardduty/latest/APIReference/API_CreateMembers.html), including the
    /// associated email addresses, will be retained.
    /// This is done so that you can invoke InviteMembers without the need to invoke
    /// [CreateMembers](https://docs.aws.amazon.com/guardduty/latest/APIReference/API_CreateMembers.html) again. To
    /// remove the details associated with a member account, you must also invoke
    /// [DeleteMembers](https://docs.aws.amazon.com/guardduty/latest/APIReference/API_DeleteMembers.html).
    ///
    /// If you disassociate a member account that was added by invitation, the
    /// member account details
    /// obtained from this API, including the associated email addresses, will be
    /// retained.
    /// This is done so that the delegated administrator can invoke the
    /// [InviteMembers](https://docs.aws.amazon.com/guardduty/latest/APIReference/API_InviteMembers.html) API without the need to invoke the CreateMembers API again. To
    /// remove the details associated with a member account, the delegated
    /// administrator must invoke the
    /// [DeleteMembers](https://docs.aws.amazon.com/guardduty/latest/APIReference/API_DeleteMembers.html) API.
    ///
    /// When the member accounts added through Organizations are later
    /// disassociated, you (administrator)
    /// can't invite them by calling the InviteMembers API. You can create an
    /// association with these
    /// member accounts again only by calling the CreateMembers API.
    pub fn inviteMembers(self: *Self, allocator: std.mem.Allocator, input: invite_members.InviteMembersInput, options: invite_members.Options) !invite_members.InviteMembersOutput {
        return invite_members.execute(self, allocator, input, options);
    }

    /// Lists coverage details for your GuardDuty account. If you're a GuardDuty
    /// administrator, you can
    /// retrieve all resources associated with the active member accounts in your
    /// organization.
    ///
    /// Make sure the accounts have Runtime Monitoring enabled and GuardDuty agent
    /// running on
    /// their resources.
    pub fn listCoverage(self: *Self, allocator: std.mem.Allocator, input: list_coverage.ListCoverageInput, options: list_coverage.Options) !list_coverage.ListCoverageOutput {
        return list_coverage.execute(self, allocator, input, options);
    }

    /// Lists detectorIds of all the existing Amazon GuardDuty detector resources.
    pub fn listDetectors(self: *Self, allocator: std.mem.Allocator, input: list_detectors.ListDetectorsInput, options: list_detectors.Options) !list_detectors.ListDetectorsOutput {
        return list_detectors.execute(self, allocator, input, options);
    }

    /// Returns a paginated list of the current filters.
    pub fn listFilters(self: *Self, allocator: std.mem.Allocator, input: list_filters.ListFiltersInput, options: list_filters.Options) !list_filters.ListFiltersOutput {
        return list_filters.execute(self, allocator, input, options);
    }

    /// Lists GuardDuty findings for the specified detector ID.
    ///
    /// There might be regional differences because some flags might not be
    /// available in all the Regions where GuardDuty
    /// is currently supported. For more information, see [Regions and
    /// endpoints](https://docs.aws.amazon.com/guardduty/latest/ug/guardduty_regions.html).
    pub fn listFindings(self: *Self, allocator: std.mem.Allocator, input: list_findings.ListFindingsInput, options: list_findings.Options) !list_findings.ListFindingsOutput {
        return list_findings.execute(self, allocator, input, options);
    }

    /// Lists all GuardDuty membership invitations that were sent to the current
    /// Amazon Web Services
    /// account.
    pub fn listInvitations(self: *Self, allocator: std.mem.Allocator, input: list_invitations.ListInvitationsInput, options: list_invitations.Options) !list_invitations.ListInvitationsOutput {
        return list_invitations.execute(self, allocator, input, options);
    }

    /// Lists the IPSets of the GuardDuty service specified by the detector ID. If
    /// you use this
    /// operation from a member account, the IPSets returned are the IPSets from the
    /// associated
    /// administrator account.
    pub fn listIpSets(self: *Self, allocator: std.mem.Allocator, input: list_ip_sets.ListIPSetsInput, options: list_ip_sets.Options) !list_ip_sets.ListIPSetsOutput {
        return list_ip_sets.execute(self, allocator, input, options);
    }

    /// Lists the Malware Protection plan IDs associated with the protected
    /// resources in your Amazon Web Services account.
    pub fn listMalwareProtectionPlans(self: *Self, allocator: std.mem.Allocator, input: list_malware_protection_plans.ListMalwareProtectionPlansInput, options: list_malware_protection_plans.Options) !list_malware_protection_plans.ListMalwareProtectionPlansOutput {
        return list_malware_protection_plans.execute(self, allocator, input, options);
    }

    /// Returns a list of malware scans. Each member account can view the malware
    /// scans for their
    /// own accounts. An administrator can view the malware scans for all of its
    /// members' accounts.
    pub fn listMalwareScans(self: *Self, allocator: std.mem.Allocator, input: list_malware_scans.ListMalwareScansInput, options: list_malware_scans.Options) !list_malware_scans.ListMalwareScansOutput {
        return list_malware_scans.execute(self, allocator, input, options);
    }

    /// Lists details about all member accounts for the current GuardDuty
    /// administrator
    /// account.
    pub fn listMembers(self: *Self, allocator: std.mem.Allocator, input: list_members.ListMembersInput, options: list_members.Options) !list_members.ListMembersOutput {
        return list_members.execute(self, allocator, input, options);
    }

    /// Lists the accounts designated as GuardDuty delegated administrators.
    /// Only the organization's management account can run this
    /// API operation.
    pub fn listOrganizationAdminAccounts(self: *Self, allocator: std.mem.Allocator, input: list_organization_admin_accounts.ListOrganizationAdminAccountsInput, options: list_organization_admin_accounts.Options) !list_organization_admin_accounts.ListOrganizationAdminAccountsOutput {
        return list_organization_admin_accounts.execute(self, allocator, input, options);
    }

    /// Returns a list of publishing destinations associated with the specified
    /// `detectorId`.
    pub fn listPublishingDestinations(self: *Self, allocator: std.mem.Allocator, input: list_publishing_destinations.ListPublishingDestinationsInput, options: list_publishing_destinations.Options) !list_publishing_destinations.ListPublishingDestinationsOutput {
        return list_publishing_destinations.execute(self, allocator, input, options);
    }

    /// Lists tags for a resource. Tagging is currently supported for detectors,
    /// finding filters,
    /// IP sets, threat intel sets, and publishing destination, with a limit of 50
    /// tags per resource.
    /// When invoked, this
    /// operation returns all assigned tags for a given resource.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: list_tags_for_resource.Options) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Lists the threat entity sets associated with the specified GuardDuty
    /// detector ID. If you use this
    /// operation from a member account, the threat entity sets that are returned as
    /// a response, belong to the
    /// administrator account.
    pub fn listThreatEntitySets(self: *Self, allocator: std.mem.Allocator, input: list_threat_entity_sets.ListThreatEntitySetsInput, options: list_threat_entity_sets.Options) !list_threat_entity_sets.ListThreatEntitySetsOutput {
        return list_threat_entity_sets.execute(self, allocator, input, options);
    }

    /// Lists the ThreatIntelSets of the GuardDuty service specified by the detector
    /// ID. If you
    /// use this operation from a member account, the ThreatIntelSets associated
    /// with the
    /// administrator account are returned.
    pub fn listThreatIntelSets(self: *Self, allocator: std.mem.Allocator, input: list_threat_intel_sets.ListThreatIntelSetsInput, options: list_threat_intel_sets.Options) !list_threat_intel_sets.ListThreatIntelSetsOutput {
        return list_threat_intel_sets.execute(self, allocator, input, options);
    }

    /// Lists the trusted entity sets associated with the specified GuardDuty
    /// detector ID. If you use this
    /// operation from a member account, the trusted entity sets that are returned
    /// as a response, belong to the
    /// administrator account.
    pub fn listTrustedEntitySets(self: *Self, allocator: std.mem.Allocator, input: list_trusted_entity_sets.ListTrustedEntitySetsInput, options: list_trusted_entity_sets.Options) !list_trusted_entity_sets.ListTrustedEntitySetsOutput {
        return list_trusted_entity_sets.execute(self, allocator, input, options);
    }

    /// Initiates a malware scan for a specific S3 object. This API allows you to
    /// perform on-demand malware scanning of individual objects in S3 buckets that
    /// have Malware Protection for S3 enabled.
    ///
    /// When you use this API, the Amazon Web Services service terms for GuardDuty
    /// Malware
    /// Protection apply. For more information, see [Amazon Web Services service
    /// terms for GuardDuty Malware
    /// Protection](http://aws.amazon.com/service-terms/#87._Amazon_GuardDuty).
    pub fn sendObjectMalwareScan(self: *Self, allocator: std.mem.Allocator, input: send_object_malware_scan.SendObjectMalwareScanInput, options: send_object_malware_scan.Options) !send_object_malware_scan.SendObjectMalwareScanOutput {
        return send_object_malware_scan.execute(self, allocator, input, options);
    }

    /// Initiates the malware scan. Invoking this API will automatically create the
    /// [Service-linked
    /// role](https://docs.aws.amazon.com/guardduty/latest/ug/slr-permissions-malware-protection.html) in
    /// the corresponding account if the resourceArn belongs to an EC2 instance.
    ///
    /// When the malware scan starts, you can use the associated scan ID to track
    /// the status of the scan. For more information,
    /// see
    /// [ListMalwareScans](https://docs.aws.amazon.com/guardduty/latest/APIReference/API_ListMalwareScans.html) and [GetMalwareScan](https://docs.aws.amazon.com/guardduty/latest/APIReference/API_GetMalwareScan.html).
    ///
    /// When you use this API, the Amazon Web Services service terms for GuardDuty
    /// Malware
    /// Protection apply. For more information, see [Amazon Web Services service
    /// terms for GuardDuty Malware
    /// Protection](http://aws.amazon.com/service-terms/#87._Amazon_GuardDuty).
    pub fn startMalwareScan(self: *Self, allocator: std.mem.Allocator, input: start_malware_scan.StartMalwareScanInput, options: start_malware_scan.Options) !start_malware_scan.StartMalwareScanOutput {
        return start_malware_scan.execute(self, allocator, input, options);
    }

    /// Turns on GuardDuty monitoring of the specified member accounts. Use this
    /// operation to
    /// restart monitoring of accounts that you stopped monitoring with the
    /// [StopMonitoringMembers](https://docs.aws.amazon.com/guardduty/latest/APIReference/API_StopMonitoringMembers.html) operation.
    pub fn startMonitoringMembers(self: *Self, allocator: std.mem.Allocator, input: start_monitoring_members.StartMonitoringMembersInput, options: start_monitoring_members.Options) !start_monitoring_members.StartMonitoringMembersOutput {
        return start_monitoring_members.execute(self, allocator, input, options);
    }

    /// Stops GuardDuty monitoring for the specified member accounts. Use the
    /// `StartMonitoringMembers` operation to restart monitoring for those
    /// accounts.
    ///
    /// With `autoEnableOrganizationMembers` configuration for your organization set
    /// to
    /// `ALL`, you'll receive an error if you attempt to stop monitoring the member
    /// accounts in your organization.
    pub fn stopMonitoringMembers(self: *Self, allocator: std.mem.Allocator, input: stop_monitoring_members.StopMonitoringMembersInput, options: stop_monitoring_members.Options) !stop_monitoring_members.StopMonitoringMembersOutput {
        return stop_monitoring_members.execute(self, allocator, input, options);
    }

    /// Adds tags to a resource.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: tag_resource.Options) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Unarchives GuardDuty findings specified by the `findingIds`.
    pub fn unarchiveFindings(self: *Self, allocator: std.mem.Allocator, input: unarchive_findings.UnarchiveFindingsInput, options: unarchive_findings.Options) !unarchive_findings.UnarchiveFindingsOutput {
        return unarchive_findings.execute(self, allocator, input, options);
    }

    /// Removes tags from a resource.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: untag_resource.Options) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Updates the GuardDuty detector specified by the detector ID.
    ///
    /// Specifying both EKS Runtime Monitoring (`EKS_RUNTIME_MONITORING`)
    /// and Runtime Monitoring (`RUNTIME_MONITORING`) will cause an error.
    /// You can add only one of these two features because Runtime Monitoring
    /// already includes the
    /// threat detection for Amazon EKS resources. For more information, see
    /// [Runtime
    /// Monitoring](https://docs.aws.amazon.com/guardduty/latest/ug/runtime-monitoring.html).
    ///
    /// There might be regional differences because some data sources might not be
    /// available in all the Amazon Web Services Regions where GuardDuty is
    /// presently supported. For more
    /// information, see [Regions and
    /// endpoints](https://docs.aws.amazon.com/guardduty/latest/ug/guardduty_regions.html).
    pub fn updateDetector(self: *Self, allocator: std.mem.Allocator, input: update_detector.UpdateDetectorInput, options: update_detector.Options) !update_detector.UpdateDetectorOutput {
        return update_detector.execute(self, allocator, input, options);
    }

    /// Updates the filter specified by the filter name.
    pub fn updateFilter(self: *Self, allocator: std.mem.Allocator, input: update_filter.UpdateFilterInput, options: update_filter.Options) !update_filter.UpdateFilterOutput {
        return update_filter.execute(self, allocator, input, options);
    }

    /// Marks the specified GuardDuty findings as useful or not useful.
    pub fn updateFindingsFeedback(self: *Self, allocator: std.mem.Allocator, input: update_findings_feedback.UpdateFindingsFeedbackInput, options: update_findings_feedback.Options) !update_findings_feedback.UpdateFindingsFeedbackOutput {
        return update_findings_feedback.execute(self, allocator, input, options);
    }

    /// Updates the IPSet specified by the IPSet ID.
    pub fn updateIpSet(self: *Self, allocator: std.mem.Allocator, input: update_ip_set.UpdateIPSetInput, options: update_ip_set.Options) !update_ip_set.UpdateIPSetOutput {
        return update_ip_set.execute(self, allocator, input, options);
    }

    /// Updates an existing Malware Protection plan resource.
    pub fn updateMalwareProtectionPlan(self: *Self, allocator: std.mem.Allocator, input: update_malware_protection_plan.UpdateMalwareProtectionPlanInput, options: update_malware_protection_plan.Options) !update_malware_protection_plan.UpdateMalwareProtectionPlanOutput {
        return update_malware_protection_plan.execute(self, allocator, input, options);
    }

    /// Updates the malware scan settings.
    ///
    /// There might be regional differences because some data sources might not be
    /// available in all the Amazon Web Services Regions where GuardDuty is
    /// presently supported. For more
    /// information, see [Regions and
    /// endpoints](https://docs.aws.amazon.com/guardduty/latest/ug/guardduty_regions.html).
    pub fn updateMalwareScanSettings(self: *Self, allocator: std.mem.Allocator, input: update_malware_scan_settings.UpdateMalwareScanSettingsInput, options: update_malware_scan_settings.Options) !update_malware_scan_settings.UpdateMalwareScanSettingsOutput {
        return update_malware_scan_settings.execute(self, allocator, input, options);
    }

    /// Contains information on member accounts to be updated.
    ///
    /// Specifying both EKS Runtime Monitoring (`EKS_RUNTIME_MONITORING`)
    /// and Runtime Monitoring (`RUNTIME_MONITORING`) will cause an error.
    /// You can add only one of these two features because Runtime Monitoring
    /// already includes the
    /// threat detection for Amazon EKS resources. For more information, see
    /// [Runtime
    /// Monitoring](https://docs.aws.amazon.com/guardduty/latest/ug/runtime-monitoring.html).
    ///
    /// There might be regional differences because some data sources might not be
    /// available in all the Amazon Web Services Regions where GuardDuty is
    /// presently supported. For more
    /// information, see [Regions and
    /// endpoints](https://docs.aws.amazon.com/guardduty/latest/ug/guardduty_regions.html).
    pub fn updateMemberDetectors(self: *Self, allocator: std.mem.Allocator, input: update_member_detectors.UpdateMemberDetectorsInput, options: update_member_detectors.Options) !update_member_detectors.UpdateMemberDetectorsOutput {
        return update_member_detectors.execute(self, allocator, input, options);
    }

    /// Configures the delegated administrator account with the provided values. You
    /// must provide
    /// a value for either `autoEnableOrganizationMembers` or `autoEnable`, but not
    /// both.
    ///
    /// Specifying both EKS Runtime Monitoring (`EKS_RUNTIME_MONITORING`)
    /// and Runtime Monitoring (`RUNTIME_MONITORING`) will cause an error.
    /// You can add only one of these two features because Runtime Monitoring
    /// already includes the
    /// threat detection for Amazon EKS resources. For more information, see
    /// [Runtime
    /// Monitoring](https://docs.aws.amazon.com/guardduty/latest/ug/runtime-monitoring.html).
    ///
    /// There might be regional differences because some data sources might not be
    /// available in all the Amazon Web Services Regions where GuardDuty is
    /// presently supported. For more
    /// information, see [Regions and
    /// endpoints](https://docs.aws.amazon.com/guardduty/latest/ug/guardduty_regions.html).
    pub fn updateOrganizationConfiguration(self: *Self, allocator: std.mem.Allocator, input: update_organization_configuration.UpdateOrganizationConfigurationInput, options: update_organization_configuration.Options) !update_organization_configuration.UpdateOrganizationConfigurationOutput {
        return update_organization_configuration.execute(self, allocator, input, options);
    }

    /// Updates information about the publishing destination specified by the
    /// `destinationId`.
    pub fn updatePublishingDestination(self: *Self, allocator: std.mem.Allocator, input: update_publishing_destination.UpdatePublishingDestinationInput, options: update_publishing_destination.Options) !update_publishing_destination.UpdatePublishingDestinationOutput {
        return update_publishing_destination.execute(self, allocator, input, options);
    }

    /// Updates the threat entity set associated with the specified
    /// `threatEntitySetId`.
    pub fn updateThreatEntitySet(self: *Self, allocator: std.mem.Allocator, input: update_threat_entity_set.UpdateThreatEntitySetInput, options: update_threat_entity_set.Options) !update_threat_entity_set.UpdateThreatEntitySetOutput {
        return update_threat_entity_set.execute(self, allocator, input, options);
    }

    /// Updates the ThreatIntelSet specified by the ThreatIntelSet ID.
    pub fn updateThreatIntelSet(self: *Self, allocator: std.mem.Allocator, input: update_threat_intel_set.UpdateThreatIntelSetInput, options: update_threat_intel_set.Options) !update_threat_intel_set.UpdateThreatIntelSetOutput {
        return update_threat_intel_set.execute(self, allocator, input, options);
    }

    /// Updates the trusted entity set associated with the specified
    /// `trustedEntitySetId`.
    pub fn updateTrustedEntitySet(self: *Self, allocator: std.mem.Allocator, input: update_trusted_entity_set.UpdateTrustedEntitySetInput, options: update_trusted_entity_set.Options) !update_trusted_entity_set.UpdateTrustedEntitySetOutput {
        return update_trusted_entity_set.execute(self, allocator, input, options);
    }

    pub fn describeMalwareScansPaginator(self: *Self, params: describe_malware_scans.DescribeMalwareScansInput) paginator.DescribeMalwareScansPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeOrganizationConfigurationPaginator(self: *Self, params: describe_organization_configuration.DescribeOrganizationConfigurationInput) paginator.DescribeOrganizationConfigurationPaginator {
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

    pub fn listCoveragePaginator(self: *Self, params: list_coverage.ListCoverageInput) paginator.ListCoveragePaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listDetectorsPaginator(self: *Self, params: list_detectors.ListDetectorsInput) paginator.ListDetectorsPaginator {
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

    pub fn listFindingsPaginator(self: *Self, params: list_findings.ListFindingsInput) paginator.ListFindingsPaginator {
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

    pub fn listIpSetsPaginator(self: *Self, params: list_ip_sets.ListIPSetsInput) paginator.ListIPSetsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listMalwareScansPaginator(self: *Self, params: list_malware_scans.ListMalwareScansInput) paginator.ListMalwareScansPaginator {
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

    pub fn listPublishingDestinationsPaginator(self: *Self, params: list_publishing_destinations.ListPublishingDestinationsInput) paginator.ListPublishingDestinationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listThreatEntitySetsPaginator(self: *Self, params: list_threat_entity_sets.ListThreatEntitySetsInput) paginator.ListThreatEntitySetsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listThreatIntelSetsPaginator(self: *Self, params: list_threat_intel_sets.ListThreatIntelSetsInput) paginator.ListThreatIntelSetsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listTrustedEntitySetsPaginator(self: *Self, params: list_trusted_entity_sets.ListTrustedEntitySetsInput) paginator.ListTrustedEntitySetsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};
