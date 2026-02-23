const aws = @import("aws");
const std = @import("std");


const accept_delegation_request = @import("accept_delegation_request.zig");
const add_client_id_to_open_id_connect_provider = @import("add_client_id_to_open_id_connect_provider.zig");
const add_role_to_instance_profile = @import("add_role_to_instance_profile.zig");
const add_user_to_group = @import("add_user_to_group.zig");
const associate_delegation_request = @import("associate_delegation_request.zig");
const attach_group_policy = @import("attach_group_policy.zig");
const attach_role_policy = @import("attach_role_policy.zig");
const attach_user_policy = @import("attach_user_policy.zig");
const change_password = @import("change_password.zig");
const create_access_key = @import("create_access_key.zig");
const create_account_alias = @import("create_account_alias.zig");
const create_delegation_request = @import("create_delegation_request.zig");
const create_group = @import("create_group.zig");
const create_instance_profile = @import("create_instance_profile.zig");
const create_login_profile = @import("create_login_profile.zig");
const create_open_id_connect_provider = @import("create_open_id_connect_provider.zig");
const create_policy = @import("create_policy.zig");
const create_policy_version = @import("create_policy_version.zig");
const create_role = @import("create_role.zig");
const create_saml_provider = @import("create_saml_provider.zig");
const create_service_linked_role = @import("create_service_linked_role.zig");
const create_service_specific_credential = @import("create_service_specific_credential.zig");
const create_user = @import("create_user.zig");
const create_virtual_mfa_device = @import("create_virtual_mfa_device.zig");
const deactivate_mfa_device = @import("deactivate_mfa_device.zig");
const delete_access_key = @import("delete_access_key.zig");
const delete_account_alias = @import("delete_account_alias.zig");
const delete_account_password_policy = @import("delete_account_password_policy.zig");
const delete_group = @import("delete_group.zig");
const delete_group_policy = @import("delete_group_policy.zig");
const delete_instance_profile = @import("delete_instance_profile.zig");
const delete_login_profile = @import("delete_login_profile.zig");
const delete_open_id_connect_provider = @import("delete_open_id_connect_provider.zig");
const delete_policy = @import("delete_policy.zig");
const delete_policy_version = @import("delete_policy_version.zig");
const delete_role = @import("delete_role.zig");
const delete_role_permissions_boundary = @import("delete_role_permissions_boundary.zig");
const delete_role_policy = @import("delete_role_policy.zig");
const delete_saml_provider = @import("delete_saml_provider.zig");
const delete_server_certificate = @import("delete_server_certificate.zig");
const delete_service_linked_role = @import("delete_service_linked_role.zig");
const delete_service_specific_credential = @import("delete_service_specific_credential.zig");
const delete_signing_certificate = @import("delete_signing_certificate.zig");
const delete_ssh_public_key = @import("delete_ssh_public_key.zig");
const delete_user = @import("delete_user.zig");
const delete_user_permissions_boundary = @import("delete_user_permissions_boundary.zig");
const delete_user_policy = @import("delete_user_policy.zig");
const delete_virtual_mfa_device = @import("delete_virtual_mfa_device.zig");
const detach_group_policy = @import("detach_group_policy.zig");
const detach_role_policy = @import("detach_role_policy.zig");
const detach_user_policy = @import("detach_user_policy.zig");
const disable_organizations_root_credentials_management = @import("disable_organizations_root_credentials_management.zig");
const disable_organizations_root_sessions = @import("disable_organizations_root_sessions.zig");
const disable_outbound_web_identity_federation = @import("disable_outbound_web_identity_federation.zig");
const enable_mfa_device = @import("enable_mfa_device.zig");
const enable_organizations_root_credentials_management = @import("enable_organizations_root_credentials_management.zig");
const enable_organizations_root_sessions = @import("enable_organizations_root_sessions.zig");
const enable_outbound_web_identity_federation = @import("enable_outbound_web_identity_federation.zig");
const generate_credential_report = @import("generate_credential_report.zig");
const generate_organizations_access_report = @import("generate_organizations_access_report.zig");
const generate_service_last_accessed_details = @import("generate_service_last_accessed_details.zig");
const get_access_key_last_used = @import("get_access_key_last_used.zig");
const get_account_authorization_details = @import("get_account_authorization_details.zig");
const get_account_password_policy = @import("get_account_password_policy.zig");
const get_account_summary = @import("get_account_summary.zig");
const get_context_keys_for_custom_policy = @import("get_context_keys_for_custom_policy.zig");
const get_context_keys_for_principal_policy = @import("get_context_keys_for_principal_policy.zig");
const get_credential_report = @import("get_credential_report.zig");
const get_delegation_request = @import("get_delegation_request.zig");
const get_group = @import("get_group.zig");
const get_group_policy = @import("get_group_policy.zig");
const get_human_readable_summary = @import("get_human_readable_summary.zig");
const get_instance_profile = @import("get_instance_profile.zig");
const get_login_profile = @import("get_login_profile.zig");
const get_mfa_device = @import("get_mfa_device.zig");
const get_open_id_connect_provider = @import("get_open_id_connect_provider.zig");
const get_organizations_access_report = @import("get_organizations_access_report.zig");
const get_outbound_web_identity_federation_info = @import("get_outbound_web_identity_federation_info.zig");
const get_policy = @import("get_policy.zig");
const get_policy_version = @import("get_policy_version.zig");
const get_role = @import("get_role.zig");
const get_role_policy = @import("get_role_policy.zig");
const get_saml_provider = @import("get_saml_provider.zig");
const get_server_certificate = @import("get_server_certificate.zig");
const get_service_last_accessed_details = @import("get_service_last_accessed_details.zig");
const get_service_last_accessed_details_with_entities = @import("get_service_last_accessed_details_with_entities.zig");
const get_service_linked_role_deletion_status = @import("get_service_linked_role_deletion_status.zig");
const get_ssh_public_key = @import("get_ssh_public_key.zig");
const get_user = @import("get_user.zig");
const get_user_policy = @import("get_user_policy.zig");
const list_access_keys = @import("list_access_keys.zig");
const list_account_aliases = @import("list_account_aliases.zig");
const list_attached_group_policies = @import("list_attached_group_policies.zig");
const list_attached_role_policies = @import("list_attached_role_policies.zig");
const list_attached_user_policies = @import("list_attached_user_policies.zig");
const list_delegation_requests = @import("list_delegation_requests.zig");
const list_entities_for_policy = @import("list_entities_for_policy.zig");
const list_group_policies = @import("list_group_policies.zig");
const list_groups = @import("list_groups.zig");
const list_groups_for_user = @import("list_groups_for_user.zig");
const list_instance_profile_tags = @import("list_instance_profile_tags.zig");
const list_instance_profiles = @import("list_instance_profiles.zig");
const list_instance_profiles_for_role = @import("list_instance_profiles_for_role.zig");
const list_mfa_device_tags = @import("list_mfa_device_tags.zig");
const list_mfa_devices = @import("list_mfa_devices.zig");
const list_open_id_connect_provider_tags = @import("list_open_id_connect_provider_tags.zig");
const list_open_id_connect_providers = @import("list_open_id_connect_providers.zig");
const list_organizations_features = @import("list_organizations_features.zig");
const list_policies = @import("list_policies.zig");
const list_policies_granting_service_access = @import("list_policies_granting_service_access.zig");
const list_policy_tags = @import("list_policy_tags.zig");
const list_policy_versions = @import("list_policy_versions.zig");
const list_role_policies = @import("list_role_policies.zig");
const list_role_tags = @import("list_role_tags.zig");
const list_roles = @import("list_roles.zig");
const list_saml_provider_tags = @import("list_saml_provider_tags.zig");
const list_saml_providers = @import("list_saml_providers.zig");
const list_server_certificate_tags = @import("list_server_certificate_tags.zig");
const list_server_certificates = @import("list_server_certificates.zig");
const list_service_specific_credentials = @import("list_service_specific_credentials.zig");
const list_signing_certificates = @import("list_signing_certificates.zig");
const list_ssh_public_keys = @import("list_ssh_public_keys.zig");
const list_user_policies = @import("list_user_policies.zig");
const list_user_tags = @import("list_user_tags.zig");
const list_users = @import("list_users.zig");
const list_virtual_mfa_devices = @import("list_virtual_mfa_devices.zig");
const put_group_policy = @import("put_group_policy.zig");
const put_role_permissions_boundary = @import("put_role_permissions_boundary.zig");
const put_role_policy = @import("put_role_policy.zig");
const put_user_permissions_boundary = @import("put_user_permissions_boundary.zig");
const put_user_policy = @import("put_user_policy.zig");
const reject_delegation_request = @import("reject_delegation_request.zig");
const remove_client_id_from_open_id_connect_provider = @import("remove_client_id_from_open_id_connect_provider.zig");
const remove_role_from_instance_profile = @import("remove_role_from_instance_profile.zig");
const remove_user_from_group = @import("remove_user_from_group.zig");
const reset_service_specific_credential = @import("reset_service_specific_credential.zig");
const resync_mfa_device = @import("resync_mfa_device.zig");
const send_delegation_token = @import("send_delegation_token.zig");
const set_default_policy_version = @import("set_default_policy_version.zig");
const set_security_token_service_preferences = @import("set_security_token_service_preferences.zig");
const simulate_custom_policy = @import("simulate_custom_policy.zig");
const simulate_principal_policy = @import("simulate_principal_policy.zig");
const tag_instance_profile = @import("tag_instance_profile.zig");
const tag_mfa_device = @import("tag_mfa_device.zig");
const tag_open_id_connect_provider = @import("tag_open_id_connect_provider.zig");
const tag_policy = @import("tag_policy.zig");
const tag_role = @import("tag_role.zig");
const tag_saml_provider = @import("tag_saml_provider.zig");
const tag_server_certificate = @import("tag_server_certificate.zig");
const tag_user = @import("tag_user.zig");
const untag_instance_profile = @import("untag_instance_profile.zig");
const untag_mfa_device = @import("untag_mfa_device.zig");
const untag_open_id_connect_provider = @import("untag_open_id_connect_provider.zig");
const untag_policy = @import("untag_policy.zig");
const untag_role = @import("untag_role.zig");
const untag_saml_provider = @import("untag_saml_provider.zig");
const untag_server_certificate = @import("untag_server_certificate.zig");
const untag_user = @import("untag_user.zig");
const update_access_key = @import("update_access_key.zig");
const update_account_password_policy = @import("update_account_password_policy.zig");
const update_assume_role_policy = @import("update_assume_role_policy.zig");
const update_delegation_request = @import("update_delegation_request.zig");
const update_group = @import("update_group.zig");
const update_login_profile = @import("update_login_profile.zig");
const update_open_id_connect_provider_thumbprint = @import("update_open_id_connect_provider_thumbprint.zig");
const update_role = @import("update_role.zig");
const update_role_description = @import("update_role_description.zig");
const update_saml_provider = @import("update_saml_provider.zig");
const update_server_certificate = @import("update_server_certificate.zig");
const update_service_specific_credential = @import("update_service_specific_credential.zig");
const update_signing_certificate = @import("update_signing_certificate.zig");
const update_ssh_public_key = @import("update_ssh_public_key.zig");
const update_user = @import("update_user.zig");
const upload_server_certificate = @import("upload_server_certificate.zig");
const upload_signing_certificate = @import("upload_signing_certificate.zig");
const upload_ssh_public_key = @import("upload_ssh_public_key.zig");
const paginator = @import("paginator.zig");
const waiters = @import("waiters.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "IAM";

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

    /// Accepts a delegation request, granting the requested temporary access.
    ///
    /// Once the delegation request is accepted, it is eligible to send the exchange
    /// token to the partner.
    /// The
    /// [SendDelegationToken](https://docs.aws.amazon.com/IAM/latest/APIReference/API_SendDelegationToken.html)
    /// API has to be explicitly called to send the delegation token.
    ///
    /// At the time of acceptance, IAM records the details and the state of the
    /// identity that called this API.
    /// This is the identity that gets mapped to the delegated credential.
    ///
    /// An accepted request may be rejected before the exchange token is sent to the
    /// partner.
    pub fn acceptDelegationRequest(self: *Self, allocator: std.mem.Allocator, input: accept_delegation_request.AcceptDelegationRequestInput, options: accept_delegation_request.Options) !accept_delegation_request.AcceptDelegationRequestOutput {
        return accept_delegation_request.execute(self, allocator, input, options);
    }

    /// Adds a new client ID (also known as audience) to the list of client IDs
    /// already
    /// registered for the specified IAM OpenID Connect (OIDC) provider resource.
    ///
    /// This operation is idempotent; it does not fail or return an error if you add
    /// an
    /// existing client ID to the provider.
    pub fn addClientIdToOpenIdConnectProvider(self: *Self, allocator: std.mem.Allocator, input: add_client_id_to_open_id_connect_provider.AddClientIDToOpenIDConnectProviderInput, options: add_client_id_to_open_id_connect_provider.Options) !add_client_id_to_open_id_connect_provider.AddClientIDToOpenIDConnectProviderOutput {
        return add_client_id_to_open_id_connect_provider.execute(self, allocator, input, options);
    }

    /// Adds the specified IAM role to the specified instance profile. An instance
    /// profile
    /// can contain only one role, and this quota cannot be increased. You can
    /// remove the
    /// existing role and then add a different role to an instance profile. You must
    /// then wait
    /// for the change to appear across all of Amazon Web Services because of
    /// [eventual
    /// consistency](https://en.wikipedia.org/wiki/Eventual_consistency). To force
    /// the change, you must [disassociate the instance
    /// profile](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_DisassociateIamInstanceProfile.html) and then [associate the
    /// instance
    /// profile](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_AssociateIamInstanceProfile.html), or you can stop your instance and then restart it.
    ///
    /// The caller of this operation must be granted the `PassRole` permission
    /// on the IAM role by a permissions policy.
    ///
    /// When using the
    /// [iam:AssociatedResourceArn](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_policies_iam-condition-keys.html#available-keys-for-iam) condition in a policy to restrict the [PassRole](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_use_passrole.html) IAM action, special considerations apply if the policy is
    /// intended to define access for the `AddRoleToInstanceProfile` action. In
    /// this case, you cannot specify a Region or instance ID in the EC2 instance
    /// ARN. The
    /// ARN value must be `arn:aws:ec2:*:CallerAccountId:instance/*`. Using any
    /// other ARN value may lead to unexpected evaluation results.
    ///
    /// For more information about roles, see [IAM
    /// roles](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles.html) in
    /// the
    /// *IAM User Guide*. For more information about instance profiles,
    /// see [Using
    /// instance
    /// profiles](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_use_switch-role-ec2_instance-profiles.html) in the *IAM User Guide*.
    pub fn addRoleToInstanceProfile(self: *Self, allocator: std.mem.Allocator, input: add_role_to_instance_profile.AddRoleToInstanceProfileInput, options: add_role_to_instance_profile.Options) !add_role_to_instance_profile.AddRoleToInstanceProfileOutput {
        return add_role_to_instance_profile.execute(self, allocator, input, options);
    }

    /// Adds the specified user to the specified group.
    pub fn addUserToGroup(self: *Self, allocator: std.mem.Allocator, input: add_user_to_group.AddUserToGroupInput, options: add_user_to_group.Options) !add_user_to_group.AddUserToGroupOutput {
        return add_user_to_group.execute(self, allocator, input, options);
    }

    /// Associates a delegation request with the current identity.
    ///
    /// If the partner that created the delegation request has specified the owner
    /// account during creation,
    /// only an identity from that owner account can call the
    /// `AssociateDelegationRequest` API for
    /// the specified delegation request. Once the `AssociateDelegationRequest` API
    /// call is successful,
    /// the ARN of the current calling identity will be stored as the
    /// `ownerId`
    /// of the request.
    ///
    /// If the partner that created the delegation request has not specified the
    /// owner account during creation,
    /// any caller from any account can call the `AssociateDelegationRequest` API
    /// for
    /// the delegation request. Once this API call is successful, the ARN of the
    /// current calling identity will be stored as the
    /// `ownerId`
    /// and the Amazon Web Services account ID of the current calling identity will
    /// be stored as the
    /// `ownerAccount`
    /// of the request.
    ///
    /// For more details, see
    /// [
    /// Managing Permissions for Delegation
    /// Requests](https://docs.aws.amazon.com/IAM/latest/UserGuide/access_policies-temporary-delegation.html#temporary-delegation-managing-permissions).
    pub fn associateDelegationRequest(self: *Self, allocator: std.mem.Allocator, input: associate_delegation_request.AssociateDelegationRequestInput, options: associate_delegation_request.Options) !associate_delegation_request.AssociateDelegationRequestOutput {
        return associate_delegation_request.execute(self, allocator, input, options);
    }

    /// Attaches the specified managed policy to the specified IAM group.
    ///
    /// You use this operation to attach a managed policy to a group. To embed an
    /// inline
    /// policy in a group, use [
    /// `PutGroupPolicy`
    /// ](https://docs.aws.amazon.com/IAM/latest/APIReference/API_PutGroupPolicy.html).
    ///
    /// As a best practice, you can validate your IAM policies.
    /// To learn more, see [Validating IAM
    /// policies](https://docs.aws.amazon.com/IAM/latest/UserGuide/access_policies_policy-validator.html)
    /// in the *IAM User Guide*.
    ///
    /// For more information about policies, see [Managed policies and inline
    /// policies](https://docs.aws.amazon.com/IAM/latest/UserGuide/policies-managed-vs-inline.html) in the *IAM User Guide*.
    pub fn attachGroupPolicy(self: *Self, allocator: std.mem.Allocator, input: attach_group_policy.AttachGroupPolicyInput, options: attach_group_policy.Options) !attach_group_policy.AttachGroupPolicyOutput {
        return attach_group_policy.execute(self, allocator, input, options);
    }

    /// Attaches the specified managed policy to the specified IAM role. When you
    /// attach a
    /// managed policy to a role, the managed policy becomes part of the role's
    /// permission
    /// (access) policy.
    ///
    /// You cannot use a managed policy as the role's trust policy. The role's trust
    /// policy is created at the same time as the role, using [
    /// `CreateRole`
    /// ](https://docs.aws.amazon.com/IAM/latest/APIReference/API_CreateRole.html).
    /// You can update a role's trust policy using
    /// [
    /// `UpdateAssumerolePolicy`
    /// ](https://docs.aws.amazon.com/IAM/latest/APIReference/API_UpdateAssumeRolePolicy.html).
    ///
    /// Use this operation to attach a *managed* policy to a role. To embed
    /// an inline policy in a role, use [
    /// `PutRolePolicy`
    /// ](https://docs.aws.amazon.com/IAM/latest/APIReference/API_PutRolePolicy.html). For more information about policies, see [Managed
    /// policies and inline
    /// policies](https://docs.aws.amazon.com/IAM/latest/UserGuide/policies-managed-vs-inline.html) in the
    /// *IAM User Guide*.
    ///
    /// As a best practice, you can validate your IAM policies.
    /// To learn more, see [Validating IAM
    /// policies](https://docs.aws.amazon.com/IAM/latest/UserGuide/access_policies_policy-validator.html)
    /// in the *IAM User Guide*.
    pub fn attachRolePolicy(self: *Self, allocator: std.mem.Allocator, input: attach_role_policy.AttachRolePolicyInput, options: attach_role_policy.Options) !attach_role_policy.AttachRolePolicyOutput {
        return attach_role_policy.execute(self, allocator, input, options);
    }

    /// Attaches the specified managed policy to the specified user.
    ///
    /// You use this operation to attach a *managed* policy to a user. To
    /// embed an inline policy in a user, use [
    /// `PutUserPolicy`
    /// ](https://docs.aws.amazon.com/IAM/latest/APIReference/API_PutUserPolicy.html).
    ///
    /// As a best practice, you can validate your IAM policies.
    /// To learn more, see [Validating IAM
    /// policies](https://docs.aws.amazon.com/IAM/latest/UserGuide/access_policies_policy-validator.html)
    /// in the *IAM User Guide*.
    ///
    /// For more information about policies, see [Managed policies and inline
    /// policies](https://docs.aws.amazon.com/IAM/latest/UserGuide/policies-managed-vs-inline.html) in the *IAM User Guide*.
    pub fn attachUserPolicy(self: *Self, allocator: std.mem.Allocator, input: attach_user_policy.AttachUserPolicyInput, options: attach_user_policy.Options) !attach_user_policy.AttachUserPolicyOutput {
        return attach_user_policy.execute(self, allocator, input, options);
    }

    /// Changes the password of the IAM user who is calling this operation. This
    /// operation
    /// can be performed using the CLI, the Amazon Web Services API, or the **My
    /// Security Credentials** page in the Amazon Web Services Management Console.
    /// The Amazon Web Services account root user password is
    /// not affected by this operation.
    ///
    /// Use
    /// [UpdateLoginProfile](https://docs.aws.amazon.com/IAM/latest/APIReference/API_UpdateLoginProfile.html)
    /// to use the CLI, the Amazon Web Services API, or the **Users** page in
    /// the IAM console to change the password for any IAM user. For more
    /// information about
    /// modifying passwords, see [Managing
    /// passwords](https://docs.aws.amazon.com/IAM/latest/UserGuide/Using_ManagingLogins.html) in the
    /// *IAM User Guide*.
    pub fn changePassword(self: *Self, allocator: std.mem.Allocator, input: change_password.ChangePasswordInput, options: change_password.Options) !change_password.ChangePasswordOutput {
        return change_password.execute(self, allocator, input, options);
    }

    /// Creates a new Amazon Web Services secret access key and corresponding Amazon
    /// Web Services access key ID for the
    /// specified user. The default status for new keys is `Active`.
    ///
    /// If you do not specify a user name, IAM determines the user name implicitly
    /// based on
    /// the Amazon Web Services access key ID signing the request. This operation
    /// works for access keys under
    /// the Amazon Web Services account. Consequently, you can use this operation to
    /// manage Amazon Web Services account root
    /// user credentials. This is true even if the Amazon Web Services account has
    /// no associated users.
    ///
    /// For information about quotas on the number of keys you can create, see [IAM
    /// and STS
    /// quotas](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_iam-quotas.html) in the *IAM User Guide*.
    ///
    /// To ensure the security of your Amazon Web Services account, the secret
    /// access key is accessible
    /// only during key and user creation. You must save the key (for example, in a
    /// text
    /// file) if you want to be able to access it again. If a secret key is lost,
    /// you can
    /// delete the access keys for the associated user and then create new keys.
    pub fn createAccessKey(self: *Self, allocator: std.mem.Allocator, input: create_access_key.CreateAccessKeyInput, options: create_access_key.Options) !create_access_key.CreateAccessKeyOutput {
        return create_access_key.execute(self, allocator, input, options);
    }

    /// Creates an alias for your Amazon Web Services account. For information about
    /// using an Amazon Web Services account
    /// alias, see [Creating, deleting, and
    /// listing an Amazon Web Services account
    /// alias](https://docs.aws.amazon.com/signin/latest/userguide/CreateAccountAlias.html) in the *Amazon Web Services Sign-In User
    /// Guide*.
    pub fn createAccountAlias(self: *Self, allocator: std.mem.Allocator, input: create_account_alias.CreateAccountAliasInput, options: create_account_alias.Options) !create_account_alias.CreateAccountAliasOutput {
        return create_account_alias.execute(self, allocator, input, options);
    }

    /// Creates an IAM delegation request for temporary access delegation.
    ///
    /// This API is not available for general use. In order to use this API, a
    /// caller first need to
    /// go through an onboarding process described in the
    /// [partner onboarding
    /// documentation](https://docs.aws.amazon.com/IAM/latest/UserGuide/access_policies-temporary-delegation-partner-guide.html).
    pub fn createDelegationRequest(self: *Self, allocator: std.mem.Allocator, input: create_delegation_request.CreateDelegationRequestInput, options: create_delegation_request.Options) !create_delegation_request.CreateDelegationRequestOutput {
        return create_delegation_request.execute(self, allocator, input, options);
    }

    /// Creates a new group.
    ///
    /// For information about the number of groups you can create, see [IAM and STS
    /// quotas](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_iam-quotas.html) in the *IAM User Guide*.
    pub fn createGroup(self: *Self, allocator: std.mem.Allocator, input: create_group.CreateGroupInput, options: create_group.Options) !create_group.CreateGroupOutput {
        return create_group.execute(self, allocator, input, options);
    }

    /// Creates a new instance profile. For information about instance profiles, see
    /// [Using
    /// roles for applications on Amazon
    /// EC2](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_use_switch-role-ec2.html) in the
    /// *IAM User Guide*, and [Instance
    /// profiles](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/iam-roles-for-amazon-ec2.html#ec2-instance-profile) in the *Amazon EC2 User Guide*.
    ///
    /// For information about the number of instance profiles you can create, see
    /// [IAM object
    /// quotas](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_iam-quotas.html) in the *IAM User Guide*.
    pub fn createInstanceProfile(self: *Self, allocator: std.mem.Allocator, input: create_instance_profile.CreateInstanceProfileInput, options: create_instance_profile.Options) !create_instance_profile.CreateInstanceProfileOutput {
        return create_instance_profile.execute(self, allocator, input, options);
    }

    /// Creates a password for the specified IAM user. A password allows an IAM user
    /// to
    /// access Amazon Web Services services through the Amazon Web Services
    /// Management Console.
    ///
    /// You can use the CLI, the Amazon Web Services API, or the **Users**
    /// page in the IAM console to create a password for any IAM user. Use
    /// [ChangePassword](https://docs.aws.amazon.com/IAM/latest/APIReference/API_ChangePassword.html) to update your own existing password in the **My Security Credentials** page in the Amazon Web Services Management Console.
    ///
    /// For more information about managing passwords, see [Managing
    /// passwords](https://docs.aws.amazon.com/IAM/latest/UserGuide/Using_ManagingLogins.html) in the
    /// *IAM User Guide*.
    pub fn createLoginProfile(self: *Self, allocator: std.mem.Allocator, input: create_login_profile.CreateLoginProfileInput, options: create_login_profile.Options) !create_login_profile.CreateLoginProfileOutput {
        return create_login_profile.execute(self, allocator, input, options);
    }

    /// Creates an IAM entity to describe an identity provider (IdP) that supports
    /// [OpenID Connect (OIDC)](http://openid.net/connect/).
    ///
    /// The OIDC provider that you create with this operation can be used as a
    /// principal in a
    /// role's trust policy. Such a policy establishes a trust relationship between
    /// Amazon Web Services and
    /// the OIDC provider.
    ///
    /// If you are using an OIDC identity provider from Google, Facebook, or Amazon
    /// Cognito, you don't
    /// need to create a separate IAM identity provider. These OIDC identity
    /// providers are
    /// already built-in to Amazon Web Services and are available for your use.
    /// Instead, you can move directly
    /// to creating new roles using your identity provider. To learn more, see
    /// [Creating
    /// a role for web identity or OpenID connect
    /// federation](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_create_for-idp_oidc.html) in the *IAM
    /// User Guide*.
    ///
    /// When you create the IAM OIDC provider, you specify the following:
    ///
    /// * The URL of the OIDC identity provider (IdP) to trust
    ///
    /// * A list of client IDs (also known as audiences) that identify the
    ///   application
    /// or applications allowed to authenticate using the OIDC provider
    ///
    /// * A list of tags that are attached to the specified IAM OIDC provider
    ///
    /// * A list of thumbprints of one or more server certificates that the IdP
    /// uses
    ///
    /// You get all of this information from the OIDC IdP you want to use to access
    /// Amazon Web Services.
    ///
    /// Amazon Web Services secures communication with OIDC identity providers
    /// (IdPs) using our library of
    /// trusted root certificate authorities (CAs) to verify the JSON Web Key Set
    /// (JWKS)
    /// endpoint's TLS certificate. If your OIDC IdP relies on a certificate that is
    /// not signed
    /// by one of these trusted CAs, only then we secure communication using the
    /// thumbprints set
    /// in the IdP's configuration.
    ///
    /// The trust for the OIDC provider is derived from the IAM provider that this
    /// operation creates. Therefore, it is best to limit access to the
    /// [CreateOpenIDConnectProvider](https://docs.aws.amazon.com/IAM/latest/APIReference/API_CreateOpenIDConnectProvider.html) operation to highly privileged
    /// users.
    pub fn createOpenIdConnectProvider(self: *Self, allocator: std.mem.Allocator, input: create_open_id_connect_provider.CreateOpenIDConnectProviderInput, options: create_open_id_connect_provider.Options) !create_open_id_connect_provider.CreateOpenIDConnectProviderOutput {
        return create_open_id_connect_provider.execute(self, allocator, input, options);
    }

    /// Creates a new managed policy for your Amazon Web Services account.
    ///
    /// This operation creates a policy version with a version identifier of `v1`
    /// and sets v1 as the policy's default version. For more information about
    /// policy versions,
    /// see [Versioning for managed
    /// policies](https://docs.aws.amazon.com/IAM/latest/UserGuide/policies-managed-versions.html) in the
    /// *IAM User Guide*.
    ///
    /// As a best practice, you can validate your IAM policies.
    /// To learn more, see [Validating IAM
    /// policies](https://docs.aws.amazon.com/IAM/latest/UserGuide/access_policies_policy-validator.html)
    /// in the *IAM User Guide*.
    ///
    /// For more information about managed policies in general, see [Managed
    /// policies and inline
    /// policies](https://docs.aws.amazon.com/IAM/latest/UserGuide/policies-managed-vs-inline.html) in the
    /// *IAM User Guide*.
    pub fn createPolicy(self: *Self, allocator: std.mem.Allocator, input: create_policy.CreatePolicyInput, options: create_policy.Options) !create_policy.CreatePolicyOutput {
        return create_policy.execute(self, allocator, input, options);
    }

    /// Creates a new version of the specified managed policy. To update a managed
    /// policy, you
    /// create a new policy version. A managed policy can have up to five versions.
    /// If the
    /// policy has five versions, you must delete an existing version using
    /// [DeletePolicyVersion](https://docs.aws.amazon.com/IAM/latest/APIReference/API_DeletePolicyVersion.html) before you create a new version.
    ///
    /// Optionally, you can set the new version as the policy's default version. The
    /// default
    /// version is the version that is in effect for the IAM users, groups, and
    /// roles to which
    /// the policy is attached.
    ///
    /// For more information about managed policy versions, see [Versioning for
    /// managed
    /// policies](https://docs.aws.amazon.com/IAM/latest/UserGuide/policies-managed-versions.html) in the *IAM User Guide*.
    pub fn createPolicyVersion(self: *Self, allocator: std.mem.Allocator, input: create_policy_version.CreatePolicyVersionInput, options: create_policy_version.Options) !create_policy_version.CreatePolicyVersionOutput {
        return create_policy_version.execute(self, allocator, input, options);
    }

    /// Creates a new role for your Amazon Web Services account.
    ///
    /// For more information about roles, see [IAM
    /// roles](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles.html) in
    /// the
    /// *IAM User Guide*. For information about quotas for role names
    /// and the number of roles you can create, see [IAM and STS
    /// quotas](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_iam-quotas.html) in the
    /// *IAM User Guide*.
    pub fn createRole(self: *Self, allocator: std.mem.Allocator, input: create_role.CreateRoleInput, options: create_role.Options) !create_role.CreateRoleOutput {
        return create_role.execute(self, allocator, input, options);
    }

    /// Creates an IAM resource that describes an identity provider (IdP) that
    /// supports SAML
    /// 2.0.
    ///
    /// The SAML provider resource that you create with this operation can be used
    /// as a
    /// principal in an IAM role's trust policy. Such a policy can enable federated
    /// users who
    /// sign in using the SAML IdP to assume the role. You can create an IAM role
    /// that
    /// supports Web-based single sign-on (SSO) to the Amazon Web Services
    /// Management Console or one that supports API access
    /// to Amazon Web Services.
    ///
    /// When you create the SAML provider resource, you upload a SAML metadata
    /// document that
    /// you get from your IdP. That document includes the issuer's name, expiration
    /// information,
    /// and keys that can be used to validate the SAML authentication response
    /// (assertions) that
    /// the IdP sends. You must generate the metadata document using the identity
    /// management
    /// software that is used as your organization's IdP.
    ///
    /// This operation requires [Signature Version
    /// 4](https://docs.aws.amazon.com/general/latest/gr/signature-version-4.html).
    ///
    /// For more information, see [Enabling SAML 2.0
    /// federated users to access the Amazon Web Services Management
    /// Console](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_providers_enable-console-saml.html) and [About SAML 2.0-based
    /// federation](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_providers_saml.html) in the *IAM User Guide*.
    pub fn createSamlProvider(self: *Self, allocator: std.mem.Allocator, input: create_saml_provider.CreateSAMLProviderInput, options: create_saml_provider.Options) !create_saml_provider.CreateSAMLProviderOutput {
        return create_saml_provider.execute(self, allocator, input, options);
    }

    /// Creates an IAM role that is linked to a specific Amazon Web Services
    /// service. The service controls
    /// the attached policies and when the role can be deleted. This helps ensure
    /// that the
    /// service is not broken by an unexpectedly changed or deleted role, which
    /// could put your
    /// Amazon Web Services resources into an unknown state. Allowing the service to
    /// control the role helps
    /// improve service stability and proper cleanup when a service and its role are
    /// no longer
    /// needed. For more information, see [Using service-linked
    /// roles](https://docs.aws.amazon.com/IAM/latest/UserGuide/using-service-linked-roles.html) in the *IAM User Guide*.
    ///
    /// To attach a policy to this service-linked role, you must make the request
    /// using the
    /// Amazon Web Services service that depends on this role.
    pub fn createServiceLinkedRole(self: *Self, allocator: std.mem.Allocator, input: create_service_linked_role.CreateServiceLinkedRoleInput, options: create_service_linked_role.Options) !create_service_linked_role.CreateServiceLinkedRoleOutput {
        return create_service_linked_role.execute(self, allocator, input, options);
    }

    /// Generates a set of credentials consisting of a user name and password that
    /// can be used
    /// to access the service specified in the request. These credentials are
    /// generated by
    /// IAM, and can be used only for the specified service.
    ///
    /// You can have a maximum of two sets of service-specific credentials for each
    /// supported
    /// service per user.
    ///
    /// You can create service-specific credentials for Amazon Bedrock, CodeCommit
    /// and Amazon Keyspaces (for Apache Cassandra).
    ///
    /// You can reset the password to a new service-generated value by calling
    /// [ResetServiceSpecificCredential](https://docs.aws.amazon.com/IAM/latest/APIReference/API_ResetServiceSpecificCredential.html).
    ///
    /// For more information about service-specific credentials, see
    /// [Service-specific credentials for IAM
    /// users](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_bedrock.html) in the
    /// *IAM User Guide*.
    pub fn createServiceSpecificCredential(self: *Self, allocator: std.mem.Allocator, input: create_service_specific_credential.CreateServiceSpecificCredentialInput, options: create_service_specific_credential.Options) !create_service_specific_credential.CreateServiceSpecificCredentialOutput {
        return create_service_specific_credential.execute(self, allocator, input, options);
    }

    /// Creates a new IAM user for your Amazon Web Services account.
    ///
    /// For information about quotas for the number of IAM users you can create, see
    /// [IAM and STS
    /// quotas](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_iam-quotas.html) in the *IAM User Guide*.
    pub fn createUser(self: *Self, allocator: std.mem.Allocator, input: create_user.CreateUserInput, options: create_user.Options) !create_user.CreateUserOutput {
        return create_user.execute(self, allocator, input, options);
    }

    /// Creates a new virtual MFA device for the Amazon Web Services account. After
    /// creating the virtual
    /// MFA, use
    /// [EnableMFADevice](https://docs.aws.amazon.com/IAM/latest/APIReference/API_EnableMFADevice.html) to
    /// attach the MFA device to an IAM user. For more information about creating
    /// and working
    /// with virtual MFA devices, see [Using a virtual MFA
    /// device](https://docs.aws.amazon.com/IAM/latest/UserGuide/Using_VirtualMFA.html) in the
    /// *IAM User Guide*.
    ///
    /// For information about the maximum number of MFA devices you can create, see
    /// [IAM and STS
    /// quotas](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_iam-quotas.html) in the *IAM User Guide*.
    ///
    /// The seed information contained in the QR code and the Base32 string should
    /// be
    /// treated like any other secret access information. In other words, protect
    /// the seed
    /// information as you would your Amazon Web Services access keys or your
    /// passwords. After you
    /// provision your virtual device, you should ensure that the information is
    /// destroyed
    /// following secure procedures.
    pub fn createVirtualMfaDevice(self: *Self, allocator: std.mem.Allocator, input: create_virtual_mfa_device.CreateVirtualMFADeviceInput, options: create_virtual_mfa_device.Options) !create_virtual_mfa_device.CreateVirtualMFADeviceOutput {
        return create_virtual_mfa_device.execute(self, allocator, input, options);
    }

    /// Deactivates the specified MFA device and removes it from association with
    /// the user
    /// name for which it was originally enabled.
    ///
    /// For more information about creating and working with virtual MFA devices,
    /// see [Enabling a virtual
    /// multi-factor authentication (MFA)
    /// device](https://docs.aws.amazon.com/IAM/latest/UserGuide/Using_VirtualMFA.html) in the
    /// *IAM User Guide*.
    pub fn deactivateMfaDevice(self: *Self, allocator: std.mem.Allocator, input: deactivate_mfa_device.DeactivateMFADeviceInput, options: deactivate_mfa_device.Options) !deactivate_mfa_device.DeactivateMFADeviceOutput {
        return deactivate_mfa_device.execute(self, allocator, input, options);
    }

    /// Deletes the access key pair associated with the specified IAM user.
    ///
    /// If you do not specify a user name, IAM determines the user name implicitly
    /// based on
    /// the Amazon Web Services access key ID signing the request. This operation
    /// works for access keys under
    /// the Amazon Web Services account. Consequently, you can use this operation to
    /// manage Amazon Web Services account root
    /// user credentials even if the Amazon Web Services account has no associated
    /// users.
    pub fn deleteAccessKey(self: *Self, allocator: std.mem.Allocator, input: delete_access_key.DeleteAccessKeyInput, options: delete_access_key.Options) !delete_access_key.DeleteAccessKeyOutput {
        return delete_access_key.execute(self, allocator, input, options);
    }

    /// Deletes the specified Amazon Web Services account alias. For information
    /// about using an Amazon Web Services
    /// account alias, see [Creating, deleting, and
    /// listing an Amazon Web Services account
    /// alias](https://docs.aws.amazon.com/signin/latest/userguide/CreateAccountAlias.html) in the *Amazon Web Services Sign-In User
    /// Guide*.
    pub fn deleteAccountAlias(self: *Self, allocator: std.mem.Allocator, input: delete_account_alias.DeleteAccountAliasInput, options: delete_account_alias.Options) !delete_account_alias.DeleteAccountAliasOutput {
        return delete_account_alias.execute(self, allocator, input, options);
    }

    /// Deletes the password policy for the Amazon Web Services account. There are
    /// no parameters.
    pub fn deleteAccountPasswordPolicy(self: *Self, allocator: std.mem.Allocator, input: delete_account_password_policy.DeleteAccountPasswordPolicyInput, options: delete_account_password_policy.Options) !delete_account_password_policy.DeleteAccountPasswordPolicyOutput {
        return delete_account_password_policy.execute(self, allocator, input, options);
    }

    /// Deletes the specified IAM group. The group must not contain any users or
    /// have any
    /// attached policies.
    pub fn deleteGroup(self: *Self, allocator: std.mem.Allocator, input: delete_group.DeleteGroupInput, options: delete_group.Options) !delete_group.DeleteGroupOutput {
        return delete_group.execute(self, allocator, input, options);
    }

    /// Deletes the specified inline policy that is embedded in the specified IAM
    /// group.
    ///
    /// A group can also have managed policies attached to it. To detach a managed
    /// policy from
    /// a group, use
    /// [DetachGroupPolicy](https://docs.aws.amazon.com/IAM/latest/APIReference/API_DetachGroupPolicy.html).
    /// For more information about policies, refer to [Managed policies and inline
    /// policies](https://docs.aws.amazon.com/IAM/latest/UserGuide/policies-managed-vs-inline.html) in the *IAM User Guide*.
    pub fn deleteGroupPolicy(self: *Self, allocator: std.mem.Allocator, input: delete_group_policy.DeleteGroupPolicyInput, options: delete_group_policy.Options) !delete_group_policy.DeleteGroupPolicyOutput {
        return delete_group_policy.execute(self, allocator, input, options);
    }

    /// Deletes the specified instance profile. The instance profile must not have
    /// an
    /// associated role.
    ///
    /// Make sure that you do not have any Amazon EC2 instances running with the
    /// instance
    /// profile you are about to delete. Deleting a role or instance profile that is
    /// associated with a running instance will break any applications running on
    /// the
    /// instance.
    ///
    /// For more information about instance profiles, see [Using
    /// instance
    /// profiles](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_use_switch-role-ec2_instance-profiles.html) in the *IAM User Guide*.
    pub fn deleteInstanceProfile(self: *Self, allocator: std.mem.Allocator, input: delete_instance_profile.DeleteInstanceProfileInput, options: delete_instance_profile.Options) !delete_instance_profile.DeleteInstanceProfileOutput {
        return delete_instance_profile.execute(self, allocator, input, options);
    }

    /// Deletes the password for the specified IAM user or root user, For more
    /// information, see
    /// [Managing
    /// passwords for IAM
    /// users](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_passwords_admin-change-user.html).
    ///
    /// You can use the CLI, the Amazon Web Services API, or the **Users**
    /// page in the IAM console to delete a password for any IAM user. You can use
    /// [ChangePassword](https://docs.aws.amazon.com/IAM/latest/APIReference/API_ChangePassword.html) to update, but not delete, your own password in the
    /// **My Security Credentials** page in the
    /// Amazon Web Services Management Console.
    ///
    /// Deleting a user's password does not prevent a user from accessing Amazon Web
    /// Services through
    /// the command line interface or the API. To prevent all user access, you must
    /// also
    /// either make any access keys inactive or delete them. For more information
    /// about
    /// making keys inactive or deleting them, see
    /// [UpdateAccessKey](https://docs.aws.amazon.com/IAM/latest/APIReference/API_UpdateAccessKey.html)
    /// and
    /// [DeleteAccessKey](https://docs.aws.amazon.com/IAM/latest/APIReference/API_DeleteAccessKey.html).
    pub fn deleteLoginProfile(self: *Self, allocator: std.mem.Allocator, input: delete_login_profile.DeleteLoginProfileInput, options: delete_login_profile.Options) !delete_login_profile.DeleteLoginProfileOutput {
        return delete_login_profile.execute(self, allocator, input, options);
    }

    /// Deletes an OpenID Connect identity provider (IdP) resource object in IAM.
    ///
    /// Deleting an IAM OIDC provider resource does not update any roles that
    /// reference the
    /// provider as a principal in their trust policies. Any attempt to assume a
    /// role that
    /// references a deleted provider fails.
    ///
    /// This operation is idempotent; it does not fail or return an error if you
    /// call the
    /// operation for a provider that does not exist.
    pub fn deleteOpenIdConnectProvider(self: *Self, allocator: std.mem.Allocator, input: delete_open_id_connect_provider.DeleteOpenIDConnectProviderInput, options: delete_open_id_connect_provider.Options) !delete_open_id_connect_provider.DeleteOpenIDConnectProviderOutput {
        return delete_open_id_connect_provider.execute(self, allocator, input, options);
    }

    /// Deletes the specified managed policy.
    ///
    /// Before you can delete a managed policy, you must first detach the policy
    /// from all
    /// users, groups, and roles that it is attached to. In addition, you must
    /// delete all the
    /// policy's versions. The following steps describe the process for deleting a
    /// managed
    /// policy:
    ///
    /// * Detach the policy from all users, groups, and roles that the policy is
    /// attached to, using
    /// [DetachUserPolicy](https://docs.aws.amazon.com/IAM/latest/APIReference/API_DetachUserPolicy.html), [DetachGroupPolicy](https://docs.aws.amazon.com/IAM/latest/APIReference/API_DetachGroupPolicy.html), or [DetachRolePolicy](https://docs.aws.amazon.com/IAM/latest/APIReference/API_DetachRolePolicy.html). To list all the users, groups, and roles that a
    /// policy is attached to, use
    /// [ListEntitiesForPolicy](https://docs.aws.amazon.com/IAM/latest/APIReference/API_ListEntitiesForPolicy.html).
    ///
    /// * Delete all versions of the policy using
    ///   [DeletePolicyVersion](https://docs.aws.amazon.com/IAM/latest/APIReference/API_DeletePolicyVersion.html). To list the policy's versions, use [ListPolicyVersions](https://docs.aws.amazon.com/IAM/latest/APIReference/API_ListPolicyVersions.html). You cannot use [DeletePolicyVersion](https://docs.aws.amazon.com/IAM/latest/APIReference/API_DeletePolicyVersion.html) to delete the version that is marked as the
    /// default version. You delete the policy's default version in the next step of
    /// the
    /// process.
    ///
    /// * Delete the policy (this automatically deletes the policy's default
    ///   version)
    /// using this operation.
    ///
    /// For information about managed policies, see [Managed policies and inline
    /// policies](https://docs.aws.amazon.com/IAM/latest/UserGuide/policies-managed-vs-inline.html) in the *IAM User Guide*.
    pub fn deletePolicy(self: *Self, allocator: std.mem.Allocator, input: delete_policy.DeletePolicyInput, options: delete_policy.Options) !delete_policy.DeletePolicyOutput {
        return delete_policy.execute(self, allocator, input, options);
    }

    /// Deletes the specified version from the specified managed policy.
    ///
    /// You cannot delete the default version from a policy using this operation. To
    /// delete
    /// the default version from a policy, use
    /// [DeletePolicy](https://docs.aws.amazon.com/IAM/latest/APIReference/API_DeletePolicy.html). To find
    /// out which version of a policy is marked as the default version, use
    /// [ListPolicyVersions](https://docs.aws.amazon.com/IAM/latest/APIReference/API_ListPolicyVersions.html).
    ///
    /// For information about versions for managed policies, see [Versioning for
    /// managed
    /// policies](https://docs.aws.amazon.com/IAM/latest/UserGuide/policies-managed-versions.html) in the *IAM User Guide*.
    pub fn deletePolicyVersion(self: *Self, allocator: std.mem.Allocator, input: delete_policy_version.DeletePolicyVersionInput, options: delete_policy_version.Options) !delete_policy_version.DeletePolicyVersionOutput {
        return delete_policy_version.execute(self, allocator, input, options);
    }

    /// Deletes the specified role. Unlike the Amazon Web Services Management
    /// Console, when you delete a role
    /// programmatically, you must delete the items attached to the role manually,
    /// or the
    /// deletion fails. For more information, see [Deleting an IAM
    /// role](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_manage_delete.html#roles-managingrole-deleting-cli). Before attempting to delete a role, remove the
    /// following attached items:
    ///
    /// * Inline policies
    ///   ([DeleteRolePolicy](https://docs.aws.amazon.com/IAM/latest/APIReference/API_DeleteRolePolicy.html))
    ///
    /// * Attached managed policies
    ///   ([DetachRolePolicy](https://docs.aws.amazon.com/IAM/latest/APIReference/API_DetachRolePolicy.html))
    ///
    /// * Instance profile
    ///   ([RemoveRoleFromInstanceProfile](https://docs.aws.amazon.com/IAM/latest/APIReference/API_RemoveRoleFromInstanceProfile.html))
    ///
    /// * Optional – Delete instance profile after detaching from role for
    /// resource clean up
    /// ([DeleteInstanceProfile](https://docs.aws.amazon.com/IAM/latest/APIReference/API_DeleteInstanceProfile.html))
    ///
    /// Make sure that you do not have any Amazon EC2 instances running with the
    /// role you are
    /// about to delete. Deleting a role or instance profile that is associated with
    /// a
    /// running instance will break any applications running on the instance.
    pub fn deleteRole(self: *Self, allocator: std.mem.Allocator, input: delete_role.DeleteRoleInput, options: delete_role.Options) !delete_role.DeleteRoleOutput {
        return delete_role.execute(self, allocator, input, options);
    }

    /// Deletes the permissions boundary for the specified IAM role.
    ///
    /// You cannot set the boundary for a service-linked role.
    ///
    /// Deleting the permissions boundary for a role might increase its permissions.
    /// For
    /// example, it might allow anyone who assumes the role to perform all the
    /// actions
    /// granted in its permissions policies.
    pub fn deleteRolePermissionsBoundary(self: *Self, allocator: std.mem.Allocator, input: delete_role_permissions_boundary.DeleteRolePermissionsBoundaryInput, options: delete_role_permissions_boundary.Options) !delete_role_permissions_boundary.DeleteRolePermissionsBoundaryOutput {
        return delete_role_permissions_boundary.execute(self, allocator, input, options);
    }

    /// Deletes the specified inline policy that is embedded in the specified IAM
    /// role.
    ///
    /// A role can also have managed policies attached to it. To detach a managed
    /// policy from
    /// a role, use
    /// [DetachRolePolicy](https://docs.aws.amazon.com/IAM/latest/APIReference/API_DetachRolePolicy.html).
    /// For more information about policies, refer to [Managed policies and inline
    /// policies](https://docs.aws.amazon.com/IAM/latest/UserGuide/policies-managed-vs-inline.html) in the *IAM User Guide*.
    pub fn deleteRolePolicy(self: *Self, allocator: std.mem.Allocator, input: delete_role_policy.DeleteRolePolicyInput, options: delete_role_policy.Options) !delete_role_policy.DeleteRolePolicyOutput {
        return delete_role_policy.execute(self, allocator, input, options);
    }

    /// Deletes a SAML provider resource in IAM.
    ///
    /// Deleting the provider resource from IAM does not update any roles that
    /// reference the
    /// SAML provider resource's ARN as a principal in their trust policies. Any
    /// attempt to
    /// assume a role that references a non-existent provider resource ARN fails.
    ///
    /// This operation requires [Signature Version
    /// 4](https://docs.aws.amazon.com/general/latest/gr/signature-version-4.html).
    pub fn deleteSamlProvider(self: *Self, allocator: std.mem.Allocator, input: delete_saml_provider.DeleteSAMLProviderInput, options: delete_saml_provider.Options) !delete_saml_provider.DeleteSAMLProviderOutput {
        return delete_saml_provider.execute(self, allocator, input, options);
    }

    /// Deletes the specified server certificate.
    ///
    /// For more information about working with server certificates, see [Working
    /// with server
    /// certificates](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_server-certs.html) in the *IAM User Guide*. This
    /// topic also includes a list of Amazon Web Services services that can use the
    /// server certificates that
    /// you manage with IAM.
    ///
    /// If you are using a server certificate with Elastic Load Balancing, deleting
    /// the
    /// certificate could have implications for your application. If Elastic Load
    /// Balancing
    /// doesn't detect the deletion of bound certificates, it may continue to use
    /// the
    /// certificates. This could cause Elastic Load Balancing to stop accepting
    /// traffic. We
    /// recommend that you remove the reference to the certificate from Elastic Load
    /// Balancing before using this command to delete the certificate. For more
    /// information,
    /// see
    /// [DeleteLoadBalancerListeners](https://docs.aws.amazon.com/ElasticLoadBalancing/latest/APIReference/API_DeleteLoadBalancerListeners.html) in the *Elastic Load Balancing API
    /// Reference*.
    pub fn deleteServerCertificate(self: *Self, allocator: std.mem.Allocator, input: delete_server_certificate.DeleteServerCertificateInput, options: delete_server_certificate.Options) !delete_server_certificate.DeleteServerCertificateOutput {
        return delete_server_certificate.execute(self, allocator, input, options);
    }

    /// Submits a service-linked role deletion request and returns a
    /// `DeletionTaskId`, which you can use to check the status of the deletion.
    /// Before you call this operation, confirm that the role has no active sessions
    /// and that
    /// any resources used by the role in the linked service are deleted. If you
    /// call this
    /// operation more than once for the same service-linked role and an earlier
    /// deletion task
    /// is not complete, then the `DeletionTaskId` of the earlier request is
    /// returned.
    ///
    /// If you submit a deletion request for a service-linked role whose linked
    /// service is
    /// still accessing a resource, then the deletion task fails. If it fails, the
    /// [GetServiceLinkedRoleDeletionStatus](https://docs.aws.amazon.com/IAM/latest/APIReference/API_GetServiceLinkedRoleDeletionStatus.html) operation returns the reason for the
    /// failure, usually including the resources that must be deleted. To delete the
    /// service-linked role, you must first remove those resources from the linked
    /// service and
    /// then submit the deletion request again. Resources are specific to the
    /// service that is
    /// linked to the role. For more information about removing resources from a
    /// service, see
    /// the [Amazon Web Services documentation](http://docs.aws.amazon.com/) for
    /// your
    /// service.
    ///
    /// For more information about service-linked roles, see [Roles terms and
    /// concepts: Amazon Web Services service-linked
    /// role](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_terms-and-concepts.html#iam-term-service-linked-role) in the
    /// *IAM User Guide*.
    pub fn deleteServiceLinkedRole(self: *Self, allocator: std.mem.Allocator, input: delete_service_linked_role.DeleteServiceLinkedRoleInput, options: delete_service_linked_role.Options) !delete_service_linked_role.DeleteServiceLinkedRoleOutput {
        return delete_service_linked_role.execute(self, allocator, input, options);
    }

    /// Deletes the specified service-specific credential.
    pub fn deleteServiceSpecificCredential(self: *Self, allocator: std.mem.Allocator, input: delete_service_specific_credential.DeleteServiceSpecificCredentialInput, options: delete_service_specific_credential.Options) !delete_service_specific_credential.DeleteServiceSpecificCredentialOutput {
        return delete_service_specific_credential.execute(self, allocator, input, options);
    }

    /// Deletes a signing certificate associated with the specified IAM user.
    ///
    /// If you do not specify a user name, IAM determines the user name implicitly
    /// based on
    /// the Amazon Web Services access key ID signing the request. This operation
    /// works for access keys under
    /// the Amazon Web Services account. Consequently, you can use this operation to
    /// manage Amazon Web Services account root
    /// user credentials even if the Amazon Web Services account has no associated
    /// IAM users.
    pub fn deleteSigningCertificate(self: *Self, allocator: std.mem.Allocator, input: delete_signing_certificate.DeleteSigningCertificateInput, options: delete_signing_certificate.Options) !delete_signing_certificate.DeleteSigningCertificateOutput {
        return delete_signing_certificate.execute(self, allocator, input, options);
    }

    /// Deletes the specified SSH public key.
    ///
    /// The SSH public key deleted by this operation is used only for authenticating
    /// the
    /// associated IAM user to an CodeCommit repository. For more information about
    /// using SSH keys
    /// to authenticate to an CodeCommit repository, see [Set up CodeCommit for
    /// SSH
    /// connections](https://docs.aws.amazon.com/codecommit/latest/userguide/setting-up-credentials-ssh.html) in the *CodeCommit User Guide*.
    pub fn deleteSshPublicKey(self: *Self, allocator: std.mem.Allocator, input: delete_ssh_public_key.DeleteSSHPublicKeyInput, options: delete_ssh_public_key.Options) !delete_ssh_public_key.DeleteSSHPublicKeyOutput {
        return delete_ssh_public_key.execute(self, allocator, input, options);
    }

    /// Deletes the specified IAM user. Unlike the Amazon Web Services Management
    /// Console, when you delete a user
    /// programmatically, you must delete the items attached to the user manually,
    /// or the
    /// deletion fails. For more information, see [Deleting an IAM
    /// user](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_users_manage.html#id_users_deleting_cli). Before attempting to delete a user, remove the following items:
    ///
    /// * Password
    ///   ([DeleteLoginProfile](https://docs.aws.amazon.com/IAM/latest/APIReference/API_DeleteLoginProfile.html))
    ///
    /// * Access keys
    ///   ([DeleteAccessKey](https://docs.aws.amazon.com/IAM/latest/APIReference/API_DeleteAccessKey.html))
    ///
    /// * Signing certificate
    ///   ([DeleteSigningCertificate](https://docs.aws.amazon.com/IAM/latest/APIReference/API_DeleteSigningCertificate.html))
    ///
    /// * SSH public key
    ///   ([DeleteSSHPublicKey](https://docs.aws.amazon.com/IAM/latest/APIReference/API_DeleteSSHPublicKey.html))
    ///
    /// * Git credentials
    ///   ([DeleteServiceSpecificCredential](https://docs.aws.amazon.com/IAM/latest/APIReference/API_DeleteServiceSpecificCredential.html))
    ///
    /// * Multi-factor authentication (MFA) device
    ///   ([DeactivateMFADevice](https://docs.aws.amazon.com/IAM/latest/APIReference/API_DeactivateMFADevice.html), [DeleteVirtualMFADevice](https://docs.aws.amazon.com/IAM/latest/APIReference/API_DeleteVirtualMFADevice.html))
    ///
    /// * Inline policies
    ///   ([DeleteUserPolicy](https://docs.aws.amazon.com/IAM/latest/APIReference/API_DeleteUserPolicy.html))
    ///
    /// * Attached managed policies
    ///   ([DetachUserPolicy](https://docs.aws.amazon.com/IAM/latest/APIReference/API_DetachUserPolicy.html))
    ///
    /// * Group memberships
    ///   ([RemoveUserFromGroup](https://docs.aws.amazon.com/IAM/latest/APIReference/API_RemoveUserFromGroup.html))
    pub fn deleteUser(self: *Self, allocator: std.mem.Allocator, input: delete_user.DeleteUserInput, options: delete_user.Options) !delete_user.DeleteUserOutput {
        return delete_user.execute(self, allocator, input, options);
    }

    /// Deletes the permissions boundary for the specified IAM user.
    ///
    /// Deleting the permissions boundary for a user might increase its permissions
    /// by
    /// allowing the user to perform all the actions granted in its permissions
    /// policies.
    pub fn deleteUserPermissionsBoundary(self: *Self, allocator: std.mem.Allocator, input: delete_user_permissions_boundary.DeleteUserPermissionsBoundaryInput, options: delete_user_permissions_boundary.Options) !delete_user_permissions_boundary.DeleteUserPermissionsBoundaryOutput {
        return delete_user_permissions_boundary.execute(self, allocator, input, options);
    }

    /// Deletes the specified inline policy that is embedded in the specified IAM
    /// user.
    ///
    /// A user can also have managed policies attached to it. To detach a managed
    /// policy from
    /// a user, use
    /// [DetachUserPolicy](https://docs.aws.amazon.com/IAM/latest/APIReference/API_DetachUserPolicy.html).
    /// For more information about policies, refer to [Managed policies and inline
    /// policies](https://docs.aws.amazon.com/IAM/latest/UserGuide/policies-managed-vs-inline.html) in the *IAM User Guide*.
    pub fn deleteUserPolicy(self: *Self, allocator: std.mem.Allocator, input: delete_user_policy.DeleteUserPolicyInput, options: delete_user_policy.Options) !delete_user_policy.DeleteUserPolicyOutput {
        return delete_user_policy.execute(self, allocator, input, options);
    }

    /// Deletes a virtual MFA device.
    ///
    /// You must deactivate a user's virtual MFA device before you can delete it.
    /// For
    /// information about deactivating MFA devices, see
    /// [DeactivateMFADevice](https://docs.aws.amazon.com/IAM/latest/APIReference/API_DeactivateMFADevice.html).
    pub fn deleteVirtualMfaDevice(self: *Self, allocator: std.mem.Allocator, input: delete_virtual_mfa_device.DeleteVirtualMFADeviceInput, options: delete_virtual_mfa_device.Options) !delete_virtual_mfa_device.DeleteVirtualMFADeviceOutput {
        return delete_virtual_mfa_device.execute(self, allocator, input, options);
    }

    /// Removes the specified managed policy from the specified IAM group.
    ///
    /// A group can also have inline policies embedded with it. To delete an inline
    /// policy,
    /// use
    /// [DeleteGroupPolicy](https://docs.aws.amazon.com/IAM/latest/APIReference/API_DeleteGroupPolicy.html). For information about policies, see [Managed
    /// policies and inline
    /// policies](https://docs.aws.amazon.com/IAM/latest/UserGuide/policies-managed-vs-inline.html) in the
    /// *IAM User Guide*.
    pub fn detachGroupPolicy(self: *Self, allocator: std.mem.Allocator, input: detach_group_policy.DetachGroupPolicyInput, options: detach_group_policy.Options) !detach_group_policy.DetachGroupPolicyOutput {
        return detach_group_policy.execute(self, allocator, input, options);
    }

    /// Removes the specified managed policy from the specified role.
    ///
    /// A role can also have inline policies embedded with it. To delete an inline
    /// policy, use
    /// [DeleteRolePolicy](https://docs.aws.amazon.com/IAM/latest/APIReference/API_DeleteRolePolicy.html). For information about policies, see [Managed
    /// policies and inline
    /// policies](https://docs.aws.amazon.com/IAM/latest/UserGuide/policies-managed-vs-inline.html) in the
    /// *IAM User Guide*.
    pub fn detachRolePolicy(self: *Self, allocator: std.mem.Allocator, input: detach_role_policy.DetachRolePolicyInput, options: detach_role_policy.Options) !detach_role_policy.DetachRolePolicyOutput {
        return detach_role_policy.execute(self, allocator, input, options);
    }

    /// Removes the specified managed policy from the specified user.
    ///
    /// A user can also have inline policies embedded with it. To delete an inline
    /// policy, use
    /// [DeleteUserPolicy](https://docs.aws.amazon.com/IAM/latest/APIReference/API_DeleteUserPolicy.html). For information about policies, see [Managed
    /// policies and inline
    /// policies](https://docs.aws.amazon.com/IAM/latest/UserGuide/policies-managed-vs-inline.html) in the
    /// *IAM User Guide*.
    pub fn detachUserPolicy(self: *Self, allocator: std.mem.Allocator, input: detach_user_policy.DetachUserPolicyInput, options: detach_user_policy.Options) !detach_user_policy.DetachUserPolicyOutput {
        return detach_user_policy.execute(self, allocator, input, options);
    }

    /// Disables the management of privileged root user credentials across member
    /// accounts in
    /// your organization. When you disable this feature, the management account and
    /// the
    /// delegated administrator for IAM can no longer manage root user credentials
    /// for member
    /// accounts in your organization.
    pub fn disableOrganizationsRootCredentialsManagement(self: *Self, allocator: std.mem.Allocator, input: disable_organizations_root_credentials_management.DisableOrganizationsRootCredentialsManagementInput, options: disable_organizations_root_credentials_management.Options) !disable_organizations_root_credentials_management.DisableOrganizationsRootCredentialsManagementOutput {
        return disable_organizations_root_credentials_management.execute(self, allocator, input, options);
    }

    /// Disables root user sessions for privileged tasks across member accounts in
    /// your
    /// organization. When you disable this feature, the management account and the
    /// delegated
    /// administrator for IAM can no longer perform privileged tasks on member
    /// accounts in
    /// your organization.
    pub fn disableOrganizationsRootSessions(self: *Self, allocator: std.mem.Allocator, input: disable_organizations_root_sessions.DisableOrganizationsRootSessionsInput, options: disable_organizations_root_sessions.Options) !disable_organizations_root_sessions.DisableOrganizationsRootSessionsOutput {
        return disable_organizations_root_sessions.execute(self, allocator, input, options);
    }

    /// Disables the outbound identity federation feature for your Amazon Web
    /// Services account. When disabled, IAM principals in the account cannot
    /// use the `GetWebIdentityToken` API to obtain JSON Web Tokens (JWTs) for
    /// authentication with external services. This operation
    /// does not affect tokens that were issued before the feature was disabled.
    pub fn disableOutboundWebIdentityFederation(self: *Self, allocator: std.mem.Allocator, input: disable_outbound_web_identity_federation.DisableOutboundWebIdentityFederationInput, options: disable_outbound_web_identity_federation.Options) !disable_outbound_web_identity_federation.DisableOutboundWebIdentityFederationOutput {
        return disable_outbound_web_identity_federation.execute(self, allocator, input, options);
    }

    /// Enables the specified MFA device and associates it with the specified IAM
    /// user. When
    /// enabled, the MFA device is required for every subsequent login by the IAM
    /// user
    /// associated with the device.
    pub fn enableMfaDevice(self: *Self, allocator: std.mem.Allocator, input: enable_mfa_device.EnableMFADeviceInput, options: enable_mfa_device.Options) !enable_mfa_device.EnableMFADeviceOutput {
        return enable_mfa_device.execute(self, allocator, input, options);
    }

    /// Enables the management of privileged root user credentials across member
    /// accounts in your
    /// organization. When you enable root credentials management for [centralized
    /// root
    /// access](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_root-user.html#id_root-user-access-management), the management account and the delegated
    /// administrator for IAM can manage root user credentials for member accounts
    /// in your
    /// organization.
    ///
    /// Before you enable centralized root access, you must have an account
    /// configured with
    /// the following settings:
    ///
    /// * You must manage your Amazon Web Services accounts in
    ///   [Organizations](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_introduction.html).
    ///
    /// * Enable trusted access for Identity and Access Management in Organizations.
    ///   For details, see
    /// [IAM and
    /// Organizations](https://docs.aws.amazon.com/organizations/latest/userguide/services-that-can-integrate-iam.html) in the *Organizations User
    /// Guide*.
    pub fn enableOrganizationsRootCredentialsManagement(self: *Self, allocator: std.mem.Allocator, input: enable_organizations_root_credentials_management.EnableOrganizationsRootCredentialsManagementInput, options: enable_organizations_root_credentials_management.Options) !enable_organizations_root_credentials_management.EnableOrganizationsRootCredentialsManagementOutput {
        return enable_organizations_root_credentials_management.execute(self, allocator, input, options);
    }

    /// Allows the management account or delegated administrator to perform
    /// privileged tasks
    /// on member accounts in your organization. For more information, see
    /// [Centrally manage root access for member
    /// accounts](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_root-user.html#id_root-user-access-management) in the *Identity and Access Management
    /// User Guide*.
    ///
    /// Before you enable this feature, you must have an account configured with the
    /// following
    /// settings:
    ///
    /// * You must manage your Amazon Web Services accounts in
    ///   [Organizations](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_introduction.html).
    ///
    /// * Enable trusted access for Identity and Access Management in Organizations.
    ///   For details, see
    /// [IAM and
    /// Organizations](https://docs.aws.amazon.com/organizations/latest/userguide/services-that-can-integrate-ra.html) in the *Organizations User
    /// Guide*.
    pub fn enableOrganizationsRootSessions(self: *Self, allocator: std.mem.Allocator, input: enable_organizations_root_sessions.EnableOrganizationsRootSessionsInput, options: enable_organizations_root_sessions.Options) !enable_organizations_root_sessions.EnableOrganizationsRootSessionsOutput {
        return enable_organizations_root_sessions.execute(self, allocator, input, options);
    }

    /// Enables the outbound identity federation feature for your Amazon Web
    /// Services account. When enabled, IAM principals in your account
    /// can use the `GetWebIdentityToken` API to obtain JSON Web Tokens (JWTs) for
    /// secure authentication with external services.
    /// This operation also generates a unique issuer URL for your Amazon Web
    /// Services account.
    pub fn enableOutboundWebIdentityFederation(self: *Self, allocator: std.mem.Allocator, input: enable_outbound_web_identity_federation.EnableOutboundWebIdentityFederationInput, options: enable_outbound_web_identity_federation.Options) !enable_outbound_web_identity_federation.EnableOutboundWebIdentityFederationOutput {
        return enable_outbound_web_identity_federation.execute(self, allocator, input, options);
    }

    /// Generates a credential report for the Amazon Web Services account. For more
    /// information about the
    /// credential report, see [Getting credential
    /// reports](https://docs.aws.amazon.com/IAM/latest/UserGuide/credential-reports.html) in
    /// the *IAM User Guide*.
    pub fn generateCredentialReport(self: *Self, allocator: std.mem.Allocator, input: generate_credential_report.GenerateCredentialReportInput, options: generate_credential_report.Options) !generate_credential_report.GenerateCredentialReportOutput {
        return generate_credential_report.execute(self, allocator, input, options);
    }

    /// Generates a report for service last accessed data for Organizations. You can
    /// generate a
    /// report for any entities (organization root, organizational unit, or account)
    /// or policies
    /// in your organization.
    ///
    /// To call this operation, you must be signed in using your Organizations
    /// management account
    /// credentials. You can use your long-term IAM user or root user credentials,
    /// or temporary
    /// credentials from assuming an IAM role. SCPs must be enabled for your
    /// organization
    /// root. You must have the required IAM and Organizations permissions. For more
    /// information, see
    /// [Refining permissions using service last accessed
    /// data](https://docs.aws.amazon.com/IAM/latest/UserGuide/access_policies_access-advisor.html) in the
    /// *IAM User Guide*.
    ///
    /// You can generate a service last accessed data report for entities by
    /// specifying only
    /// the entity's path. This data includes a list of services that are allowed by
    /// any service
    /// control policies (SCPs) that apply to the entity.
    ///
    /// You can generate a service last accessed data report for a policy by
    /// specifying an
    /// entity's path and an optional Organizations policy ID. This data includes a
    /// list of services that
    /// are allowed by the specified SCP.
    ///
    /// For each service in both report types, the data includes the most recent
    /// account
    /// activity that the policy allows to account principals in the entity or the
    /// entity's
    /// children. For important information about the data, reporting period,
    /// permissions
    /// required, troubleshooting, and supported Regions see [Reducing permissions
    /// using
    /// service last accessed
    /// data](https://docs.aws.amazon.com/IAM/latest/UserGuide/access_policies_access-advisor.html) in the
    /// *IAM User Guide*.
    ///
    /// The data includes all attempts to access Amazon Web Services, not just the
    /// successful ones. This
    /// includes all attempts that were made using the Amazon Web Services
    /// Management Console, the Amazon Web Services API through any
    /// of the SDKs, or any of the command line tools. An unexpected entry in the
    /// service
    /// last accessed data does not mean that an account has been compromised,
    /// because the
    /// request might have been denied. Refer to your CloudTrail logs as the
    /// authoritative
    /// source for information about all API calls and whether they were successful
    /// or
    /// denied access. For more information, see [Logging IAM events with
    /// CloudTrail](https://docs.aws.amazon.com/IAM/latest/UserGuide/cloudtrail-integration.html) in the *IAM User Guide*.
    ///
    /// This operation returns a `JobId`. Use this parameter in the `
    /// [GetOrganizationsAccessReport](https://docs.aws.amazon.com/IAM/latest/APIReference/API_GetOrganizationsAccessReport.html)
    /// ` operation to check the status of
    /// the report generation. To check the status of this request, use the `JobId`
    /// parameter in the `
    /// [GetOrganizationsAccessReport](https://docs.aws.amazon.com/IAM/latest/APIReference/API_GetOrganizationsAccessReport.html)
    /// ` operation and test the
    /// `JobStatus` response parameter. When the job is complete, you can
    /// retrieve the report.
    ///
    /// To generate a service last accessed data report for entities, specify an
    /// entity path
    /// without specifying the optional Organizations policy ID. The type of entity
    /// that you specify
    /// determines the data returned in the report.
    ///
    /// * **Root** – When you specify the
    /// organizations root as the entity, the resulting report lists all of the
    /// services
    /// allowed by SCPs that are attached to your root. For each service, the report
    /// includes data for all accounts in your organization except the
    /// management account, because the management account is not limited by SCPs.
    ///
    /// * **OU** – When you specify an
    /// organizational unit (OU) as the entity, the resulting report lists all of
    /// the
    /// services allowed by SCPs that are attached to the OU and its parents. For
    /// each
    /// service, the report includes data for all accounts in the OU or its
    /// children.
    /// This data excludes the management account, because the management account is
    /// not
    /// limited by SCPs.
    ///
    /// * **management account** – When you specify the
    /// management account, the resulting report lists all Amazon Web Services
    /// services, because the
    /// management account is not limited by SCPs. For each service, the report
    /// includes
    /// data for only the management account.
    ///
    /// * **Account** – When you specify another
    /// account as the entity, the resulting report lists all of the services
    /// allowed by
    /// SCPs that are attached to the account and its parents. For each service, the
    /// report includes data for only the specified account.
    ///
    /// To generate a service last accessed data report for policies, specify an
    /// entity path
    /// and the optional Organizations policy ID. The type of entity that you
    /// specify determines the data
    /// returned for each service.
    ///
    /// * **Root** – When you specify the root
    /// entity and a policy ID, the resulting report lists all of the services that
    /// are
    /// allowed by the specified SCP. For each service, the report includes data for
    /// all
    /// accounts in your organization to which the SCP applies. This data excludes
    /// the
    /// management account, because the management account is not limited by SCPs.
    /// If the
    /// SCP is not attached to any entities in the organization, then the report
    /// will
    /// return a list of services with no data.
    ///
    /// * **OU** – When you specify an OU entity and
    /// a policy ID, the resulting report lists all of the services that are allowed
    /// by
    /// the specified SCP. For each service, the report includes data for all
    /// accounts
    /// in the OU or its children to which the SCP applies. This means that other
    /// accounts outside the OU that are affected by the SCP might not be included
    /// in
    /// the data. This data excludes the management account, because the
    /// management account is not limited by SCPs. If the SCP is not attached to the
    /// OU
    /// or one of its children, the report will return a list of services with no
    /// data.
    ///
    /// * **management account** – When you specify the
    /// management account, the resulting report lists all Amazon Web Services
    /// services, because the
    /// management account is not limited by SCPs. If you specify a policy ID in the
    /// CLI
    /// or API, the policy is ignored. For each service, the report includes data
    /// for
    /// only the management account.
    ///
    /// * **Account** – When you specify another
    /// account entity and a policy ID, the resulting report lists all of the
    /// services
    /// that are allowed by the specified SCP. For each service, the report includes
    /// data for only the specified account. This means that other accounts in the
    /// organization that are affected by the SCP might not be included in the data.
    /// If
    /// the SCP is not attached to the account, the report will return a list of
    /// services with no data.
    ///
    /// Service last accessed data does not use other policy types when determining
    /// whether a principal could access a service. These other policy types include
    /// identity-based policies, resource-based policies, access control lists, IAM
    /// permissions boundaries, and STS assume role policies. It only applies SCP
    /// logic.
    /// For more about the evaluation of policy types, see [Evaluating
    /// policies](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_policies_evaluation-logic.html#policy-eval-basics) in the
    /// *IAM User Guide*.
    ///
    /// For more information about service last accessed data, see [Reducing policy
    /// scope by
    /// viewing user
    /// activity](https://docs.aws.amazon.com/IAM/latest/UserGuide/access_policies_access-advisor.html) in the *IAM User Guide*.
    pub fn generateOrganizationsAccessReport(self: *Self, allocator: std.mem.Allocator, input: generate_organizations_access_report.GenerateOrganizationsAccessReportInput, options: generate_organizations_access_report.Options) !generate_organizations_access_report.GenerateOrganizationsAccessReportOutput {
        return generate_organizations_access_report.execute(self, allocator, input, options);
    }

    /// Generates a report that includes details about when an IAM resource (user,
    /// group,
    /// role, or policy) was last used in an attempt to access Amazon Web Services
    /// services. Recent activity
    /// usually appears within four hours. IAM reports activity for at least the
    /// last 400
    /// days, or less if your Region began supporting this feature within the last
    /// year. For
    /// more information, see [Regions where data is
    /// tracked](https://docs.aws.amazon.com/IAM/latest/UserGuide/access_policies_access-advisor.html#access-advisor_tracking-period). For more information about services and
    /// actions for which action last accessed information is displayed, see [IAM
    /// action last accessed information services and
    /// actions](https://docs.aws.amazon.com/IAM/latest/UserGuide/access_policies_access-advisor-action-last-accessed.html).
    ///
    /// The service last accessed data includes all attempts to access an Amazon Web
    /// Services API, not
    /// just the successful ones. This includes all attempts that were made using
    /// the
    /// Amazon Web Services Management Console, the Amazon Web Services API through
    /// any of the SDKs, or any of the command line tools.
    /// An unexpected entry in the service last accessed data does not mean that
    /// your
    /// account has been compromised, because the request might have been denied.
    /// Refer to
    /// your CloudTrail logs as the authoritative source for information about all
    /// API calls
    /// and whether they were successful or denied access. For more information, see
    /// [Logging
    /// IAM events with
    /// CloudTrail](https://docs.aws.amazon.com/IAM/latest/UserGuide/cloudtrail-integration.html) in the
    /// *IAM User Guide*.
    ///
    /// The `GenerateServiceLastAccessedDetails` operation returns a
    /// `JobId`. Use this parameter in the following operations to retrieve the
    /// following details from your report:
    ///
    /// *
    ///   [GetServiceLastAccessedDetails](https://docs.aws.amazon.com/IAM/latest/APIReference/API_GetServiceLastAccessedDetails.html) – Use this operation for
    /// users, groups, roles, or policies to list every Amazon Web Services service
    /// that the resource
    /// could access using permissions policies. For each service, the response
    /// includes
    /// information about the most recent access attempt.
    ///
    /// The `JobId` returned by
    /// `GenerateServiceLastAccessedDetail` must be used by the same role
    /// within a session, or by the same user when used to call
    /// `GetServiceLastAccessedDetail`.
    ///
    /// *
    ///   [GetServiceLastAccessedDetailsWithEntities](https://docs.aws.amazon.com/IAM/latest/APIReference/API_GetServiceLastAccessedDetailsWithEntities.html) – Use this
    /// operation for groups and policies to list information about the associated
    /// entities (users or roles) that attempted to access a specific Amazon Web
    /// Services service.
    ///
    /// To check the status of the `GenerateServiceLastAccessedDetails` request,
    /// use the `JobId` parameter in the same operations and test the
    /// `JobStatus` response parameter.
    ///
    /// For additional information about the permissions policies that allow an
    /// identity
    /// (user, group, or role) to access specific services, use the
    /// [ListPoliciesGrantingServiceAccess](https://docs.aws.amazon.com/IAM/latest/APIReference/API_ListPoliciesGrantingServiceAccess.html) operation.
    ///
    /// Service last accessed data does not use other policy types when determining
    /// whether a resource could access a service. These other policy types include
    /// resource-based policies, access control lists, Organizations policies, IAM
    /// permissions
    /// boundaries, and STS assume role policies. It only applies permissions policy
    /// logic. For more about the evaluation of policy types, see [Evaluating
    /// policies](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_policies_evaluation-logic.html#policy-eval-basics) in the
    /// *IAM User Guide*.
    ///
    /// For more information about service and action last accessed data, see
    /// [Reducing permissions using service last accessed
    /// data](https://docs.aws.amazon.com/IAM/latest/UserGuide/access_policies_access-advisor.html) in the
    /// *IAM User Guide*.
    pub fn generateServiceLastAccessedDetails(self: *Self, allocator: std.mem.Allocator, input: generate_service_last_accessed_details.GenerateServiceLastAccessedDetailsInput, options: generate_service_last_accessed_details.Options) !generate_service_last_accessed_details.GenerateServiceLastAccessedDetailsOutput {
        return generate_service_last_accessed_details.execute(self, allocator, input, options);
    }

    /// Retrieves information about when the specified access key was last used. The
    /// information includes the date and time of last use, along with the Amazon
    /// Web Services service and
    /// Region that were specified in the last request made with that key.
    pub fn getAccessKeyLastUsed(self: *Self, allocator: std.mem.Allocator, input: get_access_key_last_used.GetAccessKeyLastUsedInput, options: get_access_key_last_used.Options) !get_access_key_last_used.GetAccessKeyLastUsedOutput {
        return get_access_key_last_used.execute(self, allocator, input, options);
    }

    /// Retrieves information about all IAM users, groups, roles, and policies in
    /// your Amazon Web Services
    /// account, including their relationships to one another. Use this operation to
    /// obtain a
    /// snapshot of the configuration of IAM permissions (users, groups, roles, and
    /// policies)
    /// in your account.
    ///
    /// Policies returned by this operation are URL-encoded compliant
    /// with [RFC 3986](https://tools.ietf.org/html/rfc3986). You can use a URL
    /// decoding method to convert the policy back to plain JSON text. For example,
    /// if you use Java, you
    /// can use the `decode` method of the `java.net.URLDecoder` utility class in
    /// the Java SDK. Other languages and SDKs provide similar functionality, and
    /// some SDKs do this decoding
    /// automatically.
    ///
    /// You can optionally filter the results using the `Filter` parameter. You can
    /// paginate the results using the `MaxItems` and `Marker`
    /// parameters.
    pub fn getAccountAuthorizationDetails(self: *Self, allocator: std.mem.Allocator, input: get_account_authorization_details.GetAccountAuthorizationDetailsInput, options: get_account_authorization_details.Options) !get_account_authorization_details.GetAccountAuthorizationDetailsOutput {
        return get_account_authorization_details.execute(self, allocator, input, options);
    }

    /// Retrieves the password policy for the Amazon Web Services account. This
    /// tells you the complexity
    /// requirements and mandatory rotation periods for the IAM user passwords in
    /// your account.
    /// For more information about using a password policy, see [Managing an IAM
    /// password
    /// policy](https://docs.aws.amazon.com/IAM/latest/UserGuide/Using_ManagingPasswordPolicies.html).
    pub fn getAccountPasswordPolicy(self: *Self, allocator: std.mem.Allocator, input: get_account_password_policy.GetAccountPasswordPolicyInput, options: get_account_password_policy.Options) !get_account_password_policy.GetAccountPasswordPolicyOutput {
        return get_account_password_policy.execute(self, allocator, input, options);
    }

    /// Retrieves information about IAM entity usage and IAM quotas in the Amazon
    /// Web Services
    /// account.
    ///
    /// For information about IAM quotas, see [IAM and STS
    /// quotas](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_iam-quotas.html) in the
    /// *IAM User Guide*.
    pub fn getAccountSummary(self: *Self, allocator: std.mem.Allocator, input: get_account_summary.GetAccountSummaryInput, options: get_account_summary.Options) !get_account_summary.GetAccountSummaryOutput {
        return get_account_summary.execute(self, allocator, input, options);
    }

    /// Gets a list of all of the context keys referenced in the input policies. The
    /// policies
    /// are supplied as a list of one or more strings. To get the context keys from
    /// policies
    /// associated with an IAM user, group, or role, use
    /// [GetContextKeysForPrincipalPolicy](https://docs.aws.amazon.com/IAM/latest/APIReference/API_GetContextKeysForPrincipalPolicy.html).
    ///
    /// Context keys are variables maintained by Amazon Web Services and its
    /// services that provide details
    /// about the context of an API query request. Context keys can be evaluated by
    /// testing
    /// against a value specified in an IAM policy. Use
    /// `GetContextKeysForCustomPolicy` to understand what key names and values
    /// you must supply when you call
    /// [SimulateCustomPolicy](https://docs.aws.amazon.com/IAM/latest/APIReference/API_SimulateCustomPolicy.html). Note that all parameters are shown in unencoded form
    /// here for clarity but must be URL encoded to be included as a part of a real
    /// HTML
    /// request.
    pub fn getContextKeysForCustomPolicy(self: *Self, allocator: std.mem.Allocator, input: get_context_keys_for_custom_policy.GetContextKeysForCustomPolicyInput, options: get_context_keys_for_custom_policy.Options) !get_context_keys_for_custom_policy.GetContextKeysForCustomPolicyOutput {
        return get_context_keys_for_custom_policy.execute(self, allocator, input, options);
    }

    /// Gets a list of all of the context keys referenced in all the IAM policies
    /// that are
    /// attached to the specified IAM entity. The entity can be an IAM user, group,
    /// or role.
    /// If you specify a user, then the request also includes all of the policies
    /// attached to
    /// groups that the user is a member of.
    ///
    /// You can optionally include a list of one or more additional policies,
    /// specified as
    /// strings. If you want to include *only* a list of policies by string,
    /// use
    /// [GetContextKeysForCustomPolicy](https://docs.aws.amazon.com/IAM/latest/APIReference/API_GetContextKeysForCustomPolicy.html) instead.
    ///
    /// **Note:** This operation discloses information about the
    /// permissions granted to other users. If you do not want users to see other
    /// user's
    /// permissions, then consider allowing them to use
    /// [GetContextKeysForCustomPolicy](https://docs.aws.amazon.com/IAM/latest/APIReference/API_GetContextKeysForCustomPolicy.html) instead.
    ///
    /// Context keys are variables maintained by Amazon Web Services and its
    /// services that provide details
    /// about the context of an API query request. Context keys can be evaluated by
    /// testing
    /// against a value in an IAM policy. Use
    /// [GetContextKeysForPrincipalPolicy](https://docs.aws.amazon.com/IAM/latest/APIReference/API_GetContextKeysForPrincipalPolicy.html) to understand what key names and values
    /// you must supply when you call
    /// [SimulatePrincipalPolicy](https://docs.aws.amazon.com/IAM/latest/APIReference/API_SimulatePrincipalPolicy.html).
    pub fn getContextKeysForPrincipalPolicy(self: *Self, allocator: std.mem.Allocator, input: get_context_keys_for_principal_policy.GetContextKeysForPrincipalPolicyInput, options: get_context_keys_for_principal_policy.Options) !get_context_keys_for_principal_policy.GetContextKeysForPrincipalPolicyOutput {
        return get_context_keys_for_principal_policy.execute(self, allocator, input, options);
    }

    /// Retrieves a credential report for the Amazon Web Services account. For more
    /// information about the
    /// credential report, see [Getting credential
    /// reports](https://docs.aws.amazon.com/IAM/latest/UserGuide/credential-reports.html) in
    /// the *IAM User Guide*.
    pub fn getCredentialReport(self: *Self, allocator: std.mem.Allocator, input: get_credential_report.GetCredentialReportInput, options: get_credential_report.Options) !get_credential_report.GetCredentialReportOutput {
        return get_credential_report.execute(self, allocator, input, options);
    }

    /// Retrieves information about a specific delegation request.
    ///
    /// If a delegation request has no owner or owner account,
    /// `GetDelegationRequest` for that delegation request can be called by any
    /// account.
    /// If the owner account is assigned but there is
    /// no owner id, only identities within that owner account can call
    /// `GetDelegationRequest`
    /// for the delegation request. Once the delegation request is fully owned, the
    /// owner of the request gets
    /// a default permission to get that delegation request. For more details, see
    /// [
    /// Managing Permissions for Delegation
    /// Requests](https://docs.aws.amazon.com/IAM/latest/UserGuide/access_policies-temporary-delegation.html#temporary-delegation-managing-permissions).
    pub fn getDelegationRequest(self: *Self, allocator: std.mem.Allocator, input: get_delegation_request.GetDelegationRequestInput, options: get_delegation_request.Options) !get_delegation_request.GetDelegationRequestOutput {
        return get_delegation_request.execute(self, allocator, input, options);
    }

    /// Returns a list of IAM users that are in the specified IAM group. You can
    /// paginate
    /// the results using the `MaxItems` and `Marker` parameters.
    pub fn getGroup(self: *Self, allocator: std.mem.Allocator, input: get_group.GetGroupInput, options: get_group.Options) !get_group.GetGroupOutput {
        return get_group.execute(self, allocator, input, options);
    }

    /// Retrieves the specified inline policy document that is embedded in the
    /// specified IAM
    /// group.
    ///
    /// Policies returned by this operation are URL-encoded compliant
    /// with [RFC 3986](https://tools.ietf.org/html/rfc3986). You can use a URL
    /// decoding method to convert the policy back to plain JSON text. For example,
    /// if you use Java, you
    /// can use the `decode` method of the `java.net.URLDecoder` utility class in
    /// the Java SDK. Other languages and SDKs provide similar functionality, and
    /// some SDKs do this decoding
    /// automatically.
    ///
    /// An IAM group can also have managed policies attached to it. To retrieve a
    /// managed
    /// policy document that is attached to a group, use
    /// [GetPolicy](https://docs.aws.amazon.com/IAM/latest/APIReference/API_GetPolicy.html) to determine the
    /// policy's default version, then use
    /// [GetPolicyVersion](https://docs.aws.amazon.com/IAM/latest/APIReference/API_GetPolicyVersion.html) to
    /// retrieve the policy document.
    ///
    /// For more information about policies, see [Managed policies and inline
    /// policies](https://docs.aws.amazon.com/IAM/latest/UserGuide/policies-managed-vs-inline.html) in the *IAM User Guide*.
    pub fn getGroupPolicy(self: *Self, allocator: std.mem.Allocator, input: get_group_policy.GetGroupPolicyInput, options: get_group_policy.Options) !get_group_policy.GetGroupPolicyOutput {
        return get_group_policy.execute(self, allocator, input, options);
    }

    /// Retrieves a human readable summary for a given entity. At this time, the
    /// only supported
    /// entity type is `delegation-request`
    ///
    /// This method uses a Large Language Model (LLM) to generate the summary.
    ///
    /// If a delegation request has no owner or owner account,
    /// `GetHumanReadableSummary` for that delegation request can be called by any
    /// account.
    /// If the owner account is assigned but there is
    /// no owner id, only identities within that owner account can call
    /// `GetHumanReadableSummary`
    /// for the delegation request to retrieve a summary of that request.
    /// Once the delegation request is fully owned, the owner of the request gets
    /// a default permission to get that delegation request. For more details, read
    /// default permissions granted to delegation requests. These rules are
    /// identical to
    /// [GetDelegationRequest](https://docs.aws.amazon.com/IAM/latest/APIReference/API_GetDelegationRequest.html)
    /// API behavior, such that a party who has permissions to call
    /// [GetDelegationRequest](https://docs.aws.amazon.com/IAM/latest/APIReference/API_GetDelegationRequest.html)
    /// for a given delegation request will always be able to retrieve the human
    /// readable summary for that request.
    pub fn getHumanReadableSummary(self: *Self, allocator: std.mem.Allocator, input: get_human_readable_summary.GetHumanReadableSummaryInput, options: get_human_readable_summary.Options) !get_human_readable_summary.GetHumanReadableSummaryOutput {
        return get_human_readable_summary.execute(self, allocator, input, options);
    }

    /// Retrieves information about the specified instance profile, including the
    /// instance
    /// profile's path, GUID, ARN, and role. For more information about instance
    /// profiles, see
    /// [Using
    /// instance
    /// profiles](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_use_switch-role-ec2_instance-profiles.html) in the *IAM User Guide*.
    pub fn getInstanceProfile(self: *Self, allocator: std.mem.Allocator, input: get_instance_profile.GetInstanceProfileInput, options: get_instance_profile.Options) !get_instance_profile.GetInstanceProfileOutput {
        return get_instance_profile.execute(self, allocator, input, options);
    }

    /// Retrieves the user name for the specified IAM user. A login profile is
    /// created when
    /// you create a password for the user to access the Amazon Web Services
    /// Management Console. If the user does not exist
    /// or does not have a password, the operation returns a 404 (`NoSuchEntity`)
    /// error.
    ///
    /// If you create an IAM user with access to the console, the `CreateDate`
    /// reflects the date you created the initial password for the user.
    ///
    /// If you create an IAM user with programmatic access, and then later add a
    /// password
    /// for the user to access the Amazon Web Services Management Console, the
    /// `CreateDate` reflects the initial
    /// password creation date. A user with programmatic access does not have a
    /// login profile
    /// unless you create a password for the user to access the Amazon Web Services
    /// Management Console.
    pub fn getLoginProfile(self: *Self, allocator: std.mem.Allocator, input: get_login_profile.GetLoginProfileInput, options: get_login_profile.Options) !get_login_profile.GetLoginProfileOutput {
        return get_login_profile.execute(self, allocator, input, options);
    }

    /// Retrieves information about an MFA device for a specified user.
    pub fn getMfaDevice(self: *Self, allocator: std.mem.Allocator, input: get_mfa_device.GetMFADeviceInput, options: get_mfa_device.Options) !get_mfa_device.GetMFADeviceOutput {
        return get_mfa_device.execute(self, allocator, input, options);
    }

    /// Returns information about the specified OpenID Connect (OIDC) provider
    /// resource object
    /// in IAM.
    pub fn getOpenIdConnectProvider(self: *Self, allocator: std.mem.Allocator, input: get_open_id_connect_provider.GetOpenIDConnectProviderInput, options: get_open_id_connect_provider.Options) !get_open_id_connect_provider.GetOpenIDConnectProviderOutput {
        return get_open_id_connect_provider.execute(self, allocator, input, options);
    }

    /// Retrieves the service last accessed data report for Organizations that was
    /// previously
    /// generated using the `
    /// [GenerateOrganizationsAccessReport](https://docs.aws.amazon.com/IAM/latest/APIReference/API_GenerateOrganizationsAccessReport.html)
    /// ` operation. This operation
    /// retrieves the status of your report job and the report contents.
    ///
    /// Depending on the parameters that you passed when you generated the report,
    /// the data
    /// returned could include different information. For details, see
    /// [GenerateOrganizationsAccessReport](https://docs.aws.amazon.com/IAM/latest/APIReference/API_GenerateOrganizationsAccessReport.html).
    ///
    /// To call this operation, you must be signed in to the management account in
    /// your
    /// organization. SCPs must be enabled for your organization root. You must have
    /// permissions
    /// to perform this operation. For more information, see [Refining permissions
    /// using
    /// service last accessed
    /// data](https://docs.aws.amazon.com/IAM/latest/UserGuide/access_policies_access-advisor.html) in the
    /// *IAM User Guide*.
    ///
    /// For each service that principals in an account (root user, IAM users, or IAM
    /// roles)
    /// could access using SCPs, the operation returns details about the most recent
    /// access
    /// attempt. If there was no attempt, the service is listed without details
    /// about the most
    /// recent attempt to access the service. If the operation fails, it returns the
    /// reason that
    /// it failed.
    ///
    /// By default, the list is sorted by service namespace.
    pub fn getOrganizationsAccessReport(self: *Self, allocator: std.mem.Allocator, input: get_organizations_access_report.GetOrganizationsAccessReportInput, options: get_organizations_access_report.Options) !get_organizations_access_report.GetOrganizationsAccessReportOutput {
        return get_organizations_access_report.execute(self, allocator, input, options);
    }

    /// Retrieves the configuration information for the outbound identity federation
    /// feature in your Amazon Web Services account. The response includes the
    /// unique issuer URL for your
    /// Amazon Web Services account and the current enabled/disabled status of the
    /// feature. Use this operation to obtain the issuer URL that you need to
    /// configure trust relationships with external services.
    pub fn getOutboundWebIdentityFederationInfo(self: *Self, allocator: std.mem.Allocator, input: get_outbound_web_identity_federation_info.GetOutboundWebIdentityFederationInfoInput, options: get_outbound_web_identity_federation_info.Options) !get_outbound_web_identity_federation_info.GetOutboundWebIdentityFederationInfoOutput {
        return get_outbound_web_identity_federation_info.execute(self, allocator, input, options);
    }

    /// Retrieves information about the specified managed policy, including the
    /// policy's
    /// default version and the total number of IAM users, groups, and roles to
    /// which the
    /// policy is attached. To retrieve the list of the specific users, groups, and
    /// roles that
    /// the policy is attached to, use
    /// [ListEntitiesForPolicy](https://docs.aws.amazon.com/IAM/latest/APIReference/API_ListEntitiesForPolicy.html). This operation returns metadata about the policy. To
    /// retrieve the actual policy document for a specific version of the policy,
    /// use
    /// [GetPolicyVersion](https://docs.aws.amazon.com/IAM/latest/APIReference/API_GetPolicyVersion.html).
    ///
    /// This operation retrieves information about managed policies. To retrieve
    /// information
    /// about an inline policy that is embedded with an IAM user, group, or role,
    /// use
    /// [GetUserPolicy](https://docs.aws.amazon.com/IAM/latest/APIReference/API_GetUserPolicy.html), [GetGroupPolicy](https://docs.aws.amazon.com/IAM/latest/APIReference/API_GetGroupPolicy.html), or
    /// [GetRolePolicy](https://docs.aws.amazon.com/IAM/latest/APIReference/API_GetRolePolicy.html).
    ///
    /// For more information about policies, see [Managed policies and inline
    /// policies](https://docs.aws.amazon.com/IAM/latest/UserGuide/policies-managed-vs-inline.html) in the *IAM User Guide*.
    pub fn getPolicy(self: *Self, allocator: std.mem.Allocator, input: get_policy.GetPolicyInput, options: get_policy.Options) !get_policy.GetPolicyOutput {
        return get_policy.execute(self, allocator, input, options);
    }

    /// Retrieves information about the specified version of the specified managed
    /// policy,
    /// including the policy document.
    ///
    /// Policies returned by this operation are URL-encoded compliant
    /// with [RFC 3986](https://tools.ietf.org/html/rfc3986). You can use a URL
    /// decoding method to convert the policy back to plain JSON text. For example,
    /// if you use Java, you
    /// can use the `decode` method of the `java.net.URLDecoder` utility class in
    /// the Java SDK. Other languages and SDKs provide similar functionality, and
    /// some SDKs do this decoding
    /// automatically.
    ///
    /// To list the available versions for a policy, use
    /// [ListPolicyVersions](https://docs.aws.amazon.com/IAM/latest/APIReference/API_ListPolicyVersions.html).
    ///
    /// This operation retrieves information about managed policies. To retrieve
    /// information
    /// about an inline policy that is embedded in a user, group, or role, use
    /// [GetUserPolicy](https://docs.aws.amazon.com/IAM/latest/APIReference/API_GetUserPolicy.html), [GetGroupPolicy](https://docs.aws.amazon.com/IAM/latest/APIReference/API_GetGroupPolicy.html), or
    /// [GetRolePolicy](https://docs.aws.amazon.com/IAM/latest/APIReference/API_GetRolePolicy.html).
    ///
    /// For more information about the types of policies, see [Managed policies and
    /// inline
    /// policies](https://docs.aws.amazon.com/IAM/latest/UserGuide/policies-managed-vs-inline.html) in the *IAM User Guide*.
    ///
    /// For more information about managed policy versions, see [Versioning for
    /// managed
    /// policies](https://docs.aws.amazon.com/IAM/latest/UserGuide/policies-managed-versions.html) in the *IAM User Guide*.
    pub fn getPolicyVersion(self: *Self, allocator: std.mem.Allocator, input: get_policy_version.GetPolicyVersionInput, options: get_policy_version.Options) !get_policy_version.GetPolicyVersionOutput {
        return get_policy_version.execute(self, allocator, input, options);
    }

    /// Retrieves information about the specified role, including the role's path,
    /// GUID, ARN,
    /// and the role's trust policy that grants permission to assume the role. For
    /// more
    /// information about roles, see [IAM
    /// roles](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles.html) in
    /// the
    /// *IAM User Guide*.
    ///
    /// Policies returned by this operation are URL-encoded compliant
    /// with [RFC 3986](https://tools.ietf.org/html/rfc3986). You can use a URL
    /// decoding method to convert the policy back to plain JSON text. For example,
    /// if you use Java, you
    /// can use the `decode` method of the `java.net.URLDecoder` utility class in
    /// the Java SDK. Other languages and SDKs provide similar functionality, and
    /// some SDKs do this decoding
    /// automatically.
    pub fn getRole(self: *Self, allocator: std.mem.Allocator, input: get_role.GetRoleInput, options: get_role.Options) !get_role.GetRoleOutput {
        return get_role.execute(self, allocator, input, options);
    }

    /// Retrieves the specified inline policy document that is embedded with the
    /// specified
    /// IAM role.
    ///
    /// Policies returned by this operation are URL-encoded compliant
    /// with [RFC 3986](https://tools.ietf.org/html/rfc3986). You can use a URL
    /// decoding method to convert the policy back to plain JSON text. For example,
    /// if you use Java, you
    /// can use the `decode` method of the `java.net.URLDecoder` utility class in
    /// the Java SDK. Other languages and SDKs provide similar functionality, and
    /// some SDKs do this decoding
    /// automatically.
    ///
    /// An IAM role can also have managed policies attached to it. To retrieve a
    /// managed
    /// policy document that is attached to a role, use
    /// [GetPolicy](https://docs.aws.amazon.com/IAM/latest/APIReference/API_GetPolicy.html) to determine the
    /// policy's default version, then use
    /// [GetPolicyVersion](https://docs.aws.amazon.com/IAM/latest/APIReference/API_GetPolicyVersion.html) to
    /// retrieve the policy document.
    ///
    /// For more information about policies, see [Managed policies and inline
    /// policies](https://docs.aws.amazon.com/IAM/latest/UserGuide/policies-managed-vs-inline.html) in the *IAM User Guide*.
    ///
    /// For more information about roles, see [IAM
    /// roles](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles.html) in
    /// the
    /// *IAM User Guide*.
    pub fn getRolePolicy(self: *Self, allocator: std.mem.Allocator, input: get_role_policy.GetRolePolicyInput, options: get_role_policy.Options) !get_role_policy.GetRolePolicyOutput {
        return get_role_policy.execute(self, allocator, input, options);
    }

    /// Returns the SAML provider metadocument that was uploaded when the IAM SAML
    /// provider
    /// resource object was created or updated.
    ///
    /// This operation requires [Signature Version
    /// 4](https://docs.aws.amazon.com/general/latest/gr/signature-version-4.html).
    pub fn getSamlProvider(self: *Self, allocator: std.mem.Allocator, input: get_saml_provider.GetSAMLProviderInput, options: get_saml_provider.Options) !get_saml_provider.GetSAMLProviderOutput {
        return get_saml_provider.execute(self, allocator, input, options);
    }

    /// Retrieves information about the specified server certificate stored in IAM.
    ///
    /// For more information about working with server certificates, see [Working
    /// with server
    /// certificates](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_server-certs.html) in the *IAM User Guide*. This
    /// topic includes a list of Amazon Web Services services that can use the
    /// server certificates that you
    /// manage with IAM.
    pub fn getServerCertificate(self: *Self, allocator: std.mem.Allocator, input: get_server_certificate.GetServerCertificateInput, options: get_server_certificate.Options) !get_server_certificate.GetServerCertificateOutput {
        return get_server_certificate.execute(self, allocator, input, options);
    }

    /// Retrieves a service last accessed report that was created using the
    /// `GenerateServiceLastAccessedDetails` operation. You can use the
    /// `JobId` parameter in `GetServiceLastAccessedDetails` to
    /// retrieve the status of your report job. When the report is complete, you can
    /// retrieve
    /// the generated report. The report includes a list of Amazon Web Services
    /// services that the resource
    /// (user, group, role, or managed policy) can access.
    ///
    /// Service last accessed data does not use other policy types when determining
    /// whether a resource could access a service. These other policy types include
    /// resource-based policies, access control lists, Organizations policies, IAM
    /// permissions
    /// boundaries, and STS assume role policies. It only applies permissions policy
    /// logic. For more about the evaluation of policy types, see [Evaluating
    /// policies](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_policies_evaluation-logic.html#policy-eval-basics) in the
    /// *IAM User Guide*.
    ///
    /// For each service that the resource could access using permissions policies,
    /// the
    /// operation returns details about the most recent access attempt. If there was
    /// no attempt,
    /// the service is listed without details about the most recent attempt to
    /// access the
    /// service. If the operation fails, the `GetServiceLastAccessedDetails`
    /// operation returns the reason that it failed.
    ///
    /// The `GetServiceLastAccessedDetails` operation returns a list of services.
    /// This list includes the number of entities that have attempted to access the
    /// service and
    /// the date and time of the last attempt. It also returns the ARN of the
    /// following entity,
    /// depending on the resource ARN that you used to generate the report:
    ///
    /// * **User** – Returns the user ARN that you
    /// used to generate the report
    ///
    /// * **Group** – Returns the ARN of the group
    /// member (user) that last attempted to access the service
    ///
    /// * **Role** – Returns the role ARN that you
    /// used to generate the report
    ///
    /// * **Policy** – Returns the ARN of the user
    /// or role that last used the policy to attempt to access the service
    ///
    /// By default, the list is sorted by service namespace.
    ///
    /// If you specified `ACTION_LEVEL` granularity when you generated the report,
    /// this operation returns service and action last accessed data. This includes
    /// the most
    /// recent access attempt for each tracked action within a service. Otherwise,
    /// this
    /// operation returns only service data.
    ///
    /// For more information about service and action last accessed data, see
    /// [Reducing permissions using service last accessed
    /// data](https://docs.aws.amazon.com/IAM/latest/UserGuide/access_policies_access-advisor.html) in the
    /// *IAM User Guide*.
    pub fn getServiceLastAccessedDetails(self: *Self, allocator: std.mem.Allocator, input: get_service_last_accessed_details.GetServiceLastAccessedDetailsInput, options: get_service_last_accessed_details.Options) !get_service_last_accessed_details.GetServiceLastAccessedDetailsOutput {
        return get_service_last_accessed_details.execute(self, allocator, input, options);
    }

    /// After you generate a group or policy report using the
    /// `GenerateServiceLastAccessedDetails` operation, you can use the
    /// `JobId` parameter in
    /// `GetServiceLastAccessedDetailsWithEntities`. This operation retrieves the
    /// status of your report job and a list of entities that could have used group
    /// or policy
    /// permissions to access the specified service.
    ///
    /// * **Group** – For a group report, this
    /// operation returns a list of users in the group that could have used the
    /// group’s
    /// policies in an attempt to access the service.
    ///
    /// * **Policy** – For a policy report, this
    /// operation returns a list of entities (users or roles) that could have used
    /// the
    /// policy in an attempt to access the service.
    ///
    /// You can also use this operation for user or role reports to retrieve details
    /// about
    /// those entities.
    ///
    /// If the operation fails, the `GetServiceLastAccessedDetailsWithEntities`
    /// operation returns the reason that it failed.
    ///
    /// By default, the list of associated entities is sorted by date, with the most
    /// recent
    /// access listed first.
    pub fn getServiceLastAccessedDetailsWithEntities(self: *Self, allocator: std.mem.Allocator, input: get_service_last_accessed_details_with_entities.GetServiceLastAccessedDetailsWithEntitiesInput, options: get_service_last_accessed_details_with_entities.Options) !get_service_last_accessed_details_with_entities.GetServiceLastAccessedDetailsWithEntitiesOutput {
        return get_service_last_accessed_details_with_entities.execute(self, allocator, input, options);
    }

    /// Retrieves the status of your service-linked role deletion. After you use
    /// [DeleteServiceLinkedRole](https://docs.aws.amazon.com/IAM/latest/APIReference/API_DeleteServiceLinkedRole.html) to submit a service-linked role for deletion, you
    /// can use the `DeletionTaskId` parameter in
    /// `GetServiceLinkedRoleDeletionStatus` to check the status of the deletion.
    /// If the deletion fails, this operation returns the reason that it failed, if
    /// that
    /// information is returned by the service.
    pub fn getServiceLinkedRoleDeletionStatus(self: *Self, allocator: std.mem.Allocator, input: get_service_linked_role_deletion_status.GetServiceLinkedRoleDeletionStatusInput, options: get_service_linked_role_deletion_status.Options) !get_service_linked_role_deletion_status.GetServiceLinkedRoleDeletionStatusOutput {
        return get_service_linked_role_deletion_status.execute(self, allocator, input, options);
    }

    /// Retrieves the specified SSH public key, including metadata about the key.
    ///
    /// The SSH public key retrieved by this operation is used only for
    /// authenticating the
    /// associated IAM user to an CodeCommit repository. For more information about
    /// using SSH keys
    /// to authenticate to an CodeCommit repository, see [Set up CodeCommit for SSH
    /// connections](https://docs.aws.amazon.com/codecommit/latest/userguide/setting-up-credentials-ssh.html) in the *CodeCommit User Guide*.
    pub fn getSshPublicKey(self: *Self, allocator: std.mem.Allocator, input: get_ssh_public_key.GetSSHPublicKeyInput, options: get_ssh_public_key.Options) !get_ssh_public_key.GetSSHPublicKeyOutput {
        return get_ssh_public_key.execute(self, allocator, input, options);
    }

    /// Retrieves information about the specified IAM user, including the user's
    /// creation
    /// date, path, unique ID, and ARN.
    ///
    /// If you do not specify a user name, IAM determines the user name implicitly
    /// based on
    /// the Amazon Web Services access key ID used to sign the request to this
    /// operation.
    pub fn getUser(self: *Self, allocator: std.mem.Allocator, input: get_user.GetUserInput, options: get_user.Options) !get_user.GetUserOutput {
        return get_user.execute(self, allocator, input, options);
    }

    /// Retrieves the specified inline policy document that is embedded in the
    /// specified IAM
    /// user.
    ///
    /// Policies returned by this operation are URL-encoded compliant
    /// with [RFC 3986](https://tools.ietf.org/html/rfc3986). You can use a URL
    /// decoding method to convert the policy back to plain JSON text. For example,
    /// if you use Java, you
    /// can use the `decode` method of the `java.net.URLDecoder` utility class in
    /// the Java SDK. Other languages and SDKs provide similar functionality, and
    /// some SDKs do this decoding
    /// automatically.
    ///
    /// An IAM user can also have managed policies attached to it. To retrieve a
    /// managed
    /// policy document that is attached to a user, use
    /// [GetPolicy](https://docs.aws.amazon.com/IAM/latest/APIReference/API_GetPolicy.html) to determine the
    /// policy's default version. Then use
    /// [GetPolicyVersion](https://docs.aws.amazon.com/IAM/latest/APIReference/API_GetPolicyVersion.html) to
    /// retrieve the policy document.
    ///
    /// For more information about policies, see [Managed policies and inline
    /// policies](https://docs.aws.amazon.com/IAM/latest/UserGuide/policies-managed-vs-inline.html) in the *IAM User Guide*.
    pub fn getUserPolicy(self: *Self, allocator: std.mem.Allocator, input: get_user_policy.GetUserPolicyInput, options: get_user_policy.Options) !get_user_policy.GetUserPolicyOutput {
        return get_user_policy.execute(self, allocator, input, options);
    }

    /// Returns information about the access key IDs associated with the specified
    /// IAM user.
    /// If there is none, the operation returns an empty list.
    ///
    /// Although each user is limited to a small number of keys, you can still
    /// paginate the
    /// results using the `MaxItems` and `Marker` parameters.
    ///
    /// If the `UserName` is not specified, the user name is determined implicitly
    /// based on the Amazon Web Services access key ID used to sign the request. If
    /// a temporary access key is
    /// used, then `UserName` is required. If a long-term key is assigned to the
    /// user, then `UserName` is not required.
    ///
    /// This operation works for access keys under the Amazon Web Services account.
    /// If the Amazon Web Services account has
    /// no associated users, the root user returns it's own access key IDs by
    /// running this
    /// command.
    ///
    /// To ensure the security of your Amazon Web Services account, the secret
    /// access key is accessible
    /// only during key and user creation.
    pub fn listAccessKeys(self: *Self, allocator: std.mem.Allocator, input: list_access_keys.ListAccessKeysInput, options: list_access_keys.Options) !list_access_keys.ListAccessKeysOutput {
        return list_access_keys.execute(self, allocator, input, options);
    }

    /// Lists the account alias associated with the Amazon Web Services account
    /// (Note: you can have only
    /// one). For information about using an Amazon Web Services account alias, see
    /// [Creating,
    /// deleting, and listing an Amazon Web Services account
    /// alias](https://docs.aws.amazon.com/IAM/latest/UserGuide/console_account-alias.html#CreateAccountAlias) in the
    /// *IAM User Guide*.
    pub fn listAccountAliases(self: *Self, allocator: std.mem.Allocator, input: list_account_aliases.ListAccountAliasesInput, options: list_account_aliases.Options) !list_account_aliases.ListAccountAliasesOutput {
        return list_account_aliases.execute(self, allocator, input, options);
    }

    /// Lists all managed policies that are attached to the specified IAM group.
    ///
    /// An IAM group can also have inline policies embedded with it. To list the
    /// inline
    /// policies for a group, use
    /// [ListGroupPolicies](https://docs.aws.amazon.com/IAM/latest/APIReference/API_ListGroupPolicies.html).
    /// For information about policies, see [Managed policies and inline
    /// policies](https://docs.aws.amazon.com/IAM/latest/UserGuide/policies-managed-vs-inline.html) in the *IAM User Guide*.
    ///
    /// You can paginate the results using the `MaxItems` and `Marker`
    /// parameters. You can use the `PathPrefix` parameter to limit the list of
    /// policies to only those matching the specified path prefix. If there are no
    /// policies
    /// attached to the specified group (or none that match the specified path
    /// prefix), the
    /// operation returns an empty list.
    pub fn listAttachedGroupPolicies(self: *Self, allocator: std.mem.Allocator, input: list_attached_group_policies.ListAttachedGroupPoliciesInput, options: list_attached_group_policies.Options) !list_attached_group_policies.ListAttachedGroupPoliciesOutput {
        return list_attached_group_policies.execute(self, allocator, input, options);
    }

    /// Lists all managed policies that are attached to the specified IAM role.
    ///
    /// An IAM role can also have inline policies embedded with it. To list the
    /// inline
    /// policies for a role, use
    /// [ListRolePolicies](https://docs.aws.amazon.com/IAM/latest/APIReference/API_ListRolePolicies.html).
    /// For information about policies, see [Managed policies and inline
    /// policies](https://docs.aws.amazon.com/IAM/latest/UserGuide/policies-managed-vs-inline.html) in the *IAM User Guide*.
    ///
    /// You can paginate the results using the `MaxItems` and `Marker`
    /// parameters. You can use the `PathPrefix` parameter to limit the list of
    /// policies to only those matching the specified path prefix. If there are no
    /// policies
    /// attached to the specified role (or none that match the specified path
    /// prefix), the
    /// operation returns an empty list.
    pub fn listAttachedRolePolicies(self: *Self, allocator: std.mem.Allocator, input: list_attached_role_policies.ListAttachedRolePoliciesInput, options: list_attached_role_policies.Options) !list_attached_role_policies.ListAttachedRolePoliciesOutput {
        return list_attached_role_policies.execute(self, allocator, input, options);
    }

    /// Lists all managed policies that are attached to the specified IAM user.
    ///
    /// An IAM user can also have inline policies embedded with it. To list the
    /// inline
    /// policies for a user, use
    /// [ListUserPolicies](https://docs.aws.amazon.com/IAM/latest/APIReference/API_ListUserPolicies.html).
    /// For information about policies, see [Managed policies and inline
    /// policies](https://docs.aws.amazon.com/IAM/latest/UserGuide/policies-managed-vs-inline.html) in the *IAM User Guide*.
    ///
    /// You can paginate the results using the `MaxItems` and `Marker`
    /// parameters. You can use the `PathPrefix` parameter to limit the list of
    /// policies to only those matching the specified path prefix. If there are no
    /// policies
    /// attached to the specified group (or none that match the specified path
    /// prefix), the
    /// operation returns an empty list.
    pub fn listAttachedUserPolicies(self: *Self, allocator: std.mem.Allocator, input: list_attached_user_policies.ListAttachedUserPoliciesInput, options: list_attached_user_policies.Options) !list_attached_user_policies.ListAttachedUserPoliciesOutput {
        return list_attached_user_policies.execute(self, allocator, input, options);
    }

    /// Lists delegation requests based on the specified criteria.
    ///
    /// If a delegation request has no owner, even if it is assigned to a specific
    /// account, it will not be part of the
    /// `ListDelegationRequests` output for that account.
    ///
    /// For more details, see
    /// [
    /// Managing Permissions for Delegation
    /// Requests](https://docs.aws.amazon.com/IAM/latest/UserGuide/access_policies-temporary-delegation.html#temporary-delegation-managing-permissions).
    pub fn listDelegationRequests(self: *Self, allocator: std.mem.Allocator, input: list_delegation_requests.ListDelegationRequestsInput, options: list_delegation_requests.Options) !list_delegation_requests.ListDelegationRequestsOutput {
        return list_delegation_requests.execute(self, allocator, input, options);
    }

    /// Lists all IAM users, groups, and roles that the specified managed policy is
    /// attached
    /// to.
    ///
    /// You can use the optional `EntityFilter` parameter to limit the results to a
    /// particular type of entity (users, groups, or roles). For example, to list
    /// only the roles
    /// that are attached to the specified policy, set `EntityFilter` to
    /// `Role`.
    ///
    /// You can paginate the results using the `MaxItems` and `Marker`
    /// parameters.
    pub fn listEntitiesForPolicy(self: *Self, allocator: std.mem.Allocator, input: list_entities_for_policy.ListEntitiesForPolicyInput, options: list_entities_for_policy.Options) !list_entities_for_policy.ListEntitiesForPolicyOutput {
        return list_entities_for_policy.execute(self, allocator, input, options);
    }

    /// Lists the names of the inline policies that are embedded in the specified
    /// IAM
    /// group.
    ///
    /// An IAM group can also have managed policies attached to it. To list the
    /// managed
    /// policies that are attached to a group, use
    /// [ListAttachedGroupPolicies](https://docs.aws.amazon.com/IAM/latest/APIReference/API_ListAttachedGroupPolicies.html). For more information about policies, see [Managed
    /// policies and inline
    /// policies](https://docs.aws.amazon.com/IAM/latest/UserGuide/policies-managed-vs-inline.html) in the
    /// *IAM User Guide*.
    ///
    /// You can paginate the results using the `MaxItems` and `Marker`
    /// parameters. If there are no inline policies embedded with the specified
    /// group, the
    /// operation returns an empty list.
    pub fn listGroupPolicies(self: *Self, allocator: std.mem.Allocator, input: list_group_policies.ListGroupPoliciesInput, options: list_group_policies.Options) !list_group_policies.ListGroupPoliciesOutput {
        return list_group_policies.execute(self, allocator, input, options);
    }

    /// Lists the IAM groups that have the specified path prefix.
    ///
    /// You can paginate the results using the `MaxItems` and `Marker`
    /// parameters.
    pub fn listGroups(self: *Self, allocator: std.mem.Allocator, input: list_groups.ListGroupsInput, options: list_groups.Options) !list_groups.ListGroupsOutput {
        return list_groups.execute(self, allocator, input, options);
    }

    /// Lists the IAM groups that the specified IAM user belongs to.
    ///
    /// You can paginate the results using the `MaxItems` and `Marker`
    /// parameters.
    pub fn listGroupsForUser(self: *Self, allocator: std.mem.Allocator, input: list_groups_for_user.ListGroupsForUserInput, options: list_groups_for_user.Options) !list_groups_for_user.ListGroupsForUserOutput {
        return list_groups_for_user.execute(self, allocator, input, options);
    }

    /// Lists the tags that are attached to the specified IAM instance profile. The
    /// returned list of tags is sorted by tag key.
    /// For more information about tagging, see [Tagging IAM
    /// resources](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_tags.html) in
    /// the
    /// *IAM User Guide*.
    pub fn listInstanceProfileTags(self: *Self, allocator: std.mem.Allocator, input: list_instance_profile_tags.ListInstanceProfileTagsInput, options: list_instance_profile_tags.Options) !list_instance_profile_tags.ListInstanceProfileTagsOutput {
        return list_instance_profile_tags.execute(self, allocator, input, options);
    }

    /// Lists the instance profiles that have the specified path prefix. If there
    /// are none,
    /// the operation returns an empty list. For more information about instance
    /// profiles, see
    /// [Using
    /// instance
    /// profiles](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_use_switch-role-ec2_instance-profiles.html) in the *IAM User Guide*.
    ///
    /// IAM resource-listing operations return a subset of the available
    /// attributes for the resource. For example, this operation does not return
    /// tags, even though they are an attribute of the returned object. To view all
    /// of the information for an instance profile, see
    /// [GetInstanceProfile](https://docs.aws.amazon.com/IAM/latest/APIReference/API_GetInstanceProfile.html).
    ///
    /// You can paginate the results using the `MaxItems` and `Marker`
    /// parameters.
    pub fn listInstanceProfiles(self: *Self, allocator: std.mem.Allocator, input: list_instance_profiles.ListInstanceProfilesInput, options: list_instance_profiles.Options) !list_instance_profiles.ListInstanceProfilesOutput {
        return list_instance_profiles.execute(self, allocator, input, options);
    }

    /// Lists the instance profiles that have the specified associated IAM role. If
    /// there
    /// are none, the operation returns an empty list. For more information about
    /// instance
    /// profiles, go to [Using
    /// instance
    /// profiles](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_use_switch-role-ec2_instance-profiles.html) in the *IAM User Guide*.
    ///
    /// You can paginate the results using the `MaxItems` and `Marker`
    /// parameters.
    pub fn listInstanceProfilesForRole(self: *Self, allocator: std.mem.Allocator, input: list_instance_profiles_for_role.ListInstanceProfilesForRoleInput, options: list_instance_profiles_for_role.Options) !list_instance_profiles_for_role.ListInstanceProfilesForRoleOutput {
        return list_instance_profiles_for_role.execute(self, allocator, input, options);
    }

    /// Lists the tags that are attached to the specified IAM virtual multi-factor
    /// authentication (MFA) device. The returned list of tags is
    /// sorted by tag key. For more information about tagging, see [Tagging IAM
    /// resources](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_tags.html) in
    /// the
    /// *IAM User Guide*.
    pub fn listMfaDeviceTags(self: *Self, allocator: std.mem.Allocator, input: list_mfa_device_tags.ListMFADeviceTagsInput, options: list_mfa_device_tags.Options) !list_mfa_device_tags.ListMFADeviceTagsOutput {
        return list_mfa_device_tags.execute(self, allocator, input, options);
    }

    /// Lists the MFA devices for an IAM user. If the request includes a IAM user
    /// name,
    /// then this operation lists all the MFA devices associated with the specified
    /// user. If you
    /// do not specify a user name, IAM determines the user name implicitly based on
    /// the Amazon Web Services
    /// access key ID signing the request for this operation.
    ///
    /// You can paginate the results using the `MaxItems` and `Marker`
    /// parameters.
    pub fn listMfaDevices(self: *Self, allocator: std.mem.Allocator, input: list_mfa_devices.ListMFADevicesInput, options: list_mfa_devices.Options) !list_mfa_devices.ListMFADevicesOutput {
        return list_mfa_devices.execute(self, allocator, input, options);
    }

    /// Lists the tags that are attached to the specified OpenID Connect
    /// (OIDC)-compatible
    /// identity provider. The returned list of tags is sorted by tag key. For more
    /// information, see [About web identity
    /// federation](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_providers_oidc.html).
    ///
    /// For more information about tagging, see [Tagging IAM
    /// resources](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_tags.html) in
    /// the
    /// *IAM User Guide*.
    pub fn listOpenIdConnectProviderTags(self: *Self, allocator: std.mem.Allocator, input: list_open_id_connect_provider_tags.ListOpenIDConnectProviderTagsInput, options: list_open_id_connect_provider_tags.Options) !list_open_id_connect_provider_tags.ListOpenIDConnectProviderTagsOutput {
        return list_open_id_connect_provider_tags.execute(self, allocator, input, options);
    }

    /// Lists information about the IAM OpenID Connect (OIDC) provider resource
    /// objects
    /// defined in the Amazon Web Services account.
    ///
    /// IAM resource-listing operations return a subset of the available
    /// attributes for the resource. For example, this operation does not return
    /// tags, even though they are an attribute of the returned object. To view all
    /// of the information for an OIDC provider, see
    /// [GetOpenIDConnectProvider](https://docs.aws.amazon.com/IAM/latest/APIReference/API_GetOpenIDConnectProvider.html).
    pub fn listOpenIdConnectProviders(self: *Self, allocator: std.mem.Allocator, input: list_open_id_connect_providers.ListOpenIDConnectProvidersInput, options: list_open_id_connect_providers.Options) !list_open_id_connect_providers.ListOpenIDConnectProvidersOutput {
        return list_open_id_connect_providers.execute(self, allocator, input, options);
    }

    /// Lists the centralized root access features enabled for your organization.
    /// For more
    /// information, see [Centrally manage root access for member
    /// accounts](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_root-user.html#id_root-user-access-management).
    pub fn listOrganizationsFeatures(self: *Self, allocator: std.mem.Allocator, input: list_organizations_features.ListOrganizationsFeaturesInput, options: list_organizations_features.Options) !list_organizations_features.ListOrganizationsFeaturesOutput {
        return list_organizations_features.execute(self, allocator, input, options);
    }

    /// Lists all the managed policies that are available in your Amazon Web
    /// Services account, including
    /// your own customer-defined managed policies and all Amazon Web Services
    /// managed policies.
    ///
    /// You can filter the list of policies that is returned using the optional
    /// `OnlyAttached`, `Scope`, and `PathPrefix`
    /// parameters. For example, to list only the customer managed policies in your
    /// Amazon Web Services
    /// account, set `Scope` to `Local`. To list only Amazon Web Services managed
    /// policies, set `Scope` to `AWS`.
    ///
    /// You can paginate the results using the `MaxItems` and `Marker`
    /// parameters.
    ///
    /// For more information about managed policies, see [Managed policies and
    /// inline
    /// policies](https://docs.aws.amazon.com/IAM/latest/UserGuide/policies-managed-vs-inline.html) in the *IAM User Guide*.
    ///
    /// IAM resource-listing operations return a subset of the available
    /// attributes for the resource. For example, this operation does not return
    /// tags, even though they are an attribute of the returned object. To view all
    /// of the information for a customer manged policy, see
    /// [GetPolicy](https://docs.aws.amazon.com/IAM/latest/APIReference/API_GetPolicy.html).
    pub fn listPolicies(self: *Self, allocator: std.mem.Allocator, input: list_policies.ListPoliciesInput, options: list_policies.Options) !list_policies.ListPoliciesOutput {
        return list_policies.execute(self, allocator, input, options);
    }

    /// Retrieves a list of policies that the IAM identity (user, group, or role)
    /// can use to
    /// access each specified service.
    ///
    /// This operation does not use other policy types when determining whether a
    /// resource
    /// could access a service. These other policy types include resource-based
    /// policies,
    /// access control lists, Organizations policies, IAM permissions boundaries,
    /// and STS
    /// assume role policies. It only applies permissions policy logic. For more
    /// about the
    /// evaluation of policy types, see [Evaluating
    /// policies](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_policies_evaluation-logic.html#policy-eval-basics) in the
    /// *IAM User Guide*.
    ///
    /// The list of policies returned by the operation depends on the ARN of the
    /// identity that
    /// you provide.
    ///
    /// * **User** – The list of policies includes
    /// the managed and inline policies that are attached to the user directly. The
    /// list
    /// also includes any additional managed and inline policies that are attached
    /// to
    /// the group to which the user belongs.
    ///
    /// * **Group** – The list of policies includes
    /// only the managed and inline policies that are attached to the group
    /// directly.
    /// Policies that are attached to the group’s user are not included.
    ///
    /// * **Role** – The list of policies includes
    /// only the managed and inline policies that are attached to the role.
    ///
    /// For each managed policy, this operation returns the ARN and policy name. For
    /// each
    /// inline policy, it returns the policy name and the entity to which it is
    /// attached. Inline
    /// policies do not have an ARN. For more information about these policy types,
    /// see [Managed policies and inline
    /// policies](https://docs.aws.amazon.com/IAM/latest/UserGuide/access_policies_managed-vs-inline.html) in the
    /// *IAM User Guide*.
    ///
    /// Policies that are attached to users and roles as permissions boundaries are
    /// not
    /// returned. To view which managed policy is currently used to set the
    /// permissions boundary
    /// for a user or role, use the
    /// [GetUser](https://docs.aws.amazon.com/IAM/latest/APIReference/API_GetUser.html) or [GetRole](https://docs.aws.amazon.com/IAM/latest/APIReference/API_GetRole.html)
    /// operations.
    pub fn listPoliciesGrantingServiceAccess(self: *Self, allocator: std.mem.Allocator, input: list_policies_granting_service_access.ListPoliciesGrantingServiceAccessInput, options: list_policies_granting_service_access.Options) !list_policies_granting_service_access.ListPoliciesGrantingServiceAccessOutput {
        return list_policies_granting_service_access.execute(self, allocator, input, options);
    }

    /// Lists the tags that are attached to the specified IAM customer managed
    /// policy.
    /// The returned list of tags is sorted by tag key. For more information about
    /// tagging, see [Tagging IAM
    /// resources](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_tags.html) in
    /// the
    /// *IAM User Guide*.
    pub fn listPolicyTags(self: *Self, allocator: std.mem.Allocator, input: list_policy_tags.ListPolicyTagsInput, options: list_policy_tags.Options) !list_policy_tags.ListPolicyTagsOutput {
        return list_policy_tags.execute(self, allocator, input, options);
    }

    /// Lists information about the versions of the specified managed policy,
    /// including the
    /// version that is currently set as the policy's default version.
    ///
    /// For more information about managed policies, see [Managed policies and
    /// inline
    /// policies](https://docs.aws.amazon.com/IAM/latest/UserGuide/policies-managed-vs-inline.html) in the *IAM User Guide*.
    pub fn listPolicyVersions(self: *Self, allocator: std.mem.Allocator, input: list_policy_versions.ListPolicyVersionsInput, options: list_policy_versions.Options) !list_policy_versions.ListPolicyVersionsOutput {
        return list_policy_versions.execute(self, allocator, input, options);
    }

    /// Lists the names of the inline policies that are embedded in the specified
    /// IAM
    /// role.
    ///
    /// An IAM role can also have managed policies attached to it. To list the
    /// managed
    /// policies that are attached to a role, use
    /// [ListAttachedRolePolicies](https://docs.aws.amazon.com/IAM/latest/APIReference/API_ListAttachedRolePolicies.html). For more information about policies, see [Managed
    /// policies and inline
    /// policies](https://docs.aws.amazon.com/IAM/latest/UserGuide/policies-managed-vs-inline.html) in the
    /// *IAM User Guide*.
    ///
    /// You can paginate the results using the `MaxItems` and `Marker`
    /// parameters. If there are no inline policies embedded with the specified
    /// role, the
    /// operation returns an empty list.
    pub fn listRolePolicies(self: *Self, allocator: std.mem.Allocator, input: list_role_policies.ListRolePoliciesInput, options: list_role_policies.Options) !list_role_policies.ListRolePoliciesOutput {
        return list_role_policies.execute(self, allocator, input, options);
    }

    /// Lists the tags that are attached to the specified role. The returned list of
    /// tags is
    /// sorted by tag key. For more information about tagging, see [Tagging IAM
    /// resources](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_tags.html) in
    /// the
    /// *IAM User Guide*.
    pub fn listRoleTags(self: *Self, allocator: std.mem.Allocator, input: list_role_tags.ListRoleTagsInput, options: list_role_tags.Options) !list_role_tags.ListRoleTagsOutput {
        return list_role_tags.execute(self, allocator, input, options);
    }

    /// Lists the IAM roles that have the specified path prefix. If there are none,
    /// the
    /// operation returns an empty list. For more information about roles, see [IAM
    /// roles](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles.html) in
    /// the
    /// *IAM User Guide*.
    ///
    /// IAM resource-listing operations return a subset of the available
    /// attributes for the resource. This operation does not return the following
    /// attributes, even though they are an attribute of the returned object:
    ///
    /// * PermissionsBoundary
    ///
    /// * RoleLastUsed
    ///
    /// * Tags
    ///
    /// To view all of the information for a role, see
    /// [GetRole](https://docs.aws.amazon.com/IAM/latest/APIReference/API_GetRole.html).
    ///
    /// You can paginate the results using the `MaxItems` and `Marker`
    /// parameters.
    pub fn listRoles(self: *Self, allocator: std.mem.Allocator, input: list_roles.ListRolesInput, options: list_roles.Options) !list_roles.ListRolesOutput {
        return list_roles.execute(self, allocator, input, options);
    }

    /// Lists the tags that are attached to the specified Security Assertion Markup
    /// Language
    /// (SAML) identity provider. The returned list of tags is sorted by tag key.
    /// For more information, see [About SAML 2.0-based
    /// federation](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_providers_saml.html).
    ///
    /// For more information about tagging, see [Tagging IAM
    /// resources](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_tags.html) in
    /// the
    /// *IAM User Guide*.
    pub fn listSamlProviderTags(self: *Self, allocator: std.mem.Allocator, input: list_saml_provider_tags.ListSAMLProviderTagsInput, options: list_saml_provider_tags.Options) !list_saml_provider_tags.ListSAMLProviderTagsOutput {
        return list_saml_provider_tags.execute(self, allocator, input, options);
    }

    /// Lists the SAML provider resource objects defined in IAM in the account.
    /// IAM resource-listing operations return a subset of the available
    /// attributes for the resource. For example, this operation does not return
    /// tags, even though they are an attribute of the returned object. To view all
    /// of the information for a SAML provider, see
    /// [GetSAMLProvider](https://docs.aws.amazon.com/IAM/latest/APIReference/API_GetSAMLProvider.html).
    ///
    /// This operation requires [Signature Version
    /// 4](https://docs.aws.amazon.com/general/latest/gr/signature-version-4.html).
    pub fn listSamlProviders(self: *Self, allocator: std.mem.Allocator, input: list_saml_providers.ListSAMLProvidersInput, options: list_saml_providers.Options) !list_saml_providers.ListSAMLProvidersOutput {
        return list_saml_providers.execute(self, allocator, input, options);
    }

    /// Lists the tags that are attached to the specified IAM server certificate.
    /// The
    /// returned list of tags is sorted by tag key. For more information about
    /// tagging, see [Tagging IAM
    /// resources](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_tags.html) in
    /// the
    /// *IAM User Guide*.
    ///
    /// For certificates in a Region supported by Certificate Manager (ACM), we
    /// recommend that you don't use IAM server certificates. Instead, use ACM to
    /// provision,
    /// manage, and deploy your server certificates. For more information about IAM
    /// server
    /// certificates, [Working with server
    /// certificates](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_server-certs.html) in the *IAM User Guide*.
    pub fn listServerCertificateTags(self: *Self, allocator: std.mem.Allocator, input: list_server_certificate_tags.ListServerCertificateTagsInput, options: list_server_certificate_tags.Options) !list_server_certificate_tags.ListServerCertificateTagsOutput {
        return list_server_certificate_tags.execute(self, allocator, input, options);
    }

    /// Lists the server certificates stored in IAM that have the specified path
    /// prefix. If
    /// none exist, the operation returns an empty list.
    ///
    /// You can paginate the results using the `MaxItems` and `Marker`
    /// parameters.
    ///
    /// For more information about working with server certificates, see [Working
    /// with server
    /// certificates](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_server-certs.html) in the *IAM User Guide*. This
    /// topic also includes a list of Amazon Web Services services that can use the
    /// server certificates that
    /// you manage with IAM.
    ///
    /// IAM resource-listing operations return a subset of the available
    /// attributes for the resource. For example, this operation does not return
    /// tags, even though they are an attribute of the returned object. To view all
    /// of the information for a servercertificate, see
    /// [GetServerCertificate](https://docs.aws.amazon.com/IAM/latest/APIReference/API_GetServerCertificate.html).
    pub fn listServerCertificates(self: *Self, allocator: std.mem.Allocator, input: list_server_certificates.ListServerCertificatesInput, options: list_server_certificates.Options) !list_server_certificates.ListServerCertificatesOutput {
        return list_server_certificates.execute(self, allocator, input, options);
    }

    /// Returns information about the service-specific credentials associated with
    /// the
    /// specified IAM user. If none exists, the operation returns an empty list. The
    /// service-specific credentials returned by this operation are used only for
    /// authenticating
    /// the IAM user to a specific service. For more information about using
    /// service-specific
    /// credentials to authenticate to an Amazon Web Services service, see [Set up
    /// service-specific
    /// credentials](https://docs.aws.amazon.com/codecommit/latest/userguide/setting-up-gc.html)
    /// in the CodeCommit User Guide.
    pub fn listServiceSpecificCredentials(self: *Self, allocator: std.mem.Allocator, input: list_service_specific_credentials.ListServiceSpecificCredentialsInput, options: list_service_specific_credentials.Options) !list_service_specific_credentials.ListServiceSpecificCredentialsOutput {
        return list_service_specific_credentials.execute(self, allocator, input, options);
    }

    /// Returns information about the signing certificates associated with the
    /// specified IAM
    /// user. If none exists, the operation returns an empty list.
    ///
    /// Although each user is limited to a small number of signing certificates, you
    /// can still
    /// paginate the results using the `MaxItems` and `Marker`
    /// parameters.
    ///
    /// If the `UserName` field is not specified, the user name is determined
    /// implicitly based on the Amazon Web Services access key ID used to sign the
    /// request for this operation.
    /// This operation works for access keys under the Amazon Web Services account.
    /// Consequently, you can use
    /// this operation to manage Amazon Web Services account root user credentials
    /// even if the Amazon Web Services account has no
    /// associated users.
    pub fn listSigningCertificates(self: *Self, allocator: std.mem.Allocator, input: list_signing_certificates.ListSigningCertificatesInput, options: list_signing_certificates.Options) !list_signing_certificates.ListSigningCertificatesOutput {
        return list_signing_certificates.execute(self, allocator, input, options);
    }

    /// Returns information about the SSH public keys associated with the specified
    /// IAM
    /// user. If none exists, the operation returns an empty list.
    ///
    /// The SSH public keys returned by this operation are used only for
    /// authenticating the
    /// IAM user to an CodeCommit repository. For more information about using SSH
    /// keys to
    /// authenticate to an CodeCommit repository, see [Set up CodeCommit for
    /// SSH
    /// connections](https://docs.aws.amazon.com/codecommit/latest/userguide/setting-up-credentials-ssh.html) in the *CodeCommit User Guide*.
    ///
    /// Although each user is limited to a small number of keys, you can still
    /// paginate the
    /// results using the `MaxItems` and `Marker` parameters.
    pub fn listSshPublicKeys(self: *Self, allocator: std.mem.Allocator, input: list_ssh_public_keys.ListSSHPublicKeysInput, options: list_ssh_public_keys.Options) !list_ssh_public_keys.ListSSHPublicKeysOutput {
        return list_ssh_public_keys.execute(self, allocator, input, options);
    }

    /// Lists the names of the inline policies embedded in the specified IAM user.
    ///
    /// An IAM user can also have managed policies attached to it. To list the
    /// managed
    /// policies that are attached to a user, use
    /// [ListAttachedUserPolicies](https://docs.aws.amazon.com/IAM/latest/APIReference/API_ListAttachedUserPolicies.html). For more information about policies, see [Managed
    /// policies and inline
    /// policies](https://docs.aws.amazon.com/IAM/latest/UserGuide/policies-managed-vs-inline.html) in the
    /// *IAM User Guide*.
    ///
    /// You can paginate the results using the `MaxItems` and `Marker`
    /// parameters. If there are no inline policies embedded with the specified
    /// user, the
    /// operation returns an empty list.
    pub fn listUserPolicies(self: *Self, allocator: std.mem.Allocator, input: list_user_policies.ListUserPoliciesInput, options: list_user_policies.Options) !list_user_policies.ListUserPoliciesOutput {
        return list_user_policies.execute(self, allocator, input, options);
    }

    /// Lists the tags that are attached to the specified IAM user. The returned
    /// list of tags is sorted by tag key. For more information about tagging, see
    /// [Tagging IAM
    /// resources](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_tags.html) in
    /// the
    /// *IAM User Guide*.
    pub fn listUserTags(self: *Self, allocator: std.mem.Allocator, input: list_user_tags.ListUserTagsInput, options: list_user_tags.Options) !list_user_tags.ListUserTagsOutput {
        return list_user_tags.execute(self, allocator, input, options);
    }

    /// Lists the IAM users that have the specified path prefix. If no path prefix
    /// is
    /// specified, the operation returns all users in the Amazon Web Services
    /// account. If there are none, the
    /// operation returns an empty list.
    ///
    /// IAM resource-listing operations return a subset of the available
    /// attributes for the resource. This operation does not return the following
    /// attributes, even though they are an attribute of the returned object:
    ///
    /// * PermissionsBoundary
    ///
    /// * Tags
    ///
    /// To view all of the information for a user, see
    /// [GetUser](https://docs.aws.amazon.com/IAM/latest/APIReference/API_GetUser.html).
    ///
    /// You can paginate the results using the `MaxItems` and `Marker`
    /// parameters.
    pub fn listUsers(self: *Self, allocator: std.mem.Allocator, input: list_users.ListUsersInput, options: list_users.Options) !list_users.ListUsersOutput {
        return list_users.execute(self, allocator, input, options);
    }

    /// Lists the virtual MFA devices defined in the Amazon Web Services account by
    /// assignment status. If
    /// you do not specify an assignment status, the operation returns a list of all
    /// virtual MFA
    /// devices. Assignment status can be `Assigned`, `Unassigned`, or
    /// `Any`.
    ///
    /// IAM resource-listing operations return a subset of the available
    /// attributes for the resource. For example, this operation does not return
    /// tags, even though they are an attribute of the returned object. To view tag
    /// information for a virtual MFA device, see
    /// [ListMFADeviceTags](https://docs.aws.amazon.com/IAM/latest/APIReference/API_ListMFADeviceTags.html).
    ///
    /// You can paginate the results using the `MaxItems` and `Marker`
    /// parameters.
    pub fn listVirtualMfaDevices(self: *Self, allocator: std.mem.Allocator, input: list_virtual_mfa_devices.ListVirtualMFADevicesInput, options: list_virtual_mfa_devices.Options) !list_virtual_mfa_devices.ListVirtualMFADevicesOutput {
        return list_virtual_mfa_devices.execute(self, allocator, input, options);
    }

    /// Adds or updates an inline policy document that is embedded in the specified
    /// IAM
    /// group.
    ///
    /// A user can also have managed policies attached to it. To attach a managed
    /// policy to a
    /// group, use [
    /// `AttachGroupPolicy`
    /// ](https://docs.aws.amazon.com/IAM/latest/APIReference/API_AttachGroupPolicy.html). To create a new managed policy, use
    /// [
    /// `CreatePolicy`
    /// ](https://docs.aws.amazon.com/IAM/latest/APIReference/API_CreatePolicy.html). For information about policies, see [Managed
    /// policies and inline
    /// policies](https://docs.aws.amazon.com/IAM/latest/UserGuide/policies-managed-vs-inline.html) in the
    /// *IAM User Guide*.
    ///
    /// For information about the maximum number of inline policies that you can
    /// embed in a
    /// group, see [IAM and STS
    /// quotas](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_iam-quotas.html) in the *IAM User Guide*.
    ///
    /// Because policy documents can be large, you should use POST rather than GET
    /// when
    /// calling `PutGroupPolicy`. For general information about using the Query
    /// API with IAM, see [Making query
    /// requests](https://docs.aws.amazon.com/IAM/latest/UserGuide/IAM_UsingQueryAPI.html) in the
    /// *IAM User Guide*.
    pub fn putGroupPolicy(self: *Self, allocator: std.mem.Allocator, input: put_group_policy.PutGroupPolicyInput, options: put_group_policy.Options) !put_group_policy.PutGroupPolicyOutput {
        return put_group_policy.execute(self, allocator, input, options);
    }

    /// Adds or updates the policy that is specified as the IAM role's permissions
    /// boundary.
    /// You can use an Amazon Web Services managed policy or a customer managed
    /// policy to set the boundary for
    /// a role. Use the boundary to control the maximum permissions that the role
    /// can have.
    /// Setting a permissions boundary is an advanced feature that can affect the
    /// permissions
    /// for the role.
    ///
    /// You cannot set the boundary for a service-linked role.
    ///
    /// Policies used as permissions boundaries do not provide permissions. You must
    /// also
    /// attach a permissions policy to the role. To learn how the effective
    /// permissions for
    /// a role are evaluated, see [IAM JSON policy
    /// evaluation
    /// logic](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_policies_evaluation-logic.html) in the IAM User Guide.
    pub fn putRolePermissionsBoundary(self: *Self, allocator: std.mem.Allocator, input: put_role_permissions_boundary.PutRolePermissionsBoundaryInput, options: put_role_permissions_boundary.Options) !put_role_permissions_boundary.PutRolePermissionsBoundaryOutput {
        return put_role_permissions_boundary.execute(self, allocator, input, options);
    }

    /// Adds or updates an inline policy document that is embedded in the specified
    /// IAM
    /// role.
    ///
    /// When you embed an inline policy in a role, the inline policy is used as part
    /// of the
    /// role's access (permissions) policy. The role's trust policy is created at
    /// the same time
    /// as the role, using [
    /// `CreateRole`
    /// ](https://docs.aws.amazon.com/IAM/latest/APIReference/API_CreateRole.html).
    /// You can update a role's trust policy using [
    /// `UpdateAssumeRolePolicy`
    /// ](https://docs.aws.amazon.com/IAM/latest/APIReference/API_UpdateAssumeRolePolicy.html). For more information about roles,
    /// see [IAM
    /// roles](https://docs.aws.amazon.com/IAM/latest/UserGuide/roles-toplevel.html)
    /// in the *IAM User Guide*.
    ///
    /// A role can also have a managed policy attached to it. To attach a managed
    /// policy to a
    /// role, use [
    /// `AttachRolePolicy`
    /// ](https://docs.aws.amazon.com/IAM/latest/APIReference/API_AttachRolePolicy.html). To create a new managed policy, use
    /// [
    /// `CreatePolicy`
    /// ](https://docs.aws.amazon.com/IAM/latest/APIReference/API_CreatePolicy.html). For information about policies, see [Managed
    /// policies and inline
    /// policies](https://docs.aws.amazon.com/IAM/latest/UserGuide/policies-managed-vs-inline.html) in the
    /// *IAM User Guide*.
    ///
    /// For information about the maximum number of inline policies that you can
    /// embed with a
    /// role, see [IAM and STS
    /// quotas](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_iam-quotas.html) in the *IAM User Guide*.
    ///
    /// Because policy documents can be large, you should use POST rather than GET
    /// when
    /// calling `PutRolePolicy`. For general information about using the Query
    /// API with IAM, see [Making query
    /// requests](https://docs.aws.amazon.com/IAM/latest/UserGuide/IAM_UsingQueryAPI.html) in the
    /// *IAM User Guide*.
    pub fn putRolePolicy(self: *Self, allocator: std.mem.Allocator, input: put_role_policy.PutRolePolicyInput, options: put_role_policy.Options) !put_role_policy.PutRolePolicyOutput {
        return put_role_policy.execute(self, allocator, input, options);
    }

    /// Adds or updates the policy that is specified as the IAM user's permissions
    /// boundary. You can use an Amazon Web Services managed policy or a customer
    /// managed policy to set the
    /// boundary for a user. Use the boundary to control the maximum permissions
    /// that the user
    /// can have. Setting a permissions boundary is an advanced feature that can
    /// affect the
    /// permissions for the user.
    ///
    /// Policies that are used as permissions boundaries do not provide permissions.
    /// You
    /// must also attach a permissions policy to the user. To learn how the
    /// effective
    /// permissions for a user are evaluated, see [IAM JSON policy
    /// evaluation
    /// logic](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_policies_evaluation-logic.html) in the IAM User Guide.
    pub fn putUserPermissionsBoundary(self: *Self, allocator: std.mem.Allocator, input: put_user_permissions_boundary.PutUserPermissionsBoundaryInput, options: put_user_permissions_boundary.Options) !put_user_permissions_boundary.PutUserPermissionsBoundaryOutput {
        return put_user_permissions_boundary.execute(self, allocator, input, options);
    }

    /// Adds or updates an inline policy document that is embedded in the specified
    /// IAM
    /// user.
    ///
    /// An IAM user can also have a managed policy attached to it. To attach a
    /// managed
    /// policy to a user, use [
    /// `AttachUserPolicy`
    /// ](https://docs.aws.amazon.com/IAM/latest/APIReference/API_AttachUserPolicy.html). To create a new managed policy, use
    /// [
    /// `CreatePolicy`
    /// ](https://docs.aws.amazon.com/IAM/latest/APIReference/API_CreatePolicy.html). For information about policies, see [Managed
    /// policies and inline
    /// policies](https://docs.aws.amazon.com/IAM/latest/UserGuide/policies-managed-vs-inline.html) in the
    /// *IAM User Guide*.
    ///
    /// For information about the maximum number of inline policies that you can
    /// embed in a
    /// user, see [IAM and STS
    /// quotas](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_iam-quotas.html) in the *IAM User Guide*.
    ///
    /// Because policy documents can be large, you should use POST rather than GET
    /// when
    /// calling `PutUserPolicy`. For general information about using the Query
    /// API with IAM, see [Making query
    /// requests](https://docs.aws.amazon.com/IAM/latest/UserGuide/IAM_UsingQueryAPI.html) in the
    /// *IAM User Guide*.
    pub fn putUserPolicy(self: *Self, allocator: std.mem.Allocator, input: put_user_policy.PutUserPolicyInput, options: put_user_policy.Options) !put_user_policy.PutUserPolicyOutput {
        return put_user_policy.execute(self, allocator, input, options);
    }

    /// Rejects a delegation request, denying the requested temporary access.
    ///
    /// Once a request is rejected, it cannot be accepted or updated later. Rejected
    /// requests expire after 7 days.
    ///
    /// When rejecting a request, an optional explanation can be added using the
    /// `Notes` request parameter.
    ///
    /// For more details, see
    /// [
    /// Managing Permissions for Delegation
    /// Requests](https://docs.aws.amazon.com/IAM/latest/UserGuide/access_policies-temporary-delegation.html#temporary-delegation-managing-permissions).
    pub fn rejectDelegationRequest(self: *Self, allocator: std.mem.Allocator, input: reject_delegation_request.RejectDelegationRequestInput, options: reject_delegation_request.Options) !reject_delegation_request.RejectDelegationRequestOutput {
        return reject_delegation_request.execute(self, allocator, input, options);
    }

    /// Removes the specified client ID (also known as audience) from the list of
    /// client IDs
    /// registered for the specified IAM OpenID Connect (OIDC) provider resource
    /// object.
    ///
    /// This operation is idempotent; it does not fail or return an error if you try
    /// to remove
    /// a client ID that does not exist.
    pub fn removeClientIdFromOpenIdConnectProvider(self: *Self, allocator: std.mem.Allocator, input: remove_client_id_from_open_id_connect_provider.RemoveClientIDFromOpenIDConnectProviderInput, options: remove_client_id_from_open_id_connect_provider.Options) !remove_client_id_from_open_id_connect_provider.RemoveClientIDFromOpenIDConnectProviderOutput {
        return remove_client_id_from_open_id_connect_provider.execute(self, allocator, input, options);
    }

    /// Removes the specified IAM role from the specified Amazon EC2 instance
    /// profile.
    ///
    /// Make sure that you do not have any Amazon EC2 instances running with the
    /// role you are
    /// about to remove from the instance profile. Removing a role from an instance
    /// profile
    /// that is associated with a running instance might break any applications
    /// running on
    /// the instance.
    ///
    /// For more information about roles, see [IAM
    /// roles](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles.html) in
    /// the
    /// *IAM User Guide*. For more information about instance profiles,
    /// see [Using
    /// instance
    /// profiles](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_use_switch-role-ec2_instance-profiles.html) in the *IAM User Guide*.
    pub fn removeRoleFromInstanceProfile(self: *Self, allocator: std.mem.Allocator, input: remove_role_from_instance_profile.RemoveRoleFromInstanceProfileInput, options: remove_role_from_instance_profile.Options) !remove_role_from_instance_profile.RemoveRoleFromInstanceProfileOutput {
        return remove_role_from_instance_profile.execute(self, allocator, input, options);
    }

    /// Removes the specified user from the specified group.
    pub fn removeUserFromGroup(self: *Self, allocator: std.mem.Allocator, input: remove_user_from_group.RemoveUserFromGroupInput, options: remove_user_from_group.Options) !remove_user_from_group.RemoveUserFromGroupOutput {
        return remove_user_from_group.execute(self, allocator, input, options);
    }

    /// Resets the password for a service-specific credential. The new password is
    /// Amazon Web Services
    /// generated and cryptographically strong. It cannot be configured by the user.
    /// Resetting
    /// the password immediately invalidates the previous password associated with
    /// this
    /// user.
    pub fn resetServiceSpecificCredential(self: *Self, allocator: std.mem.Allocator, input: reset_service_specific_credential.ResetServiceSpecificCredentialInput, options: reset_service_specific_credential.Options) !reset_service_specific_credential.ResetServiceSpecificCredentialOutput {
        return reset_service_specific_credential.execute(self, allocator, input, options);
    }

    /// Synchronizes the specified MFA device with its IAM resource object on the
    /// Amazon Web Services
    /// servers.
    ///
    /// For more information about creating and working with virtual MFA devices,
    /// see [Using a virtual MFA
    /// device](https://docs.aws.amazon.com/IAM/latest/UserGuide/Using_VirtualMFA.html) in the *IAM User Guide*.
    pub fn resyncMfaDevice(self: *Self, allocator: std.mem.Allocator, input: resync_mfa_device.ResyncMFADeviceInput, options: resync_mfa_device.Options) !resync_mfa_device.ResyncMFADeviceOutput {
        return resync_mfa_device.execute(self, allocator, input, options);
    }

    /// Sends the exchange token for an accepted delegation request.
    ///
    /// The exchange token is sent to the partner via an asynchronous notification
    /// channel, established by the partner.
    ///
    /// The delegation request must be in the `ACCEPTED` state when calling this
    /// API. After the
    /// `SendDelegationToken` API
    /// call is successful, the request transitions to a `FINALIZED` state and
    /// cannot be rolled back. However, a user may reject
    /// an accepted request before the `SendDelegationToken` API is called.
    ///
    /// For more details, see
    /// [
    /// Managing Permissions for Delegation
    /// Requests](https://docs.aws.amazon.com/IAM/latest/UserGuide/access_policies-temporary-delegation.html#temporary-delegation-managing-permissions).
    pub fn sendDelegationToken(self: *Self, allocator: std.mem.Allocator, input: send_delegation_token.SendDelegationTokenInput, options: send_delegation_token.Options) !send_delegation_token.SendDelegationTokenOutput {
        return send_delegation_token.execute(self, allocator, input, options);
    }

    /// Sets the specified version of the specified policy as the policy's default
    /// (operative)
    /// version.
    ///
    /// This operation affects all users, groups, and roles that the policy is
    /// attached to. To
    /// list the users, groups, and roles that the policy is attached to, use
    /// [ListEntitiesForPolicy](https://docs.aws.amazon.com/IAM/latest/APIReference/API_ListEntitiesForPolicy.html).
    ///
    /// For information about managed policies, see [Managed policies and inline
    /// policies](https://docs.aws.amazon.com/IAM/latest/UserGuide/policies-managed-vs-inline.html) in the *IAM User Guide*.
    pub fn setDefaultPolicyVersion(self: *Self, allocator: std.mem.Allocator, input: set_default_policy_version.SetDefaultPolicyVersionInput, options: set_default_policy_version.Options) !set_default_policy_version.SetDefaultPolicyVersionOutput {
        return set_default_policy_version.execute(self, allocator, input, options);
    }

    /// Sets the specified version of the global endpoint token as the token version
    /// used for
    /// the Amazon Web Services account.
    ///
    /// By default, Security Token Service (STS) is available as a global service,
    /// and all STS requests
    /// go to a single endpoint at `https://sts.amazonaws.com`. Amazon Web Services
    /// recommends
    /// using Regional STS endpoints to reduce latency, build in redundancy, and
    /// increase
    /// session token availability. For information about Regional endpoints for
    /// STS, see
    /// [Security Token Service
    /// endpoints and
    /// quotas](https://docs.aws.amazon.com/general/latest/gr/sts.html) in the
    /// *Amazon Web Services General Reference*.
    ///
    /// If you make an STS call to the global endpoint, the resulting session tokens
    /// might
    /// be valid in some Regions but not others. It depends on the version that is
    /// set in this
    /// operation. Version 1 tokens are valid only in Amazon Web Services Regions
    /// that are
    /// available by default. These tokens do not work in manually enabled Regions,
    /// such as Asia
    /// Pacific (Hong Kong). Version 2 tokens are valid in all Regions. However,
    /// version 2
    /// tokens are longer and might affect systems where you temporarily store
    /// tokens. For
    /// information, see [Activating and
    /// deactivating STS in an Amazon Web Services
    /// Region](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_temp_enable-regions.html) in the
    /// *IAM User Guide*.
    ///
    /// To view the current session token version, see the
    /// `GlobalEndpointTokenVersion` entry in the response of the
    /// [GetAccountSummary](https://docs.aws.amazon.com/IAM/latest/APIReference/API_GetAccountSummary.html) operation.
    pub fn setSecurityTokenServicePreferences(self: *Self, allocator: std.mem.Allocator, input: set_security_token_service_preferences.SetSecurityTokenServicePreferencesInput, options: set_security_token_service_preferences.Options) !set_security_token_service_preferences.SetSecurityTokenServicePreferencesOutput {
        return set_security_token_service_preferences.execute(self, allocator, input, options);
    }

    /// Simulate how a set of IAM policies and optionally a resource-based policy
    /// works with
    /// a list of API operations and Amazon Web Services resources to determine the
    /// policies' effective
    /// permissions. The policies are provided as strings.
    ///
    /// The simulation does not perform the API operations; it only checks the
    /// authorization
    /// to determine if the simulated policies allow or deny the operations. You can
    /// simulate
    /// resources that don't exist in your account.
    ///
    /// If you want to simulate existing policies that are attached to an IAM user,
    /// group,
    /// or role, use
    /// [SimulatePrincipalPolicy](https://docs.aws.amazon.com/IAM/latest/APIReference/API_SimulatePrincipalPolicy.html) instead.
    ///
    /// Context keys are variables that are maintained by Amazon Web Services and
    /// its services and which
    /// provide details about the context of an API query request. You can use the
    /// `Condition` element of an IAM policy to evaluate context keys. To get
    /// the list of context keys that the policies require for correct simulation,
    /// use
    /// [GetContextKeysForCustomPolicy](https://docs.aws.amazon.com/IAM/latest/APIReference/API_GetContextKeysForCustomPolicy.html).
    ///
    /// If the output is long, you can use `MaxItems` and `Marker`
    /// parameters to paginate the results.
    ///
    /// The IAM policy simulator evaluates statements in the identity-based policy
    /// and
    /// the inputs that you provide during simulation. The policy simulator results
    /// can
    /// differ from your live Amazon Web Services environment. We recommend that you
    /// check your policies
    /// against your live Amazon Web Services environment after testing using the
    /// policy simulator to
    /// confirm that you have the desired results. For more information about using
    /// the
    /// policy simulator, see [Testing IAM
    /// policies with the IAM policy simulator
    /// ](https://docs.aws.amazon.com/IAM/latest/UserGuide/access_policies_testing-policies.html)in the
    /// *IAM User Guide*.
    pub fn simulateCustomPolicy(self: *Self, allocator: std.mem.Allocator, input: simulate_custom_policy.SimulateCustomPolicyInput, options: simulate_custom_policy.Options) !simulate_custom_policy.SimulateCustomPolicyOutput {
        return simulate_custom_policy.execute(self, allocator, input, options);
    }

    /// Simulate how a set of IAM policies attached to an IAM entity works with a
    /// list of
    /// API operations and Amazon Web Services resources to determine the policies'
    /// effective permissions. The
    /// entity can be an IAM user, group, or role. If you specify a user, then the
    /// simulation
    /// also includes all of the policies that are attached to groups that the user
    /// belongs to.
    /// You can simulate resources that don't exist in your account.
    ///
    /// You can optionally include a list of one or more additional policies
    /// specified as
    /// strings to include in the simulation. If you want to simulate only policies
    /// specified as
    /// strings, use
    /// [SimulateCustomPolicy](https://docs.aws.amazon.com/IAM/latest/APIReference/API_SimulateCustomPolicy.html) instead.
    ///
    /// You can also optionally include one resource-based policy to be evaluated
    /// with each of
    /// the resources included in the simulation for IAM users only.
    ///
    /// The simulation does not perform the API operations; it only checks the
    /// authorization
    /// to determine if the simulated policies allow or deny the operations.
    ///
    /// **Note:** This operation discloses information about the
    /// permissions granted to other users. If you do not want users to see other
    /// user's
    /// permissions, then consider allowing them to use
    /// [SimulateCustomPolicy](https://docs.aws.amazon.com/IAM/latest/APIReference/API_SimulateCustomPolicy.html) instead.
    ///
    /// Context keys are variables maintained by Amazon Web Services and its
    /// services that provide details
    /// about the context of an API query request. You can use the `Condition`
    /// element of an IAM policy to evaluate context keys. To get the list of
    /// context keys
    /// that the policies require for correct simulation, use
    /// [GetContextKeysForPrincipalPolicy](https://docs.aws.amazon.com/IAM/latest/APIReference/API_GetContextKeysForPrincipalPolicy.html).
    ///
    /// If the output is long, you can use the `MaxItems` and `Marker`
    /// parameters to paginate the results.
    ///
    /// The IAM policy simulator evaluates statements in the identity-based policy
    /// and
    /// the inputs that you provide during simulation. The policy simulator results
    /// can
    /// differ from your live Amazon Web Services environment. We recommend that you
    /// check your policies
    /// against your live Amazon Web Services environment after testing using the
    /// policy simulator to
    /// confirm that you have the desired results. For more information about using
    /// the
    /// policy simulator, see [Testing IAM
    /// policies with the IAM policy simulator
    /// ](https://docs.aws.amazon.com/IAM/latest/UserGuide/access_policies_testing-policies.html)in the
    /// *IAM User Guide*.
    pub fn simulatePrincipalPolicy(self: *Self, allocator: std.mem.Allocator, input: simulate_principal_policy.SimulatePrincipalPolicyInput, options: simulate_principal_policy.Options) !simulate_principal_policy.SimulatePrincipalPolicyOutput {
        return simulate_principal_policy.execute(self, allocator, input, options);
    }

    /// Adds one or more tags to an IAM instance profile. If a tag with the same key
    /// name
    /// already exists, then that tag is overwritten with the new value.
    ///
    /// Each tag consists of a key name and an associated value. By assigning tags
    /// to your resources, you can do the
    /// following:
    ///
    /// * **Administrative grouping and discovery** - Attach
    /// tags to resources to aid in organization and search. For example, you could
    /// search for all
    /// resources with the key name *Project* and the value
    /// *MyImportantProject*. Or search for all resources with the key name
    /// *Cost Center* and the value *41200*.
    ///
    /// * **Access control** - Include tags in IAM user-based
    /// and resource-based policies. You can use tags to restrict access to only an
    /// IAM instance
    /// profile that has a specified tag attached. For examples of policies that
    /// show how to use
    /// tags to control access, see [Control access using IAM
    /// tags](https://docs.aws.amazon.com/IAM/latest/UserGuide/access_tags.html) in
    /// the
    /// *IAM User Guide*.
    ///
    /// * If any one of the tags is invalid or if you exceed the allowed maximum
    ///   number of tags, then the entire request
    /// fails and the resource is not created. For more information about tagging,
    /// see [Tagging IAM
    /// resources](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_tags.html) in
    /// the
    /// *IAM User Guide*.
    ///
    /// * Amazon Web Services always interprets the tag `Value` as a single string.
    ///   If you
    /// need to store an array, you can store comma-separated values in the string.
    /// However, you
    /// must interpret the value in your code.
    pub fn tagInstanceProfile(self: *Self, allocator: std.mem.Allocator, input: tag_instance_profile.TagInstanceProfileInput, options: tag_instance_profile.Options) !tag_instance_profile.TagInstanceProfileOutput {
        return tag_instance_profile.execute(self, allocator, input, options);
    }

    /// Adds one or more tags to an IAM virtual multi-factor authentication (MFA)
    /// device. If
    /// a tag with the same key name already exists, then that tag is overwritten
    /// with the new
    /// value.
    ///
    /// A tag consists of a key name and an associated value. By assigning tags to
    /// your
    /// resources, you can do the following:
    ///
    /// * **Administrative grouping and discovery** - Attach
    /// tags to resources to aid in organization and search. For example, you could
    /// search for all
    /// resources with the key name *Project* and the value
    /// *MyImportantProject*. Or search for all resources with the key name
    /// *Cost Center* and the value *41200*.
    ///
    /// * **Access control** - Include tags in IAM user-based
    /// and resource-based policies. You can use tags to restrict access to only an
    /// IAM virtual
    /// MFA device that has a specified tag attached. For examples of policies that
    /// show how to
    /// use tags to control access, see [Control access using IAM
    /// tags](https://docs.aws.amazon.com/IAM/latest/UserGuide/access_tags.html) in
    /// the
    /// *IAM User Guide*.
    ///
    /// * If any one of the tags is invalid or if you exceed the allowed maximum
    ///   number of tags, then the entire request
    /// fails and the resource is not created. For more information about tagging,
    /// see [Tagging IAM
    /// resources](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_tags.html) in
    /// the
    /// *IAM User Guide*.
    ///
    /// * Amazon Web Services always interprets the tag `Value` as a single string.
    ///   If you
    /// need to store an array, you can store comma-separated values in the string.
    /// However, you
    /// must interpret the value in your code.
    pub fn tagMfaDevice(self: *Self, allocator: std.mem.Allocator, input: tag_mfa_device.TagMFADeviceInput, options: tag_mfa_device.Options) !tag_mfa_device.TagMFADeviceOutput {
        return tag_mfa_device.execute(self, allocator, input, options);
    }

    /// Adds one or more tags to an OpenID Connect (OIDC)-compatible identity
    /// provider. For
    /// more information about these providers, see [About web identity
    /// federation](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_providers_oidc.html). If
    /// a tag with the same key name already exists, then that tag is overwritten
    /// with the new
    /// value.
    ///
    /// A tag consists of a key name and an associated value. By assigning tags to
    /// your
    /// resources, you can do the following:
    ///
    /// * **Administrative grouping and discovery** - Attach
    /// tags to resources to aid in organization and search. For example, you could
    /// search for all
    /// resources with the key name *Project* and the value
    /// *MyImportantProject*. Or search for all resources with the key name
    /// *Cost Center* and the value *41200*.
    ///
    /// * **Access control** - Include tags in IAM identity-based
    /// and resource-based policies. You can use tags to restrict access to only an
    /// OIDC provider
    /// that has a specified tag attached. For examples of policies that show how to
    /// use tags to
    /// control access, see [Control access using IAM
    /// tags](https://docs.aws.amazon.com/IAM/latest/UserGuide/access_tags.html) in
    /// the
    /// *IAM User Guide*.
    ///
    /// * If any one of the tags is invalid or if you exceed the allowed maximum
    ///   number of tags, then the entire request
    /// fails and the resource is not created. For more information about tagging,
    /// see [Tagging IAM
    /// resources](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_tags.html) in
    /// the
    /// *IAM User Guide*.
    ///
    /// * Amazon Web Services always interprets the tag `Value` as a single string.
    ///   If you
    /// need to store an array, you can store comma-separated values in the string.
    /// However, you
    /// must interpret the value in your code.
    pub fn tagOpenIdConnectProvider(self: *Self, allocator: std.mem.Allocator, input: tag_open_id_connect_provider.TagOpenIDConnectProviderInput, options: tag_open_id_connect_provider.Options) !tag_open_id_connect_provider.TagOpenIDConnectProviderOutput {
        return tag_open_id_connect_provider.execute(self, allocator, input, options);
    }

    /// Adds one or more tags to an IAM customer managed policy. If a tag with the
    /// same key
    /// name already exists, then that tag is overwritten with the new value.
    ///
    /// A tag consists of a key name and an associated value. By assigning tags to
    /// your
    /// resources, you can do the following:
    ///
    /// * **Administrative grouping and discovery** - Attach
    /// tags to resources to aid in organization and search. For example, you could
    /// search for all
    /// resources with the key name *Project* and the value
    /// *MyImportantProject*. Or search for all resources with the key name
    /// *Cost Center* and the value *41200*.
    ///
    /// * **Access control** - Include tags in IAM user-based
    /// and resource-based policies. You can use tags to restrict access to only an
    /// IAM customer
    /// managed policy that has a specified tag attached. For examples of policies
    /// that show how
    /// to use tags to control access, see [Control access using IAM
    /// tags](https://docs.aws.amazon.com/IAM/latest/UserGuide/access_tags.html) in
    /// the
    /// *IAM User Guide*.
    ///
    /// * If any one of the tags is invalid or if you exceed the allowed maximum
    ///   number of tags, then the entire request
    /// fails and the resource is not created. For more information about tagging,
    /// see [Tagging IAM
    /// resources](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_tags.html) in
    /// the
    /// *IAM User Guide*.
    ///
    /// * Amazon Web Services always interprets the tag `Value` as a single string.
    ///   If you
    /// need to store an array, you can store comma-separated values in the string.
    /// However, you
    /// must interpret the value in your code.
    pub fn tagPolicy(self: *Self, allocator: std.mem.Allocator, input: tag_policy.TagPolicyInput, options: tag_policy.Options) !tag_policy.TagPolicyOutput {
        return tag_policy.execute(self, allocator, input, options);
    }

    /// Adds one or more tags to an IAM role. The role can be a regular role or a
    /// service-linked role. If a tag with the same key name already exists, then
    /// that tag is
    /// overwritten with the new value.
    ///
    /// A tag consists of a key name and an associated value. By assigning tags to
    /// your
    /// resources, you can do the following:
    ///
    /// * **Administrative grouping and discovery** - Attach
    /// tags to resources to aid in organization and search. For example, you could
    /// search for all
    /// resources with the key name *Project* and the value
    /// *MyImportantProject*. Or search for all resources with the key name
    /// *Cost Center* and the value *41200*.
    ///
    /// * **Access control** - Include tags in IAM user-based
    /// and resource-based policies. You can use tags to restrict access to only an
    /// IAM role
    /// that has a specified tag attached. You can also restrict access to only
    /// those resources
    /// that have a certain tag attached. For examples of policies that show how to
    /// use tags to
    /// control access, see [Control access using IAM
    /// tags](https://docs.aws.amazon.com/IAM/latest/UserGuide/access_tags.html) in
    /// the
    /// *IAM User Guide*.
    ///
    /// * **Cost allocation** - Use tags to help track which
    /// individuals and teams are using which Amazon Web Services resources.
    ///
    /// * If any one of the tags is invalid or if you exceed the allowed maximum
    ///   number of tags, then the entire request
    /// fails and the resource is not created. For more information about tagging,
    /// see [Tagging IAM
    /// resources](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_tags.html) in
    /// the
    /// *IAM User Guide*.
    ///
    /// * Amazon Web Services always interprets the tag `Value` as a single string.
    ///   If you
    /// need to store an array, you can store comma-separated values in the string.
    /// However, you
    /// must interpret the value in your code.
    ///
    /// For more information about tagging, see [Tagging IAM
    /// identities](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_tags.html)
    /// in the
    /// *IAM User Guide*.
    pub fn tagRole(self: *Self, allocator: std.mem.Allocator, input: tag_role.TagRoleInput, options: tag_role.Options) !tag_role.TagRoleOutput {
        return tag_role.execute(self, allocator, input, options);
    }

    /// Adds one or more tags to a Security Assertion Markup Language (SAML)
    /// identity provider.
    /// For more information about these providers, see [About SAML 2.0-based
    /// federation
    /// ](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_providers_saml.html).
    /// If a tag with the same key name already exists, then that tag is overwritten
    /// with the new
    /// value.
    ///
    /// A tag consists of a key name and an associated value. By assigning tags to
    /// your
    /// resources, you can do the following:
    ///
    /// * **Administrative grouping and discovery** - Attach
    /// tags to resources to aid in organization and search. For example, you could
    /// search for all
    /// resources with the key name *Project* and the value
    /// *MyImportantProject*. Or search for all resources with the key name
    /// *Cost Center* and the value *41200*.
    ///
    /// * **Access control** - Include tags in IAM user-based
    /// and resource-based policies. You can use tags to restrict access to only a
    /// SAML identity
    /// provider that has a specified tag attached. For examples of policies that
    /// show how to use
    /// tags to control access, see [Control access using IAM
    /// tags](https://docs.aws.amazon.com/IAM/latest/UserGuide/access_tags.html) in
    /// the
    /// *IAM User Guide*.
    ///
    /// * If any one of the tags is invalid or if you exceed the allowed maximum
    ///   number of tags, then the entire request
    /// fails and the resource is not created. For more information about tagging,
    /// see [Tagging IAM
    /// resources](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_tags.html) in
    /// the
    /// *IAM User Guide*.
    ///
    /// * Amazon Web Services always interprets the tag `Value` as a single string.
    ///   If you
    /// need to store an array, you can store comma-separated values in the string.
    /// However, you
    /// must interpret the value in your code.
    pub fn tagSamlProvider(self: *Self, allocator: std.mem.Allocator, input: tag_saml_provider.TagSAMLProviderInput, options: tag_saml_provider.Options) !tag_saml_provider.TagSAMLProviderOutput {
        return tag_saml_provider.execute(self, allocator, input, options);
    }

    /// Adds one or more tags to an IAM server certificate. If a tag with the same
    /// key name
    /// already exists, then that tag is overwritten with the new value.
    ///
    /// For certificates in a Region supported by Certificate Manager (ACM), we
    /// recommend that you don't use IAM server certificates. Instead, use ACM to
    /// provision,
    /// manage, and deploy your server certificates. For more information about IAM
    /// server
    /// certificates, [Working with server
    /// certificates](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_server-certs.html) in the *IAM User Guide*.
    ///
    /// A tag consists of a key name and an associated value. By assigning tags to
    /// your
    /// resources, you can do the following:
    ///
    /// * **Administrative grouping and discovery** - Attach
    /// tags to resources to aid in organization and search. For example, you could
    /// search for all
    /// resources with the key name *Project* and the value
    /// *MyImportantProject*. Or search for all resources with the key name
    /// *Cost Center* and the value *41200*.
    ///
    /// * **Access control** - Include tags in IAM user-based
    /// and resource-based policies. You can use tags to restrict access to only a
    /// server
    /// certificate that has a specified tag attached. For examples of policies that
    /// show how to
    /// use tags to control access, see [Control access using IAM
    /// tags](https://docs.aws.amazon.com/IAM/latest/UserGuide/access_tags.html) in
    /// the
    /// *IAM User Guide*.
    ///
    /// * **Cost allocation** - Use tags to help track which
    /// individuals and teams are using which Amazon Web Services resources.
    ///
    /// * If any one of the tags is invalid or if you exceed the allowed maximum
    ///   number of tags, then the entire request
    /// fails and the resource is not created. For more information about tagging,
    /// see [Tagging IAM
    /// resources](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_tags.html) in
    /// the
    /// *IAM User Guide*.
    ///
    /// * Amazon Web Services always interprets the tag `Value` as a single string.
    ///   If you
    /// need to store an array, you can store comma-separated values in the string.
    /// However, you
    /// must interpret the value in your code.
    pub fn tagServerCertificate(self: *Self, allocator: std.mem.Allocator, input: tag_server_certificate.TagServerCertificateInput, options: tag_server_certificate.Options) !tag_server_certificate.TagServerCertificateOutput {
        return tag_server_certificate.execute(self, allocator, input, options);
    }

    /// Adds one or more tags to an IAM user. If a tag with the same key name
    /// already exists,
    /// then that tag is overwritten with the new value.
    ///
    /// A tag consists of a key name and an associated value. By assigning tags to
    /// your
    /// resources, you can do the following:
    ///
    /// * **Administrative grouping and discovery** - Attach
    /// tags to resources to aid in organization and search. For example, you could
    /// search for all
    /// resources with the key name *Project* and the value
    /// *MyImportantProject*. Or search for all resources with the key name
    /// *Cost Center* and the value *41200*.
    ///
    /// * **Access control** - Include tags in IAM identity-based
    /// and resource-based policies. You can use tags to restrict access to only an
    /// IAM
    /// requesting user that has a specified tag attached. You can also restrict
    /// access to only
    /// those resources that have a certain tag attached. For examples of policies
    /// that show how
    /// to use tags to control access, see [Control access using IAM
    /// tags](https://docs.aws.amazon.com/IAM/latest/UserGuide/access_tags.html) in
    /// the
    /// *IAM User Guide*.
    ///
    /// * **Cost allocation** - Use tags to help track which
    /// individuals and teams are using which Amazon Web Services resources.
    ///
    /// * If any one of the tags is invalid or if you exceed the allowed maximum
    ///   number of tags, then the entire request
    /// fails and the resource is not created. For more information about tagging,
    /// see [Tagging IAM
    /// resources](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_tags.html) in
    /// the
    /// *IAM User Guide*.
    ///
    /// * Amazon Web Services always interprets the tag `Value` as a single string.
    ///   If you
    /// need to store an array, you can store comma-separated values in the string.
    /// However, you
    /// must interpret the value in your code.
    ///
    /// For more information about tagging, see [Tagging IAM
    /// identities](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_tags.html)
    /// in the
    /// *IAM User Guide*.
    pub fn tagUser(self: *Self, allocator: std.mem.Allocator, input: tag_user.TagUserInput, options: tag_user.Options) !tag_user.TagUserOutput {
        return tag_user.execute(self, allocator, input, options);
    }

    /// Removes the specified tags from the IAM instance profile. For more
    /// information about tagging, see [Tagging IAM
    /// resources](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_tags.html) in
    /// the
    /// *IAM User Guide*.
    pub fn untagInstanceProfile(self: *Self, allocator: std.mem.Allocator, input: untag_instance_profile.UntagInstanceProfileInput, options: untag_instance_profile.Options) !untag_instance_profile.UntagInstanceProfileOutput {
        return untag_instance_profile.execute(self, allocator, input, options);
    }

    /// Removes the specified tags from the IAM virtual multi-factor authentication
    /// (MFA)
    /// device. For more information about tagging, see [Tagging IAM
    /// resources](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_tags.html) in
    /// the
    /// *IAM User Guide*.
    pub fn untagMfaDevice(self: *Self, allocator: std.mem.Allocator, input: untag_mfa_device.UntagMFADeviceInput, options: untag_mfa_device.Options) !untag_mfa_device.UntagMFADeviceOutput {
        return untag_mfa_device.execute(self, allocator, input, options);
    }

    /// Removes the specified tags from the specified OpenID Connect
    /// (OIDC)-compatible identity
    /// provider in IAM. For more information about OIDC providers, see [About web
    /// identity
    /// federation](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_providers_oidc.html).
    /// For more information about tagging, see [Tagging IAM
    /// resources](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_tags.html) in
    /// the
    /// *IAM User Guide*.
    pub fn untagOpenIdConnectProvider(self: *Self, allocator: std.mem.Allocator, input: untag_open_id_connect_provider.UntagOpenIDConnectProviderInput, options: untag_open_id_connect_provider.Options) !untag_open_id_connect_provider.UntagOpenIDConnectProviderOutput {
        return untag_open_id_connect_provider.execute(self, allocator, input, options);
    }

    /// Removes the specified tags from the customer managed policy. For more
    /// information about tagging, see [Tagging IAM
    /// resources](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_tags.html) in
    /// the
    /// *IAM User Guide*.
    pub fn untagPolicy(self: *Self, allocator: std.mem.Allocator, input: untag_policy.UntagPolicyInput, options: untag_policy.Options) !untag_policy.UntagPolicyOutput {
        return untag_policy.execute(self, allocator, input, options);
    }

    /// Removes the specified tags from the role. For more information about
    /// tagging, see [Tagging IAM
    /// resources](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_tags.html) in
    /// the
    /// *IAM User Guide*.
    pub fn untagRole(self: *Self, allocator: std.mem.Allocator, input: untag_role.UntagRoleInput, options: untag_role.Options) !untag_role.UntagRoleOutput {
        return untag_role.execute(self, allocator, input, options);
    }

    /// Removes the specified tags from the specified Security Assertion Markup
    /// Language (SAML)
    /// identity provider in IAM. For more information about these providers, see
    /// [About web identity
    /// federation](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_providers_oidc.html). For more information about tagging, see [Tagging IAM resources](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_tags.html) in the
    /// *IAM User Guide*.
    pub fn untagSamlProvider(self: *Self, allocator: std.mem.Allocator, input: untag_saml_provider.UntagSAMLProviderInput, options: untag_saml_provider.Options) !untag_saml_provider.UntagSAMLProviderOutput {
        return untag_saml_provider.execute(self, allocator, input, options);
    }

    /// Removes the specified tags from the IAM server certificate.
    /// For more information about tagging, see [Tagging IAM
    /// resources](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_tags.html) in
    /// the
    /// *IAM User Guide*.
    ///
    /// For certificates in a Region supported by Certificate Manager (ACM), we
    /// recommend that you don't use IAM server certificates. Instead, use ACM to
    /// provision,
    /// manage, and deploy your server certificates. For more information about IAM
    /// server
    /// certificates, [Working with server
    /// certificates](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_server-certs.html) in the *IAM User Guide*.
    pub fn untagServerCertificate(self: *Self, allocator: std.mem.Allocator, input: untag_server_certificate.UntagServerCertificateInput, options: untag_server_certificate.Options) !untag_server_certificate.UntagServerCertificateOutput {
        return untag_server_certificate.execute(self, allocator, input, options);
    }

    /// Removes the specified tags from the user. For more information about
    /// tagging, see [Tagging IAM
    /// resources](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_tags.html) in
    /// the
    /// *IAM User Guide*.
    pub fn untagUser(self: *Self, allocator: std.mem.Allocator, input: untag_user.UntagUserInput, options: untag_user.Options) !untag_user.UntagUserOutput {
        return untag_user.execute(self, allocator, input, options);
    }

    /// Changes the status of the specified access key from Active to Inactive, or
    /// vice versa.
    /// This operation can be used to disable a user's key as part of a key rotation
    /// workflow.
    ///
    /// If the `UserName` is not specified, the user name is determined implicitly
    /// based on the Amazon Web Services access key ID used to sign the request. If
    /// a temporary access key is
    /// used, then `UserName` is required. If a long-term key is assigned to the
    /// user, then `UserName` is not required. This operation works for access keys
    /// under the Amazon Web Services account. Consequently, you can use this
    /// operation to manage Amazon Web Services account root user
    /// credentials even if the Amazon Web Services account has no associated users.
    ///
    /// For information about rotating keys, see [Managing keys and
    /// certificates](https://docs.aws.amazon.com/IAM/latest/UserGuide/ManagingCredentials.html)
    /// in the *IAM User Guide*.
    pub fn updateAccessKey(self: *Self, allocator: std.mem.Allocator, input: update_access_key.UpdateAccessKeyInput, options: update_access_key.Options) !update_access_key.UpdateAccessKeyOutput {
        return update_access_key.execute(self, allocator, input, options);
    }

    /// Updates the password policy settings for the Amazon Web Services account.
    ///
    /// This operation does not support partial updates. No parameters are required,
    /// but
    /// if you do not specify a parameter, that parameter's value reverts to its
    /// default
    /// value. See the **Request Parameters** section for each
    /// parameter's default value. Also note that some parameters do not allow the
    /// default
    /// parameter to be explicitly set. Instead, to invoke the default value, do not
    /// include
    /// that parameter when you invoke the operation.
    ///
    /// For more information about using a password policy, see [Managing an IAM
    /// password
    /// policy](https://docs.aws.amazon.com/IAM/latest/UserGuide/Using_ManagingPasswordPolicies.html) in the *IAM User Guide*.
    pub fn updateAccountPasswordPolicy(self: *Self, allocator: std.mem.Allocator, input: update_account_password_policy.UpdateAccountPasswordPolicyInput, options: update_account_password_policy.Options) !update_account_password_policy.UpdateAccountPasswordPolicyOutput {
        return update_account_password_policy.execute(self, allocator, input, options);
    }

    /// Updates the policy that grants an IAM entity permission to assume a role.
    /// This is
    /// typically referred to as the "role trust policy". For more information about
    /// roles, see
    /// [Using roles to
    /// delegate permissions and federate
    /// identities](https://docs.aws.amazon.com/IAM/latest/UserGuide/roles-toplevel.html).
    pub fn updateAssumeRolePolicy(self: *Self, allocator: std.mem.Allocator, input: update_assume_role_policy.UpdateAssumeRolePolicyInput, options: update_assume_role_policy.Options) !update_assume_role_policy.UpdateAssumeRolePolicyOutput {
        return update_assume_role_policy.execute(self, allocator, input, options);
    }

    /// Updates an existing delegation request with additional information. When the
    /// delegation
    /// request is updated, it reaches the `PENDING_APPROVAL` state.
    ///
    /// Once a delegation request has an owner, that owner gets a default permission
    /// to update the
    /// delegation request. For more details, see
    /// [
    /// Managing Permissions for Delegation
    /// Requests](https://docs.aws.amazon.com/IAM/latest/UserGuide/access_policies-temporary-delegation.html#temporary-delegation-managing-permissions).
    pub fn updateDelegationRequest(self: *Self, allocator: std.mem.Allocator, input: update_delegation_request.UpdateDelegationRequestInput, options: update_delegation_request.Options) !update_delegation_request.UpdateDelegationRequestOutput {
        return update_delegation_request.execute(self, allocator, input, options);
    }

    /// Updates the name and/or the path of the specified IAM group.
    ///
    /// You should understand the implications of changing a group's path or name.
    /// For
    /// more information, see [Renaming users and
    /// groups](https://docs.aws.amazon.com/IAM/latest/UserGuide/Using_WorkingWithGroupsAndUsers.html) in the *IAM User Guide*.
    ///
    /// The person making the request (the principal), must have permission to
    /// change the
    /// role group with the old name and the new name. For example, to change the
    /// group
    /// named `Managers` to `MGRs`, the principal must have a policy
    /// that allows them to update both groups. If the principal has permission to
    /// update
    /// the `Managers` group, but not the `MGRs` group, then the
    /// update fails. For more information about permissions, see [Access
    /// management](https://docs.aws.amazon.com/IAM/latest/UserGuide/access.html).
    pub fn updateGroup(self: *Self, allocator: std.mem.Allocator, input: update_group.UpdateGroupInput, options: update_group.Options) !update_group.UpdateGroupOutput {
        return update_group.execute(self, allocator, input, options);
    }

    /// Changes the password for the specified IAM user. You can use the CLI, the
    /// Amazon Web Services
    /// API, or the **Users** page in the IAM console to change
    /// the password for any IAM user. Use
    /// [ChangePassword](https://docs.aws.amazon.com/IAM/latest/APIReference/API_ChangePassword.html) to
    /// change your own password in the **My Security Credentials**
    /// page in the Amazon Web Services Management Console.
    ///
    /// For more information about modifying passwords, see [Managing
    /// passwords](https://docs.aws.amazon.com/IAM/latest/UserGuide/Using_ManagingLogins.html) in the
    /// *IAM User Guide*.
    pub fn updateLoginProfile(self: *Self, allocator: std.mem.Allocator, input: update_login_profile.UpdateLoginProfileInput, options: update_login_profile.Options) !update_login_profile.UpdateLoginProfileOutput {
        return update_login_profile.execute(self, allocator, input, options);
    }

    /// Replaces the existing list of server certificate thumbprints associated with
    /// an OpenID
    /// Connect (OIDC) provider resource object with a new list of thumbprints.
    ///
    /// The list that you pass with this operation completely replaces the existing
    /// list of
    /// thumbprints. (The lists are not merged.)
    ///
    /// Typically, you need to update a thumbprint only when the identity provider
    /// certificate
    /// changes, which occurs rarely. However, if the provider's certificate
    /// *does* change, any attempt to assume an IAM role that specifies
    /// the OIDC provider as a principal fails until the certificate thumbprint is
    /// updated.
    ///
    /// Amazon Web Services secures communication with OIDC identity providers
    /// (IdPs) using our library of
    /// trusted root certificate authorities (CAs) to verify the JSON Web Key Set
    /// (JWKS)
    /// endpoint's TLS certificate. If your OIDC IdP relies on a certificate that is
    /// not signed
    /// by one of these trusted CAs, only then we secure communication using the
    /// thumbprints set
    /// in the IdP's configuration.
    ///
    /// Trust for the OIDC provider is derived from the provider certificate and is
    /// validated by the thumbprint. Therefore, it is best to limit access to the
    /// `UpdateOpenIDConnectProviderThumbprint` operation to highly
    /// privileged users.
    pub fn updateOpenIdConnectProviderThumbprint(self: *Self, allocator: std.mem.Allocator, input: update_open_id_connect_provider_thumbprint.UpdateOpenIDConnectProviderThumbprintInput, options: update_open_id_connect_provider_thumbprint.Options) !update_open_id_connect_provider_thumbprint.UpdateOpenIDConnectProviderThumbprintOutput {
        return update_open_id_connect_provider_thumbprint.execute(self, allocator, input, options);
    }

    /// Updates the description or maximum session duration setting of a role.
    pub fn updateRole(self: *Self, allocator: std.mem.Allocator, input: update_role.UpdateRoleInput, options: update_role.Options) !update_role.UpdateRoleOutput {
        return update_role.execute(self, allocator, input, options);
    }

    /// Use
    /// [UpdateRole](https://docs.aws.amazon.com/IAM/latest/APIReference/API_UpdateRole.html) instead.
    ///
    /// Modifies only the description of a role. This operation performs the same
    /// function as
    /// the `Description` parameter in the `UpdateRole` operation.
    pub fn updateRoleDescription(self: *Self, allocator: std.mem.Allocator, input: update_role_description.UpdateRoleDescriptionInput, options: update_role_description.Options) !update_role_description.UpdateRoleDescriptionOutput {
        return update_role_description.execute(self, allocator, input, options);
    }

    /// Updates the metadata document, SAML encryption settings, and private keys
    /// for an
    /// existing SAML provider. To rotate private keys, add your new private key and
    /// then remove
    /// the old key in a separate request.
    pub fn updateSamlProvider(self: *Self, allocator: std.mem.Allocator, input: update_saml_provider.UpdateSAMLProviderInput, options: update_saml_provider.Options) !update_saml_provider.UpdateSAMLProviderOutput {
        return update_saml_provider.execute(self, allocator, input, options);
    }

    /// Updates the name and/or the path of the specified server certificate stored
    /// in
    /// IAM.
    ///
    /// For more information about working with server certificates, see [Working
    /// with server
    /// certificates](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_server-certs.html) in the *IAM User Guide*. This
    /// topic also includes a list of Amazon Web Services services that can use the
    /// server certificates that
    /// you manage with IAM.
    ///
    /// You should understand the implications of changing a server certificate's
    /// path or
    /// name. For more information, see [Renaming a server
    /// certificate](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_server-certs_manage.html#RenamingServerCerts) in the
    /// *IAM User Guide*.
    ///
    /// The person making the request (the principal), must have permission to
    /// change the
    /// server certificate with the old name and the new name. For example, to
    /// change the
    /// certificate named `ProductionCert` to `ProdCert`, the
    /// principal must have a policy that allows them to update both certificates.
    /// If the
    /// principal has permission to update the `ProductionCert` group, but not
    /// the `ProdCert` certificate, then the update fails. For more information
    /// about permissions, see [Access
    /// management](https://docs.aws.amazon.com/IAM/latest/UserGuide/access.html) in
    /// the *IAM User Guide*.
    pub fn updateServerCertificate(self: *Self, allocator: std.mem.Allocator, input: update_server_certificate.UpdateServerCertificateInput, options: update_server_certificate.Options) !update_server_certificate.UpdateServerCertificateOutput {
        return update_server_certificate.execute(self, allocator, input, options);
    }

    /// Sets the status of a service-specific credential to `Active` or
    /// `Inactive`. Service-specific credentials that are inactive cannot be used
    /// for authentication to the service. This operation can be used to disable a
    /// user's
    /// service-specific credential as part of a credential rotation work flow.
    pub fn updateServiceSpecificCredential(self: *Self, allocator: std.mem.Allocator, input: update_service_specific_credential.UpdateServiceSpecificCredentialInput, options: update_service_specific_credential.Options) !update_service_specific_credential.UpdateServiceSpecificCredentialOutput {
        return update_service_specific_credential.execute(self, allocator, input, options);
    }

    /// Changes the status of the specified user signing certificate from active to
    /// disabled,
    /// or vice versa. This operation can be used to disable an IAM user's signing
    /// certificate as part of a certificate rotation work flow.
    ///
    /// If the `UserName` field is not specified, the user name is determined
    /// implicitly based on the Amazon Web Services access key ID used to sign the
    /// request. This operation
    /// works for access keys under the Amazon Web Services account. Consequently,
    /// you can use this operation
    /// to manage Amazon Web Services account root user credentials even if the
    /// Amazon Web Services account has no associated
    /// users.
    pub fn updateSigningCertificate(self: *Self, allocator: std.mem.Allocator, input: update_signing_certificate.UpdateSigningCertificateInput, options: update_signing_certificate.Options) !update_signing_certificate.UpdateSigningCertificateOutput {
        return update_signing_certificate.execute(self, allocator, input, options);
    }

    /// Sets the status of an IAM user's SSH public key to active or inactive. SSH
    /// public
    /// keys that are inactive cannot be used for authentication. This operation can
    /// be used to
    /// disable a user's SSH public key as part of a key rotation work flow.
    ///
    /// The SSH public key affected by this operation is used only for
    /// authenticating the
    /// associated IAM user to an CodeCommit repository. For more information about
    /// using SSH keys
    /// to authenticate to an CodeCommit repository, see [Set up CodeCommit for
    /// SSH
    /// connections](https://docs.aws.amazon.com/codecommit/latest/userguide/setting-up-credentials-ssh.html) in the *CodeCommit User Guide*.
    pub fn updateSshPublicKey(self: *Self, allocator: std.mem.Allocator, input: update_ssh_public_key.UpdateSSHPublicKeyInput, options: update_ssh_public_key.Options) !update_ssh_public_key.UpdateSSHPublicKeyOutput {
        return update_ssh_public_key.execute(self, allocator, input, options);
    }

    /// Updates the name and/or the path of the specified IAM user.
    ///
    /// You should understand the implications of changing an IAM user's path or
    /// name. For more information, see [Renaming an IAM
    /// user](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_users_manage.html#id_users_renaming) and [Renaming an IAM
    /// group](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_groups_manage_rename.html) in the *IAM User Guide*.
    ///
    /// To change a user name, the requester must have appropriate permissions on
    /// both
    /// the source object and the target object. For example, to change Bob to
    /// Robert, the
    /// entity making the request must have permission on Bob and Robert, or must
    /// have
    /// permission on all (*). For more information about permissions, see
    /// [Permissions and
    /// policies](https://docs.aws.amazon.com/IAM/latest/UserGuide/PermissionsAndPolicies.html).
    pub fn updateUser(self: *Self, allocator: std.mem.Allocator, input: update_user.UpdateUserInput, options: update_user.Options) !update_user.UpdateUserOutput {
        return update_user.execute(self, allocator, input, options);
    }

    /// Uploads a server certificate entity for the Amazon Web Services account. The
    /// server certificate
    /// entity includes a public key certificate, a private key, and an optional
    /// certificate
    /// chain, which should all be PEM-encoded.
    ///
    /// We recommend that you use [Certificate
    /// Manager](https://docs.aws.amazon.com/acm/) to
    /// provision, manage, and deploy your server certificates. With ACM you can
    /// request a
    /// certificate, deploy it to Amazon Web Services resources, and let ACM handle
    /// certificate renewals for
    /// you. Certificates provided by ACM are free. For more information about using
    /// ACM,
    /// see the [Certificate Manager User
    /// Guide](https://docs.aws.amazon.com/acm/latest/userguide/).
    ///
    /// For more information about working with server certificates, see [Working
    /// with server
    /// certificates](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_server-certs.html) in the *IAM User Guide*. This
    /// topic includes a list of Amazon Web Services services that can use the
    /// server certificates that you
    /// manage with IAM.
    ///
    /// For information about the number of server certificates you can upload, see
    /// [IAM and STS
    /// quotas](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_iam-quotas.html) in the *IAM User Guide*.
    ///
    /// Because the body of the public key certificate, private key, and the
    /// certificate
    /// chain can be large, you should use POST rather than GET when calling
    /// `UploadServerCertificate`. For information about setting up
    /// signatures and authorization through the API, see [Signing Amazon Web
    /// Services API
    /// requests](https://docs.aws.amazon.com/general/latest/gr/signing_aws_api_requests.html) in the *Amazon Web Services General Reference*. For general
    /// information about using the Query API with IAM, see [Calling the API by
    /// making HTTP query
    /// requests](https://docs.aws.amazon.com/IAM/latest/UserGuide/programming.html)
    /// in the *IAM User Guide*.
    pub fn uploadServerCertificate(self: *Self, allocator: std.mem.Allocator, input: upload_server_certificate.UploadServerCertificateInput, options: upload_server_certificate.Options) !upload_server_certificate.UploadServerCertificateOutput {
        return upload_server_certificate.execute(self, allocator, input, options);
    }

    /// Uploads an X.509 signing certificate and associates it with the specified
    /// IAM user.
    /// Some Amazon Web Services services require you to use certificates to
    /// validate requests that are signed
    /// with a corresponding private key. When you upload the certificate, its
    /// default status is
    /// `Active`.
    ///
    /// For information about when you would use an X.509 signing certificate, see
    /// [Managing
    /// server certificates in
    /// IAM](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_server-certs.html) in the
    /// *IAM User Guide*.
    ///
    /// If the `UserName` is not specified, the IAM user name is determined
    /// implicitly based on the Amazon Web Services access key ID used to sign the
    /// request. This operation
    /// works for access keys under the Amazon Web Services account. Consequently,
    /// you can use this operation
    /// to manage Amazon Web Services account root user credentials even if the
    /// Amazon Web Services account has no associated
    /// users.
    ///
    /// Because the body of an X.509 certificate can be large, you should use POST
    /// rather
    /// than GET when calling `UploadSigningCertificate`. For information about
    /// setting up signatures and authorization through the API, see [Signing
    /// Amazon Web Services API
    /// requests](https://docs.aws.amazon.com/general/latest/gr/signing_aws_api_requests.html) in the *Amazon Web Services General Reference*. For
    /// general information about using the Query API with IAM, see [Making query
    /// requests](https://docs.aws.amazon.com/IAM/latest/UserGuide/IAM_UsingQueryAPI.html) in the *IAM User Guide*.
    pub fn uploadSigningCertificate(self: *Self, allocator: std.mem.Allocator, input: upload_signing_certificate.UploadSigningCertificateInput, options: upload_signing_certificate.Options) !upload_signing_certificate.UploadSigningCertificateOutput {
        return upload_signing_certificate.execute(self, allocator, input, options);
    }

    /// Uploads an SSH public key and associates it with the specified IAM user.
    ///
    /// The SSH public key uploaded by this operation can be used only for
    /// authenticating the
    /// associated IAM user to an CodeCommit repository. For more information about
    /// using SSH keys
    /// to authenticate to an CodeCommit repository, see [Set up CodeCommit for
    /// SSH
    /// connections](https://docs.aws.amazon.com/codecommit/latest/userguide/setting-up-credentials-ssh.html) in the *CodeCommit User Guide*.
    pub fn uploadSshPublicKey(self: *Self, allocator: std.mem.Allocator, input: upload_ssh_public_key.UploadSSHPublicKeyInput, options: upload_ssh_public_key.Options) !upload_ssh_public_key.UploadSSHPublicKeyOutput {
        return upload_ssh_public_key.execute(self, allocator, input, options);
    }

    pub fn getAccountAuthorizationDetailsPaginator(self: *Self, params: get_account_authorization_details.GetAccountAuthorizationDetailsInput) paginator.GetAccountAuthorizationDetailsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn getGroupPaginator(self: *Self, params: get_group.GetGroupInput) paginator.GetGroupPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listAccessKeysPaginator(self: *Self, params: list_access_keys.ListAccessKeysInput) paginator.ListAccessKeysPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listAccountAliasesPaginator(self: *Self, params: list_account_aliases.ListAccountAliasesInput) paginator.ListAccountAliasesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listAttachedGroupPoliciesPaginator(self: *Self, params: list_attached_group_policies.ListAttachedGroupPoliciesInput) paginator.ListAttachedGroupPoliciesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listAttachedRolePoliciesPaginator(self: *Self, params: list_attached_role_policies.ListAttachedRolePoliciesInput) paginator.ListAttachedRolePoliciesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listAttachedUserPoliciesPaginator(self: *Self, params: list_attached_user_policies.ListAttachedUserPoliciesInput) paginator.ListAttachedUserPoliciesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listEntitiesForPolicyPaginator(self: *Self, params: list_entities_for_policy.ListEntitiesForPolicyInput) paginator.ListEntitiesForPolicyPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listGroupPoliciesPaginator(self: *Self, params: list_group_policies.ListGroupPoliciesInput) paginator.ListGroupPoliciesPaginator {
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

    pub fn listGroupsForUserPaginator(self: *Self, params: list_groups_for_user.ListGroupsForUserInput) paginator.ListGroupsForUserPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listInstanceProfileTagsPaginator(self: *Self, params: list_instance_profile_tags.ListInstanceProfileTagsInput) paginator.ListInstanceProfileTagsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listInstanceProfilesPaginator(self: *Self, params: list_instance_profiles.ListInstanceProfilesInput) paginator.ListInstanceProfilesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listInstanceProfilesForRolePaginator(self: *Self, params: list_instance_profiles_for_role.ListInstanceProfilesForRoleInput) paginator.ListInstanceProfilesForRolePaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listMfaDeviceTagsPaginator(self: *Self, params: list_mfa_device_tags.ListMFADeviceTagsInput) paginator.ListMFADeviceTagsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listMfaDevicesPaginator(self: *Self, params: list_mfa_devices.ListMFADevicesInput) paginator.ListMFADevicesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listOpenIdConnectProviderTagsPaginator(self: *Self, params: list_open_id_connect_provider_tags.ListOpenIDConnectProviderTagsInput) paginator.ListOpenIDConnectProviderTagsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listPoliciesPaginator(self: *Self, params: list_policies.ListPoliciesInput) paginator.ListPoliciesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listPolicyTagsPaginator(self: *Self, params: list_policy_tags.ListPolicyTagsInput) paginator.ListPolicyTagsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listPolicyVersionsPaginator(self: *Self, params: list_policy_versions.ListPolicyVersionsInput) paginator.ListPolicyVersionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listRolePoliciesPaginator(self: *Self, params: list_role_policies.ListRolePoliciesInput) paginator.ListRolePoliciesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listRoleTagsPaginator(self: *Self, params: list_role_tags.ListRoleTagsInput) paginator.ListRoleTagsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listRolesPaginator(self: *Self, params: list_roles.ListRolesInput) paginator.ListRolesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listSamlProviderTagsPaginator(self: *Self, params: list_saml_provider_tags.ListSAMLProviderTagsInput) paginator.ListSAMLProviderTagsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listServerCertificateTagsPaginator(self: *Self, params: list_server_certificate_tags.ListServerCertificateTagsInput) paginator.ListServerCertificateTagsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listServerCertificatesPaginator(self: *Self, params: list_server_certificates.ListServerCertificatesInput) paginator.ListServerCertificatesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listSigningCertificatesPaginator(self: *Self, params: list_signing_certificates.ListSigningCertificatesInput) paginator.ListSigningCertificatesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listSshPublicKeysPaginator(self: *Self, params: list_ssh_public_keys.ListSSHPublicKeysInput) paginator.ListSSHPublicKeysPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listUserPoliciesPaginator(self: *Self, params: list_user_policies.ListUserPoliciesInput) paginator.ListUserPoliciesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listUserTagsPaginator(self: *Self, params: list_user_tags.ListUserTagsInput) paginator.ListUserTagsPaginator {
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

    pub fn listVirtualMfaDevicesPaginator(self: *Self, params: list_virtual_mfa_devices.ListVirtualMFADevicesInput) paginator.ListVirtualMFADevicesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn simulateCustomPolicyPaginator(self: *Self, params: simulate_custom_policy.SimulateCustomPolicyInput) paginator.SimulateCustomPolicyPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn simulatePrincipalPolicyPaginator(self: *Self, params: simulate_principal_policy.SimulatePrincipalPolicyInput) paginator.SimulatePrincipalPolicyPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn waitUntilInstanceProfileExists(self: *Self, params: get_instance_profile.GetInstanceProfileInput) aws.waiter.WaiterError!void {
        var w = waiters.InstanceProfileExistsWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilPolicyExists(self: *Self, params: get_policy.GetPolicyInput) aws.waiter.WaiterError!void {
        var w = waiters.PolicyExistsWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilRoleExists(self: *Self, params: get_role.GetRoleInput) aws.waiter.WaiterError!void {
        var w = waiters.RoleExistsWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilUserExists(self: *Self, params: get_user.GetUserInput) aws.waiter.WaiterError!void {
        var w = waiters.UserExistsWaiter{ .client = self, .params = params };
        return w.wait();
    }
};
