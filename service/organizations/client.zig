const aws = @import("aws");
const std = @import("std");

const accept_handshake = @import("accept_handshake.zig");
const attach_policy = @import("attach_policy.zig");
const cancel_handshake = @import("cancel_handshake.zig");
const close_account = @import("close_account.zig");
const create_account = @import("create_account.zig");
const create_gov_cloud_account = @import("create_gov_cloud_account.zig");
const create_organization = @import("create_organization.zig");
const create_organizational_unit = @import("create_organizational_unit.zig");
const create_policy = @import("create_policy.zig");
const decline_handshake = @import("decline_handshake.zig");
const delete_organization = @import("delete_organization.zig");
const delete_organizational_unit = @import("delete_organizational_unit.zig");
const delete_policy = @import("delete_policy.zig");
const delete_resource_policy = @import("delete_resource_policy.zig");
const deregister_delegated_administrator = @import("deregister_delegated_administrator.zig");
const describe_account = @import("describe_account.zig");
const describe_create_account_status = @import("describe_create_account_status.zig");
const describe_effective_policy = @import("describe_effective_policy.zig");
const describe_handshake = @import("describe_handshake.zig");
const describe_organization = @import("describe_organization.zig");
const describe_organizational_unit = @import("describe_organizational_unit.zig");
const describe_policy = @import("describe_policy.zig");
const describe_resource_policy = @import("describe_resource_policy.zig");
const describe_responsibility_transfer = @import("describe_responsibility_transfer.zig");
const detach_policy = @import("detach_policy.zig");
const disable_aws_service_access = @import("disable_aws_service_access.zig");
const disable_policy_type = @import("disable_policy_type.zig");
const enable_all_features = @import("enable_all_features.zig");
const enable_aws_service_access = @import("enable_aws_service_access.zig");
const enable_policy_type = @import("enable_policy_type.zig");
const invite_account_to_organization = @import("invite_account_to_organization.zig");
const invite_organization_to_transfer_responsibility = @import("invite_organization_to_transfer_responsibility.zig");
const leave_organization = @import("leave_organization.zig");
const list_accounts = @import("list_accounts.zig");
const list_accounts_for_parent = @import("list_accounts_for_parent.zig");
const list_accounts_with_invalid_effective_policy = @import("list_accounts_with_invalid_effective_policy.zig");
const list_aws_service_access_for_organization = @import("list_aws_service_access_for_organization.zig");
const list_children = @import("list_children.zig");
const list_create_account_status = @import("list_create_account_status.zig");
const list_delegated_administrators = @import("list_delegated_administrators.zig");
const list_delegated_services_for_account = @import("list_delegated_services_for_account.zig");
const list_effective_policy_validation_errors = @import("list_effective_policy_validation_errors.zig");
const list_handshakes_for_account = @import("list_handshakes_for_account.zig");
const list_handshakes_for_organization = @import("list_handshakes_for_organization.zig");
const list_inbound_responsibility_transfers = @import("list_inbound_responsibility_transfers.zig");
const list_organizational_units_for_parent = @import("list_organizational_units_for_parent.zig");
const list_outbound_responsibility_transfers = @import("list_outbound_responsibility_transfers.zig");
const list_parents = @import("list_parents.zig");
const list_policies = @import("list_policies.zig");
const list_policies_for_target = @import("list_policies_for_target.zig");
const list_roots = @import("list_roots.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const list_targets_for_policy = @import("list_targets_for_policy.zig");
const move_account = @import("move_account.zig");
const put_resource_policy = @import("put_resource_policy.zig");
const register_delegated_administrator = @import("register_delegated_administrator.zig");
const remove_account_from_organization = @import("remove_account_from_organization.zig");
const tag_resource = @import("tag_resource.zig");
const terminate_responsibility_transfer = @import("terminate_responsibility_transfer.zig");
const untag_resource = @import("untag_resource.zig");
const update_organizational_unit = @import("update_organizational_unit.zig");
const update_policy = @import("update_policy.zig");
const update_responsibility_transfer = @import("update_responsibility_transfer.zig");
const CallOptions = @import("call_options.zig").CallOptions;
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "Organizations";

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

    /// Accepts a handshake by sending an `ACCEPTED` response to the sender. You
    /// can view accepted handshakes in API responses for 30 days before they are
    /// deleted.
    ///
    /// **Only the management account can accept the following
    /// handshakes**:
    ///
    /// * Enable all features final confirmation
    /// (`APPROVE_ALL_FEATURES`)
    ///
    /// * Billing transfer (`TRANSFER_RESPONSIBILITY`)
    ///
    /// For more information, see [Enabling all
    /// features](https://docs.aws.amazon.com/organizations/latest/userguide/manage-begin-all-features-standard-migration.html#manage-approve-all-features-invite) and [Responding to a billing transfer invitation](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_transfer_billing-respond-invitation.html) in the
    /// *Organizations User Guide*.
    ///
    /// **Only a member account can accept the following
    /// handshakes**:
    ///
    /// * Invitation to join (`INVITE`)
    ///
    /// * Approve all features request (`ENABLE_ALL_FEATURES`)
    ///
    /// For more information, see [Responding to
    /// invitations](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_manage_accounts_accept-decline-invite.html) and [Enabling all features](https://docs.aws.amazon.com/organizations/latest/userguide/manage-begin-all-features-standard-migration.html#manage-approve-all-features-invite) in the *Organizations User Guide*.
    pub fn acceptHandshake(self: *Self, allocator: std.mem.Allocator, input: accept_handshake.AcceptHandshakeInput, options: CallOptions) !accept_handshake.AcceptHandshakeOutput {
        return accept_handshake.execute(self, allocator, input, options);
    }

    /// Attaches a policy to a root, an organizational unit (OU), or an individual
    /// account.
    /// How the policy affects accounts depends on the type of policy. Refer to the
    /// *Organizations User Guide* for information about each policy type:
    ///
    /// *
    ///   [SERVICE_CONTROL_POLICY](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_manage_policies_scp.html)
    ///
    /// *
    ///   [RESOURCE_CONTROL_POLICY](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_manage_policies_rcps.html)
    ///
    /// *
    ///   [DECLARATIVE_POLICY_EC2](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_manage_policies_declarative.html)
    ///
    /// *
    ///   [BACKUP_POLICY](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_manage_policies_backup.html)
    ///
    /// *
    ///   [TAG_POLICY](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_manage_policies_tag-policies.html)
    ///
    /// *
    ///   [CHATBOT_POLICY](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_manage_policies_chatbot.html)
    ///
    /// *
    ///   [AISERVICES_OPT_OUT_POLICY](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_manage_policies_ai-opt-out.html)
    ///
    /// *
    ///   [SECURITYHUB_POLICY](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_manage_policies_security_hub.html)
    ///
    /// *
    ///   [UPGRADE_ROLLOUT_POLICY](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_manage_policies_upgrade_rollout.html)
    ///
    /// *
    ///   [INSPECTOR_POLICY](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_manage_policies_inspector.html)
    ///
    /// *
    ///   [BEDROCK_POLICY](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_manage_policies_bedrock.html)
    ///
    /// *
    ///   [S3_POLICY](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_manage_policies_s3.html)
    ///
    /// *
    ///   [NETWORK_SECURITY_DIRECTOR_POLICY](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_manage_policies_network_security_director.html)
    ///
    /// You can only call this operation from the management account or a member
    /// account that is a delegated administrator.
    pub fn attachPolicy(self: *Self, allocator: std.mem.Allocator, input: attach_policy.AttachPolicyInput, options: CallOptions) !attach_policy.AttachPolicyOutput {
        return attach_policy.execute(self, allocator, input, options);
    }

    /// Cancels a Handshake.
    ///
    /// Only the account that sent a handshake can call this operation. The
    /// recipient of the handshake can't cancel it, but can use DeclineHandshake to
    /// decline. After a handshake is canceled, the
    /// recipient can no longer respond to the handshake.
    ///
    /// You can view canceled handshakes in API responses for 30 days before they
    /// are
    /// deleted.
    pub fn cancelHandshake(self: *Self, allocator: std.mem.Allocator, input: cancel_handshake.CancelHandshakeInput, options: CallOptions) !cancel_handshake.CancelHandshakeOutput {
        return cancel_handshake.execute(self, allocator, input, options);
    }

    /// Closes an Amazon Web Services member account within an organization. You can
    /// close an account when
    /// [all
    /// features are enabled
    /// ](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_manage_org_support-all-features.html). You can't close the management account with this API.
    /// This is an asynchronous request that Amazon Web Services performs in the
    /// background. Because
    /// `CloseAccount` operates asynchronously, it can return a successful
    /// completion message even though account closure might still be in progress.
    /// You need to
    /// wait a few minutes before the account is fully closed. To check the status
    /// of the
    /// request, do one of the following:
    ///
    /// * Use the `AccountId` that you sent in the `CloseAccount`
    /// request to provide as a parameter to the DescribeAccount
    /// operation.
    ///
    /// While the close account request is in progress, Account status will indicate
    /// PENDING_CLOSURE. When the close account request completes, the status will
    /// change to SUSPENDED.
    ///
    /// * Check the CloudTrail log for the `CloseAccountResult` event that gets
    /// published after the account closes successfully. For information on using
    /// CloudTrail
    /// with Organizations, see [Logging and monitoring in
    /// Organizations](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_security_incident-response.html#orgs_cloudtrail-integration) in the
    /// *Organizations User Guide*.
    ///
    /// * Resources remaining within the account after closing will be automatically
    ///   deleted after 90 days. During this 90-day period,
    /// the resources won't be available unless you contact Amazon Web Services
    /// Support to reopen the account. After 90 days, you can't reopen an account.
    /// You might still receive a [bill after account
    /// closure](https://repost.aws/knowledge-center/closed-account-bill).
    ///
    /// * Within a rolling 30 day period you can close the higher of either 250 or
    ///   20% of the member accounts in your organization,
    /// up to a maximum of 1,000. This quota is not bound by a calendar month, but
    /// starts when you close an account. After you reach this limit, you can't
    /// close additional accounts. For more information, see [Closing a member
    /// account in your
    /// organization](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_manage_accounts_close.html) and [Quotas for
    /// Organizations](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_reference_limits.html) in the *Organizations User Guide*.
    ///
    /// * To reinstate a closed account, contact Amazon Web Services Support within
    ///   the 90-day
    /// grace period while the account is in SUSPENDED status.
    ///
    /// * If the Amazon Web Services account you attempt to close is linked to an
    ///   Amazon Web Services GovCloud
    /// (US) account, the `CloseAccount` request will close both
    /// accounts. To learn important pre-closure details, see [
    /// Closing an Amazon Web Services GovCloud (US)
    /// account](https://docs.aws.amazon.com/govcloud-us/latest/UserGuide/Closing-govcloud-account.html) in the *
    /// Amazon Web Services GovCloud User Guide*.
    pub fn closeAccount(self: *Self, allocator: std.mem.Allocator, input: close_account.CloseAccountInput, options: CallOptions) !close_account.CloseAccountOutput {
        return close_account.execute(self, allocator, input, options);
    }

    /// Creates an Amazon Web Services account that is automatically a member of the
    /// organization whose
    /// credentials made the request. This is an asynchronous request that Amazon
    /// Web Services performs in the
    /// background. Because `CreateAccount` operates asynchronously, it can return a
    /// successful completion message even though account initialization might still
    /// be in
    /// progress. You might need to wait a few minutes before you can successfully
    /// access the
    /// account. To check the status of the request, do one of the following:
    ///
    /// * Use the `Id` value of the `CreateAccountStatus` response
    /// element from this operation to provide as a parameter to the
    /// DescribeCreateAccountStatus operation.
    ///
    /// * Check the CloudTrail log for the `CreateAccountResult` event. For
    /// information on using CloudTrail with Organizations, see [Logging and
    /// monitoring in
    /// Organizations](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_security_incident-response.html#orgs_cloudtrail-integration) in the
    /// *Organizations User Guide*.
    ///
    /// The user who calls the API to create an account must have the
    /// `organizations:CreateAccount` permission. If you enabled all features in
    /// the organization, Organizations creates the required service-linked role
    /// named
    /// `AWSServiceRoleForOrganizations`. For more information, see [Organizations
    /// and service-linked
    /// roles](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_integrate_services.html#orgs_integrate_services-using_slrs) in the
    /// *Organizations User Guide*.
    ///
    /// If the request includes tags, then the requester must have the
    /// `organizations:TagResource` permission.
    ///
    /// Organizations preconfigures the new member account with a role (named
    /// `OrganizationAccountAccessRole` by default) that grants users in the
    /// management account administrator permissions in the new member account.
    /// Principals in
    /// the management account can assume the role. Organizations clones the company
    /// name and address
    /// information for the new account from the organization's management account.
    ///
    /// You can only call this operation from the management account.
    ///
    /// For more information about creating accounts, see [Creating
    /// a member account in your
    /// organization](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_manage_accounts_create.html) in the
    /// *Organizations User Guide*.
    ///
    /// * When you create an account in an organization using the Organizations
    ///   console,
    /// API, or CLI commands, the information required for the account to operate
    /// as a standalone account, such as a payment method is
    /// *not* automatically collected. If you must remove an
    /// account from your organization later, you can do so only after you provide
    /// the missing information. For more information, see [Considerations before
    /// removing an account from an
    /// organization](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_manage_account-before-remove.html)
    /// in the *Organizations User Guide*.
    ///
    /// * If you get an exception that indicates that you exceeded your account
    /// limits for the organization, contact [Amazon Web Services
    /// Support](https://console.aws.amazon.com/support/home#/).
    ///
    /// * If you get an exception that indicates that the operation failed because
    /// your organization is still initializing, wait one hour and then try again.
    /// If the error persists, contact [Amazon Web Services
    /// Support](https://console.aws.amazon.com/support/home#/).
    ///
    /// * It isn't recommended to use `CreateAccount` to create multiple
    /// temporary accounts, and using the `CreateAccount` API to close
    /// accounts is subject to a 30-day usage quota. For information on the
    /// requirements and process for closing an account, see [Closing a member
    /// account in your
    /// organization](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_manage_accounts_close.html) in the
    /// *Organizations User Guide*.
    ///
    /// When you create a member account with this operation, you can choose whether
    /// to
    /// create the account with the **IAM User and Role Access to
    /// Billing Information** switch enabled. If you enable it, IAM users and
    /// roles that have appropriate permissions can view billing information for the
    /// account. If you disable it, only the account root user can access billing
    /// information. For information about how to disable this switch for an
    /// account, see
    /// [Granting access to
    /// your billing information and
    /// tools](https://docs.aws.amazon.com/awsaccountbilling/latest/aboutv2/control-access-billing.html#grantaccess).
    pub fn createAccount(self: *Self, allocator: std.mem.Allocator, input: create_account.CreateAccountInput, options: CallOptions) !create_account.CreateAccountOutput {
        return create_account.execute(self, allocator, input, options);
    }

    /// This action is available if all of the following are true:
    ///
    /// * You're authorized to create accounts in the Amazon Web Services GovCloud
    ///   (US) Region. For
    /// more information on the Amazon Web Services GovCloud (US) Region, see the [
    /// *Amazon Web Services GovCloud User
    /// Guide*.](https://docs.aws.amazon.com/govcloud-us/latest/UserGuide/welcome.html)
    ///
    /// * You already have an account in the Amazon Web Services GovCloud (US)
    ///   Region that is paired
    /// with a management account of an organization in the commercial Region.
    ///
    /// * You call this action from the management account of your organization in
    ///   the
    /// commercial Region.
    ///
    /// * You have the `organizations:CreateGovCloudAccount` permission.
    ///
    /// Organizations automatically creates the required service-linked role named
    /// `AWSServiceRoleForOrganizations`. For more information, see [Organizations
    /// and service-linked
    /// roles](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_integrate_services.html#orgs_integrate_services-using_slrs) in the
    /// *Organizations User Guide*.
    ///
    /// Amazon Web Services automatically enables CloudTrail for Amazon Web Services
    /// GovCloud (US) accounts, but you should also
    /// do the following:
    ///
    /// * Verify that CloudTrail is enabled to store logs.
    ///
    /// * Create an Amazon S3 bucket for CloudTrail log storage.
    ///
    /// For more information, see [Verifying CloudTrail Is
    /// Enabled](https://docs.aws.amazon.com/govcloud-us/latest/UserGuide/verifying-cloudtrail.html) in the *Amazon Web Services GovCloud User Guide*.
    ///
    /// If the request includes tags, then the requester must have the
    /// `organizations:TagResource` permission. The tags are attached to the
    /// commercial account associated with the GovCloud account, rather than the
    /// GovCloud
    /// account itself. To add tags to the GovCloud account, call the TagResource
    /// operation in the GovCloud Region after the new GovCloud
    /// account exists.
    ///
    /// You call this action from the management account of your organization in the
    /// commercial Region to create a standalone Amazon Web Services account in the
    /// Amazon Web Services GovCloud (US)
    /// Region. After the account is created, the management account of an
    /// organization in the
    /// Amazon Web Services GovCloud (US) Region can invite it to that organization.
    /// For more information on
    /// inviting standalone accounts in the Amazon Web Services GovCloud (US) to
    /// join an organization, see
    /// [Organizations](https://docs.aws.amazon.com/govcloud-us/latest/UserGuide/govcloud-organizations.html) in the
    /// *Amazon Web Services GovCloud User Guide*.
    ///
    /// Calling `CreateGovCloudAccount` is an asynchronous request that Amazon Web
    /// Services
    /// performs in the background. Because `CreateGovCloudAccount` operates
    /// asynchronously, it can return a successful completion message even though
    /// account
    /// initialization might still be in progress. You might need to wait a few
    /// minutes before
    /// you can successfully access the account. To check the status of the request,
    /// do one of
    /// the following:
    ///
    /// * Use the `OperationId` response element from this operation to
    /// provide as a parameter to the DescribeCreateAccountStatus
    /// operation.
    ///
    /// * Check the CloudTrail log for the `CreateAccountResult` event. For
    /// information on using CloudTrail with Organizations, see [Logging and
    /// monitoring in
    /// Organizations](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_security_incident-response.html) in the
    /// *Organizations User Guide*.
    ///
    /// When you call the `CreateGovCloudAccount` action, you create two accounts:
    /// a standalone account in the Amazon Web Services GovCloud (US) Region and an
    /// associated account in the
    /// commercial Region for billing and support purposes. The account in the
    /// commercial Region
    /// is automatically a member of the organization whose credentials made the
    /// request. Both
    /// accounts are associated with the same email address.
    ///
    /// A role is created in the new account in the commercial Region that allows
    /// the
    /// management account in the organization in the commercial Region to assume
    /// it. An Amazon Web Services
    /// GovCloud (US) account is then created and associated with the commercial
    /// account that
    /// you just created. A role is also created in the new Amazon Web Services
    /// GovCloud (US) account that can
    /// be assumed by the Amazon Web Services GovCloud (US) account that is
    /// associated with the management
    /// account of the commercial organization. For more information and to view a
    /// diagram that
    /// explains how account access works, see
    /// [Organizations](https://docs.aws.amazon.com/govcloud-us/latest/UserGuide/govcloud-organizations.html) in the
    /// *Amazon Web Services GovCloud User Guide*.
    ///
    /// For more information about creating accounts, see [Creating
    /// a member account in your
    /// organization](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_manage_accounts_create.html) in the
    /// *Organizations User Guide*.
    ///
    /// * When you create an account in an organization using the Organizations
    ///   console,
    /// API, or CLI commands, the information required for the account to operate as
    /// a standalone account is *not* automatically collected.
    /// This includes a payment method and signing the end user license agreement
    /// (EULA). If you must remove an account from your organization later, you can
    /// do so only after you provide the missing information. For more information,
    /// see [Considerations before removing an account from an
    /// organization](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_manage_account-before-remove.html)
    /// in the *Organizations User Guide*.
    ///
    /// * If you get an exception that indicates that you exceeded your account
    /// limits for the organization, contact [Amazon Web Services
    /// Support](https://console.aws.amazon.com/support/home#/).
    ///
    /// * If you get an exception that indicates that the operation failed because
    /// your organization is still initializing, wait one hour and then try again.
    /// If the error persists, contact [Amazon Web Services
    /// Support](https://console.aws.amazon.com/support/home#/).
    ///
    /// * Using `CreateGovCloudAccount` to create multiple temporary
    /// accounts isn't recommended. You can only close an account from the Amazon
    /// Web Services
    /// Billing and Cost Management console, and you must be signed in as the root
    /// user. For information on
    /// the requirements and process for closing an account, see [Closing a member
    /// account in your
    /// organization](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_manage_accounts_close.html) in the
    /// *Organizations User Guide*.
    ///
    /// When you create a member account with this operation, you can choose whether
    /// to
    /// create the account with the **IAM User and Role Access to
    /// Billing Information** switch enabled. If you enable it, IAM users and
    /// roles that have appropriate permissions can view billing information for the
    /// account. If you disable it, only the account root user can access billing
    /// information. For information about how to disable this switch for an
    /// account, see
    /// [Granting
    /// access to your billing information and
    /// tools](https://docs.aws.amazon.com/awsaccountbilling/latest/aboutv2/grantaccess.html).
    pub fn createGovCloudAccount(self: *Self, allocator: std.mem.Allocator, input: create_gov_cloud_account.CreateGovCloudAccountInput, options: CallOptions) !create_gov_cloud_account.CreateGovCloudAccountOutput {
        return create_gov_cloud_account.execute(self, allocator, input, options);
    }

    /// Creates an Amazon Web Services organization. The account whose user is
    /// calling the
    /// `CreateOrganization` operation automatically becomes the [management
    /// account](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_getting-started_concepts.html#account) of the new organization.
    ///
    /// This operation must be called using credentials from the account that is to
    /// become the
    /// new organization's management account. The principal must also have the
    /// relevant IAM
    /// permissions.
    ///
    /// By default (or if you set the `FeatureSet` parameter to `ALL`),
    /// the new organization is created with all features enabled and service
    /// control policies
    /// automatically enabled in the root. If you instead choose to create the
    /// organization
    /// supporting only the consolidated billing features by setting the
    /// `FeatureSet`
    /// parameter to `CONSOLIDATED_BILLING`, no policy types are enabled by default
    /// and you can't use organization policies.
    pub fn createOrganization(self: *Self, allocator: std.mem.Allocator, input: create_organization.CreateOrganizationInput, options: CallOptions) !create_organization.CreateOrganizationOutput {
        return create_organization.execute(self, allocator, input, options);
    }

    /// Creates an organizational unit (OU) within a root or parent OU. An OU is a
    /// container
    /// for accounts that enables you to organize your accounts to apply policies
    /// according to
    /// your business requirements. The number of levels deep that you can nest OUs
    /// is dependent
    /// upon the policy types enabled for that root. For service control policies,
    /// the limit is
    /// five.
    ///
    /// For more information about OUs, see [Managing organizational units
    /// (OUs)](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_manage_ous.html) in the
    /// *Organizations User Guide*.
    ///
    /// If the request includes tags, then the requester must have the
    /// `organizations:TagResource` permission.
    ///
    /// You can only call this operation from the management account.
    pub fn createOrganizationalUnit(self: *Self, allocator: std.mem.Allocator, input: create_organizational_unit.CreateOrganizationalUnitInput, options: CallOptions) !create_organizational_unit.CreateOrganizationalUnitOutput {
        return create_organizational_unit.execute(self, allocator, input, options);
    }

    /// Creates a policy of a specified type that you can attach to a root, an
    /// organizational
    /// unit (OU), or an individual Amazon Web Services account.
    ///
    /// For more information about policies and their use, see [Managing
    /// Organizations
    /// policies](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_manage_policies.html).
    ///
    /// If the request includes tags, then the requester must have the
    /// `organizations:TagResource` permission.
    ///
    /// You can only call this operation from the management account or a member
    /// account that is a delegated administrator.
    pub fn createPolicy(self: *Self, allocator: std.mem.Allocator, input: create_policy.CreatePolicyInput, options: CallOptions) !create_policy.CreatePolicyOutput {
        return create_policy.execute(self, allocator, input, options);
    }

    /// Declines a Handshake.
    ///
    /// Only the account that receives a handshake can call this operation. The
    /// sender of the handshake can use CancelHandshake to
    /// cancel if the handshake hasn't yet been responded to.
    ///
    /// You can view canceled handshakes in API responses for 30 days before they
    /// are
    /// deleted.
    pub fn declineHandshake(self: *Self, allocator: std.mem.Allocator, input: decline_handshake.DeclineHandshakeInput, options: CallOptions) !decline_handshake.DeclineHandshakeOutput {
        return decline_handshake.execute(self, allocator, input, options);
    }

    /// Deletes the organization. You can delete an organization only by using
    /// credentials
    /// from the management account. The organization must be empty of member
    /// accounts.
    pub fn deleteOrganization(self: *Self, allocator: std.mem.Allocator, input: delete_organization.DeleteOrganizationInput, options: CallOptions) !delete_organization.DeleteOrganizationOutput {
        return delete_organization.execute(self, allocator, input, options);
    }

    /// Deletes an organizational unit (OU) from a root or another OU. You must
    /// first remove
    /// all accounts and child OUs from the OU that you want to delete.
    ///
    /// You can only call this operation from the management account.
    pub fn deleteOrganizationalUnit(self: *Self, allocator: std.mem.Allocator, input: delete_organizational_unit.DeleteOrganizationalUnitInput, options: CallOptions) !delete_organizational_unit.DeleteOrganizationalUnitOutput {
        return delete_organizational_unit.execute(self, allocator, input, options);
    }

    /// Deletes the specified policy from your organization. Before you perform this
    /// operation, you must first detach the policy from all organizational units
    /// (OUs), roots,
    /// and accounts.
    ///
    /// You can only call this operation from the management account or a member
    /// account that is a delegated administrator.
    pub fn deletePolicy(self: *Self, allocator: std.mem.Allocator, input: delete_policy.DeletePolicyInput, options: CallOptions) !delete_policy.DeletePolicyOutput {
        return delete_policy.execute(self, allocator, input, options);
    }

    /// Deletes the resource policy from your organization.
    ///
    /// You can only call this operation from the management account.
    pub fn deleteResourcePolicy(self: *Self, allocator: std.mem.Allocator, input: delete_resource_policy.DeleteResourcePolicyInput, options: CallOptions) !delete_resource_policy.DeleteResourcePolicyOutput {
        return delete_resource_policy.execute(self, allocator, input, options);
    }

    /// Removes the specified member Amazon Web Services account as a delegated
    /// administrator for the
    /// specified Amazon Web Services service.
    ///
    /// Deregistering a delegated administrator can have unintended impacts on the
    /// functionality of the enabled Amazon Web Services service. See the
    /// documentation for the enabled
    /// service before you deregister a delegated administrator so that you
    /// understand any
    /// potential impacts.
    ///
    /// You can run this action only for Amazon Web Services services that support
    /// this
    /// feature. For a current list of services that support it, see the column
    /// *Supports
    /// Delegated Administrator* in the table at [Amazon Web Services Services that
    /// you can use with
    /// Organizations](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_integrate_services_list.html) in the *Organizations User Guide.*
    ///
    /// You can only call this operation from the management account.
    pub fn deregisterDelegatedAdministrator(self: *Self, allocator: std.mem.Allocator, input: deregister_delegated_administrator.DeregisterDelegatedAdministratorInput, options: CallOptions) !deregister_delegated_administrator.DeregisterDelegatedAdministratorOutput {
        return deregister_delegated_administrator.execute(self, allocator, input, options);
    }

    /// Retrieves Organizations-related information about the specified account.
    ///
    /// You can only call this operation from the management account or a member
    /// account that is a delegated administrator.
    pub fn describeAccount(self: *Self, allocator: std.mem.Allocator, input: describe_account.DescribeAccountInput, options: CallOptions) !describe_account.DescribeAccountOutput {
        return describe_account.execute(self, allocator, input, options);
    }

    /// Retrieves the current status of an asynchronous request to create an
    /// account.
    ///
    /// You can only call this operation from the management account or a member
    /// account that is a delegated administrator.
    pub fn describeCreateAccountStatus(self: *Self, allocator: std.mem.Allocator, input: describe_create_account_status.DescribeCreateAccountStatusInput, options: CallOptions) !describe_create_account_status.DescribeCreateAccountStatusOutput {
        return describe_create_account_status.execute(self, allocator, input, options);
    }

    /// Returns the contents of the effective policy for specified policy type and
    /// account.
    /// The effective policy is the aggregation of any policies of the specified
    /// type that the
    /// account inherits, plus any policy of that type that is directly attached to
    /// the
    /// account.
    ///
    /// This operation applies only to management policies. It does not apply to
    /// authorization
    /// policies: service control policies (SCPs) and resource control policies
    /// (RCPs).
    ///
    /// For more information about policy inheritance, see [Understanding
    /// management policy
    /// inheritance](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_manage_policies_inheritance_mgmt.html) in the
    /// *Organizations User Guide*.
    ///
    /// You can call this operation from any account in a organization.
    pub fn describeEffectivePolicy(self: *Self, allocator: std.mem.Allocator, input: describe_effective_policy.DescribeEffectivePolicyInput, options: CallOptions) !describe_effective_policy.DescribeEffectivePolicyOutput {
        return describe_effective_policy.execute(self, allocator, input, options);
    }

    /// Returns details for a handshake. A handshake is the secure exchange of
    /// information
    /// between two Amazon Web Services accounts: a sender and a recipient.
    ///
    /// You can view `ACCEPTED`, `DECLINED`, or `CANCELED`
    /// handshakes in API Responses for 30 days before they are deleted.
    ///
    /// You can call this operation from any account in a organization.
    pub fn describeHandshake(self: *Self, allocator: std.mem.Allocator, input: describe_handshake.DescribeHandshakeInput, options: CallOptions) !describe_handshake.DescribeHandshakeOutput {
        return describe_handshake.execute(self, allocator, input, options);
    }

    /// Retrieves information about the organization that the user's account belongs
    /// to.
    ///
    /// You can call this operation from any account in a organization.
    ///
    /// Even if a policy type is shown as available in the organization, you can
    /// disable
    /// it separately at the root level with DisablePolicyType. Use ListRoots to see
    /// the status of policy types for a specified
    /// root.
    pub fn describeOrganization(self: *Self, allocator: std.mem.Allocator, input: describe_organization.DescribeOrganizationInput, options: CallOptions) !describe_organization.DescribeOrganizationOutput {
        return describe_organization.execute(self, allocator, input, options);
    }

    /// Retrieves information about an organizational unit (OU).
    ///
    /// You can only call this operation from the management account or a member
    /// account that is a delegated administrator.
    pub fn describeOrganizationalUnit(self: *Self, allocator: std.mem.Allocator, input: describe_organizational_unit.DescribeOrganizationalUnitInput, options: CallOptions) !describe_organizational_unit.DescribeOrganizationalUnitOutput {
        return describe_organizational_unit.execute(self, allocator, input, options);
    }

    /// Retrieves information about a policy.
    ///
    /// You can only call this operation from the management account or a member
    /// account that is a delegated administrator.
    pub fn describePolicy(self: *Self, allocator: std.mem.Allocator, input: describe_policy.DescribePolicyInput, options: CallOptions) !describe_policy.DescribePolicyOutput {
        return describe_policy.execute(self, allocator, input, options);
    }

    /// Retrieves information about a resource policy.
    ///
    /// You can only call this operation from the management account or a member
    /// account that is a delegated administrator.
    pub fn describeResourcePolicy(self: *Self, allocator: std.mem.Allocator, input: describe_resource_policy.DescribeResourcePolicyInput, options: CallOptions) !describe_resource_policy.DescribeResourcePolicyOutput {
        return describe_resource_policy.execute(self, allocator, input, options);
    }

    /// Returns details for a transfer. A *transfer* is an arrangement
    /// between two management accounts where one account designates the other with
    /// specified
    /// responsibilities for their organization.
    pub fn describeResponsibilityTransfer(self: *Self, allocator: std.mem.Allocator, input: describe_responsibility_transfer.DescribeResponsibilityTransferInput, options: CallOptions) !describe_responsibility_transfer.DescribeResponsibilityTransferOutput {
        return describe_responsibility_transfer.execute(self, allocator, input, options);
    }

    /// Detaches a policy from a target root, organizational unit (OU), or account.
    ///
    /// If the policy being detached is a service control policy (SCP), the changes
    /// to
    /// permissions for Identity and Access Management (IAM) users and roles in
    /// affected accounts are
    /// immediate.
    ///
    /// Every root, OU, and account must have at least one SCP attached. If you want
    /// to
    /// replace the default `FullAWSAccess` policy with an SCP that limits the
    /// permissions that can be delegated, you must attach the replacement SCP
    /// before you can
    /// remove the default SCP. This is the authorization strategy of an "[allow
    /// list](https://docs.aws.amazon.com/organizations/latest/userguide/SCP_strategies.html#orgs_policies_allowlist)". If you instead attach a second SCP and
    /// leave the `FullAWSAccess` SCP still attached, and specify `"Effect":
    /// "Deny"` in the second SCP to override the `"Effect": "Allow"` in
    /// the `FullAWSAccess` policy (or any other attached SCP), you're using the
    /// authorization strategy of a "[deny
    /// list](https://docs.aws.amazon.com/organizations/latest/userguide/SCP_strategies.html#orgs_policies_denylist)".
    ///
    /// You can only call this operation from the management account or a member
    /// account that is a delegated administrator.
    pub fn detachPolicy(self: *Self, allocator: std.mem.Allocator, input: detach_policy.DetachPolicyInput, options: CallOptions) !detach_policy.DetachPolicyOutput {
        return detach_policy.execute(self, allocator, input, options);
    }

    /// Disables the integration of an Amazon Web Services service (the service that
    /// is specified by
    /// `ServicePrincipal`) with Organizations. When you disable integration, the
    /// specified service no longer can create a [service-linked
    /// role](https://docs.aws.amazon.com/IAM/latest/UserGuide/using-service-linked-roles.html) in
    /// *new* accounts in your organization. This means the service can't
    /// perform operations on your behalf on any new accounts in your organization.
    /// The service
    /// can still perform operations in older accounts until the service completes
    /// its clean-up
    /// from Organizations.
    ///
    /// We **
    /// *strongly recommend*
    /// ** that
    /// you don't use this command to disable integration between Organizations and
    /// the specified
    /// Amazon Web Services service. Instead, use the console or commands that are
    /// provided by the
    /// specified service. This lets the trusted service perform any required
    /// initialization
    /// when enabling trusted access, such as creating any required resources and
    /// any
    /// required clean up of resources when disabling trusted access.
    ///
    /// For information about how to disable trusted service access to your
    /// organization
    /// using the trusted service, see the **Learn more** link
    /// under the **Supports Trusted Access** column at [Amazon Web Services
    /// services that you can use with
    /// Organizations](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_integrate_services_list.html). on this page.
    ///
    /// If you disable access by using this command, it causes the following actions
    /// to
    /// occur:
    ///
    /// * The service can no longer create a service-linked role in the accounts in
    /// your organization. This means that the service can't perform operations on
    /// your behalf on any new accounts in your organization. The service can still
    /// perform operations in older accounts until the service completes its
    /// clean-up from Organizations.
    ///
    /// * The service can no longer perform tasks in the member accounts in the
    /// organization, unless those operations are explicitly permitted by the IAM
    /// policies that are attached to your roles. This includes any data aggregation
    /// from the member accounts to the management account, or to a delegated
    /// administrator account, where relevant.
    ///
    /// * Some services detect this and clean up any remaining data or resources
    /// related to the integration, while other services stop accessing the
    /// organization but leave any historical data and configuration in place to
    /// support a possible re-enabling of the integration.
    ///
    /// Using the other service's console or commands to disable the integration
    /// ensures
    /// that the other service is aware that it can clean up any resources that are
    /// required
    /// only for the integration. How the service cleans up its resources in the
    /// organization's accounts depends on that service. For more information, see
    /// the
    /// documentation for the other Amazon Web Services service.
    ///
    /// After you perform the `DisableAWSServiceAccess` operation, the specified
    /// service can no longer perform operations in your organization's accounts
    ///
    /// For more information about integrating other services with Organizations,
    /// including the
    /// list of services that work with Organizations, see [Using Organizations with
    /// other Amazon Web Services
    /// services](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_integrate_services.html) in the *Organizations User Guide*.
    ///
    /// You can only call this operation from the management account.
    pub fn disableAwsServiceAccess(self: *Self, allocator: std.mem.Allocator, input: disable_aws_service_access.DisableAWSServiceAccessInput, options: CallOptions) !disable_aws_service_access.DisableAWSServiceAccessOutput {
        return disable_aws_service_access.execute(self, allocator, input, options);
    }

    /// Disables an organizational policy type in a root. A policy of a certain type
    /// can be
    /// attached to entities in a root only if that type is enabled in the root.
    /// After you
    /// perform this operation, you no longer can attach policies of the specified
    /// type to that
    /// root or to any organizational unit (OU) or account in that root. You can
    /// undo this by
    /// using the EnablePolicyType operation.
    ///
    /// This is an asynchronous request that Amazon Web Services performs in the
    /// background. If you disable
    /// a policy type for a root, it still appears enabled for the organization if
    /// [all
    /// features](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_manage_org_support-all-features.html) are enabled for the organization. Amazon Web Services recommends that you
    /// first use ListRoots to see the status of policy types for a specified
    /// root, and then use this operation.
    ///
    /// You can only call this operation from the management account or a member
    /// account that is a delegated administrator.
    ///
    /// To view the status of available policy types in the organization, use
    /// ListRoots.
    pub fn disablePolicyType(self: *Self, allocator: std.mem.Allocator, input: disable_policy_type.DisablePolicyTypeInput, options: CallOptions) !disable_policy_type.DisablePolicyTypeOutput {
        return disable_policy_type.execute(self, allocator, input, options);
    }

    /// Enables all features in an organization. This enables the use of
    /// organization policies
    /// that can restrict the services and actions that can be called in each
    /// account. Until you
    /// enable all features, you have access only to consolidated billing, and you
    /// can't use any
    /// of the advanced account administration features that Organizations supports.
    /// For more
    /// information, see [Enabling all features in your
    /// organization](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_manage_org_support-all-features.html) in the
    /// *Organizations User Guide*.
    ///
    /// This operation is required only for organizations that were created
    /// explicitly
    /// with only the consolidated billing features enabled. Calling this operation
    /// sends a
    /// handshake to every invited account in the organization. The feature set
    /// change can
    /// be finalized and the additional features enabled only after all
    /// administrators in
    /// the invited accounts approve the change by accepting the handshake.
    ///
    /// After you enable all features, you can separately enable or disable
    /// individual policy
    /// types in a root using EnablePolicyType and DisablePolicyType. To see the
    /// status of policy types in a root, use
    /// ListRoots.
    ///
    /// After all invited member accounts accept the handshake, you finalize the
    /// feature set
    /// change by accepting the handshake that contains `"Action":
    /// "ENABLE_ALL_FEATURES"`. This completes the change.
    ///
    /// After you enable all features in your organization, the management account
    /// in the
    /// organization can apply policies on all member accounts. These policies can
    /// restrict what
    /// users and even administrators in those accounts can do. The management
    /// account can apply
    /// policies that prevent accounts from leaving the organization. Ensure that
    /// your account
    /// administrators are aware of this.
    ///
    /// You can only call this operation from the management account.
    pub fn enableAllFeatures(self: *Self, allocator: std.mem.Allocator, input: enable_all_features.EnableAllFeaturesInput, options: CallOptions) !enable_all_features.EnableAllFeaturesOutput {
        return enable_all_features.execute(self, allocator, input, options);
    }

    /// Provides an Amazon Web Services service (the service that is specified by
    /// `ServicePrincipal`) with permissions to view the structure of an
    /// organization, create a [service-linked
    /// role](https://docs.aws.amazon.com/IAM/latest/UserGuide/using-service-linked-roles.html) in
    /// all the accounts in the organization, and allow the service to perform
    /// operations on
    /// behalf of the organization and its accounts. Establishing these permissions
    /// can be a
    /// first step in enabling the integration of an Amazon Web Services service
    /// with Organizations.
    ///
    /// We recommend that you enable integration between Organizations and the
    /// specified Amazon Web Services
    /// service by using the console or commands that are provided by the specified
    /// service.
    /// Doing so ensures that the service is aware that it can create the resources
    /// that are
    /// required for the integration. How the service creates those resources in the
    /// organization's accounts depends on that service. For more information, see
    /// the
    /// documentation for the other Amazon Web Services service.
    ///
    /// For more information about enabling services to integrate with
    /// Organizations, see [Using
    /// Organizations with other Amazon Web Services
    /// services](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_integrate_services.html) in the
    /// *Organizations User Guide*.
    ///
    /// You can only call this operation from the management account.
    pub fn enableAwsServiceAccess(self: *Self, allocator: std.mem.Allocator, input: enable_aws_service_access.EnableAWSServiceAccessInput, options: CallOptions) !enable_aws_service_access.EnableAWSServiceAccessOutput {
        return enable_aws_service_access.execute(self, allocator, input, options);
    }

    /// Enables a policy type in a root. After you enable a policy type in a root,
    /// you can
    /// attach policies of that type to the root, any organizational unit (OU), or
    /// account in
    /// that root. You can undo this by using the DisablePolicyType
    /// operation.
    ///
    /// This is an asynchronous request that Amazon Web Services performs in the
    /// background. Amazon Web Services
    /// recommends that you first use ListRoots to see the status of policy
    /// types for a specified root, and then use this operation.
    ///
    /// You can only call this operation from the management account or a member
    /// account that is a delegated administrator.
    ///
    /// You can enable a policy type in a root only if that policy type is available
    /// in the
    /// organization. To view the status of available policy types in the
    /// organization, use
    /// ListRoots.
    pub fn enablePolicyType(self: *Self, allocator: std.mem.Allocator, input: enable_policy_type.EnablePolicyTypeInput, options: CallOptions) !enable_policy_type.EnablePolicyTypeOutput {
        return enable_policy_type.execute(self, allocator, input, options);
    }

    /// Sends an invitation to another account to join your organization as a member
    /// account.
    /// Organizations sends email on your behalf to the email address that is
    /// associated with the
    /// other account's owner. The invitation is implemented as a Handshake
    /// whose details are in the response.
    ///
    /// If you receive an exception that indicates that you exceeded your account
    /// limits
    /// for the organization or that the operation failed because your organization
    /// is still
    /// initializing, wait one hour and then try again. If the error persists after
    /// an hour,
    /// contact [Amazon Web Services
    /// Support](https://console.aws.amazon.com/support/home#/).
    ///
    /// If the request includes tags, then the requester must have the
    /// `organizations:TagResource` permission.
    ///
    /// You can only call this operation from the management account.
    pub fn inviteAccountToOrganization(self: *Self, allocator: std.mem.Allocator, input: invite_account_to_organization.InviteAccountToOrganizationInput, options: CallOptions) !invite_account_to_organization.InviteAccountToOrganizationOutput {
        return invite_account_to_organization.execute(self, allocator, input, options);
    }

    /// Sends an invitation to another organization's management account to
    /// designate your
    /// account with the specified responsibilities for their organization. The
    /// invitation is
    /// implemented as a Handshake whose details are in the response.
    ///
    /// You can only call this operation from the management account.
    pub fn inviteOrganizationToTransferResponsibility(self: *Self, allocator: std.mem.Allocator, input: invite_organization_to_transfer_responsibility.InviteOrganizationToTransferResponsibilityInput, options: CallOptions) !invite_organization_to_transfer_responsibility.InviteOrganizationToTransferResponsibilityOutput {
        return invite_organization_to_transfer_responsibility.execute(self, allocator, input, options);
    }

    /// Removes a member account from its parent organization. This version of the
    /// operation
    /// is performed by the account that wants to leave. To remove a member account
    /// as a user in
    /// the management account, use RemoveAccountFromOrganization
    /// instead.
    ///
    /// You can only call from operation from a member account.
    ///
    /// * The management account in an organization with all features enabled can
    /// set service control policies (SCPs) that can restrict what administrators of
    /// member accounts can do. This includes preventing them from successfully
    /// calling `LeaveOrganization` and leaving the organization.
    ///
    /// * You can leave an organization as a member account only if the account is
    /// configured with the information required to operate as a standalone account.
    /// When you create an account in an organization using the Organizations
    /// console,
    /// API, or CLI commands, the information required of standalone accounts is
    /// *not* automatically collected. For each account that
    /// you want to make standalone, you must perform the following steps. If any of
    /// the steps are already completed for this account, that step doesn't
    /// appear.
    ///
    /// * Choose a support plan
    ///
    /// * Provide and verify the required contact information
    ///
    /// * Provide a current payment method
    ///
    /// Amazon Web Services uses the payment method to charge for any billable (not
    /// free tier)
    /// Amazon Web Services activity that occurs while the account isn't attached to
    /// an
    /// organization. For more information, see [Considerations before removing an
    /// account from an
    /// organization](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_manage_account-before-remove.html)
    /// in the *Organizations User Guide*.
    ///
    /// * The account that you want to leave must not be a delegated administrator
    /// account for any Amazon Web Services service enabled for your organization.
    /// If the account
    /// is a delegated administrator, you must first change the delegated
    /// administrator account to another account that is remaining in the
    /// organization.
    ///
    /// * After the account leaves the organization, all tags that were attached to
    /// the account object in the organization are deleted. Amazon Web Services
    /// accounts outside
    /// of an organization do not support tags.
    ///
    /// * A newly created account has a waiting period before it can be removed from
    /// its organization. You must wait until at least four days after the account
    /// was created. Invited accounts aren't subject to this waiting period.
    ///
    /// * If you are using an organization principal to call
    /// `LeaveOrganization` across multiple accounts, you can only do
    /// this up to 5 accounts per second in a single organization.
    pub fn leaveOrganization(self: *Self, allocator: std.mem.Allocator, input: leave_organization.LeaveOrganizationInput, options: CallOptions) !leave_organization.LeaveOrganizationOutput {
        return leave_organization.execute(self, allocator, input, options);
    }

    /// Lists all the accounts in the organization. To request only the accounts in
    /// a
    /// specified root or organizational unit (OU), use the ListAccountsForParent
    /// operation instead.
    ///
    /// When calling List* operations, always check the `NextToken` response
    /// parameter value, even if you receive an empty result set.
    /// These operations can occasionally return an empty set of results even when
    /// more results are available.
    /// Continue making requests until `NextToken` returns null. A null `NextToken`
    /// value indicates that you have retrieved all available results.
    ///
    /// You can only call this operation from the management account or a member
    /// account that is a delegated administrator.
    pub fn listAccounts(self: *Self, allocator: std.mem.Allocator, input: list_accounts.ListAccountsInput, options: CallOptions) !list_accounts.ListAccountsOutput {
        return list_accounts.execute(self, allocator, input, options);
    }

    /// Lists the accounts in an organization that are contained by the specified
    /// target root
    /// or organizational unit (OU). If you specify the root, you get a list of all
    /// the accounts
    /// that aren't in any OU. If you specify an OU, you get a list of all the
    /// accounts in only
    /// that OU and not in any child OUs. To get a list of all accounts in the
    /// organization, use
    /// the ListAccounts operation.
    ///
    /// When calling List* operations, always check the `NextToken` response
    /// parameter value, even if you receive an empty result set.
    /// These operations can occasionally return an empty set of results even when
    /// more results are available.
    /// Continue making requests until `NextToken` returns null. A null `NextToken`
    /// value indicates that you have retrieved all available results.
    ///
    /// You can only call this operation from the management account or a member
    /// account that is a delegated administrator.
    pub fn listAccountsForParent(self: *Self, allocator: std.mem.Allocator, input: list_accounts_for_parent.ListAccountsForParentInput, options: CallOptions) !list_accounts_for_parent.ListAccountsForParentOutput {
        return list_accounts_for_parent.execute(self, allocator, input, options);
    }

    /// Lists all the accounts in an organization that have invalid effective
    /// policies. An
    /// *invalid effective policy* is an [effective
    /// policy](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_manage_policies_effective.html) that fails validation checks, resulting in the effective policy not
    /// being fully enforced on all the intended accounts within an organization.
    ///
    /// You can only call this operation from the management account or a member
    /// account that is a delegated administrator.
    pub fn listAccountsWithInvalidEffectivePolicy(self: *Self, allocator: std.mem.Allocator, input: list_accounts_with_invalid_effective_policy.ListAccountsWithInvalidEffectivePolicyInput, options: CallOptions) !list_accounts_with_invalid_effective_policy.ListAccountsWithInvalidEffectivePolicyOutput {
        return list_accounts_with_invalid_effective_policy.execute(self, allocator, input, options);
    }

    /// Returns a list of the Amazon Web Services services that you enabled to
    /// integrate with your
    /// organization. After a service on this list creates the resources that it
    /// requires for
    /// the integration, it can perform operations on your organization and its
    /// accounts.
    ///
    /// For more information about integrating other services with Organizations,
    /// including the
    /// list of services that currently work with Organizations, see [Using
    /// Organizations with other Amazon Web Services
    /// services](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_integrate_services.html) in the *Organizations User Guide*.
    ///
    /// You can only call this operation from the management account or a member
    /// account that is a delegated administrator.
    pub fn listAwsServiceAccessForOrganization(self: *Self, allocator: std.mem.Allocator, input: list_aws_service_access_for_organization.ListAWSServiceAccessForOrganizationInput, options: CallOptions) !list_aws_service_access_for_organization.ListAWSServiceAccessForOrganizationOutput {
        return list_aws_service_access_for_organization.execute(self, allocator, input, options);
    }

    /// Lists all of the organizational units (OUs) or accounts that are contained
    /// in the
    /// specified parent OU or root. This operation, along with ListParents
    /// enables you to traverse the tree structure that makes up this root.
    ///
    /// When calling List* operations, always check the `NextToken` response
    /// parameter value, even if you receive an empty result set.
    /// These operations can occasionally return an empty set of results even when
    /// more results are available.
    /// Continue making requests until `NextToken` returns null. A null `NextToken`
    /// value indicates that you have retrieved all available results.
    ///
    /// You can only call this operation from the management account or a member
    /// account that is a delegated administrator.
    pub fn listChildren(self: *Self, allocator: std.mem.Allocator, input: list_children.ListChildrenInput, options: CallOptions) !list_children.ListChildrenOutput {
        return list_children.execute(self, allocator, input, options);
    }

    /// Lists the account creation requests that match the specified status that is
    /// currently
    /// being tracked for the organization.
    ///
    /// When calling List* operations, always check the `NextToken` response
    /// parameter value, even if you receive an empty result set.
    /// These operations can occasionally return an empty set of results even when
    /// more results are available.
    /// Continue making requests until `NextToken` returns null. A null `NextToken`
    /// value indicates that you have retrieved all available results.
    ///
    /// You can only call this operation from the management account or a member
    /// account that is a delegated administrator.
    pub fn listCreateAccountStatus(self: *Self, allocator: std.mem.Allocator, input: list_create_account_status.ListCreateAccountStatusInput, options: CallOptions) !list_create_account_status.ListCreateAccountStatusOutput {
        return list_create_account_status.execute(self, allocator, input, options);
    }

    /// Lists the Amazon Web Services accounts that are designated as delegated
    /// administrators in this
    /// organization.
    ///
    /// You can only call this operation from the management account or a member
    /// account that is a delegated administrator.
    pub fn listDelegatedAdministrators(self: *Self, allocator: std.mem.Allocator, input: list_delegated_administrators.ListDelegatedAdministratorsInput, options: CallOptions) !list_delegated_administrators.ListDelegatedAdministratorsOutput {
        return list_delegated_administrators.execute(self, allocator, input, options);
    }

    /// List the Amazon Web Services services for which the specified account is a
    /// delegated
    /// administrator.
    ///
    /// You can only call this operation from the management account or a member
    /// account that is a delegated administrator.
    pub fn listDelegatedServicesForAccount(self: *Self, allocator: std.mem.Allocator, input: list_delegated_services_for_account.ListDelegatedServicesForAccountInput, options: CallOptions) !list_delegated_services_for_account.ListDelegatedServicesForAccountOutput {
        return list_delegated_services_for_account.execute(self, allocator, input, options);
    }

    /// Lists all the validation errors on an [effective
    /// policy](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_manage_policies_effective.html) for a specified account and policy type.
    ///
    /// You can only call this operation from the management account or a member
    /// account that is a delegated administrator.
    pub fn listEffectivePolicyValidationErrors(self: *Self, allocator: std.mem.Allocator, input: list_effective_policy_validation_errors.ListEffectivePolicyValidationErrorsInput, options: CallOptions) !list_effective_policy_validation_errors.ListEffectivePolicyValidationErrorsOutput {
        return list_effective_policy_validation_errors.execute(self, allocator, input, options);
    }

    /// Lists the recent handshakes that you have received.
    ///
    /// You can view `CANCELED`, `ACCEPTED`, `DECLINED`, or
    /// `EXPIRED` handshakes in API responses for 30 days before they are
    /// deleted.
    ///
    /// You can call this operation from any account in a organization.
    ///
    /// When calling List* operations, always check the `NextToken` response
    /// parameter value, even if you receive an empty result set.
    /// These operations can occasionally return an empty set of results even when
    /// more results are available.
    /// Continue making requests until `NextToken` returns null. A null `NextToken`
    /// value indicates that you have retrieved all available results.
    pub fn listHandshakesForAccount(self: *Self, allocator: std.mem.Allocator, input: list_handshakes_for_account.ListHandshakesForAccountInput, options: CallOptions) !list_handshakes_for_account.ListHandshakesForAccountOutput {
        return list_handshakes_for_account.execute(self, allocator, input, options);
    }

    /// Lists the recent handshakes that you have sent.
    ///
    /// You can view `CANCELED`, `ACCEPTED`, `DECLINED`, or
    /// `EXPIRED` handshakes in API responses for 30 days before they are
    /// deleted.
    ///
    /// You can only call this operation from the management account or a member
    /// account that is a delegated administrator.
    ///
    /// When calling List* operations, always check the `NextToken` response
    /// parameter value, even if you receive an empty result set.
    /// These operations can occasionally return an empty set of results even when
    /// more results are available.
    /// Continue making requests until `NextToken` returns null. A null `NextToken`
    /// value indicates that you have retrieved all available results.
    pub fn listHandshakesForOrganization(self: *Self, allocator: std.mem.Allocator, input: list_handshakes_for_organization.ListHandshakesForOrganizationInput, options: CallOptions) !list_handshakes_for_organization.ListHandshakesForOrganizationOutput {
        return list_handshakes_for_organization.execute(self, allocator, input, options);
    }

    /// Lists transfers that allow you to manage the specified responsibilities for
    /// another
    /// organization. This operation returns both transfer invitations and
    /// transfers.
    ///
    /// When calling List* operations, always check the `NextToken` response
    /// parameter value, even if you receive an empty result set.
    /// These operations can occasionally return an empty set of results even when
    /// more results are available.
    /// Continue making requests until `NextToken` returns null. A null `NextToken`
    /// value indicates that you have retrieved all available results.
    pub fn listInboundResponsibilityTransfers(self: *Self, allocator: std.mem.Allocator, input: list_inbound_responsibility_transfers.ListInboundResponsibilityTransfersInput, options: CallOptions) !list_inbound_responsibility_transfers.ListInboundResponsibilityTransfersOutput {
        return list_inbound_responsibility_transfers.execute(self, allocator, input, options);
    }

    /// Lists the organizational units (OUs) in a parent organizational unit or
    /// root.
    ///
    /// When calling List* operations, always check the `NextToken` response
    /// parameter value, even if you receive an empty result set.
    /// These operations can occasionally return an empty set of results even when
    /// more results are available.
    /// Continue making requests until `NextToken` returns null. A null `NextToken`
    /// value indicates that you have retrieved all available results.
    ///
    /// You can only call this operation from the management account or a member
    /// account that is a delegated administrator.
    pub fn listOrganizationalUnitsForParent(self: *Self, allocator: std.mem.Allocator, input: list_organizational_units_for_parent.ListOrganizationalUnitsForParentInput, options: CallOptions) !list_organizational_units_for_parent.ListOrganizationalUnitsForParentOutput {
        return list_organizational_units_for_parent.execute(self, allocator, input, options);
    }

    /// Lists transfers that allow an account outside your organization to manage
    /// the
    /// specified responsibilities for your organization. This operation returns
    /// both transfer
    /// invitations and transfers.
    ///
    /// When calling List* operations, always check the `NextToken` response
    /// parameter value, even if you receive an empty result set.
    /// These operations can occasionally return an empty set of results even when
    /// more results are available.
    /// Continue making requests until `NextToken` returns null. A null `NextToken`
    /// value indicates that you have retrieved all available results.
    pub fn listOutboundResponsibilityTransfers(self: *Self, allocator: std.mem.Allocator, input: list_outbound_responsibility_transfers.ListOutboundResponsibilityTransfersInput, options: CallOptions) !list_outbound_responsibility_transfers.ListOutboundResponsibilityTransfersOutput {
        return list_outbound_responsibility_transfers.execute(self, allocator, input, options);
    }

    /// Lists the root or organizational units (OUs) that serve as the immediate
    /// parent of the
    /// specified child OU or account. This operation, along with ListChildren
    /// enables you to traverse the tree structure that makes up this root.
    ///
    /// When calling List* operations, always check the `NextToken` response
    /// parameter value, even if you receive an empty result set.
    /// These operations can occasionally return an empty set of results even when
    /// more results are available.
    /// Continue making requests until `NextToken` returns null. A null `NextToken`
    /// value indicates that you have retrieved all available results.
    ///
    /// You can only call this operation from the management account or a member
    /// account that is a delegated administrator.
    ///
    /// In the current release, a child can have only a single parent.
    pub fn listParents(self: *Self, allocator: std.mem.Allocator, input: list_parents.ListParentsInput, options: CallOptions) !list_parents.ListParentsOutput {
        return list_parents.execute(self, allocator, input, options);
    }

    /// Retrieves the list of all policies in an organization of a specified type.
    ///
    /// When calling List* operations, always check the `NextToken` response
    /// parameter value, even if you receive an empty result set.
    /// These operations can occasionally return an empty set of results even when
    /// more results are available.
    /// Continue making requests until `NextToken` returns null. A null `NextToken`
    /// value indicates that you have retrieved all available results.
    ///
    /// You can only call this operation from the management account or a member
    /// account that is a delegated administrator.
    pub fn listPolicies(self: *Self, allocator: std.mem.Allocator, input: list_policies.ListPoliciesInput, options: CallOptions) !list_policies.ListPoliciesOutput {
        return list_policies.execute(self, allocator, input, options);
    }

    /// Lists the policies that are directly attached to the specified target root,
    /// organizational unit (OU), or account. You must specify the policy type that
    /// you want
    /// included in the returned list.
    ///
    /// When calling List* operations, always check the `NextToken` response
    /// parameter value, even if you receive an empty result set.
    /// These operations can occasionally return an empty set of results even when
    /// more results are available.
    /// Continue making requests until `NextToken` returns null. A null `NextToken`
    /// value indicates that you have retrieved all available results.
    ///
    /// You can only call this operation from the management account or a member
    /// account that is a delegated administrator.
    pub fn listPoliciesForTarget(self: *Self, allocator: std.mem.Allocator, input: list_policies_for_target.ListPoliciesForTargetInput, options: CallOptions) !list_policies_for_target.ListPoliciesForTargetOutput {
        return list_policies_for_target.execute(self, allocator, input, options);
    }

    /// Lists the roots that are defined in the current organization.
    ///
    /// When calling List* operations, always check the `NextToken` response
    /// parameter value, even if you receive an empty result set.
    /// These operations can occasionally return an empty set of results even when
    /// more results are available.
    /// Continue making requests until `NextToken` returns null. A null `NextToken`
    /// value indicates that you have retrieved all available results.
    ///
    /// You can only call this operation from the management account or a member
    /// account that is a delegated administrator.
    ///
    /// Policy types can be enabled and disabled in roots. This is distinct from
    /// whether
    /// they're available in the organization. When you enable all features, you
    /// make policy
    /// types available for use in that organization. Individual policy types can
    /// then be
    /// enabled and disabled in a root. To see the availability of a policy type in
    /// an
    /// organization, use DescribeOrganization.
    pub fn listRoots(self: *Self, allocator: std.mem.Allocator, input: list_roots.ListRootsInput, options: CallOptions) !list_roots.ListRootsOutput {
        return list_roots.execute(self, allocator, input, options);
    }

    /// Lists tags that are attached to the specified resource.
    ///
    /// You can attach tags to the following resources in Organizations.
    ///
    /// * Amazon Web Services account
    ///
    /// * Organization root
    ///
    /// * Organizational unit (OU)
    ///
    /// * Policy (any type)
    ///
    /// You can only call this operation from the management account or a member
    /// account that is a delegated administrator.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: CallOptions) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Lists all the roots, organizational units (OUs), and accounts that the
    /// specified
    /// policy is attached to.
    ///
    /// When calling List* operations, always check the `NextToken` response
    /// parameter value, even if you receive an empty result set.
    /// These operations can occasionally return an empty set of results even when
    /// more results are available.
    /// Continue making requests until `NextToken` returns null. A null `NextToken`
    /// value indicates that you have retrieved all available results.
    ///
    /// You can only call this operation from the management account or a member
    /// account that is a delegated administrator.
    pub fn listTargetsForPolicy(self: *Self, allocator: std.mem.Allocator, input: list_targets_for_policy.ListTargetsForPolicyInput, options: CallOptions) !list_targets_for_policy.ListTargetsForPolicyOutput {
        return list_targets_for_policy.execute(self, allocator, input, options);
    }

    /// Moves an account from its current source parent root or organizational unit
    /// (OU) to
    /// the specified destination parent root or OU.
    ///
    /// You can only call this operation from the management account.
    pub fn moveAccount(self: *Self, allocator: std.mem.Allocator, input: move_account.MoveAccountInput, options: CallOptions) !move_account.MoveAccountOutput {
        return move_account.execute(self, allocator, input, options);
    }

    /// Creates or updates a resource policy.
    ///
    /// You can only call this operation from the management account..
    pub fn putResourcePolicy(self: *Self, allocator: std.mem.Allocator, input: put_resource_policy.PutResourcePolicyInput, options: CallOptions) !put_resource_policy.PutResourcePolicyOutput {
        return put_resource_policy.execute(self, allocator, input, options);
    }

    /// Enables the specified member account to administer the Organizations
    /// features of the specified
    /// Amazon Web Services service. It grants read-only access to Organizations
    /// service data. The account still
    /// requires IAM permissions to access and administer the Amazon Web Services
    /// service.
    ///
    /// You can run this action only for Amazon Web Services services that support
    /// this
    /// feature. For a current list of services that support it, see the column
    /// *Supports
    /// Delegated Administrator* in the table at [Amazon Web Services Services that
    /// you can use with
    /// Organizations](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_integrate_services_list.html) in the *Organizations User Guide.*
    ///
    /// You can only call this operation from the management account.
    pub fn registerDelegatedAdministrator(self: *Self, allocator: std.mem.Allocator, input: register_delegated_administrator.RegisterDelegatedAdministratorInput, options: CallOptions) !register_delegated_administrator.RegisterDelegatedAdministratorOutput {
        return register_delegated_administrator.execute(self, allocator, input, options);
    }

    /// Removes the specified account from the organization.
    ///
    /// The removed account becomes a standalone account that isn't a member of any
    /// organization. It's no longer subject to any policies and is responsible for
    /// its own bill
    /// payments. The organization's management account is no longer charged for any
    /// expenses
    /// accrued by the member account after it's removed from the organization.
    ///
    /// You can only call this operation from the management account. Member
    /// accounts can remove themselves with LeaveOrganization instead.
    ///
    /// * You can remove an account from your organization only if the account is
    /// configured with the information required to operate as a standalone account.
    /// When you create an account in an organization using the Organizations
    /// console,
    /// API, or CLI commands, the information required of standalone accounts is
    /// *not* automatically collected. For more information,
    /// see [Considerations before removing an account from an
    /// organization](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_manage_account-before-remove.html)
    /// in the *Organizations User Guide*.
    ///
    /// * The account that you want to leave must not be a delegated administrator
    /// account for any Amazon Web Services service enabled for your organization.
    /// If the account
    /// is a delegated administrator, you must first change the delegated
    /// administrator account to another account that is remaining in the
    /// organization.
    ///
    /// * After the account leaves the organization, all tags that were attached to
    /// the account object in the organization are deleted. Amazon Web Services
    /// accounts outside
    /// of an organization do not support tags.
    pub fn removeAccountFromOrganization(self: *Self, allocator: std.mem.Allocator, input: remove_account_from_organization.RemoveAccountFromOrganizationInput, options: CallOptions) !remove_account_from_organization.RemoveAccountFromOrganizationOutput {
        return remove_account_from_organization.execute(self, allocator, input, options);
    }

    /// Adds one or more tags to the specified resource.
    ///
    /// Currently, you can attach tags to the following resources in Organizations.
    ///
    /// * Amazon Web Services account
    ///
    /// * Organization root
    ///
    /// * Organizational unit (OU)
    ///
    /// * Policy (any type)
    ///
    /// You can only call this operation from the management account or a member
    /// account that is a delegated administrator.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: CallOptions) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Ends a transfer. A *transfer* is an arrangement between two
    /// management accounts where one account designates the other with specified
    /// responsibilities for their organization.
    pub fn terminateResponsibilityTransfer(self: *Self, allocator: std.mem.Allocator, input: terminate_responsibility_transfer.TerminateResponsibilityTransferInput, options: CallOptions) !terminate_responsibility_transfer.TerminateResponsibilityTransferOutput {
        return terminate_responsibility_transfer.execute(self, allocator, input, options);
    }

    /// Removes any tags with the specified keys from the specified resource.
    ///
    /// You can attach tags to the following resources in Organizations.
    ///
    /// * Amazon Web Services account
    ///
    /// * Organization root
    ///
    /// * Organizational unit (OU)
    ///
    /// * Policy (any type)
    ///
    /// You can only call this operation from the management account or a member
    /// account that is a delegated administrator.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: CallOptions) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Renames the specified organizational unit (OU). The ID and ARN don't change.
    /// The child
    /// OUs and accounts remain in place, and any attached policies of the OU remain
    /// attached.
    ///
    /// You can only call this operation from the management account.
    pub fn updateOrganizationalUnit(self: *Self, allocator: std.mem.Allocator, input: update_organizational_unit.UpdateOrganizationalUnitInput, options: CallOptions) !update_organizational_unit.UpdateOrganizationalUnitOutput {
        return update_organizational_unit.execute(self, allocator, input, options);
    }

    /// Updates an existing policy with a new name, description, or content. If you
    /// don't
    /// supply any parameter, that value remains unchanged. You can't change a
    /// policy's
    /// type.
    ///
    /// You can only call this operation from the management account or a member
    /// account that is a delegated administrator.
    pub fn updatePolicy(self: *Self, allocator: std.mem.Allocator, input: update_policy.UpdatePolicyInput, options: CallOptions) !update_policy.UpdatePolicyOutput {
        return update_policy.execute(self, allocator, input, options);
    }

    /// Updates a transfer. A *transfer* is the arrangement between two
    /// management accounts where one account designates the other with specified
    /// responsibilities for their organization.
    ///
    /// You can update the name assigned to a transfer.
    pub fn updateResponsibilityTransfer(self: *Self, allocator: std.mem.Allocator, input: update_responsibility_transfer.UpdateResponsibilityTransferInput, options: CallOptions) !update_responsibility_transfer.UpdateResponsibilityTransferOutput {
        return update_responsibility_transfer.execute(self, allocator, input, options);
    }

    pub fn listAccountsPaginator(self: *Self, params: list_accounts.ListAccountsInput) paginator.ListAccountsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listAccountsForParentPaginator(self: *Self, params: list_accounts_for_parent.ListAccountsForParentInput) paginator.ListAccountsForParentPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listAccountsWithInvalidEffectivePolicyPaginator(self: *Self, params: list_accounts_with_invalid_effective_policy.ListAccountsWithInvalidEffectivePolicyInput) paginator.ListAccountsWithInvalidEffectivePolicyPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listAwsServiceAccessForOrganizationPaginator(self: *Self, params: list_aws_service_access_for_organization.ListAWSServiceAccessForOrganizationInput) paginator.ListAWSServiceAccessForOrganizationPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listChildrenPaginator(self: *Self, params: list_children.ListChildrenInput) paginator.ListChildrenPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listCreateAccountStatusPaginator(self: *Self, params: list_create_account_status.ListCreateAccountStatusInput) paginator.ListCreateAccountStatusPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listDelegatedAdministratorsPaginator(self: *Self, params: list_delegated_administrators.ListDelegatedAdministratorsInput) paginator.ListDelegatedAdministratorsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listDelegatedServicesForAccountPaginator(self: *Self, params: list_delegated_services_for_account.ListDelegatedServicesForAccountInput) paginator.ListDelegatedServicesForAccountPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listEffectivePolicyValidationErrorsPaginator(self: *Self, params: list_effective_policy_validation_errors.ListEffectivePolicyValidationErrorsInput) paginator.ListEffectivePolicyValidationErrorsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listHandshakesForAccountPaginator(self: *Self, params: list_handshakes_for_account.ListHandshakesForAccountInput) paginator.ListHandshakesForAccountPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listHandshakesForOrganizationPaginator(self: *Self, params: list_handshakes_for_organization.ListHandshakesForOrganizationInput) paginator.ListHandshakesForOrganizationPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listOrganizationalUnitsForParentPaginator(self: *Self, params: list_organizational_units_for_parent.ListOrganizationalUnitsForParentInput) paginator.ListOrganizationalUnitsForParentPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listParentsPaginator(self: *Self, params: list_parents.ListParentsInput) paginator.ListParentsPaginator {
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

    pub fn listPoliciesForTargetPaginator(self: *Self, params: list_policies_for_target.ListPoliciesForTargetInput) paginator.ListPoliciesForTargetPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listRootsPaginator(self: *Self, params: list_roots.ListRootsInput) paginator.ListRootsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listTagsForResourcePaginator(self: *Self, params: list_tags_for_resource.ListTagsForResourceInput) paginator.ListTagsForResourcePaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listTargetsForPolicyPaginator(self: *Self, params: list_targets_for_policy.ListTargetsForPolicyInput) paginator.ListTargetsForPolicyPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }
};
