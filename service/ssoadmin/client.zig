const aws = @import("aws");
const std = @import("std");

const add_region = @import("add_region.zig");
const attach_customer_managed_policy_reference_to_permission_set = @import("attach_customer_managed_policy_reference_to_permission_set.zig");
const attach_managed_policy_to_permission_set = @import("attach_managed_policy_to_permission_set.zig");
const create_account_assignment = @import("create_account_assignment.zig");
const create_application = @import("create_application.zig");
const create_application_assignment = @import("create_application_assignment.zig");
const create_instance = @import("create_instance.zig");
const create_instance_access_control_attribute_configuration = @import("create_instance_access_control_attribute_configuration.zig");
const create_permission_set = @import("create_permission_set.zig");
const create_trusted_token_issuer = @import("create_trusted_token_issuer.zig");
const delete_account_assignment = @import("delete_account_assignment.zig");
const delete_application = @import("delete_application.zig");
const delete_application_access_scope = @import("delete_application_access_scope.zig");
const delete_application_assignment = @import("delete_application_assignment.zig");
const delete_application_authentication_method = @import("delete_application_authentication_method.zig");
const delete_application_grant = @import("delete_application_grant.zig");
const delete_inline_policy_from_permission_set = @import("delete_inline_policy_from_permission_set.zig");
const delete_instance = @import("delete_instance.zig");
const delete_instance_access_control_attribute_configuration = @import("delete_instance_access_control_attribute_configuration.zig");
const delete_permission_set = @import("delete_permission_set.zig");
const delete_permissions_boundary_from_permission_set = @import("delete_permissions_boundary_from_permission_set.zig");
const delete_trusted_token_issuer = @import("delete_trusted_token_issuer.zig");
const describe_account_assignment_creation_status = @import("describe_account_assignment_creation_status.zig");
const describe_account_assignment_deletion_status = @import("describe_account_assignment_deletion_status.zig");
const describe_application = @import("describe_application.zig");
const describe_application_assignment = @import("describe_application_assignment.zig");
const describe_application_provider = @import("describe_application_provider.zig");
const describe_instance = @import("describe_instance.zig");
const describe_instance_access_control_attribute_configuration = @import("describe_instance_access_control_attribute_configuration.zig");
const describe_permission_set = @import("describe_permission_set.zig");
const describe_permission_set_provisioning_status = @import("describe_permission_set_provisioning_status.zig");
const describe_region = @import("describe_region.zig");
const describe_trusted_token_issuer = @import("describe_trusted_token_issuer.zig");
const detach_customer_managed_policy_reference_from_permission_set = @import("detach_customer_managed_policy_reference_from_permission_set.zig");
const detach_managed_policy_from_permission_set = @import("detach_managed_policy_from_permission_set.zig");
const get_application_access_scope = @import("get_application_access_scope.zig");
const get_application_assignment_configuration = @import("get_application_assignment_configuration.zig");
const get_application_authentication_method = @import("get_application_authentication_method.zig");
const get_application_grant = @import("get_application_grant.zig");
const get_application_session_configuration = @import("get_application_session_configuration.zig");
const get_inline_policy_for_permission_set = @import("get_inline_policy_for_permission_set.zig");
const get_permissions_boundary_for_permission_set = @import("get_permissions_boundary_for_permission_set.zig");
const list_account_assignment_creation_status = @import("list_account_assignment_creation_status.zig");
const list_account_assignment_deletion_status = @import("list_account_assignment_deletion_status.zig");
const list_account_assignments = @import("list_account_assignments.zig");
const list_account_assignments_for_principal = @import("list_account_assignments_for_principal.zig");
const list_accounts_for_provisioned_permission_set = @import("list_accounts_for_provisioned_permission_set.zig");
const list_application_access_scopes = @import("list_application_access_scopes.zig");
const list_application_assignments = @import("list_application_assignments.zig");
const list_application_assignments_for_principal = @import("list_application_assignments_for_principal.zig");
const list_application_authentication_methods = @import("list_application_authentication_methods.zig");
const list_application_grants = @import("list_application_grants.zig");
const list_application_providers = @import("list_application_providers.zig");
const list_applications = @import("list_applications.zig");
const list_customer_managed_policy_references_in_permission_set = @import("list_customer_managed_policy_references_in_permission_set.zig");
const list_instances = @import("list_instances.zig");
const list_managed_policies_in_permission_set = @import("list_managed_policies_in_permission_set.zig");
const list_permission_set_provisioning_status = @import("list_permission_set_provisioning_status.zig");
const list_permission_sets = @import("list_permission_sets.zig");
const list_permission_sets_provisioned_to_account = @import("list_permission_sets_provisioned_to_account.zig");
const list_regions = @import("list_regions.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const list_trusted_token_issuers = @import("list_trusted_token_issuers.zig");
const provision_permission_set = @import("provision_permission_set.zig");
const put_application_access_scope = @import("put_application_access_scope.zig");
const put_application_assignment_configuration = @import("put_application_assignment_configuration.zig");
const put_application_authentication_method = @import("put_application_authentication_method.zig");
const put_application_grant = @import("put_application_grant.zig");
const put_application_session_configuration = @import("put_application_session_configuration.zig");
const put_inline_policy_to_permission_set = @import("put_inline_policy_to_permission_set.zig");
const put_permissions_boundary_to_permission_set = @import("put_permissions_boundary_to_permission_set.zig");
const remove_region = @import("remove_region.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_application = @import("update_application.zig");
const update_instance = @import("update_instance.zig");
const update_instance_access_control_attribute_configuration = @import("update_instance_access_control_attribute_configuration.zig");
const update_permission_set = @import("update_permission_set.zig");
const update_trusted_token_issuer = @import("update_trusted_token_issuer.zig");
const CallOptions = @import("call_options.zig").CallOptions;
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "SSO Admin";

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

    /// Adds a Region to an IAM Identity Center instance. This operation initiates
    /// an asynchronous workflow to replicate the IAM Identity Center instance to
    /// the target Region. The Region status is set to ADDING at first and changes
    /// to ACTIVE when the workflow completes.
    ///
    /// To use this operation, your IAM Identity Center instance and the target
    /// Region must meet the requirements described in the [IAM Identity Center User
    /// Guide](https://docs.aws.amazon.com/singlesignon/latest/userguide/multi-region-iam-identity-center.html#multi-region-prerequisites).
    ///
    /// The following actions are related to `AddRegion`:
    ///
    /// *
    ///   [RemoveRegion](https://docs.aws.amazon.com/singlesignon/latest/APIReference/API_RemoveRegion.html)
    /// *
    ///   [DescribeRegion](https://docs.aws.amazon.com/singlesignon/latest/APIReference/API_DescribeRegion.html)
    /// *
    ///   [ListRegions](https://docs.aws.amazon.com/singlesignon/latest/APIReference/API_ListRegions.html)
    pub fn addRegion(self: *Self, allocator: std.mem.Allocator, input: add_region.AddRegionInput, options: CallOptions) !add_region.AddRegionOutput {
        return add_region.execute(self, allocator, input, options);
    }

    /// Attaches the specified customer managed policy to the specified
    /// PermissionSet.
    pub fn attachCustomerManagedPolicyReferenceToPermissionSet(self: *Self, allocator: std.mem.Allocator, input: attach_customer_managed_policy_reference_to_permission_set.AttachCustomerManagedPolicyReferenceToPermissionSetInput, options: CallOptions) !attach_customer_managed_policy_reference_to_permission_set.AttachCustomerManagedPolicyReferenceToPermissionSetOutput {
        return attach_customer_managed_policy_reference_to_permission_set.execute(self, allocator, input, options);
    }

    /// Attaches an Amazon Web Services managed policy ARN to a permission set.
    ///
    /// If the permission set is already referenced by one or more account
    /// assignments, you will need to call ` ProvisionPermissionSet ` after this
    /// operation. Calling `ProvisionPermissionSet` applies the corresponding IAM
    /// policy updates to all assigned accounts.
    pub fn attachManagedPolicyToPermissionSet(self: *Self, allocator: std.mem.Allocator, input: attach_managed_policy_to_permission_set.AttachManagedPolicyToPermissionSetInput, options: CallOptions) !attach_managed_policy_to_permission_set.AttachManagedPolicyToPermissionSetOutput {
        return attach_managed_policy_to_permission_set.execute(self, allocator, input, options);
    }

    /// Assigns access to a principal for a specified Amazon Web Services account
    /// using a specified permission set.
    ///
    /// The term *principal* here refers to a user or group that is defined in IAM
    /// Identity Center.
    ///
    /// As part of a successful `CreateAccountAssignment` call, the specified
    /// permission set will automatically be provisioned to the account in the form
    /// of an IAM policy. That policy is attached to the IAM role created in IAM
    /// Identity Center. If the permission set is subsequently updated, the
    /// corresponding IAM policies attached to roles in your accounts will not be
    /// updated automatically. In this case, you must call ` ProvisionPermissionSet
    /// ` to make these updates.
    ///
    /// After a successful response, call `DescribeAccountAssignmentCreationStatus`
    /// to describe the status of an assignment creation request.
    pub fn createAccountAssignment(self: *Self, allocator: std.mem.Allocator, input: create_account_assignment.CreateAccountAssignmentInput, options: CallOptions) !create_account_assignment.CreateAccountAssignmentOutput {
        return create_account_assignment.execute(self, allocator, input, options);
    }

    /// Creates an OAuth 2.0 customer managed application in IAM Identity Center for
    /// the given application provider.
    ///
    /// This API does not support creating SAML 2.0 customer managed applications or
    /// Amazon Web Services managed applications. To learn how to create an Amazon
    /// Web Services managed application, see the application user guide. You can
    /// create a SAML 2.0 customer managed application in the Amazon Web Services
    /// Management Console only. See [Setting up customer managed SAML 2.0
    /// applications](https://docs.aws.amazon.com/singlesignon/latest/userguide/customermanagedapps-saml2-setup.html). For more information on these application types, see [Amazon Web Services managed applications](https://docs.aws.amazon.com/singlesignon/latest/userguide/awsapps.html).
    pub fn createApplication(self: *Self, allocator: std.mem.Allocator, input: create_application.CreateApplicationInput, options: CallOptions) !create_application.CreateApplicationOutput {
        return create_application.execute(self, allocator, input, options);
    }

    /// Grant application access to a user or group.
    pub fn createApplicationAssignment(self: *Self, allocator: std.mem.Allocator, input: create_application_assignment.CreateApplicationAssignmentInput, options: CallOptions) !create_application_assignment.CreateApplicationAssignmentOutput {
        return create_application_assignment.execute(self, allocator, input, options);
    }

    /// Creates an instance of IAM Identity Center for a standalone Amazon Web
    /// Services account that is not managed by Organizations or a member Amazon Web
    /// Services account in an organization. You can create only one instance per
    /// account and across all Amazon Web Services Regions.
    ///
    /// The CreateInstance request is rejected if the following apply:
    ///
    /// * The instance is created within the organization management account.
    /// * An instance already exists in the same account.
    pub fn createInstance(self: *Self, allocator: std.mem.Allocator, input: create_instance.CreateInstanceInput, options: CallOptions) !create_instance.CreateInstanceOutput {
        return create_instance.execute(self, allocator, input, options);
    }

    /// Enables the attributes-based access control (ABAC) feature for the specified
    /// IAM Identity Center instance. You can also specify new attributes to add to
    /// your ABAC configuration during the enabling process. For more information
    /// about ABAC, see [Attribute-Based Access
    /// Control](/singlesignon/latest/userguide/abac.html) in the *IAM Identity
    /// Center User Guide*.
    ///
    /// After a successful response, call
    /// `DescribeInstanceAccessControlAttributeConfiguration` to validate that
    /// `InstanceAccessControlAttributeConfiguration` was created.
    pub fn createInstanceAccessControlAttributeConfiguration(self: *Self, allocator: std.mem.Allocator, input: create_instance_access_control_attribute_configuration.CreateInstanceAccessControlAttributeConfigurationInput, options: CallOptions) !create_instance_access_control_attribute_configuration.CreateInstanceAccessControlAttributeConfigurationOutput {
        return create_instance_access_control_attribute_configuration.execute(self, allocator, input, options);
    }

    /// Creates a permission set within a specified IAM Identity Center instance.
    ///
    /// To grant users and groups access to Amazon Web Services account resources,
    /// use ` CreateAccountAssignment `.
    pub fn createPermissionSet(self: *Self, allocator: std.mem.Allocator, input: create_permission_set.CreatePermissionSetInput, options: CallOptions) !create_permission_set.CreatePermissionSetOutput {
        return create_permission_set.execute(self, allocator, input, options);
    }

    /// Creates a connection to a trusted token issuer in an instance of IAM
    /// Identity Center. A trusted token issuer enables trusted identity propagation
    /// to be used with applications that authenticate outside of Amazon Web
    /// Services.
    ///
    /// This trusted token issuer describes an external identity provider (IdP) that
    /// can generate claims or assertions in the form of access tokens for a user.
    /// Applications enabled for IAM Identity Center can use these tokens for
    /// authentication.
    pub fn createTrustedTokenIssuer(self: *Self, allocator: std.mem.Allocator, input: create_trusted_token_issuer.CreateTrustedTokenIssuerInput, options: CallOptions) !create_trusted_token_issuer.CreateTrustedTokenIssuerOutput {
        return create_trusted_token_issuer.execute(self, allocator, input, options);
    }

    /// Deletes a principal's access from a specified Amazon Web Services account
    /// using a specified permission set.
    ///
    /// After a successful response, call `DescribeAccountAssignmentDeletionStatus`
    /// to describe the status of an assignment deletion request.
    pub fn deleteAccountAssignment(self: *Self, allocator: std.mem.Allocator, input: delete_account_assignment.DeleteAccountAssignmentInput, options: CallOptions) !delete_account_assignment.DeleteAccountAssignmentOutput {
        return delete_account_assignment.execute(self, allocator, input, options);
    }

    /// Deletes the association with the application. The connected service resource
    /// still exists.
    pub fn deleteApplication(self: *Self, allocator: std.mem.Allocator, input: delete_application.DeleteApplicationInput, options: CallOptions) !delete_application.DeleteApplicationOutput {
        return delete_application.execute(self, allocator, input, options);
    }

    /// Deletes an IAM Identity Center access scope from an application.
    pub fn deleteApplicationAccessScope(self: *Self, allocator: std.mem.Allocator, input: delete_application_access_scope.DeleteApplicationAccessScopeInput, options: CallOptions) !delete_application_access_scope.DeleteApplicationAccessScopeOutput {
        return delete_application_access_scope.execute(self, allocator, input, options);
    }

    /// Revoke application access to an application by deleting application
    /// assignments for a user or group.
    pub fn deleteApplicationAssignment(self: *Self, allocator: std.mem.Allocator, input: delete_application_assignment.DeleteApplicationAssignmentInput, options: CallOptions) !delete_application_assignment.DeleteApplicationAssignmentOutput {
        return delete_application_assignment.execute(self, allocator, input, options);
    }

    /// Deletes an authentication method from an application.
    pub fn deleteApplicationAuthenticationMethod(self: *Self, allocator: std.mem.Allocator, input: delete_application_authentication_method.DeleteApplicationAuthenticationMethodInput, options: CallOptions) !delete_application_authentication_method.DeleteApplicationAuthenticationMethodOutput {
        return delete_application_authentication_method.execute(self, allocator, input, options);
    }

    /// Deletes a grant from an application.
    pub fn deleteApplicationGrant(self: *Self, allocator: std.mem.Allocator, input: delete_application_grant.DeleteApplicationGrantInput, options: CallOptions) !delete_application_grant.DeleteApplicationGrantOutput {
        return delete_application_grant.execute(self, allocator, input, options);
    }

    /// Deletes the inline policy from a specified permission set.
    pub fn deleteInlinePolicyFromPermissionSet(self: *Self, allocator: std.mem.Allocator, input: delete_inline_policy_from_permission_set.DeleteInlinePolicyFromPermissionSetInput, options: CallOptions) !delete_inline_policy_from_permission_set.DeleteInlinePolicyFromPermissionSetOutput {
        return delete_inline_policy_from_permission_set.execute(self, allocator, input, options);
    }

    /// Deletes the instance of IAM Identity Center. Only the account that owns the
    /// instance can call this API. Neither the delegated administrator nor member
    /// account can delete the organization instance, but those roles can delete
    /// their own instance.
    pub fn deleteInstance(self: *Self, allocator: std.mem.Allocator, input: delete_instance.DeleteInstanceInput, options: CallOptions) !delete_instance.DeleteInstanceOutput {
        return delete_instance.execute(self, allocator, input, options);
    }

    /// Disables the attributes-based access control (ABAC) feature for the
    /// specified IAM Identity Center instance and deletes all of the attribute
    /// mappings that have been configured. Once deleted, any attributes that are
    /// received from an identity source and any custom attributes you have
    /// previously configured will not be passed. For more information about ABAC,
    /// see [Attribute-Based Access
    /// Control](/singlesignon/latest/userguide/abac.html) in the *IAM Identity
    /// Center User Guide*.
    pub fn deleteInstanceAccessControlAttributeConfiguration(self: *Self, allocator: std.mem.Allocator, input: delete_instance_access_control_attribute_configuration.DeleteInstanceAccessControlAttributeConfigurationInput, options: CallOptions) !delete_instance_access_control_attribute_configuration.DeleteInstanceAccessControlAttributeConfigurationOutput {
        return delete_instance_access_control_attribute_configuration.execute(self, allocator, input, options);
    }

    /// Deletes the specified permission set.
    pub fn deletePermissionSet(self: *Self, allocator: std.mem.Allocator, input: delete_permission_set.DeletePermissionSetInput, options: CallOptions) !delete_permission_set.DeletePermissionSetOutput {
        return delete_permission_set.execute(self, allocator, input, options);
    }

    /// Deletes the permissions boundary from a specified PermissionSet.
    pub fn deletePermissionsBoundaryFromPermissionSet(self: *Self, allocator: std.mem.Allocator, input: delete_permissions_boundary_from_permission_set.DeletePermissionsBoundaryFromPermissionSetInput, options: CallOptions) !delete_permissions_boundary_from_permission_set.DeletePermissionsBoundaryFromPermissionSetOutput {
        return delete_permissions_boundary_from_permission_set.execute(self, allocator, input, options);
    }

    /// Deletes a trusted token issuer configuration from an instance of IAM
    /// Identity Center.
    ///
    /// Deleting this trusted token issuer configuration will cause users to lose
    /// access to any applications that are configured to use the trusted token
    /// issuer.
    pub fn deleteTrustedTokenIssuer(self: *Self, allocator: std.mem.Allocator, input: delete_trusted_token_issuer.DeleteTrustedTokenIssuerInput, options: CallOptions) !delete_trusted_token_issuer.DeleteTrustedTokenIssuerOutput {
        return delete_trusted_token_issuer.execute(self, allocator, input, options);
    }

    /// Describes the status of the assignment creation request.
    pub fn describeAccountAssignmentCreationStatus(self: *Self, allocator: std.mem.Allocator, input: describe_account_assignment_creation_status.DescribeAccountAssignmentCreationStatusInput, options: CallOptions) !describe_account_assignment_creation_status.DescribeAccountAssignmentCreationStatusOutput {
        return describe_account_assignment_creation_status.execute(self, allocator, input, options);
    }

    /// Describes the status of the assignment deletion request.
    pub fn describeAccountAssignmentDeletionStatus(self: *Self, allocator: std.mem.Allocator, input: describe_account_assignment_deletion_status.DescribeAccountAssignmentDeletionStatusInput, options: CallOptions) !describe_account_assignment_deletion_status.DescribeAccountAssignmentDeletionStatusOutput {
        return describe_account_assignment_deletion_status.execute(self, allocator, input, options);
    }

    /// Retrieves the details of an application associated with an instance of IAM
    /// Identity Center.
    pub fn describeApplication(self: *Self, allocator: std.mem.Allocator, input: describe_application.DescribeApplicationInput, options: CallOptions) !describe_application.DescribeApplicationOutput {
        return describe_application.execute(self, allocator, input, options);
    }

    /// Retrieves a direct assignment of a user or group to an application. If the
    /// user doesn’t have a direct assignment to the application, the user may still
    /// have access to the application through a group. Therefore, don’t use this
    /// API to test access to an application for a user. Instead use
    /// ListApplicationAssignmentsForPrincipal.
    pub fn describeApplicationAssignment(self: *Self, allocator: std.mem.Allocator, input: describe_application_assignment.DescribeApplicationAssignmentInput, options: CallOptions) !describe_application_assignment.DescribeApplicationAssignmentOutput {
        return describe_application_assignment.execute(self, allocator, input, options);
    }

    /// Retrieves details about a provider that can be used to connect an Amazon Web
    /// Services managed application or customer managed application to IAM Identity
    /// Center.
    pub fn describeApplicationProvider(self: *Self, allocator: std.mem.Allocator, input: describe_application_provider.DescribeApplicationProviderInput, options: CallOptions) !describe_application_provider.DescribeApplicationProviderOutput {
        return describe_application_provider.execute(self, allocator, input, options);
    }

    /// Returns the details of an instance of IAM Identity Center. The status can be
    /// one of the following:
    ///
    /// * `CREATE_IN_PROGRESS` - The instance is in the process of being created.
    ///   When the instance is ready for use, DescribeInstance returns the status of
    ///   `ACTIVE`. While the instance is in the `CREATE_IN_PROGRESS` state, you can
    ///   call only DescribeInstance and DeleteInstance operations.
    /// * `DELETE_IN_PROGRESS` - The instance is being deleted. Returns
    ///   `AccessDeniedException` after the delete operation completes.
    /// * `ACTIVE` - The instance is active.
    pub fn describeInstance(self: *Self, allocator: std.mem.Allocator, input: describe_instance.DescribeInstanceInput, options: CallOptions) !describe_instance.DescribeInstanceOutput {
        return describe_instance.execute(self, allocator, input, options);
    }

    /// Returns the list of IAM Identity Center identity store attributes that have
    /// been configured to work with attributes-based access control (ABAC) for the
    /// specified IAM Identity Center instance. This will not return attributes
    /// configured and sent by an external identity provider. For more information
    /// about ABAC, see [Attribute-Based Access
    /// Control](/singlesignon/latest/userguide/abac.html) in the *IAM Identity
    /// Center User Guide*.
    pub fn describeInstanceAccessControlAttributeConfiguration(self: *Self, allocator: std.mem.Allocator, input: describe_instance_access_control_attribute_configuration.DescribeInstanceAccessControlAttributeConfigurationInput, options: CallOptions) !describe_instance_access_control_attribute_configuration.DescribeInstanceAccessControlAttributeConfigurationOutput {
        return describe_instance_access_control_attribute_configuration.execute(self, allocator, input, options);
    }

    /// Gets the details of the permission set.
    pub fn describePermissionSet(self: *Self, allocator: std.mem.Allocator, input: describe_permission_set.DescribePermissionSetInput, options: CallOptions) !describe_permission_set.DescribePermissionSetOutput {
        return describe_permission_set.execute(self, allocator, input, options);
    }

    /// Describes the status for the given permission set provisioning request.
    pub fn describePermissionSetProvisioningStatus(self: *Self, allocator: std.mem.Allocator, input: describe_permission_set_provisioning_status.DescribePermissionSetProvisioningStatusInput, options: CallOptions) !describe_permission_set_provisioning_status.DescribePermissionSetProvisioningStatusOutput {
        return describe_permission_set_provisioning_status.execute(self, allocator, input, options);
    }

    /// Retrieves details about a specific Region enabled in an IAM Identity Center
    /// instance. Details include the Region name, current status (ACTIVE, ADDING,
    /// or REMOVING), the date when the Region was added, and whether it is the
    /// primary Region. The request must be made from one of the enabled Regions of
    /// the IAM Identity Center instance.
    ///
    /// The following actions are related to `DescribeRegion`:
    ///
    /// * [
    ///   AddRegion](https://docs.aws.amazon.com/singlesignon/latest/APIReference/API_AddRegion.html)
    /// *
    ///   [RemoveRegion](https://docs.aws.amazon.com/singlesignon/latest/APIReference/API_RemoveRegion.html)
    /// *
    ///   [ListRegions](https://docs.aws.amazon.com/singlesignon/latest/APIReference/API_ListRegions.html)
    pub fn describeRegion(self: *Self, allocator: std.mem.Allocator, input: describe_region.DescribeRegionInput, options: CallOptions) !describe_region.DescribeRegionOutput {
        return describe_region.execute(self, allocator, input, options);
    }

    /// Retrieves details about a trusted token issuer configuration stored in an
    /// instance of IAM Identity Center. Details include the name of the trusted
    /// token issuer, the issuer URL, and the path of the source attribute and the
    /// destination attribute for a trusted token issuer configuration.
    pub fn describeTrustedTokenIssuer(self: *Self, allocator: std.mem.Allocator, input: describe_trusted_token_issuer.DescribeTrustedTokenIssuerInput, options: CallOptions) !describe_trusted_token_issuer.DescribeTrustedTokenIssuerOutput {
        return describe_trusted_token_issuer.execute(self, allocator, input, options);
    }

    /// Detaches the specified customer managed policy from the specified
    /// PermissionSet.
    pub fn detachCustomerManagedPolicyReferenceFromPermissionSet(self: *Self, allocator: std.mem.Allocator, input: detach_customer_managed_policy_reference_from_permission_set.DetachCustomerManagedPolicyReferenceFromPermissionSetInput, options: CallOptions) !detach_customer_managed_policy_reference_from_permission_set.DetachCustomerManagedPolicyReferenceFromPermissionSetOutput {
        return detach_customer_managed_policy_reference_from_permission_set.execute(self, allocator, input, options);
    }

    /// Detaches the attached Amazon Web Services managed policy ARN from the
    /// specified permission set.
    pub fn detachManagedPolicyFromPermissionSet(self: *Self, allocator: std.mem.Allocator, input: detach_managed_policy_from_permission_set.DetachManagedPolicyFromPermissionSetInput, options: CallOptions) !detach_managed_policy_from_permission_set.DetachManagedPolicyFromPermissionSetOutput {
        return detach_managed_policy_from_permission_set.execute(self, allocator, input, options);
    }

    /// Retrieves the authorized targets for an IAM Identity Center access scope for
    /// an application.
    pub fn getApplicationAccessScope(self: *Self, allocator: std.mem.Allocator, input: get_application_access_scope.GetApplicationAccessScopeInput, options: CallOptions) !get_application_access_scope.GetApplicationAccessScopeOutput {
        return get_application_access_scope.execute(self, allocator, input, options);
    }

    /// Retrieves the configuration of PutApplicationAssignmentConfiguration.
    pub fn getApplicationAssignmentConfiguration(self: *Self, allocator: std.mem.Allocator, input: get_application_assignment_configuration.GetApplicationAssignmentConfigurationInput, options: CallOptions) !get_application_assignment_configuration.GetApplicationAssignmentConfigurationOutput {
        return get_application_assignment_configuration.execute(self, allocator, input, options);
    }

    /// Retrieves details about an authentication method used by an application.
    pub fn getApplicationAuthenticationMethod(self: *Self, allocator: std.mem.Allocator, input: get_application_authentication_method.GetApplicationAuthenticationMethodInput, options: CallOptions) !get_application_authentication_method.GetApplicationAuthenticationMethodOutput {
        return get_application_authentication_method.execute(self, allocator, input, options);
    }

    /// Retrieves details about an application grant.
    pub fn getApplicationGrant(self: *Self, allocator: std.mem.Allocator, input: get_application_grant.GetApplicationGrantInput, options: CallOptions) !get_application_grant.GetApplicationGrantOutput {
        return get_application_grant.execute(self, allocator, input, options);
    }

    /// Retrieves the session configuration for an application in IAM Identity
    /// Center.
    ///
    /// The session configuration determines how users can access an application.
    /// This includes whether user background sessions are enabled. User background
    /// sessions allow users to start a job on a supported Amazon Web Services
    /// managed application without having to remain signed in to an active session
    /// while the job runs.
    pub fn getApplicationSessionConfiguration(self: *Self, allocator: std.mem.Allocator, input: get_application_session_configuration.GetApplicationSessionConfigurationInput, options: CallOptions) !get_application_session_configuration.GetApplicationSessionConfigurationOutput {
        return get_application_session_configuration.execute(self, allocator, input, options);
    }

    /// Obtains the inline policy assigned to the permission set.
    pub fn getInlinePolicyForPermissionSet(self: *Self, allocator: std.mem.Allocator, input: get_inline_policy_for_permission_set.GetInlinePolicyForPermissionSetInput, options: CallOptions) !get_inline_policy_for_permission_set.GetInlinePolicyForPermissionSetOutput {
        return get_inline_policy_for_permission_set.execute(self, allocator, input, options);
    }

    /// Obtains the permissions boundary for a specified PermissionSet.
    pub fn getPermissionsBoundaryForPermissionSet(self: *Self, allocator: std.mem.Allocator, input: get_permissions_boundary_for_permission_set.GetPermissionsBoundaryForPermissionSetInput, options: CallOptions) !get_permissions_boundary_for_permission_set.GetPermissionsBoundaryForPermissionSetOutput {
        return get_permissions_boundary_for_permission_set.execute(self, allocator, input, options);
    }

    /// Lists the status of the Amazon Web Services account assignment creation
    /// requests for a specified IAM Identity Center instance.
    pub fn listAccountAssignmentCreationStatus(self: *Self, allocator: std.mem.Allocator, input: list_account_assignment_creation_status.ListAccountAssignmentCreationStatusInput, options: CallOptions) !list_account_assignment_creation_status.ListAccountAssignmentCreationStatusOutput {
        return list_account_assignment_creation_status.execute(self, allocator, input, options);
    }

    /// Lists the status of the Amazon Web Services account assignment deletion
    /// requests for a specified IAM Identity Center instance.
    pub fn listAccountAssignmentDeletionStatus(self: *Self, allocator: std.mem.Allocator, input: list_account_assignment_deletion_status.ListAccountAssignmentDeletionStatusInput, options: CallOptions) !list_account_assignment_deletion_status.ListAccountAssignmentDeletionStatusOutput {
        return list_account_assignment_deletion_status.execute(self, allocator, input, options);
    }

    /// Lists the assignee of the specified Amazon Web Services account with the
    /// specified permission set.
    pub fn listAccountAssignments(self: *Self, allocator: std.mem.Allocator, input: list_account_assignments.ListAccountAssignmentsInput, options: CallOptions) !list_account_assignments.ListAccountAssignmentsOutput {
        return list_account_assignments.execute(self, allocator, input, options);
    }

    /// Retrieves a list of the IAM Identity Center associated Amazon Web Services
    /// accounts that the principal has access to. This action must be called from
    /// the management account containing your organization instance of IAM Identity
    /// Center. This action is not valid for account instances of IAM Identity
    /// Center.
    pub fn listAccountAssignmentsForPrincipal(self: *Self, allocator: std.mem.Allocator, input: list_account_assignments_for_principal.ListAccountAssignmentsForPrincipalInput, options: CallOptions) !list_account_assignments_for_principal.ListAccountAssignmentsForPrincipalOutput {
        return list_account_assignments_for_principal.execute(self, allocator, input, options);
    }

    /// Lists all the Amazon Web Services accounts where the specified permission
    /// set is provisioned.
    pub fn listAccountsForProvisionedPermissionSet(self: *Self, allocator: std.mem.Allocator, input: list_accounts_for_provisioned_permission_set.ListAccountsForProvisionedPermissionSetInput, options: CallOptions) !list_accounts_for_provisioned_permission_set.ListAccountsForProvisionedPermissionSetOutput {
        return list_accounts_for_provisioned_permission_set.execute(self, allocator, input, options);
    }

    /// Lists the access scopes and authorized targets associated with an
    /// application.
    pub fn listApplicationAccessScopes(self: *Self, allocator: std.mem.Allocator, input: list_application_access_scopes.ListApplicationAccessScopesInput, options: CallOptions) !list_application_access_scopes.ListApplicationAccessScopesOutput {
        return list_application_access_scopes.execute(self, allocator, input, options);
    }

    /// Lists Amazon Web Services account users that are assigned to an application.
    pub fn listApplicationAssignments(self: *Self, allocator: std.mem.Allocator, input: list_application_assignments.ListApplicationAssignmentsInput, options: CallOptions) !list_application_assignments.ListApplicationAssignmentsOutput {
        return list_application_assignments.execute(self, allocator, input, options);
    }

    /// Lists the applications to which a specified principal is assigned. You must
    /// provide a filter when calling this action from a member account against your
    /// organization instance of IAM Identity Center. A filter is not required when
    /// called from the management account against an organization instance of IAM
    /// Identity Center, or from a member account against an account instance of IAM
    /// Identity Center in the same account.
    pub fn listApplicationAssignmentsForPrincipal(self: *Self, allocator: std.mem.Allocator, input: list_application_assignments_for_principal.ListApplicationAssignmentsForPrincipalInput, options: CallOptions) !list_application_assignments_for_principal.ListApplicationAssignmentsForPrincipalOutput {
        return list_application_assignments_for_principal.execute(self, allocator, input, options);
    }

    /// Lists all of the authentication methods supported by the specified
    /// application.
    pub fn listApplicationAuthenticationMethods(self: *Self, allocator: std.mem.Allocator, input: list_application_authentication_methods.ListApplicationAuthenticationMethodsInput, options: CallOptions) !list_application_authentication_methods.ListApplicationAuthenticationMethodsOutput {
        return list_application_authentication_methods.execute(self, allocator, input, options);
    }

    /// List the grants associated with an application.
    pub fn listApplicationGrants(self: *Self, allocator: std.mem.Allocator, input: list_application_grants.ListApplicationGrantsInput, options: CallOptions) !list_application_grants.ListApplicationGrantsOutput {
        return list_application_grants.execute(self, allocator, input, options);
    }

    /// Lists the application providers configured in the IAM Identity Center
    /// identity store.
    pub fn listApplicationProviders(self: *Self, allocator: std.mem.Allocator, input: list_application_providers.ListApplicationProvidersInput, options: CallOptions) !list_application_providers.ListApplicationProvidersOutput {
        return list_application_providers.execute(self, allocator, input, options);
    }

    /// Lists all applications associated with the instance of IAM Identity Center.
    /// When listing applications for an organization instance in the management
    /// account, member accounts must use the `applicationAccount` parameter to
    /// filter the list to only applications created from that account. When listing
    /// applications for an account instance in the same member account, a filter is
    /// not required.
    pub fn listApplications(self: *Self, allocator: std.mem.Allocator, input: list_applications.ListApplicationsInput, options: CallOptions) !list_applications.ListApplicationsOutput {
        return list_applications.execute(self, allocator, input, options);
    }

    /// Lists all customer managed policies attached to a specified PermissionSet.
    pub fn listCustomerManagedPolicyReferencesInPermissionSet(self: *Self, allocator: std.mem.Allocator, input: list_customer_managed_policy_references_in_permission_set.ListCustomerManagedPolicyReferencesInPermissionSetInput, options: CallOptions) !list_customer_managed_policy_references_in_permission_set.ListCustomerManagedPolicyReferencesInPermissionSetOutput {
        return list_customer_managed_policy_references_in_permission_set.execute(self, allocator, input, options);
    }

    /// Lists the details of the organization and account instances of IAM Identity
    /// Center that were created in or visible to the account calling this API.
    pub fn listInstances(self: *Self, allocator: std.mem.Allocator, input: list_instances.ListInstancesInput, options: CallOptions) !list_instances.ListInstancesOutput {
        return list_instances.execute(self, allocator, input, options);
    }

    /// Lists the Amazon Web Services managed policy that is attached to a specified
    /// permission set.
    pub fn listManagedPoliciesInPermissionSet(self: *Self, allocator: std.mem.Allocator, input: list_managed_policies_in_permission_set.ListManagedPoliciesInPermissionSetInput, options: CallOptions) !list_managed_policies_in_permission_set.ListManagedPoliciesInPermissionSetOutput {
        return list_managed_policies_in_permission_set.execute(self, allocator, input, options);
    }

    /// Lists the status of the permission set provisioning requests for a specified
    /// IAM Identity Center instance.
    pub fn listPermissionSetProvisioningStatus(self: *Self, allocator: std.mem.Allocator, input: list_permission_set_provisioning_status.ListPermissionSetProvisioningStatusInput, options: CallOptions) !list_permission_set_provisioning_status.ListPermissionSetProvisioningStatusOutput {
        return list_permission_set_provisioning_status.execute(self, allocator, input, options);
    }

    /// Lists the PermissionSets in an IAM Identity Center instance.
    pub fn listPermissionSets(self: *Self, allocator: std.mem.Allocator, input: list_permission_sets.ListPermissionSetsInput, options: CallOptions) !list_permission_sets.ListPermissionSetsOutput {
        return list_permission_sets.execute(self, allocator, input, options);
    }

    /// Lists all the permission sets that are provisioned to a specified Amazon Web
    /// Services account.
    pub fn listPermissionSetsProvisionedToAccount(self: *Self, allocator: std.mem.Allocator, input: list_permission_sets_provisioned_to_account.ListPermissionSetsProvisionedToAccountInput, options: CallOptions) !list_permission_sets_provisioned_to_account.ListPermissionSetsProvisionedToAccountOutput {
        return list_permission_sets_provisioned_to_account.execute(self, allocator, input, options);
    }

    /// Lists all enabled Regions of an IAM Identity Center instance, including
    /// those that are being added or removed. This operation returns Regions with
    /// ACTIVE, ADDING, or REMOVING status.
    ///
    /// The following actions are related to `ListRegions`:
    ///
    /// * [
    ///   AddRegion](https://docs.aws.amazon.com/singlesignon/latest/APIReference/API_AddRegion.html)
    /// *
    ///   [RemoveRegion](https://docs.aws.amazon.com/singlesignon/latest/APIReference/API_RemoveRegion.html)
    /// *
    ///   [DescribeRegion](https://docs.aws.amazon.com/singlesignon/latest/APIReference/API_DescribeRegion.html)
    pub fn listRegions(self: *Self, allocator: std.mem.Allocator, input: list_regions.ListRegionsInput, options: CallOptions) !list_regions.ListRegionsOutput {
        return list_regions.execute(self, allocator, input, options);
    }

    /// Lists the tags that are attached to a specified resource.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: CallOptions) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Lists all the trusted token issuers configured in an instance of IAM
    /// Identity Center.
    pub fn listTrustedTokenIssuers(self: *Self, allocator: std.mem.Allocator, input: list_trusted_token_issuers.ListTrustedTokenIssuersInput, options: CallOptions) !list_trusted_token_issuers.ListTrustedTokenIssuersOutput {
        return list_trusted_token_issuers.execute(self, allocator, input, options);
    }

    /// The process by which a specified permission set is provisioned to the
    /// specified target.
    pub fn provisionPermissionSet(self: *Self, allocator: std.mem.Allocator, input: provision_permission_set.ProvisionPermissionSetInput, options: CallOptions) !provision_permission_set.ProvisionPermissionSetOutput {
        return provision_permission_set.execute(self, allocator, input, options);
    }

    /// Adds or updates the list of authorized targets for an IAM Identity Center
    /// access scope for an application.
    pub fn putApplicationAccessScope(self: *Self, allocator: std.mem.Allocator, input: put_application_access_scope.PutApplicationAccessScopeInput, options: CallOptions) !put_application_access_scope.PutApplicationAccessScopeOutput {
        return put_application_access_scope.execute(self, allocator, input, options);
    }

    /// Configure how users gain access to an application. If `AssignmentsRequired`
    /// is `true` (default value), users don’t have access to the application unless
    /// an assignment is created using the [CreateApplicationAssignment
    /// API](https://docs.aws.amazon.com/singlesignon/latest/APIReference/API_CreateApplicationAssignment.html). If `false`, all users have access to the application. If an assignment is created using [CreateApplicationAssignment](https://docs.aws.amazon.com/singlesignon/latest/APIReference/API_CreateApplicationAssignment.html)., the user retains access if `AssignmentsRequired` is set to `true`.
    pub fn putApplicationAssignmentConfiguration(self: *Self, allocator: std.mem.Allocator, input: put_application_assignment_configuration.PutApplicationAssignmentConfigurationInput, options: CallOptions) !put_application_assignment_configuration.PutApplicationAssignmentConfigurationOutput {
        return put_application_assignment_configuration.execute(self, allocator, input, options);
    }

    /// Adds or updates an authentication method for an application.
    pub fn putApplicationAuthenticationMethod(self: *Self, allocator: std.mem.Allocator, input: put_application_authentication_method.PutApplicationAuthenticationMethodInput, options: CallOptions) !put_application_authentication_method.PutApplicationAuthenticationMethodOutput {
        return put_application_authentication_method.execute(self, allocator, input, options);
    }

    /// Creates a configuration for an application to use grants. Conceptually
    /// grants are authorization to request actions related to tokens. This
    /// configuration will be used when parties are requesting and receiving tokens
    /// during the trusted identity propagation process. For more information on the
    /// IAM Identity Center supported grant workflows, see [SAML 2.0 and OAuth
    /// 2.0](https://docs.aws.amazon.com/singlesignon/latest/userguide/customermanagedapps-saml2-oauth2.html).
    ///
    /// A grant is created between your applications and Identity Center instance
    /// which enables an application to use specified mechanisms to obtain tokens.
    /// These tokens are used by your applications to gain access to Amazon Web
    /// Services resources on behalf of users. The following elements are within
    /// these exchanges:
    ///
    /// * **Requester** - The application requesting access to Amazon Web Services
    ///   resources.
    /// * **Subject** - Typically the user that is requesting access to Amazon Web
    ///   Services resources.
    /// * **Grant** - Conceptually, a grant is authorization to access Amazon Web
    ///   Services resources. These grants authorize token generation for
    ///   authenticating access to the requester and for the request to make
    ///   requests on behalf of the subjects. There are four types of grants:
    ///
    /// * **AuthorizationCode** - Allows an application to request authorization
    ///   through a series of user-agent redirects.
    /// * **JWT bearer ** - Authorizes an application to exchange a JSON Web Token
    ///   that came from an external identity provider. To learn more, see [RFC
    ///   6479](https://datatracker.ietf.org/doc/html/rfc6749).
    /// * **Refresh token** - Enables application to request new access tokens to
    ///   replace expiring or expired access tokens.
    /// * **Exchange token** - A grant that requests tokens from the authorization
    ///   server by providing a ‘subject’ token with access scope authorizing
    ///   trusted identity propagation to this application. To learn more, see [RFC
    ///   8693](https://datatracker.ietf.org/doc/html/rfc8693).
    ///
    /// * **Authorization server** - IAM Identity Center requests tokens.
    ///
    /// User credentials are never shared directly within these exchanges. Instead,
    /// applications use grants to request access tokens from IAM Identity Center.
    /// For more information, see [RFC
    /// 6479](https://datatracker.ietf.org/doc/html/rfc6749). **Use cases**
    ///
    /// * Connecting to custom applications.
    /// * Configuring an Amazon Web Services service to make calls to another Amazon
    ///   Web Services services using JWT tokens.
    pub fn putApplicationGrant(self: *Self, allocator: std.mem.Allocator, input: put_application_grant.PutApplicationGrantInput, options: CallOptions) !put_application_grant.PutApplicationGrantOutput {
        return put_application_grant.execute(self, allocator, input, options);
    }

    /// Updates the session configuration for an application in IAM Identity Center.
    ///
    /// The session configuration determines how users can access an application.
    /// This includes whether user background sessions are enabled. User background
    /// sessions allow users to start a job on a supported Amazon Web Services
    /// managed application without having to remain signed in to an active session
    /// while the job runs.
    pub fn putApplicationSessionConfiguration(self: *Self, allocator: std.mem.Allocator, input: put_application_session_configuration.PutApplicationSessionConfigurationInput, options: CallOptions) !put_application_session_configuration.PutApplicationSessionConfigurationOutput {
        return put_application_session_configuration.execute(self, allocator, input, options);
    }

    /// Attaches an inline policy to a permission set.
    ///
    /// If the permission set is already referenced by one or more account
    /// assignments, you will need to call ` ProvisionPermissionSet ` after this
    /// action to apply the corresponding IAM policy updates to all assigned
    /// accounts.
    pub fn putInlinePolicyToPermissionSet(self: *Self, allocator: std.mem.Allocator, input: put_inline_policy_to_permission_set.PutInlinePolicyToPermissionSetInput, options: CallOptions) !put_inline_policy_to_permission_set.PutInlinePolicyToPermissionSetOutput {
        return put_inline_policy_to_permission_set.execute(self, allocator, input, options);
    }

    /// Attaches an Amazon Web Services managed or customer managed policy to the
    /// specified PermissionSet as a permissions boundary.
    pub fn putPermissionsBoundaryToPermissionSet(self: *Self, allocator: std.mem.Allocator, input: put_permissions_boundary_to_permission_set.PutPermissionsBoundaryToPermissionSetInput, options: CallOptions) !put_permissions_boundary_to_permission_set.PutPermissionsBoundaryToPermissionSetOutput {
        return put_permissions_boundary_to_permission_set.execute(self, allocator, input, options);
    }

    /// Removes an additional Region from an IAM Identity Center instance. This
    /// operation initiates an asynchronous workflow to clean up IAM Identity Center
    /// resources in the specified additional Region. The Region status is set to
    /// REMOVING and the Region record is deleted when the workflow completes. The
    /// request must be made from the primary Region. The target Region cannot be
    /// the primary Region, and no other add or remove Region workflows can be in
    /// progress.
    ///
    /// The following actions are related to `RemoveRegion`:
    ///
    /// * [
    ///   AddRegion](https://docs.aws.amazon.com/singlesignon/latest/APIReference/API_AddRegion.html)
    /// *
    ///   [DescribeRegion](https://docs.aws.amazon.com/singlesignon/latest/APIReference/API_DescribeRegion.html)
    /// *
    ///   [ListRegions](https://docs.aws.amazon.com/singlesignon/latest/APIReference/API_ListRegions.html)
    pub fn removeRegion(self: *Self, allocator: std.mem.Allocator, input: remove_region.RemoveRegionInput, options: CallOptions) !remove_region.RemoveRegionOutput {
        return remove_region.execute(self, allocator, input, options);
    }

    /// Associates a set of tags with a specified resource.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: CallOptions) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Disassociates a set of tags from a specified resource.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: CallOptions) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Updates application properties.
    pub fn updateApplication(self: *Self, allocator: std.mem.Allocator, input: update_application.UpdateApplicationInput, options: CallOptions) !update_application.UpdateApplicationOutput {
        return update_application.execute(self, allocator, input, options);
    }

    /// Update the details for the instance of IAM Identity Center that is owned by
    /// the Amazon Web Services account.
    pub fn updateInstance(self: *Self, allocator: std.mem.Allocator, input: update_instance.UpdateInstanceInput, options: CallOptions) !update_instance.UpdateInstanceOutput {
        return update_instance.execute(self, allocator, input, options);
    }

    /// Updates the IAM Identity Center identity store attributes that you can use
    /// with the IAM Identity Center instance for attributes-based access control
    /// (ABAC). When using an external identity provider as an identity source, you
    /// can pass attributes through the SAML assertion as an alternative to
    /// configuring attributes from the IAM Identity Center identity store. If a
    /// SAML assertion passes any of these attributes, IAM Identity Center replaces
    /// the attribute value with the value from the IAM Identity Center identity
    /// store. For more information about ABAC, see [Attribute-Based Access
    /// Control](/singlesignon/latest/userguide/abac.html) in the *IAM Identity
    /// Center User Guide*.
    pub fn updateInstanceAccessControlAttributeConfiguration(self: *Self, allocator: std.mem.Allocator, input: update_instance_access_control_attribute_configuration.UpdateInstanceAccessControlAttributeConfigurationInput, options: CallOptions) !update_instance_access_control_attribute_configuration.UpdateInstanceAccessControlAttributeConfigurationOutput {
        return update_instance_access_control_attribute_configuration.execute(self, allocator, input, options);
    }

    /// Updates an existing permission set.
    pub fn updatePermissionSet(self: *Self, allocator: std.mem.Allocator, input: update_permission_set.UpdatePermissionSetInput, options: CallOptions) !update_permission_set.UpdatePermissionSetOutput {
        return update_permission_set.execute(self, allocator, input, options);
    }

    /// Updates the name of the trusted token issuer, or the path of a source
    /// attribute or destination attribute for a trusted token issuer configuration.
    ///
    /// Updating this trusted token issuer configuration might cause users to lose
    /// access to any applications that are configured to use the trusted token
    /// issuer.
    pub fn updateTrustedTokenIssuer(self: *Self, allocator: std.mem.Allocator, input: update_trusted_token_issuer.UpdateTrustedTokenIssuerInput, options: CallOptions) !update_trusted_token_issuer.UpdateTrustedTokenIssuerOutput {
        return update_trusted_token_issuer.execute(self, allocator, input, options);
    }

    pub fn listAccountAssignmentCreationStatusPaginator(self: *Self, params: list_account_assignment_creation_status.ListAccountAssignmentCreationStatusInput) paginator.ListAccountAssignmentCreationStatusPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listAccountAssignmentDeletionStatusPaginator(self: *Self, params: list_account_assignment_deletion_status.ListAccountAssignmentDeletionStatusInput) paginator.ListAccountAssignmentDeletionStatusPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listAccountAssignmentsPaginator(self: *Self, params: list_account_assignments.ListAccountAssignmentsInput) paginator.ListAccountAssignmentsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listAccountAssignmentsForPrincipalPaginator(self: *Self, params: list_account_assignments_for_principal.ListAccountAssignmentsForPrincipalInput) paginator.ListAccountAssignmentsForPrincipalPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listAccountsForProvisionedPermissionSetPaginator(self: *Self, params: list_accounts_for_provisioned_permission_set.ListAccountsForProvisionedPermissionSetInput) paginator.ListAccountsForProvisionedPermissionSetPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listApplicationAccessScopesPaginator(self: *Self, params: list_application_access_scopes.ListApplicationAccessScopesInput) paginator.ListApplicationAccessScopesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listApplicationAssignmentsPaginator(self: *Self, params: list_application_assignments.ListApplicationAssignmentsInput) paginator.ListApplicationAssignmentsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listApplicationAssignmentsForPrincipalPaginator(self: *Self, params: list_application_assignments_for_principal.ListApplicationAssignmentsForPrincipalInput) paginator.ListApplicationAssignmentsForPrincipalPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listApplicationAuthenticationMethodsPaginator(self: *Self, params: list_application_authentication_methods.ListApplicationAuthenticationMethodsInput) paginator.ListApplicationAuthenticationMethodsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listApplicationGrantsPaginator(self: *Self, params: list_application_grants.ListApplicationGrantsInput) paginator.ListApplicationGrantsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listApplicationProvidersPaginator(self: *Self, params: list_application_providers.ListApplicationProvidersInput) paginator.ListApplicationProvidersPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listApplicationsPaginator(self: *Self, params: list_applications.ListApplicationsInput) paginator.ListApplicationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listCustomerManagedPolicyReferencesInPermissionSetPaginator(self: *Self, params: list_customer_managed_policy_references_in_permission_set.ListCustomerManagedPolicyReferencesInPermissionSetInput) paginator.ListCustomerManagedPolicyReferencesInPermissionSetPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listInstancesPaginator(self: *Self, params: list_instances.ListInstancesInput) paginator.ListInstancesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listManagedPoliciesInPermissionSetPaginator(self: *Self, params: list_managed_policies_in_permission_set.ListManagedPoliciesInPermissionSetInput) paginator.ListManagedPoliciesInPermissionSetPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listPermissionSetProvisioningStatusPaginator(self: *Self, params: list_permission_set_provisioning_status.ListPermissionSetProvisioningStatusInput) paginator.ListPermissionSetProvisioningStatusPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listPermissionSetsPaginator(self: *Self, params: list_permission_sets.ListPermissionSetsInput) paginator.ListPermissionSetsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listPermissionSetsProvisionedToAccountPaginator(self: *Self, params: list_permission_sets_provisioned_to_account.ListPermissionSetsProvisionedToAccountInput) paginator.ListPermissionSetsProvisionedToAccountPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listRegionsPaginator(self: *Self, params: list_regions.ListRegionsInput) paginator.ListRegionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listTagsForResourcePaginator(self: *Self, params: list_tags_for_resource.ListTagsForResourceInput) paginator.ListTagsForResourcePaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listTrustedTokenIssuersPaginator(self: *Self, params: list_trusted_token_issuers.ListTrustedTokenIssuersInput) paginator.ListTrustedTokenIssuersPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};
