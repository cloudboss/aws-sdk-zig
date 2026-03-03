const aws = @import("aws");
const std = @import("std");

const associate_delegate_to_resource = @import("associate_delegate_to_resource.zig");
const associate_member_to_group = @import("associate_member_to_group.zig");
const assume_impersonation_role = @import("assume_impersonation_role.zig");
const cancel_mailbox_export_job = @import("cancel_mailbox_export_job.zig");
const create_alias = @import("create_alias.zig");
const create_availability_configuration = @import("create_availability_configuration.zig");
const create_group = @import("create_group.zig");
const create_identity_center_application = @import("create_identity_center_application.zig");
const create_impersonation_role = @import("create_impersonation_role.zig");
const create_mobile_device_access_rule = @import("create_mobile_device_access_rule.zig");
const create_organization = @import("create_organization.zig");
const create_resource = @import("create_resource.zig");
const create_user = @import("create_user.zig");
const delete_access_control_rule = @import("delete_access_control_rule.zig");
const delete_alias = @import("delete_alias.zig");
const delete_availability_configuration = @import("delete_availability_configuration.zig");
const delete_email_monitoring_configuration = @import("delete_email_monitoring_configuration.zig");
const delete_group = @import("delete_group.zig");
const delete_identity_center_application = @import("delete_identity_center_application.zig");
const delete_identity_provider_configuration = @import("delete_identity_provider_configuration.zig");
const delete_impersonation_role = @import("delete_impersonation_role.zig");
const delete_mailbox_permissions = @import("delete_mailbox_permissions.zig");
const delete_mobile_device_access_override = @import("delete_mobile_device_access_override.zig");
const delete_mobile_device_access_rule = @import("delete_mobile_device_access_rule.zig");
const delete_organization = @import("delete_organization.zig");
const delete_personal_access_token = @import("delete_personal_access_token.zig");
const delete_resource = @import("delete_resource.zig");
const delete_retention_policy = @import("delete_retention_policy.zig");
const delete_user = @import("delete_user.zig");
const deregister_from_work_mail = @import("deregister_from_work_mail.zig");
const deregister_mail_domain = @import("deregister_mail_domain.zig");
const describe_email_monitoring_configuration = @import("describe_email_monitoring_configuration.zig");
const describe_entity = @import("describe_entity.zig");
const describe_group = @import("describe_group.zig");
const describe_identity_provider_configuration = @import("describe_identity_provider_configuration.zig");
const describe_inbound_dmarc_settings = @import("describe_inbound_dmarc_settings.zig");
const describe_mailbox_export_job = @import("describe_mailbox_export_job.zig");
const describe_organization = @import("describe_organization.zig");
const describe_resource = @import("describe_resource.zig");
const describe_user = @import("describe_user.zig");
const disassociate_delegate_from_resource = @import("disassociate_delegate_from_resource.zig");
const disassociate_member_from_group = @import("disassociate_member_from_group.zig");
const get_access_control_effect = @import("get_access_control_effect.zig");
const get_default_retention_policy = @import("get_default_retention_policy.zig");
const get_impersonation_role = @import("get_impersonation_role.zig");
const get_impersonation_role_effect = @import("get_impersonation_role_effect.zig");
const get_mail_domain = @import("get_mail_domain.zig");
const get_mailbox_details = @import("get_mailbox_details.zig");
const get_mobile_device_access_effect = @import("get_mobile_device_access_effect.zig");
const get_mobile_device_access_override = @import("get_mobile_device_access_override.zig");
const get_personal_access_token_metadata = @import("get_personal_access_token_metadata.zig");
const list_access_control_rules = @import("list_access_control_rules.zig");
const list_aliases = @import("list_aliases.zig");
const list_availability_configurations = @import("list_availability_configurations.zig");
const list_group_members = @import("list_group_members.zig");
const list_groups = @import("list_groups.zig");
const list_groups_for_entity = @import("list_groups_for_entity.zig");
const list_impersonation_roles = @import("list_impersonation_roles.zig");
const list_mail_domains = @import("list_mail_domains.zig");
const list_mailbox_export_jobs = @import("list_mailbox_export_jobs.zig");
const list_mailbox_permissions = @import("list_mailbox_permissions.zig");
const list_mobile_device_access_overrides = @import("list_mobile_device_access_overrides.zig");
const list_mobile_device_access_rules = @import("list_mobile_device_access_rules.zig");
const list_organizations = @import("list_organizations.zig");
const list_personal_access_tokens = @import("list_personal_access_tokens.zig");
const list_resource_delegates = @import("list_resource_delegates.zig");
const list_resources = @import("list_resources.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const list_users = @import("list_users.zig");
const put_access_control_rule = @import("put_access_control_rule.zig");
const put_email_monitoring_configuration = @import("put_email_monitoring_configuration.zig");
const put_identity_provider_configuration = @import("put_identity_provider_configuration.zig");
const put_inbound_dmarc_settings = @import("put_inbound_dmarc_settings.zig");
const put_mailbox_permissions = @import("put_mailbox_permissions.zig");
const put_mobile_device_access_override = @import("put_mobile_device_access_override.zig");
const put_retention_policy = @import("put_retention_policy.zig");
const register_mail_domain = @import("register_mail_domain.zig");
const register_to_work_mail = @import("register_to_work_mail.zig");
const reset_password = @import("reset_password.zig");
const start_mailbox_export_job = @import("start_mailbox_export_job.zig");
const tag_resource = @import("tag_resource.zig");
const test_availability_configuration = @import("test_availability_configuration.zig");
const untag_resource = @import("untag_resource.zig");
const update_availability_configuration = @import("update_availability_configuration.zig");
const update_default_mail_domain = @import("update_default_mail_domain.zig");
const update_group = @import("update_group.zig");
const update_impersonation_role = @import("update_impersonation_role.zig");
const update_mailbox_quota = @import("update_mailbox_quota.zig");
const update_mobile_device_access_rule = @import("update_mobile_device_access_rule.zig");
const update_primary_email_address = @import("update_primary_email_address.zig");
const update_resource = @import("update_resource.zig");
const update_user = @import("update_user.zig");
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "WorkMail";

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

    /// Adds a member (user or group) to the resource's set of delegates.
    pub fn associateDelegateToResource(self: *Self, allocator: std.mem.Allocator, input: associate_delegate_to_resource.AssociateDelegateToResourceInput, options: associate_delegate_to_resource.Options) !associate_delegate_to_resource.AssociateDelegateToResourceOutput {
        return associate_delegate_to_resource.execute(self, allocator, input, options);
    }

    /// Adds a member (user or group) to the group's set.
    pub fn associateMemberToGroup(self: *Self, allocator: std.mem.Allocator, input: associate_member_to_group.AssociateMemberToGroupInput, options: associate_member_to_group.Options) !associate_member_to_group.AssociateMemberToGroupOutput {
        return associate_member_to_group.execute(self, allocator, input, options);
    }

    /// Assumes an impersonation role for the given WorkMail organization. This
    /// method returns an
    /// authentication token you can use to make impersonated calls.
    pub fn assumeImpersonationRole(self: *Self, allocator: std.mem.Allocator, input: assume_impersonation_role.AssumeImpersonationRoleInput, options: assume_impersonation_role.Options) !assume_impersonation_role.AssumeImpersonationRoleOutput {
        return assume_impersonation_role.execute(self, allocator, input, options);
    }

    /// Cancels a mailbox export job.
    ///
    /// If the mailbox export job is near completion, it might not be possible to
    /// cancel
    /// it.
    pub fn cancelMailboxExportJob(self: *Self, allocator: std.mem.Allocator, input: cancel_mailbox_export_job.CancelMailboxExportJobInput, options: cancel_mailbox_export_job.Options) !cancel_mailbox_export_job.CancelMailboxExportJobOutput {
        return cancel_mailbox_export_job.execute(self, allocator, input, options);
    }

    /// Adds an alias to the set of a given member (user or group) of WorkMail.
    pub fn createAlias(self: *Self, allocator: std.mem.Allocator, input: create_alias.CreateAliasInput, options: create_alias.Options) !create_alias.CreateAliasOutput {
        return create_alias.execute(self, allocator, input, options);
    }

    /// Creates an `AvailabilityConfiguration` for the given WorkMail organization
    /// and domain.
    pub fn createAvailabilityConfiguration(self: *Self, allocator: std.mem.Allocator, input: create_availability_configuration.CreateAvailabilityConfigurationInput, options: create_availability_configuration.Options) !create_availability_configuration.CreateAvailabilityConfigurationOutput {
        return create_availability_configuration.execute(self, allocator, input, options);
    }

    /// Creates a group that can be used in WorkMail by calling the
    /// RegisterToWorkMail operation.
    pub fn createGroup(self: *Self, allocator: std.mem.Allocator, input: create_group.CreateGroupInput, options: create_group.Options) !create_group.CreateGroupOutput {
        return create_group.execute(self, allocator, input, options);
    }

    /// Creates the WorkMail application in IAM Identity Center that can be used
    /// later in the WorkMail - IdC integration. For more information, see
    /// PutIdentityProviderConfiguration. This action does not affect the
    /// authentication settings for any WorkMail organizations.
    pub fn createIdentityCenterApplication(self: *Self, allocator: std.mem.Allocator, input: create_identity_center_application.CreateIdentityCenterApplicationInput, options: create_identity_center_application.Options) !create_identity_center_application.CreateIdentityCenterApplicationOutput {
        return create_identity_center_application.execute(self, allocator, input, options);
    }

    /// Creates an impersonation role for the given WorkMail organization.
    ///
    /// *Idempotency* ensures that an API request completes no more than one
    /// time. With an idempotent request, if the original request completes
    /// successfully, any
    /// subsequent retries also complete successfully without performing any further
    /// actions.
    pub fn createImpersonationRole(self: *Self, allocator: std.mem.Allocator, input: create_impersonation_role.CreateImpersonationRoleInput, options: create_impersonation_role.Options) !create_impersonation_role.CreateImpersonationRoleOutput {
        return create_impersonation_role.execute(self, allocator, input, options);
    }

    /// Creates a new mobile device access rule for the specified WorkMail
    /// organization.
    pub fn createMobileDeviceAccessRule(self: *Self, allocator: std.mem.Allocator, input: create_mobile_device_access_rule.CreateMobileDeviceAccessRuleInput, options: create_mobile_device_access_rule.Options) !create_mobile_device_access_rule.CreateMobileDeviceAccessRuleOutput {
        return create_mobile_device_access_rule.execute(self, allocator, input, options);
    }

    /// Creates a new WorkMail organization. Optionally, you can choose to associate
    /// an existing AWS Directory Service directory with your organization. If an
    /// AWS Directory Service directory ID is specified, the organization alias must
    /// match the directory alias. If you choose not to associate an existing
    /// directory with your organization, then we create a new WorkMail directory
    /// for you. For more information, see [Adding an
    /// organization](https://docs.aws.amazon.com/workmail/latest/adminguide/add_new_organization.html) in the *WorkMail Administrator Guide*.
    ///
    /// You can associate multiple email domains with an organization, then choose
    /// your
    /// default email domain from the WorkMail console. You can also associate a
    /// domain that is managed
    /// in an Amazon Route 53 public hosted zone. For more information, see [Adding
    /// a
    /// domain](https://docs.aws.amazon.com/workmail/latest/adminguide/add_domain.html) and [Choosing the default domain](https://docs.aws.amazon.com/workmail/latest/adminguide/default_domain.html)
    /// in the *WorkMail Administrator Guide*.
    ///
    /// Optionally, you can use a customer managed key from AWS Key Management
    /// Service (AWS
    /// KMS) to encrypt email for your organization. If you don't associate an AWS
    /// KMS key, WorkMail
    /// creates a default, AWS managed key for you.
    pub fn createOrganization(self: *Self, allocator: std.mem.Allocator, input: create_organization.CreateOrganizationInput, options: create_organization.Options) !create_organization.CreateOrganizationOutput {
        return create_organization.execute(self, allocator, input, options);
    }

    /// Creates a new WorkMail resource.
    pub fn createResource(self: *Self, allocator: std.mem.Allocator, input: create_resource.CreateResourceInput, options: create_resource.Options) !create_resource.CreateResourceOutput {
        return create_resource.execute(self, allocator, input, options);
    }

    /// Creates a user who can be used in WorkMail by calling the RegisterToWorkMail
    /// operation.
    pub fn createUser(self: *Self, allocator: std.mem.Allocator, input: create_user.CreateUserInput, options: create_user.Options) !create_user.CreateUserOutput {
        return create_user.execute(self, allocator, input, options);
    }

    /// Deletes an access control rule for the specified WorkMail organization.
    ///
    /// Deleting already deleted and non-existing rules does not produce an error.
    /// In those cases, the service sends back an HTTP 200 response with an empty
    /// HTTP body.
    pub fn deleteAccessControlRule(self: *Self, allocator: std.mem.Allocator, input: delete_access_control_rule.DeleteAccessControlRuleInput, options: delete_access_control_rule.Options) !delete_access_control_rule.DeleteAccessControlRuleOutput {
        return delete_access_control_rule.execute(self, allocator, input, options);
    }

    /// Remove one or more specified aliases from a set of aliases for a given
    /// user.
    pub fn deleteAlias(self: *Self, allocator: std.mem.Allocator, input: delete_alias.DeleteAliasInput, options: delete_alias.Options) !delete_alias.DeleteAliasOutput {
        return delete_alias.execute(self, allocator, input, options);
    }

    /// Deletes the `AvailabilityConfiguration` for the given WorkMail organization
    /// and domain.
    pub fn deleteAvailabilityConfiguration(self: *Self, allocator: std.mem.Allocator, input: delete_availability_configuration.DeleteAvailabilityConfigurationInput, options: delete_availability_configuration.Options) !delete_availability_configuration.DeleteAvailabilityConfigurationOutput {
        return delete_availability_configuration.execute(self, allocator, input, options);
    }

    /// Deletes the email monitoring configuration for a specified organization.
    pub fn deleteEmailMonitoringConfiguration(self: *Self, allocator: std.mem.Allocator, input: delete_email_monitoring_configuration.DeleteEmailMonitoringConfigurationInput, options: delete_email_monitoring_configuration.Options) !delete_email_monitoring_configuration.DeleteEmailMonitoringConfigurationOutput {
        return delete_email_monitoring_configuration.execute(self, allocator, input, options);
    }

    /// Deletes a group from WorkMail.
    pub fn deleteGroup(self: *Self, allocator: std.mem.Allocator, input: delete_group.DeleteGroupInput, options: delete_group.Options) !delete_group.DeleteGroupOutput {
        return delete_group.execute(self, allocator, input, options);
    }

    /// Deletes the IAM Identity Center application from WorkMail. This action does
    /// not affect the authentication settings for any WorkMail organizations.
    pub fn deleteIdentityCenterApplication(self: *Self, allocator: std.mem.Allocator, input: delete_identity_center_application.DeleteIdentityCenterApplicationInput, options: delete_identity_center_application.Options) !delete_identity_center_application.DeleteIdentityCenterApplicationOutput {
        return delete_identity_center_application.execute(self, allocator, input, options);
    }

    /// Disables the integration between IdC and WorkMail. Authentication will
    /// continue with the directory as it was before the IdC integration. You might
    /// have to reset your directory passwords and reconfigure your desktop and
    /// mobile email clients.
    pub fn deleteIdentityProviderConfiguration(self: *Self, allocator: std.mem.Allocator, input: delete_identity_provider_configuration.DeleteIdentityProviderConfigurationInput, options: delete_identity_provider_configuration.Options) !delete_identity_provider_configuration.DeleteIdentityProviderConfigurationOutput {
        return delete_identity_provider_configuration.execute(self, allocator, input, options);
    }

    /// Deletes an impersonation role for the given WorkMail organization.
    pub fn deleteImpersonationRole(self: *Self, allocator: std.mem.Allocator, input: delete_impersonation_role.DeleteImpersonationRoleInput, options: delete_impersonation_role.Options) !delete_impersonation_role.DeleteImpersonationRoleOutput {
        return delete_impersonation_role.execute(self, allocator, input, options);
    }

    /// Deletes permissions granted to a member (user or group).
    pub fn deleteMailboxPermissions(self: *Self, allocator: std.mem.Allocator, input: delete_mailbox_permissions.DeleteMailboxPermissionsInput, options: delete_mailbox_permissions.Options) !delete_mailbox_permissions.DeleteMailboxPermissionsOutput {
        return delete_mailbox_permissions.execute(self, allocator, input, options);
    }

    /// Deletes the mobile device access override for the given WorkMail
    /// organization, user, and device.
    ///
    /// Deleting already deleted and non-existing overrides does not produce an
    /// error. In those cases, the service sends back an HTTP 200 response with an
    /// empty HTTP body.
    pub fn deleteMobileDeviceAccessOverride(self: *Self, allocator: std.mem.Allocator, input: delete_mobile_device_access_override.DeleteMobileDeviceAccessOverrideInput, options: delete_mobile_device_access_override.Options) !delete_mobile_device_access_override.DeleteMobileDeviceAccessOverrideOutput {
        return delete_mobile_device_access_override.execute(self, allocator, input, options);
    }

    /// Deletes a mobile device access rule for the specified WorkMail organization.
    ///
    /// Deleting already deleted and non-existing rules does not produce an error.
    /// In those cases, the service sends back an HTTP 200 response with an empty
    /// HTTP body.
    pub fn deleteMobileDeviceAccessRule(self: *Self, allocator: std.mem.Allocator, input: delete_mobile_device_access_rule.DeleteMobileDeviceAccessRuleInput, options: delete_mobile_device_access_rule.Options) !delete_mobile_device_access_rule.DeleteMobileDeviceAccessRuleOutput {
        return delete_mobile_device_access_rule.execute(self, allocator, input, options);
    }

    /// Deletes an WorkMail organization and all underlying AWS resources managed by
    /// WorkMail as part of the organization. You can choose whether to delete the
    /// associated directory. For more information, see [Removing an
    /// organization](https://docs.aws.amazon.com/workmail/latest/adminguide/remove_organization.html) in the *WorkMail Administrator Guide*.
    pub fn deleteOrganization(self: *Self, allocator: std.mem.Allocator, input: delete_organization.DeleteOrganizationInput, options: delete_organization.Options) !delete_organization.DeleteOrganizationOutput {
        return delete_organization.execute(self, allocator, input, options);
    }

    /// Deletes the Personal Access Token from the provided WorkMail Organization.
    pub fn deletePersonalAccessToken(self: *Self, allocator: std.mem.Allocator, input: delete_personal_access_token.DeletePersonalAccessTokenInput, options: delete_personal_access_token.Options) !delete_personal_access_token.DeletePersonalAccessTokenOutput {
        return delete_personal_access_token.execute(self, allocator, input, options);
    }

    /// Deletes the specified resource.
    pub fn deleteResource(self: *Self, allocator: std.mem.Allocator, input: delete_resource.DeleteResourceInput, options: delete_resource.Options) !delete_resource.DeleteResourceOutput {
        return delete_resource.execute(self, allocator, input, options);
    }

    /// Deletes the specified retention policy from the specified organization.
    pub fn deleteRetentionPolicy(self: *Self, allocator: std.mem.Allocator, input: delete_retention_policy.DeleteRetentionPolicyInput, options: delete_retention_policy.Options) !delete_retention_policy.DeleteRetentionPolicyOutput {
        return delete_retention_policy.execute(self, allocator, input, options);
    }

    /// Deletes a user from WorkMail and all subsequent systems. Before you can
    /// delete a
    /// user, the user state must be `DISABLED`. Use the DescribeUser
    /// action to confirm the user state.
    ///
    /// Deleting a user is permanent and cannot be undone. WorkMail archives user
    /// mailboxes for
    /// 30 days before they are permanently removed.
    pub fn deleteUser(self: *Self, allocator: std.mem.Allocator, input: delete_user.DeleteUserInput, options: delete_user.Options) !delete_user.DeleteUserOutput {
        return delete_user.execute(self, allocator, input, options);
    }

    /// Mark a user, group, or resource as no longer used in WorkMail. This action
    /// disassociates the mailbox and schedules it for clean-up. WorkMail keeps
    /// mailboxes for 30 days
    /// before they are permanently removed. The functionality in the console is
    /// *Disable*.
    pub fn deregisterFromWorkMail(self: *Self, allocator: std.mem.Allocator, input: deregister_from_work_mail.DeregisterFromWorkMailInput, options: deregister_from_work_mail.Options) !deregister_from_work_mail.DeregisterFromWorkMailOutput {
        return deregister_from_work_mail.execute(self, allocator, input, options);
    }

    /// Removes a domain from WorkMail, stops email routing to WorkMail, and removes
    /// the authorization allowing WorkMail use. SES keeps the domain because other
    /// applications may use it. You must first
    /// remove any email address used by WorkMail entities before you remove the
    /// domain.
    pub fn deregisterMailDomain(self: *Self, allocator: std.mem.Allocator, input: deregister_mail_domain.DeregisterMailDomainInput, options: deregister_mail_domain.Options) !deregister_mail_domain.DeregisterMailDomainOutput {
        return deregister_mail_domain.execute(self, allocator, input, options);
    }

    /// Describes the current email monitoring configuration for a specified
    /// organization.
    pub fn describeEmailMonitoringConfiguration(self: *Self, allocator: std.mem.Allocator, input: describe_email_monitoring_configuration.DescribeEmailMonitoringConfigurationInput, options: describe_email_monitoring_configuration.Options) !describe_email_monitoring_configuration.DescribeEmailMonitoringConfigurationOutput {
        return describe_email_monitoring_configuration.execute(self, allocator, input, options);
    }

    /// Returns basic details about an entity in WorkMail.
    pub fn describeEntity(self: *Self, allocator: std.mem.Allocator, input: describe_entity.DescribeEntityInput, options: describe_entity.Options) !describe_entity.DescribeEntityOutput {
        return describe_entity.execute(self, allocator, input, options);
    }

    /// Returns the data available for the group.
    pub fn describeGroup(self: *Self, allocator: std.mem.Allocator, input: describe_group.DescribeGroupInput, options: describe_group.Options) !describe_group.DescribeGroupOutput {
        return describe_group.execute(self, allocator, input, options);
    }

    /// Returns detailed information on the current IdC setup for the WorkMail
    /// organization.
    pub fn describeIdentityProviderConfiguration(self: *Self, allocator: std.mem.Allocator, input: describe_identity_provider_configuration.DescribeIdentityProviderConfigurationInput, options: describe_identity_provider_configuration.Options) !describe_identity_provider_configuration.DescribeIdentityProviderConfigurationOutput {
        return describe_identity_provider_configuration.execute(self, allocator, input, options);
    }

    /// Lists the settings in a DMARC policy for a specified organization.
    pub fn describeInboundDmarcSettings(self: *Self, allocator: std.mem.Allocator, input: describe_inbound_dmarc_settings.DescribeInboundDmarcSettingsInput, options: describe_inbound_dmarc_settings.Options) !describe_inbound_dmarc_settings.DescribeInboundDmarcSettingsOutput {
        return describe_inbound_dmarc_settings.execute(self, allocator, input, options);
    }

    /// Describes the current status of a mailbox export job.
    pub fn describeMailboxExportJob(self: *Self, allocator: std.mem.Allocator, input: describe_mailbox_export_job.DescribeMailboxExportJobInput, options: describe_mailbox_export_job.Options) !describe_mailbox_export_job.DescribeMailboxExportJobOutput {
        return describe_mailbox_export_job.execute(self, allocator, input, options);
    }

    /// Provides more information regarding a given organization based on its
    /// identifier.
    pub fn describeOrganization(self: *Self, allocator: std.mem.Allocator, input: describe_organization.DescribeOrganizationInput, options: describe_organization.Options) !describe_organization.DescribeOrganizationOutput {
        return describe_organization.execute(self, allocator, input, options);
    }

    /// Returns the data available for the resource.
    pub fn describeResource(self: *Self, allocator: std.mem.Allocator, input: describe_resource.DescribeResourceInput, options: describe_resource.Options) !describe_resource.DescribeResourceOutput {
        return describe_resource.execute(self, allocator, input, options);
    }

    /// Provides information regarding the user.
    pub fn describeUser(self: *Self, allocator: std.mem.Allocator, input: describe_user.DescribeUserInput, options: describe_user.Options) !describe_user.DescribeUserOutput {
        return describe_user.execute(self, allocator, input, options);
    }

    /// Removes a member from the resource's set of delegates.
    pub fn disassociateDelegateFromResource(self: *Self, allocator: std.mem.Allocator, input: disassociate_delegate_from_resource.DisassociateDelegateFromResourceInput, options: disassociate_delegate_from_resource.Options) !disassociate_delegate_from_resource.DisassociateDelegateFromResourceOutput {
        return disassociate_delegate_from_resource.execute(self, allocator, input, options);
    }

    /// Removes a member from a group.
    pub fn disassociateMemberFromGroup(self: *Self, allocator: std.mem.Allocator, input: disassociate_member_from_group.DisassociateMemberFromGroupInput, options: disassociate_member_from_group.Options) !disassociate_member_from_group.DisassociateMemberFromGroupOutput {
        return disassociate_member_from_group.execute(self, allocator, input, options);
    }

    /// Gets the effects of an organization's access control rules as they apply to
    /// a
    /// specified IPv4 address, access protocol action, and user ID or impersonation
    /// role ID. You must provide either the user ID or impersonation role ID.
    /// Impersonation role ID can only be used with Action EWS.
    pub fn getAccessControlEffect(self: *Self, allocator: std.mem.Allocator, input: get_access_control_effect.GetAccessControlEffectInput, options: get_access_control_effect.Options) !get_access_control_effect.GetAccessControlEffectOutput {
        return get_access_control_effect.execute(self, allocator, input, options);
    }

    /// Gets the default retention policy details for the specified organization.
    pub fn getDefaultRetentionPolicy(self: *Self, allocator: std.mem.Allocator, input: get_default_retention_policy.GetDefaultRetentionPolicyInput, options: get_default_retention_policy.Options) !get_default_retention_policy.GetDefaultRetentionPolicyOutput {
        return get_default_retention_policy.execute(self, allocator, input, options);
    }

    /// Gets the impersonation role details for the given WorkMail organization.
    pub fn getImpersonationRole(self: *Self, allocator: std.mem.Allocator, input: get_impersonation_role.GetImpersonationRoleInput, options: get_impersonation_role.Options) !get_impersonation_role.GetImpersonationRoleOutput {
        return get_impersonation_role.execute(self, allocator, input, options);
    }

    /// Tests whether the given impersonation role can impersonate a target user.
    pub fn getImpersonationRoleEffect(self: *Self, allocator: std.mem.Allocator, input: get_impersonation_role_effect.GetImpersonationRoleEffectInput, options: get_impersonation_role_effect.Options) !get_impersonation_role_effect.GetImpersonationRoleEffectOutput {
        return get_impersonation_role_effect.execute(self, allocator, input, options);
    }

    /// Gets details for a mail domain, including domain records required to
    /// configure your domain with recommended security.
    pub fn getMailDomain(self: *Self, allocator: std.mem.Allocator, input: get_mail_domain.GetMailDomainInput, options: get_mail_domain.Options) !get_mail_domain.GetMailDomainOutput {
        return get_mail_domain.execute(self, allocator, input, options);
    }

    /// Requests a user's mailbox details for a specified organization and user.
    pub fn getMailboxDetails(self: *Self, allocator: std.mem.Allocator, input: get_mailbox_details.GetMailboxDetailsInput, options: get_mailbox_details.Options) !get_mailbox_details.GetMailboxDetailsOutput {
        return get_mailbox_details.execute(self, allocator, input, options);
    }

    /// Simulates the effect of the mobile device access rules for the given
    /// attributes of a sample access event. Use this method to test the effects of
    /// the current set of mobile device access
    /// rules for the WorkMail organization for a particular user's attributes.
    pub fn getMobileDeviceAccessEffect(self: *Self, allocator: std.mem.Allocator, input: get_mobile_device_access_effect.GetMobileDeviceAccessEffectInput, options: get_mobile_device_access_effect.Options) !get_mobile_device_access_effect.GetMobileDeviceAccessEffectOutput {
        return get_mobile_device_access_effect.execute(self, allocator, input, options);
    }

    /// Gets the mobile device access override for the given WorkMail organization,
    /// user, and device.
    pub fn getMobileDeviceAccessOverride(self: *Self, allocator: std.mem.Allocator, input: get_mobile_device_access_override.GetMobileDeviceAccessOverrideInput, options: get_mobile_device_access_override.Options) !get_mobile_device_access_override.GetMobileDeviceAccessOverrideOutput {
        return get_mobile_device_access_override.execute(self, allocator, input, options);
    }

    /// Requests details of a specific Personal Access Token within the WorkMail
    /// organization.
    pub fn getPersonalAccessTokenMetadata(self: *Self, allocator: std.mem.Allocator, input: get_personal_access_token_metadata.GetPersonalAccessTokenMetadataInput, options: get_personal_access_token_metadata.Options) !get_personal_access_token_metadata.GetPersonalAccessTokenMetadataOutput {
        return get_personal_access_token_metadata.execute(self, allocator, input, options);
    }

    /// Lists the access control rules for the specified organization.
    pub fn listAccessControlRules(self: *Self, allocator: std.mem.Allocator, input: list_access_control_rules.ListAccessControlRulesInput, options: list_access_control_rules.Options) !list_access_control_rules.ListAccessControlRulesOutput {
        return list_access_control_rules.execute(self, allocator, input, options);
    }

    /// Creates a paginated call to list the aliases associated with a given
    /// entity.
    pub fn listAliases(self: *Self, allocator: std.mem.Allocator, input: list_aliases.ListAliasesInput, options: list_aliases.Options) !list_aliases.ListAliasesOutput {
        return list_aliases.execute(self, allocator, input, options);
    }

    /// List all the `AvailabilityConfiguration`'s for the given WorkMail
    /// organization.
    pub fn listAvailabilityConfigurations(self: *Self, allocator: std.mem.Allocator, input: list_availability_configurations.ListAvailabilityConfigurationsInput, options: list_availability_configurations.Options) !list_availability_configurations.ListAvailabilityConfigurationsOutput {
        return list_availability_configurations.execute(self, allocator, input, options);
    }

    /// Returns an overview of the members of a group. Users and groups can be
    /// members of a
    /// group.
    pub fn listGroupMembers(self: *Self, allocator: std.mem.Allocator, input: list_group_members.ListGroupMembersInput, options: list_group_members.Options) !list_group_members.ListGroupMembersOutput {
        return list_group_members.execute(self, allocator, input, options);
    }

    /// Returns summaries of the organization's groups.
    pub fn listGroups(self: *Self, allocator: std.mem.Allocator, input: list_groups.ListGroupsInput, options: list_groups.Options) !list_groups.ListGroupsOutput {
        return list_groups.execute(self, allocator, input, options);
    }

    /// Returns all the groups to which an entity belongs.
    pub fn listGroupsForEntity(self: *Self, allocator: std.mem.Allocator, input: list_groups_for_entity.ListGroupsForEntityInput, options: list_groups_for_entity.Options) !list_groups_for_entity.ListGroupsForEntityOutput {
        return list_groups_for_entity.execute(self, allocator, input, options);
    }

    /// Lists all the impersonation roles for the given WorkMail organization.
    pub fn listImpersonationRoles(self: *Self, allocator: std.mem.Allocator, input: list_impersonation_roles.ListImpersonationRolesInput, options: list_impersonation_roles.Options) !list_impersonation_roles.ListImpersonationRolesOutput {
        return list_impersonation_roles.execute(self, allocator, input, options);
    }

    /// Lists the mail domains in a given WorkMail organization.
    pub fn listMailDomains(self: *Self, allocator: std.mem.Allocator, input: list_mail_domains.ListMailDomainsInput, options: list_mail_domains.Options) !list_mail_domains.ListMailDomainsOutput {
        return list_mail_domains.execute(self, allocator, input, options);
    }

    /// Lists the mailbox export jobs started for the specified organization within
    /// the last
    /// seven days.
    pub fn listMailboxExportJobs(self: *Self, allocator: std.mem.Allocator, input: list_mailbox_export_jobs.ListMailboxExportJobsInput, options: list_mailbox_export_jobs.Options) !list_mailbox_export_jobs.ListMailboxExportJobsOutput {
        return list_mailbox_export_jobs.execute(self, allocator, input, options);
    }

    /// Lists the mailbox permissions associated with a user, group, or resource
    /// mailbox.
    pub fn listMailboxPermissions(self: *Self, allocator: std.mem.Allocator, input: list_mailbox_permissions.ListMailboxPermissionsInput, options: list_mailbox_permissions.Options) !list_mailbox_permissions.ListMailboxPermissionsOutput {
        return list_mailbox_permissions.execute(self, allocator, input, options);
    }

    /// Lists all the mobile device access overrides for any given combination of
    /// WorkMail organization, user, or device.
    pub fn listMobileDeviceAccessOverrides(self: *Self, allocator: std.mem.Allocator, input: list_mobile_device_access_overrides.ListMobileDeviceAccessOverridesInput, options: list_mobile_device_access_overrides.Options) !list_mobile_device_access_overrides.ListMobileDeviceAccessOverridesOutput {
        return list_mobile_device_access_overrides.execute(self, allocator, input, options);
    }

    /// Lists the mobile device access rules for the specified WorkMail
    /// organization.
    pub fn listMobileDeviceAccessRules(self: *Self, allocator: std.mem.Allocator, input: list_mobile_device_access_rules.ListMobileDeviceAccessRulesInput, options: list_mobile_device_access_rules.Options) !list_mobile_device_access_rules.ListMobileDeviceAccessRulesOutput {
        return list_mobile_device_access_rules.execute(self, allocator, input, options);
    }

    /// Returns summaries of the customer's organizations.
    pub fn listOrganizations(self: *Self, allocator: std.mem.Allocator, input: list_organizations.ListOrganizationsInput, options: list_organizations.Options) !list_organizations.ListOrganizationsOutput {
        return list_organizations.execute(self, allocator, input, options);
    }

    /// Returns a summary of your Personal Access Tokens.
    pub fn listPersonalAccessTokens(self: *Self, allocator: std.mem.Allocator, input: list_personal_access_tokens.ListPersonalAccessTokensInput, options: list_personal_access_tokens.Options) !list_personal_access_tokens.ListPersonalAccessTokensOutput {
        return list_personal_access_tokens.execute(self, allocator, input, options);
    }

    /// Lists the delegates associated with a resource. Users and groups can be
    /// resource
    /// delegates and answer requests on behalf of the resource.
    pub fn listResourceDelegates(self: *Self, allocator: std.mem.Allocator, input: list_resource_delegates.ListResourceDelegatesInput, options: list_resource_delegates.Options) !list_resource_delegates.ListResourceDelegatesOutput {
        return list_resource_delegates.execute(self, allocator, input, options);
    }

    /// Returns summaries of the organization's resources.
    pub fn listResources(self: *Self, allocator: std.mem.Allocator, input: list_resources.ListResourcesInput, options: list_resources.Options) !list_resources.ListResourcesOutput {
        return list_resources.execute(self, allocator, input, options);
    }

    /// Lists the tags applied to an WorkMail organization resource.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: list_tags_for_resource.Options) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Returns summaries of the organization's users.
    pub fn listUsers(self: *Self, allocator: std.mem.Allocator, input: list_users.ListUsersInput, options: list_users.Options) !list_users.ListUsersOutput {
        return list_users.execute(self, allocator, input, options);
    }

    /// Adds a new access control rule for the specified organization. The rule
    /// allows or
    /// denies access to the organization for the specified IPv4 addresses, access
    /// protocol
    /// actions, user IDs and impersonation IDs. Adding a new rule with the same
    /// name as an existing rule replaces
    /// the older rule.
    pub fn putAccessControlRule(self: *Self, allocator: std.mem.Allocator, input: put_access_control_rule.PutAccessControlRuleInput, options: put_access_control_rule.Options) !put_access_control_rule.PutAccessControlRuleOutput {
        return put_access_control_rule.execute(self, allocator, input, options);
    }

    /// Creates or updates the email monitoring configuration for a specified
    /// organization.
    pub fn putEmailMonitoringConfiguration(self: *Self, allocator: std.mem.Allocator, input: put_email_monitoring_configuration.PutEmailMonitoringConfigurationInput, options: put_email_monitoring_configuration.Options) !put_email_monitoring_configuration.PutEmailMonitoringConfigurationOutput {
        return put_email_monitoring_configuration.execute(self, allocator, input, options);
    }

    /// Enables integration between IAM Identity Center (IdC) and WorkMail to proxy
    /// authentication requests for mailbox users. You can connect your IdC
    /// directory or your external directory to WorkMail through
    /// IdC and manage access to WorkMail mailboxes in a single place. For enhanced
    /// protection, you could enable Multifactor Authentication (MFA) and Personal
    /// Access Tokens.
    pub fn putIdentityProviderConfiguration(self: *Self, allocator: std.mem.Allocator, input: put_identity_provider_configuration.PutIdentityProviderConfigurationInput, options: put_identity_provider_configuration.Options) !put_identity_provider_configuration.PutIdentityProviderConfigurationOutput {
        return put_identity_provider_configuration.execute(self, allocator, input, options);
    }

    /// Enables or disables a DMARC policy for a given organization.
    pub fn putInboundDmarcSettings(self: *Self, allocator: std.mem.Allocator, input: put_inbound_dmarc_settings.PutInboundDmarcSettingsInput, options: put_inbound_dmarc_settings.Options) !put_inbound_dmarc_settings.PutInboundDmarcSettingsOutput {
        return put_inbound_dmarc_settings.execute(self, allocator, input, options);
    }

    /// Sets permissions for a user, group, or resource. This replaces any
    /// pre-existing
    /// permissions.
    pub fn putMailboxPermissions(self: *Self, allocator: std.mem.Allocator, input: put_mailbox_permissions.PutMailboxPermissionsInput, options: put_mailbox_permissions.Options) !put_mailbox_permissions.PutMailboxPermissionsOutput {
        return put_mailbox_permissions.execute(self, allocator, input, options);
    }

    /// Creates or updates a mobile device access override for the given WorkMail
    /// organization, user, and device.
    pub fn putMobileDeviceAccessOverride(self: *Self, allocator: std.mem.Allocator, input: put_mobile_device_access_override.PutMobileDeviceAccessOverrideInput, options: put_mobile_device_access_override.Options) !put_mobile_device_access_override.PutMobileDeviceAccessOverrideOutput {
        return put_mobile_device_access_override.execute(self, allocator, input, options);
    }

    /// Puts a retention policy to the specified organization.
    pub fn putRetentionPolicy(self: *Self, allocator: std.mem.Allocator, input: put_retention_policy.PutRetentionPolicyInput, options: put_retention_policy.Options) !put_retention_policy.PutRetentionPolicyOutput {
        return put_retention_policy.execute(self, allocator, input, options);
    }

    /// Registers a new domain in WorkMail and SES, and configures it for use by
    /// WorkMail. Emails received by SES for this domain are routed to the specified
    /// WorkMail organization, and WorkMail has
    /// permanent permission to use the specified domain for sending your users'
    /// emails.
    pub fn registerMailDomain(self: *Self, allocator: std.mem.Allocator, input: register_mail_domain.RegisterMailDomainInput, options: register_mail_domain.Options) !register_mail_domain.RegisterMailDomainOutput {
        return register_mail_domain.execute(self, allocator, input, options);
    }

    /// Registers an existing and disabled user, group, or resource for WorkMail use
    /// by
    /// associating a mailbox and calendaring capabilities. It performs no change if
    /// the user,
    /// group, or resource is enabled and fails if the user, group, or resource is
    /// deleted. This
    /// operation results in the accumulation of costs. For more information, see
    /// [Pricing](https://aws.amazon.com/workmail/pricing). The equivalent console
    /// functionality for this operation is *Enable*.
    ///
    /// Users can either be created by calling the CreateUser API operation
    /// or they can be synchronized from your directory. For more information, see
    /// DeregisterFromWorkMail.
    pub fn registerToWorkMail(self: *Self, allocator: std.mem.Allocator, input: register_to_work_mail.RegisterToWorkMailInput, options: register_to_work_mail.Options) !register_to_work_mail.RegisterToWorkMailOutput {
        return register_to_work_mail.execute(self, allocator, input, options);
    }

    /// Allows the administrator to reset the password for a user.
    pub fn resetPassword(self: *Self, allocator: std.mem.Allocator, input: reset_password.ResetPasswordInput, options: reset_password.Options) !reset_password.ResetPasswordOutput {
        return reset_password.execute(self, allocator, input, options);
    }

    /// Starts a mailbox export job to export MIME-format email messages and
    /// calendar items
    /// from the specified mailbox to the specified Amazon Simple Storage Service
    /// (Amazon S3)
    /// bucket. For more information, see [Exporting mailbox
    /// content](https://docs.aws.amazon.com/workmail/latest/adminguide/mail-export.html) in
    /// the *WorkMail Administrator Guide*.
    pub fn startMailboxExportJob(self: *Self, allocator: std.mem.Allocator, input: start_mailbox_export_job.StartMailboxExportJobInput, options: start_mailbox_export_job.Options) !start_mailbox_export_job.StartMailboxExportJobOutput {
        return start_mailbox_export_job.execute(self, allocator, input, options);
    }

    /// Applies the specified tags to the specified WorkMailorganization
    /// resource.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: tag_resource.Options) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Performs a test on an availability provider to ensure that access is
    /// allowed. For EWS, it verifies the provided credentials can be used to
    /// successfully log in. For Lambda, it verifies that the Lambda function can be
    /// invoked and that the resource access
    /// policy was configured to deny anonymous access. An anonymous invocation is
    /// one done without providing either a `SourceArn` or `SourceAccount` header.
    ///
    /// The request must contain either one provider definition (`EwsProvider` or
    /// `LambdaProvider`) or the `DomainName` parameter. If the
    /// `DomainName` parameter is provided, the configuration stored under the
    /// `DomainName` will be tested.
    pub fn testAvailabilityConfiguration(self: *Self, allocator: std.mem.Allocator, input: test_availability_configuration.TestAvailabilityConfigurationInput, options: test_availability_configuration.Options) !test_availability_configuration.TestAvailabilityConfigurationOutput {
        return test_availability_configuration.execute(self, allocator, input, options);
    }

    /// Untags the specified tags from the specified WorkMail organization
    /// resource.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: untag_resource.Options) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Updates an existing `AvailabilityConfiguration` for the given WorkMail
    /// organization and domain.
    pub fn updateAvailabilityConfiguration(self: *Self, allocator: std.mem.Allocator, input: update_availability_configuration.UpdateAvailabilityConfigurationInput, options: update_availability_configuration.Options) !update_availability_configuration.UpdateAvailabilityConfigurationOutput {
        return update_availability_configuration.execute(self, allocator, input, options);
    }

    /// Updates the default mail domain for an organization. The default mail domain
    /// is used by the WorkMail AWS Console to suggest an email address when
    /// enabling a mail user. You can only have one default domain.
    pub fn updateDefaultMailDomain(self: *Self, allocator: std.mem.Allocator, input: update_default_mail_domain.UpdateDefaultMailDomainInput, options: update_default_mail_domain.Options) !update_default_mail_domain.UpdateDefaultMailDomainOutput {
        return update_default_mail_domain.execute(self, allocator, input, options);
    }

    /// Updates attributes in a group.
    pub fn updateGroup(self: *Self, allocator: std.mem.Allocator, input: update_group.UpdateGroupInput, options: update_group.Options) !update_group.UpdateGroupOutput {
        return update_group.execute(self, allocator, input, options);
    }

    /// Updates an impersonation role for the given WorkMail organization.
    pub fn updateImpersonationRole(self: *Self, allocator: std.mem.Allocator, input: update_impersonation_role.UpdateImpersonationRoleInput, options: update_impersonation_role.Options) !update_impersonation_role.UpdateImpersonationRoleOutput {
        return update_impersonation_role.execute(self, allocator, input, options);
    }

    /// Updates a user's current mailbox quota for a specified organization and
    /// user.
    pub fn updateMailboxQuota(self: *Self, allocator: std.mem.Allocator, input: update_mailbox_quota.UpdateMailboxQuotaInput, options: update_mailbox_quota.Options) !update_mailbox_quota.UpdateMailboxQuotaOutput {
        return update_mailbox_quota.execute(self, allocator, input, options);
    }

    /// Updates a mobile device access rule for the specified WorkMail organization.
    pub fn updateMobileDeviceAccessRule(self: *Self, allocator: std.mem.Allocator, input: update_mobile_device_access_rule.UpdateMobileDeviceAccessRuleInput, options: update_mobile_device_access_rule.Options) !update_mobile_device_access_rule.UpdateMobileDeviceAccessRuleOutput {
        return update_mobile_device_access_rule.execute(self, allocator, input, options);
    }

    /// Updates the primary email for a user, group, or resource. The current email
    /// is moved
    /// into the list of aliases (or swapped between an existing alias and the
    /// current primary
    /// email), and the email provided in the input is promoted as the primary.
    pub fn updatePrimaryEmailAddress(self: *Self, allocator: std.mem.Allocator, input: update_primary_email_address.UpdatePrimaryEmailAddressInput, options: update_primary_email_address.Options) !update_primary_email_address.UpdatePrimaryEmailAddressOutput {
        return update_primary_email_address.execute(self, allocator, input, options);
    }

    /// Updates data for the resource. To have the latest information, it must be
    /// preceded by
    /// a DescribeResource call. The dataset in the request should be the one
    /// expected when performing another `DescribeResource` call.
    pub fn updateResource(self: *Self, allocator: std.mem.Allocator, input: update_resource.UpdateResourceInput, options: update_resource.Options) !update_resource.UpdateResourceOutput {
        return update_resource.execute(self, allocator, input, options);
    }

    /// Updates data for the user. To have the latest information, it must be
    /// preceded by a
    /// DescribeUser call. The dataset in the request should be the one
    /// expected when performing another `DescribeUser` call.
    pub fn updateUser(self: *Self, allocator: std.mem.Allocator, input: update_user.UpdateUserInput, options: update_user.Options) !update_user.UpdateUserOutput {
        return update_user.execute(self, allocator, input, options);
    }

    pub fn listAliasesPaginator(self: *Self, params: list_aliases.ListAliasesInput) paginator.ListAliasesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listAvailabilityConfigurationsPaginator(self: *Self, params: list_availability_configurations.ListAvailabilityConfigurationsInput) paginator.ListAvailabilityConfigurationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listGroupMembersPaginator(self: *Self, params: list_group_members.ListGroupMembersInput) paginator.ListGroupMembersPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listGroupsPaginator(self: *Self, params: list_groups.ListGroupsInput) paginator.ListGroupsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listGroupsForEntityPaginator(self: *Self, params: list_groups_for_entity.ListGroupsForEntityInput) paginator.ListGroupsForEntityPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listImpersonationRolesPaginator(self: *Self, params: list_impersonation_roles.ListImpersonationRolesInput) paginator.ListImpersonationRolesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listMailDomainsPaginator(self: *Self, params: list_mail_domains.ListMailDomainsInput) paginator.ListMailDomainsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listMailboxExportJobsPaginator(self: *Self, params: list_mailbox_export_jobs.ListMailboxExportJobsInput) paginator.ListMailboxExportJobsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listMailboxPermissionsPaginator(self: *Self, params: list_mailbox_permissions.ListMailboxPermissionsInput) paginator.ListMailboxPermissionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listMobileDeviceAccessOverridesPaginator(self: *Self, params: list_mobile_device_access_overrides.ListMobileDeviceAccessOverridesInput) paginator.ListMobileDeviceAccessOverridesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listOrganizationsPaginator(self: *Self, params: list_organizations.ListOrganizationsInput) paginator.ListOrganizationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listPersonalAccessTokensPaginator(self: *Self, params: list_personal_access_tokens.ListPersonalAccessTokensInput) paginator.ListPersonalAccessTokensPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listResourceDelegatesPaginator(self: *Self, params: list_resource_delegates.ListResourceDelegatesInput) paginator.ListResourceDelegatesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listResourcesPaginator(self: *Self, params: list_resources.ListResourcesInput) paginator.ListResourcesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listUsersPaginator(self: *Self, params: list_users.ListUsersInput) paginator.ListUsersPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};
