const aws = @import("aws");
const std = @import("std");

const associate_admin_account = @import("associate_admin_account.zig");
const associate_third_party_firewall = @import("associate_third_party_firewall.zig");
const batch_associate_resource = @import("batch_associate_resource.zig");
const batch_disassociate_resource = @import("batch_disassociate_resource.zig");
const delete_apps_list = @import("delete_apps_list.zig");
const delete_notification_channel = @import("delete_notification_channel.zig");
const delete_policy = @import("delete_policy.zig");
const delete_protocols_list = @import("delete_protocols_list.zig");
const delete_resource_set = @import("delete_resource_set.zig");
const disassociate_admin_account = @import("disassociate_admin_account.zig");
const disassociate_third_party_firewall = @import("disassociate_third_party_firewall.zig");
const get_admin_account = @import("get_admin_account.zig");
const get_admin_scope = @import("get_admin_scope.zig");
const get_apps_list = @import("get_apps_list.zig");
const get_compliance_detail = @import("get_compliance_detail.zig");
const get_notification_channel = @import("get_notification_channel.zig");
const get_policy = @import("get_policy.zig");
const get_protection_status = @import("get_protection_status.zig");
const get_protocols_list = @import("get_protocols_list.zig");
const get_resource_set = @import("get_resource_set.zig");
const get_third_party_firewall_association_status = @import("get_third_party_firewall_association_status.zig");
const get_violation_details = @import("get_violation_details.zig");
const list_admin_accounts_for_organization = @import("list_admin_accounts_for_organization.zig");
const list_admins_managing_account = @import("list_admins_managing_account.zig");
const list_apps_lists = @import("list_apps_lists.zig");
const list_compliance_status = @import("list_compliance_status.zig");
const list_discovered_resources = @import("list_discovered_resources.zig");
const list_member_accounts = @import("list_member_accounts.zig");
const list_policies = @import("list_policies.zig");
const list_protocols_lists = @import("list_protocols_lists.zig");
const list_resource_set_resources = @import("list_resource_set_resources.zig");
const list_resource_sets = @import("list_resource_sets.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const list_third_party_firewall_firewall_policies = @import("list_third_party_firewall_firewall_policies.zig");
const put_admin_account = @import("put_admin_account.zig");
const put_apps_list = @import("put_apps_list.zig");
const put_notification_channel = @import("put_notification_channel.zig");
const put_policy = @import("put_policy.zig");
const put_protocols_list = @import("put_protocols_list.zig");
const put_resource_set = @import("put_resource_set.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const CallOptions = @import("call_options.zig").CallOptions;
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "FMS";

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

    /// Sets a Firewall Manager default administrator account. The Firewall Manager
    /// default administrator account can manage third-party firewalls and has full
    /// administrative scope that allows administration of all policy types,
    /// accounts, organizational units, and Regions. This account must be a member
    /// account of the organization in Organizations whose resources you want to
    /// protect.
    ///
    /// For information about working with Firewall Manager administrator accounts,
    /// see [Managing Firewall Manager
    /// administrators](https://docs.aws.amazon.com/organizations/latest/userguide/fms-administrators.html) in the *Firewall Manager Developer Guide*.
    pub fn associateAdminAccount(self: *Self, allocator: std.mem.Allocator, input: associate_admin_account.AssociateAdminAccountInput, options: CallOptions) !associate_admin_account.AssociateAdminAccountOutput {
        return associate_admin_account.execute(self, allocator, input, options);
    }

    /// Sets the Firewall Manager policy administrator as a tenant administrator of
    /// a third-party firewall service. A tenant is an instance of the third-party
    /// firewall service that's associated with your Amazon Web Services customer
    /// account.
    pub fn associateThirdPartyFirewall(self: *Self, allocator: std.mem.Allocator, input: associate_third_party_firewall.AssociateThirdPartyFirewallInput, options: CallOptions) !associate_third_party_firewall.AssociateThirdPartyFirewallOutput {
        return associate_third_party_firewall.execute(self, allocator, input, options);
    }

    /// Associate resources to a Firewall Manager resource set.
    pub fn batchAssociateResource(self: *Self, allocator: std.mem.Allocator, input: batch_associate_resource.BatchAssociateResourceInput, options: CallOptions) !batch_associate_resource.BatchAssociateResourceOutput {
        return batch_associate_resource.execute(self, allocator, input, options);
    }

    /// Disassociates resources from a Firewall Manager resource set.
    pub fn batchDisassociateResource(self: *Self, allocator: std.mem.Allocator, input: batch_disassociate_resource.BatchDisassociateResourceInput, options: CallOptions) !batch_disassociate_resource.BatchDisassociateResourceOutput {
        return batch_disassociate_resource.execute(self, allocator, input, options);
    }

    /// Permanently deletes an Firewall Manager applications list.
    pub fn deleteAppsList(self: *Self, allocator: std.mem.Allocator, input: delete_apps_list.DeleteAppsListInput, options: CallOptions) !delete_apps_list.DeleteAppsListOutput {
        return delete_apps_list.execute(self, allocator, input, options);
    }

    /// Deletes an Firewall Manager association with the IAM role and the Amazon
    /// Simple
    /// Notification Service (SNS) topic that is used to record Firewall Manager SNS
    /// logs.
    pub fn deleteNotificationChannel(self: *Self, allocator: std.mem.Allocator, input: delete_notification_channel.DeleteNotificationChannelInput, options: CallOptions) !delete_notification_channel.DeleteNotificationChannelOutput {
        return delete_notification_channel.execute(self, allocator, input, options);
    }

    /// Permanently deletes an Firewall Manager policy.
    pub fn deletePolicy(self: *Self, allocator: std.mem.Allocator, input: delete_policy.DeletePolicyInput, options: CallOptions) !delete_policy.DeletePolicyOutput {
        return delete_policy.execute(self, allocator, input, options);
    }

    /// Permanently deletes an Firewall Manager protocols list.
    pub fn deleteProtocolsList(self: *Self, allocator: std.mem.Allocator, input: delete_protocols_list.DeleteProtocolsListInput, options: CallOptions) !delete_protocols_list.DeleteProtocolsListOutput {
        return delete_protocols_list.execute(self, allocator, input, options);
    }

    /// Deletes the specified ResourceSet.
    pub fn deleteResourceSet(self: *Self, allocator: std.mem.Allocator, input: delete_resource_set.DeleteResourceSetInput, options: CallOptions) !delete_resource_set.DeleteResourceSetOutput {
        return delete_resource_set.execute(self, allocator, input, options);
    }

    /// Disassociates an Firewall Manager administrator account. To set a different
    /// account as an Firewall Manager administrator, submit a PutAdminAccount
    /// request. To set an account as a default administrator account, you must
    /// submit an AssociateAdminAccount request.
    ///
    /// Disassociation of the default administrator account follows the first in,
    /// last out principle. If you are the default administrator, all Firewall
    /// Manager administrators within the organization must first disassociate their
    /// accounts before you can disassociate your account.
    pub fn disassociateAdminAccount(self: *Self, allocator: std.mem.Allocator, input: disassociate_admin_account.DisassociateAdminAccountInput, options: CallOptions) !disassociate_admin_account.DisassociateAdminAccountOutput {
        return disassociate_admin_account.execute(self, allocator, input, options);
    }

    /// Disassociates a Firewall Manager policy administrator from a third-party
    /// firewall tenant. When you call `DisassociateThirdPartyFirewall`, the
    /// third-party firewall vendor deletes all of the firewalls that are associated
    /// with the account.
    pub fn disassociateThirdPartyFirewall(self: *Self, allocator: std.mem.Allocator, input: disassociate_third_party_firewall.DisassociateThirdPartyFirewallInput, options: CallOptions) !disassociate_third_party_firewall.DisassociateThirdPartyFirewallOutput {
        return disassociate_third_party_firewall.execute(self, allocator, input, options);
    }

    /// Returns the Organizations account that is associated with Firewall Manager
    /// as the Firewall Manager default administrator.
    pub fn getAdminAccount(self: *Self, allocator: std.mem.Allocator, input: get_admin_account.GetAdminAccountInput, options: CallOptions) !get_admin_account.GetAdminAccountOutput {
        return get_admin_account.execute(self, allocator, input, options);
    }

    /// Returns information about the specified account's administrative scope. The
    /// administrative scope defines the resources that an Firewall Manager
    /// administrator can manage.
    pub fn getAdminScope(self: *Self, allocator: std.mem.Allocator, input: get_admin_scope.GetAdminScopeInput, options: CallOptions) !get_admin_scope.GetAdminScopeOutput {
        return get_admin_scope.execute(self, allocator, input, options);
    }

    /// Returns information about the specified Firewall Manager applications list.
    pub fn getAppsList(self: *Self, allocator: std.mem.Allocator, input: get_apps_list.GetAppsListInput, options: CallOptions) !get_apps_list.GetAppsListOutput {
        return get_apps_list.execute(self, allocator, input, options);
    }

    /// Returns detailed compliance information about the specified member account.
    /// Details
    /// include resources that are in and out of compliance with the specified
    /// policy.
    ///
    /// The reasons for resources being considered compliant depend on the Firewall
    /// Manager policy type.
    pub fn getComplianceDetail(self: *Self, allocator: std.mem.Allocator, input: get_compliance_detail.GetComplianceDetailInput, options: CallOptions) !get_compliance_detail.GetComplianceDetailOutput {
        return get_compliance_detail.execute(self, allocator, input, options);
    }

    /// Information
    /// about the Amazon Simple Notification Service (SNS) topic that is used to
    /// record Firewall Manager SNS logs.
    pub fn getNotificationChannel(self: *Self, allocator: std.mem.Allocator, input: get_notification_channel.GetNotificationChannelInput, options: CallOptions) !get_notification_channel.GetNotificationChannelOutput {
        return get_notification_channel.execute(self, allocator, input, options);
    }

    /// Returns information about the specified Firewall Manager policy.
    pub fn getPolicy(self: *Self, allocator: std.mem.Allocator, input: get_policy.GetPolicyInput, options: CallOptions) !get_policy.GetPolicyOutput {
        return get_policy.execute(self, allocator, input, options);
    }

    /// If you created a Shield Advanced policy, returns policy-level attack summary
    /// information
    /// in the event of a potential DDoS attack. Other policy types are currently
    /// unsupported.
    pub fn getProtectionStatus(self: *Self, allocator: std.mem.Allocator, input: get_protection_status.GetProtectionStatusInput, options: CallOptions) !get_protection_status.GetProtectionStatusOutput {
        return get_protection_status.execute(self, allocator, input, options);
    }

    /// Returns information about the specified Firewall Manager protocols list.
    pub fn getProtocolsList(self: *Self, allocator: std.mem.Allocator, input: get_protocols_list.GetProtocolsListInput, options: CallOptions) !get_protocols_list.GetProtocolsListOutput {
        return get_protocols_list.execute(self, allocator, input, options);
    }

    /// Gets information about a specific resource set.
    pub fn getResourceSet(self: *Self, allocator: std.mem.Allocator, input: get_resource_set.GetResourceSetInput, options: CallOptions) !get_resource_set.GetResourceSetOutput {
        return get_resource_set.execute(self, allocator, input, options);
    }

    /// The onboarding status of a Firewall Manager admin account to third-party
    /// firewall vendor tenant.
    pub fn getThirdPartyFirewallAssociationStatus(self: *Self, allocator: std.mem.Allocator, input: get_third_party_firewall_association_status.GetThirdPartyFirewallAssociationStatusInput, options: CallOptions) !get_third_party_firewall_association_status.GetThirdPartyFirewallAssociationStatusOutput {
        return get_third_party_firewall_association_status.execute(self, allocator, input, options);
    }

    /// Retrieves violations for a resource based on the specified Firewall Manager
    /// policy and Amazon Web Services account.
    pub fn getViolationDetails(self: *Self, allocator: std.mem.Allocator, input: get_violation_details.GetViolationDetailsInput, options: CallOptions) !get_violation_details.GetViolationDetailsOutput {
        return get_violation_details.execute(self, allocator, input, options);
    }

    /// Returns a `AdminAccounts` object that lists the Firewall Manager
    /// administrators within the organization that are onboarded to Firewall
    /// Manager by AssociateAdminAccount.
    ///
    /// This operation can be called only from the organization's management
    /// account.
    pub fn listAdminAccountsForOrganization(self: *Self, allocator: std.mem.Allocator, input: list_admin_accounts_for_organization.ListAdminAccountsForOrganizationInput, options: CallOptions) !list_admin_accounts_for_organization.ListAdminAccountsForOrganizationOutput {
        return list_admin_accounts_for_organization.execute(self, allocator, input, options);
    }

    /// Lists the accounts that are managing the specified Organizations member
    /// account. This is useful for any member account so that they can view the
    /// accounts who are managing their account. This operation only returns the
    /// managing administrators that have the requested account within their
    /// AdminScope.
    pub fn listAdminsManagingAccount(self: *Self, allocator: std.mem.Allocator, input: list_admins_managing_account.ListAdminsManagingAccountInput, options: CallOptions) !list_admins_managing_account.ListAdminsManagingAccountOutput {
        return list_admins_managing_account.execute(self, allocator, input, options);
    }

    /// Returns an array of `AppsListDataSummary` objects.
    pub fn listAppsLists(self: *Self, allocator: std.mem.Allocator, input: list_apps_lists.ListAppsListsInput, options: CallOptions) !list_apps_lists.ListAppsListsOutput {
        return list_apps_lists.execute(self, allocator, input, options);
    }

    /// Returns an array of `PolicyComplianceStatus` objects. Use
    /// `PolicyComplianceStatus` to get a summary of which member accounts are
    /// protected
    /// by the specified policy.
    pub fn listComplianceStatus(self: *Self, allocator: std.mem.Allocator, input: list_compliance_status.ListComplianceStatusInput, options: CallOptions) !list_compliance_status.ListComplianceStatusOutput {
        return list_compliance_status.execute(self, allocator, input, options);
    }

    /// Returns an array of resources in the organization's accounts that are
    /// available to be associated with a resource set.
    pub fn listDiscoveredResources(self: *Self, allocator: std.mem.Allocator, input: list_discovered_resources.ListDiscoveredResourcesInput, options: CallOptions) !list_discovered_resources.ListDiscoveredResourcesOutput {
        return list_discovered_resources.execute(self, allocator, input, options);
    }

    /// Returns a `MemberAccounts` object that lists the member accounts in the
    /// administrator's Amazon Web Services organization.
    ///
    /// Either an Firewall Manager administrator or the organization's management
    /// account can make this request.
    pub fn listMemberAccounts(self: *Self, allocator: std.mem.Allocator, input: list_member_accounts.ListMemberAccountsInput, options: CallOptions) !list_member_accounts.ListMemberAccountsOutput {
        return list_member_accounts.execute(self, allocator, input, options);
    }

    /// Returns an array of `PolicySummary` objects.
    pub fn listPolicies(self: *Self, allocator: std.mem.Allocator, input: list_policies.ListPoliciesInput, options: CallOptions) !list_policies.ListPoliciesOutput {
        return list_policies.execute(self, allocator, input, options);
    }

    /// Returns an array of `ProtocolsListDataSummary` objects.
    pub fn listProtocolsLists(self: *Self, allocator: std.mem.Allocator, input: list_protocols_lists.ListProtocolsListsInput, options: CallOptions) !list_protocols_lists.ListProtocolsListsOutput {
        return list_protocols_lists.execute(self, allocator, input, options);
    }

    /// Returns an array of resources that are currently associated to a resource
    /// set.
    pub fn listResourceSetResources(self: *Self, allocator: std.mem.Allocator, input: list_resource_set_resources.ListResourceSetResourcesInput, options: CallOptions) !list_resource_set_resources.ListResourceSetResourcesOutput {
        return list_resource_set_resources.execute(self, allocator, input, options);
    }

    /// Returns an array of `ResourceSetSummary` objects.
    pub fn listResourceSets(self: *Self, allocator: std.mem.Allocator, input: list_resource_sets.ListResourceSetsInput, options: CallOptions) !list_resource_sets.ListResourceSetsOutput {
        return list_resource_sets.execute(self, allocator, input, options);
    }

    /// Retrieves the list of tags for the specified Amazon Web Services resource.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: CallOptions) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Retrieves a list of all of the third-party firewall policies that are
    /// associated with the third-party firewall administrator's account.
    pub fn listThirdPartyFirewallFirewallPolicies(self: *Self, allocator: std.mem.Allocator, input: list_third_party_firewall_firewall_policies.ListThirdPartyFirewallFirewallPoliciesInput, options: CallOptions) !list_third_party_firewall_firewall_policies.ListThirdPartyFirewallFirewallPoliciesOutput {
        return list_third_party_firewall_firewall_policies.execute(self, allocator, input, options);
    }

    /// Creates or updates an Firewall Manager administrator account. The account
    /// must be a member of the organization that was onboarded to Firewall Manager
    /// by AssociateAdminAccount. Only the organization's management account can
    /// create an Firewall Manager administrator account. When you create an
    /// Firewall Manager administrator account, the service checks to see if the
    /// account is already a delegated administrator within Organizations. If the
    /// account isn't a delegated administrator, Firewall Manager calls
    /// Organizations to delegate the account within Organizations. For more
    /// information about administrator accounts within Organizations, see
    /// [Managing the Amazon Web Services Accounts in Your
    /// Organization](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_manage_accounts.html).
    pub fn putAdminAccount(self: *Self, allocator: std.mem.Allocator, input: put_admin_account.PutAdminAccountInput, options: CallOptions) !put_admin_account.PutAdminAccountOutput {
        return put_admin_account.execute(self, allocator, input, options);
    }

    /// Creates an Firewall Manager applications list.
    pub fn putAppsList(self: *Self, allocator: std.mem.Allocator, input: put_apps_list.PutAppsListInput, options: CallOptions) !put_apps_list.PutAppsListOutput {
        return put_apps_list.execute(self, allocator, input, options);
    }

    /// Designates the IAM role and Amazon Simple Notification Service (SNS) topic
    /// that
    /// Firewall Manager uses to record SNS logs.
    ///
    /// To perform this action outside of the console, you must first configure the
    /// SNS topic's access policy to allow the `SnsRoleName` to publish SNS logs. If
    /// the `SnsRoleName` provided is a role other than the `AWSServiceRoleForFMS`
    /// service-linked role, this role must have a trust relationship configured to
    /// allow the Firewall Manager service principal `fms.amazonaws.com` to assume
    /// this role. For information about configuring an SNS access policy, see
    /// [Service roles for Firewall
    /// Manager](https://docs.aws.amazon.com/waf/latest/developerguide/fms-security_iam_service-with-iam.html#fms-security_iam_service-with-iam-roles-service) in the *Firewall Manager Developer Guide*.
    pub fn putNotificationChannel(self: *Self, allocator: std.mem.Allocator, input: put_notification_channel.PutNotificationChannelInput, options: CallOptions) !put_notification_channel.PutNotificationChannelOutput {
        return put_notification_channel.execute(self, allocator, input, options);
    }

    /// Creates an Firewall Manager policy.
    ///
    /// A Firewall Manager policy is specific to the individual policy type. If you
    /// want to enforce multiple
    /// policy types across accounts, you can create multiple policies. You can
    /// create more than one
    /// policy for each type.
    ///
    /// If you add a new account to an organization that you created with
    /// Organizations, Firewall Manager
    /// automatically applies the policy to the resources in that account that are
    /// within scope of
    /// the policy.
    ///
    /// Firewall Manager provides the following types of policies:
    ///
    /// * **WAF policy** - This policy applies WAF web ACL
    /// protections to specified accounts and resources.
    ///
    /// * **Shield Advanced policy** - This policy applies Shield Advanced
    /// protection to specified accounts and resources.
    ///
    /// * **Security Groups policy** - This type of policy gives you
    /// control over security groups that are in use throughout your organization in
    /// Organizations and lets you enforce a baseline set of rules across your
    /// organization.
    ///
    /// * **Network ACL policy** - This type of policy gives you
    /// control over the network ACLs that are in use throughout your organization
    /// in
    /// Organizations and lets you enforce a baseline set of first and last network
    /// ACL rules across your organization.
    ///
    /// * **Network Firewall policy** - This policy applies
    /// Network Firewall protection to your organization's VPCs.
    ///
    /// * **DNS Firewall policy** - This policy applies
    /// Amazon Route 53 Resolver DNS Firewall protections to your organization's
    /// VPCs.
    ///
    /// * **Third-party firewall policy** - This policy applies third-party firewall
    ///   protections. Third-party firewalls are available by subscription through
    ///   the Amazon Web Services Marketplace console at [Amazon Web Services
    ///   Marketplace](http://aws.amazon.com/marketplace).
    ///
    /// * **Palo Alto Networks Cloud NGFW policy** - This policy applies Palo Alto
    ///   Networks Cloud Next Generation Firewall (NGFW) protections and Palo Alto
    ///   Networks Cloud NGFW rulestacks to your organization's VPCs.
    ///
    /// * **Fortigate CNF policy** - This policy applies
    /// Fortigate Cloud Native Firewall (CNF) protections. Fortigate CNF is a
    /// cloud-centered solution that blocks Zero-Day threats and secures cloud
    /// infrastructures with industry-leading advanced threat prevention, smart web
    /// application firewalls (WAF), and API protection.
    pub fn putPolicy(self: *Self, allocator: std.mem.Allocator, input: put_policy.PutPolicyInput, options: CallOptions) !put_policy.PutPolicyOutput {
        return put_policy.execute(self, allocator, input, options);
    }

    /// Creates an Firewall Manager protocols list.
    pub fn putProtocolsList(self: *Self, allocator: std.mem.Allocator, input: put_protocols_list.PutProtocolsListInput, options: CallOptions) !put_protocols_list.PutProtocolsListOutput {
        return put_protocols_list.execute(self, allocator, input, options);
    }

    /// Creates the resource set.
    ///
    /// An Firewall Manager resource set defines the resources to import into an
    /// Firewall Manager policy from another Amazon Web Services service.
    pub fn putResourceSet(self: *Self, allocator: std.mem.Allocator, input: put_resource_set.PutResourceSetInput, options: CallOptions) !put_resource_set.PutResourceSetOutput {
        return put_resource_set.execute(self, allocator, input, options);
    }

    /// Adds one or more tags to an Amazon Web Services resource.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: CallOptions) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Removes one or more tags from an Amazon Web Services resource.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: CallOptions) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    pub fn listAdminAccountsForOrganizationPaginator(self: *Self, params: list_admin_accounts_for_organization.ListAdminAccountsForOrganizationInput) paginator.ListAdminAccountsForOrganizationPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listAdminsManagingAccountPaginator(self: *Self, params: list_admins_managing_account.ListAdminsManagingAccountInput) paginator.ListAdminsManagingAccountPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listAppsListsPaginator(self: *Self, params: list_apps_lists.ListAppsListsInput) paginator.ListAppsListsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listComplianceStatusPaginator(self: *Self, params: list_compliance_status.ListComplianceStatusInput) paginator.ListComplianceStatusPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listMemberAccountsPaginator(self: *Self, params: list_member_accounts.ListMemberAccountsInput) paginator.ListMemberAccountsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listPoliciesPaginator(self: *Self, params: list_policies.ListPoliciesInput) paginator.ListPoliciesPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listProtocolsListsPaginator(self: *Self, params: list_protocols_lists.ListProtocolsListsInput) paginator.ListProtocolsListsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listThirdPartyFirewallFirewallPoliciesPaginator(self: *Self, params: list_third_party_firewall_firewall_policies.ListThirdPartyFirewallFirewallPoliciesInput) paginator.ListThirdPartyFirewallFirewallPoliciesPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }
};
