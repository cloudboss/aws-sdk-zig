const aws = @import("aws");
const std = @import("std");

const accept_resource_share_invitation = @import("accept_resource_share_invitation.zig");
const associate_resource_share = @import("associate_resource_share.zig");
const associate_resource_share_permission = @import("associate_resource_share_permission.zig");
const create_permission = @import("create_permission.zig");
const create_permission_version = @import("create_permission_version.zig");
const create_resource_share = @import("create_resource_share.zig");
const delete_permission = @import("delete_permission.zig");
const delete_permission_version = @import("delete_permission_version.zig");
const delete_resource_share = @import("delete_resource_share.zig");
const disassociate_resource_share = @import("disassociate_resource_share.zig");
const disassociate_resource_share_permission = @import("disassociate_resource_share_permission.zig");
const enable_sharing_with_aws_organization = @import("enable_sharing_with_aws_organization.zig");
const get_permission = @import("get_permission.zig");
const get_resource_policies = @import("get_resource_policies.zig");
const get_resource_share_associations = @import("get_resource_share_associations.zig");
const get_resource_share_invitations = @import("get_resource_share_invitations.zig");
const get_resource_shares = @import("get_resource_shares.zig");
const list_pending_invitation_resources = @import("list_pending_invitation_resources.zig");
const list_permission_associations = @import("list_permission_associations.zig");
const list_permission_versions = @import("list_permission_versions.zig");
const list_permissions = @import("list_permissions.zig");
const list_principals = @import("list_principals.zig");
const list_replace_permission_associations_work = @import("list_replace_permission_associations_work.zig");
const list_resource_share_permissions = @import("list_resource_share_permissions.zig");
const list_resource_types = @import("list_resource_types.zig");
const list_resources = @import("list_resources.zig");
const list_source_associations = @import("list_source_associations.zig");
const promote_permission_created_from_policy = @import("promote_permission_created_from_policy.zig");
const promote_resource_share_created_from_policy = @import("promote_resource_share_created_from_policy.zig");
const reject_resource_share_invitation = @import("reject_resource_share_invitation.zig");
const replace_permission_associations = @import("replace_permission_associations.zig");
const set_default_permission_version = @import("set_default_permission_version.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_resource_share = @import("update_resource_share.zig");
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "RAM";

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

    /// Accepts an invitation to a resource share from another Amazon Web Services
    /// account. After you accept the
    /// invitation, the resources included in the resource share are available to
    /// interact with in the
    /// relevant Amazon Web Services Management Consoles and tools.
    pub fn acceptResourceShareInvitation(self: *Self, allocator: std.mem.Allocator, input: accept_resource_share_invitation.AcceptResourceShareInvitationInput, options: accept_resource_share_invitation.Options) !accept_resource_share_invitation.AcceptResourceShareInvitationOutput {
        return accept_resource_share_invitation.execute(self, allocator, input, options);
    }

    /// Adds the specified list of principals, resources, and source constraints to
    /// a resource share. Principals that
    /// already have access to this resource share immediately receive access to the
    /// added resources.
    /// Newly added principals immediately receive access to the resources shared in
    /// this resource share.
    pub fn associateResourceShare(self: *Self, allocator: std.mem.Allocator, input: associate_resource_share.AssociateResourceShareInput, options: associate_resource_share.Options) !associate_resource_share.AssociateResourceShareOutput {
        return associate_resource_share.execute(self, allocator, input, options);
    }

    /// Adds or replaces the RAM permission for a resource type included in a
    /// resource share. You can
    /// have exactly one permission associated with each resource type in the
    /// resource share. You can add
    /// a new RAM permission only if there are currently no resources of that
    /// resource type
    /// currently in the resource share.
    pub fn associateResourceSharePermission(self: *Self, allocator: std.mem.Allocator, input: associate_resource_share_permission.AssociateResourceSharePermissionInput, options: associate_resource_share_permission.Options) !associate_resource_share_permission.AssociateResourceSharePermissionOutput {
        return associate_resource_share_permission.execute(self, allocator, input, options);
    }

    /// Creates a customer managed permission for a specified resource type that you
    /// can attach to resource shares.
    /// It is created in the Amazon Web Services Region in which you call the
    /// operation.
    pub fn createPermission(self: *Self, allocator: std.mem.Allocator, input: create_permission.CreatePermissionInput, options: create_permission.Options) !create_permission.CreatePermissionOutput {
        return create_permission.execute(self, allocator, input, options);
    }

    /// Creates a new version of the specified customer managed permission. The new
    /// version is automatically set as
    /// the default version of the customer managed permission. New resource shares
    /// automatically use the default
    /// permission. Existing resource shares continue to use their original
    /// permission versions,
    /// but you can use ReplacePermissionAssociations to update them.
    ///
    /// If the specified customer managed permission already has the maximum of 5
    /// versions, then
    /// you must delete one of the existing versions before you can create a new
    /// one.
    pub fn createPermissionVersion(self: *Self, allocator: std.mem.Allocator, input: create_permission_version.CreatePermissionVersionInput, options: create_permission_version.Options) !create_permission_version.CreatePermissionVersionOutput {
        return create_permission_version.execute(self, allocator, input, options);
    }

    /// Creates a resource share. You can provide a list of the [Amazon Resource
    /// Names
    /// (ARNs)](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html) for the resources that you
    /// want to share, a list of principals you want to share the resources with,
    /// the
    /// permissions to grant those principals, and optionally source constraints to
    /// enhance security for service principal sharing.
    ///
    /// Sharing a resource makes it available for use by principals outside of the
    /// Amazon Web Services account that created the resource. Sharing doesn't
    /// change any permissions or
    /// quotas that apply to the resource in the account that created it.
    pub fn createResourceShare(self: *Self, allocator: std.mem.Allocator, input: create_resource_share.CreateResourceShareInput, options: create_resource_share.Options) !create_resource_share.CreateResourceShareOutput {
        return create_resource_share.execute(self, allocator, input, options);
    }

    /// Deletes the specified customer managed permission in the Amazon Web Services
    /// Region in which you call this operation. You
    /// can delete a customer managed permission only if it isn't attached to any
    /// resource share. The operation deletes all
    /// versions associated with the customer managed permission.
    pub fn deletePermission(self: *Self, allocator: std.mem.Allocator, input: delete_permission.DeletePermissionInput, options: delete_permission.Options) !delete_permission.DeletePermissionOutput {
        return delete_permission.execute(self, allocator, input, options);
    }

    /// Deletes one version of a customer managed permission. The version you
    /// specify must not be attached to any
    /// resource share and must not be the default version for the permission.
    ///
    /// If a customer managed permission has the maximum of 5 versions, then you
    /// must delete at
    /// least one version before you can create another.
    pub fn deletePermissionVersion(self: *Self, allocator: std.mem.Allocator, input: delete_permission_version.DeletePermissionVersionInput, options: delete_permission_version.Options) !delete_permission_version.DeletePermissionVersionOutput {
        return delete_permission_version.execute(self, allocator, input, options);
    }

    /// Deletes the specified resource share.
    ///
    /// This doesn't delete any of the resources that were associated with the
    /// resource share; it
    /// only stops the sharing of those resources through this resource share.
    pub fn deleteResourceShare(self: *Self, allocator: std.mem.Allocator, input: delete_resource_share.DeleteResourceShareInput, options: delete_resource_share.Options) !delete_resource_share.DeleteResourceShareOutput {
        return delete_resource_share.execute(self, allocator, input, options);
    }

    /// Removes the specified principals, resources, or source constraints from
    /// participating in the specified
    /// resource share.
    pub fn disassociateResourceShare(self: *Self, allocator: std.mem.Allocator, input: disassociate_resource_share.DisassociateResourceShareInput, options: disassociate_resource_share.Options) !disassociate_resource_share.DisassociateResourceShareOutput {
        return disassociate_resource_share.execute(self, allocator, input, options);
    }

    /// Removes a managed permission from a resource share. Permission changes take
    /// effect immediately. You can
    /// remove a managed permission from a resource share only if there are
    /// currently no resources of the relevant
    /// resource type currently attached to the resource share.
    pub fn disassociateResourceSharePermission(self: *Self, allocator: std.mem.Allocator, input: disassociate_resource_share_permission.DisassociateResourceSharePermissionInput, options: disassociate_resource_share_permission.Options) !disassociate_resource_share_permission.DisassociateResourceSharePermissionOutput {
        return disassociate_resource_share_permission.execute(self, allocator, input, options);
    }

    /// Enables resource sharing within your organization in Organizations. This
    /// operation creates
    /// a service-linked role called `AWSServiceRoleForResourceAccessManager` that
    /// has the IAM managed policy
    /// named AWSResourceAccessManagerServiceRolePolicy attached. This role permits
    /// RAM to retrieve information about
    /// the organization and its structure. This lets you share resources with all
    /// of the
    /// accounts in the calling account's organization by specifying the
    /// organization ID, or all
    /// of the accounts in an organizational unit (OU) by specifying the OU ID.
    /// Until you enable
    /// sharing within the organization, you can specify only individual Amazon Web
    /// Services accounts, or for
    /// supported resource types, IAM roles and users.
    ///
    /// You must call this operation from an IAM role or user in the organization's
    /// management account.
    pub fn enableSharingWithAwsOrganization(self: *Self, allocator: std.mem.Allocator, input: enable_sharing_with_aws_organization.EnableSharingWithAwsOrganizationInput, options: enable_sharing_with_aws_organization.Options) !enable_sharing_with_aws_organization.EnableSharingWithAwsOrganizationOutput {
        return enable_sharing_with_aws_organization.execute(self, allocator, input, options);
    }

    /// Retrieves the contents of a managed permission in JSON format.
    pub fn getPermission(self: *Self, allocator: std.mem.Allocator, input: get_permission.GetPermissionInput, options: get_permission.Options) !get_permission.GetPermissionOutput {
        return get_permission.execute(self, allocator, input, options);
    }

    /// Retrieves the resource policies for the specified resources that you own and
    /// have
    /// shared.
    ///
    /// Always check the `NextToken` response parameter for a `null` value
    /// when calling a paginated operation. These operations can occasionally return
    /// an empty set of results even when there are more
    /// results available. The `NextToken` response parameter value is `null`
    /// *only*
    /// when there are no more results to display.
    pub fn getResourcePolicies(self: *Self, allocator: std.mem.Allocator, input: get_resource_policies.GetResourcePoliciesInput, options: get_resource_policies.Options) !get_resource_policies.GetResourcePoliciesOutput {
        return get_resource_policies.execute(self, allocator, input, options);
    }

    /// Retrieves the lists of resources and principals that associated for resource
    /// shares that you
    /// own.
    ///
    /// Always check the `NextToken` response parameter for a `null` value
    /// when calling a paginated operation. These operations can occasionally return
    /// an empty set of results even when there are more
    /// results available. The `NextToken` response parameter value is `null`
    /// *only*
    /// when there are no more results to display.
    pub fn getResourceShareAssociations(self: *Self, allocator: std.mem.Allocator, input: get_resource_share_associations.GetResourceShareAssociationsInput, options: get_resource_share_associations.Options) !get_resource_share_associations.GetResourceShareAssociationsOutput {
        return get_resource_share_associations.execute(self, allocator, input, options);
    }

    /// Retrieves details about invitations that you have received for resource
    /// shares.
    ///
    /// Always check the `NextToken` response parameter for a `null` value
    /// when calling a paginated operation. These operations can occasionally return
    /// an empty set of results even when there are more
    /// results available. The `NextToken` response parameter value is `null`
    /// *only*
    /// when there are no more results to display.
    pub fn getResourceShareInvitations(self: *Self, allocator: std.mem.Allocator, input: get_resource_share_invitations.GetResourceShareInvitationsInput, options: get_resource_share_invitations.Options) !get_resource_share_invitations.GetResourceShareInvitationsOutput {
        return get_resource_share_invitations.execute(self, allocator, input, options);
    }

    /// Retrieves details about the resource shares that you own or that are shared
    /// with you.
    ///
    /// Always check the `NextToken` response parameter for a `null` value
    /// when calling a paginated operation. These operations can occasionally return
    /// an empty set of results even when there are more
    /// results available. The `NextToken` response parameter value is `null`
    /// *only*
    /// when there are no more results to display.
    pub fn getResourceShares(self: *Self, allocator: std.mem.Allocator, input: get_resource_shares.GetResourceSharesInput, options: get_resource_shares.Options) !get_resource_shares.GetResourceSharesOutput {
        return get_resource_shares.execute(self, allocator, input, options);
    }

    /// Lists the resources in a resource share that is shared with you but for
    /// which the invitation is
    /// still `PENDING`. That means that you haven't accepted or rejected the
    /// invitation and the invitation hasn't expired.
    ///
    /// Always check the `NextToken` response parameter for a `null` value
    /// when calling a paginated operation. These operations can occasionally return
    /// an empty set of results even when there are more
    /// results available. The `NextToken` response parameter value is `null`
    /// *only*
    /// when there are no more results to display.
    pub fn listPendingInvitationResources(self: *Self, allocator: std.mem.Allocator, input: list_pending_invitation_resources.ListPendingInvitationResourcesInput, options: list_pending_invitation_resources.Options) !list_pending_invitation_resources.ListPendingInvitationResourcesOutput {
        return list_pending_invitation_resources.execute(self, allocator, input, options);
    }

    /// Lists information about the managed permission and its associations to any
    /// resource shares that use
    /// this managed permission. This lets you see which resource shares use which
    /// versions of the specified
    /// managed permission.
    ///
    /// Always check the `NextToken` response parameter for a `null` value
    /// when calling a paginated operation. These operations can occasionally return
    /// an empty set of results even when there are more
    /// results available. The `NextToken` response parameter value is `null`
    /// *only*
    /// when there are no more results to display.
    pub fn listPermissionAssociations(self: *Self, allocator: std.mem.Allocator, input: list_permission_associations.ListPermissionAssociationsInput, options: list_permission_associations.Options) !list_permission_associations.ListPermissionAssociationsOutput {
        return list_permission_associations.execute(self, allocator, input, options);
    }

    /// Lists the available versions of the specified RAM permission.
    ///
    /// Always check the `NextToken` response parameter for a `null` value
    /// when calling a paginated operation. These operations can occasionally return
    /// an empty set of results even when there are more
    /// results available. The `NextToken` response parameter value is `null`
    /// *only*
    /// when there are no more results to display.
    pub fn listPermissionVersions(self: *Self, allocator: std.mem.Allocator, input: list_permission_versions.ListPermissionVersionsInput, options: list_permission_versions.Options) !list_permission_versions.ListPermissionVersionsOutput {
        return list_permission_versions.execute(self, allocator, input, options);
    }

    /// Retrieves a list of available RAM permissions that you can use for the
    /// supported
    /// resource types.
    ///
    /// Always check the `NextToken` response parameter for a `null` value
    /// when calling a paginated operation. These operations can occasionally return
    /// an empty set of results even when there are more
    /// results available. The `NextToken` response parameter value is `null`
    /// *only*
    /// when there are no more results to display.
    pub fn listPermissions(self: *Self, allocator: std.mem.Allocator, input: list_permissions.ListPermissionsInput, options: list_permissions.Options) !list_permissions.ListPermissionsOutput {
        return list_permissions.execute(self, allocator, input, options);
    }

    /// Lists the principals that you are sharing resources with or that are sharing
    /// resources
    /// with you.
    ///
    /// Always check the `NextToken` response parameter for a `null` value
    /// when calling a paginated operation. These operations can occasionally return
    /// an empty set of results even when there are more
    /// results available. The `NextToken` response parameter value is `null`
    /// *only*
    /// when there are no more results to display.
    pub fn listPrincipals(self: *Self, allocator: std.mem.Allocator, input: list_principals.ListPrincipalsInput, options: list_principals.Options) !list_principals.ListPrincipalsOutput {
        return list_principals.execute(self, allocator, input, options);
    }

    /// Retrieves the current status of the asynchronous tasks performed by RAM when
    /// you
    /// perform the ReplacePermissionAssociationsWork operation.
    ///
    /// Always check the `NextToken` response parameter for a `null` value
    /// when calling a paginated operation. These operations can occasionally return
    /// an empty set of results even when there are more
    /// results available. The `NextToken` response parameter value is `null`
    /// *only*
    /// when there are no more results to display.
    pub fn listReplacePermissionAssociationsWork(self: *Self, allocator: std.mem.Allocator, input: list_replace_permission_associations_work.ListReplacePermissionAssociationsWorkInput, options: list_replace_permission_associations_work.Options) !list_replace_permission_associations_work.ListReplacePermissionAssociationsWorkOutput {
        return list_replace_permission_associations_work.execute(self, allocator, input, options);
    }

    /// Lists the RAM permissions that are associated with a resource share.
    ///
    /// Always check the `NextToken` response parameter for a `null` value
    /// when calling a paginated operation. These operations can occasionally return
    /// an empty set of results even when there are more
    /// results available. The `NextToken` response parameter value is `null`
    /// *only*
    /// when there are no more results to display.
    pub fn listResourceSharePermissions(self: *Self, allocator: std.mem.Allocator, input: list_resource_share_permissions.ListResourceSharePermissionsInput, options: list_resource_share_permissions.Options) !list_resource_share_permissions.ListResourceSharePermissionsOutput {
        return list_resource_share_permissions.execute(self, allocator, input, options);
    }

    /// Lists the resource types that can be shared by RAM.
    pub fn listResourceTypes(self: *Self, allocator: std.mem.Allocator, input: list_resource_types.ListResourceTypesInput, options: list_resource_types.Options) !list_resource_types.ListResourceTypesOutput {
        return list_resource_types.execute(self, allocator, input, options);
    }

    /// Lists the resources that you added to a resource share or the resources that
    /// are shared with
    /// you.
    ///
    /// Always check the `NextToken` response parameter for a `null` value
    /// when calling a paginated operation. These operations can occasionally return
    /// an empty set of results even when there are more
    /// results available. The `NextToken` response parameter value is `null`
    /// *only*
    /// when there are no more results to display.
    pub fn listResources(self: *Self, allocator: std.mem.Allocator, input: list_resources.ListResourcesInput, options: list_resources.Options) !list_resources.ListResourcesOutput {
        return list_resources.execute(self, allocator, input, options);
    }

    /// Lists source associations for resource shares. Source associations control
    /// which sources can be used with service principals in resource shares. This
    /// operation provides visibility into source associations for resource share
    /// owners.
    ///
    /// You can filter the results by resource share Amazon Resource Name (ARN),
    /// source ID, source type, or association status. We recommend using pagination
    /// to ensure that the operation returns quickly and successfully.
    pub fn listSourceAssociations(self: *Self, allocator: std.mem.Allocator, input: list_source_associations.ListSourceAssociationsInput, options: list_source_associations.Options) !list_source_associations.ListSourceAssociationsOutput {
        return list_source_associations.execute(self, allocator, input, options);
    }

    /// When you attach a resource-based policy to a resource, RAM automatically
    /// creates
    /// a resource share of `featureSet`=`CREATED_FROM_POLICY` with a managed
    /// permission that
    /// has the same IAM permissions as the original resource-based policy. However,
    /// this type
    /// of managed permission is visible to only the resource share owner, and the
    /// associated resource share can't be modified by
    /// using RAM.
    ///
    /// This operation creates a separate, fully manageable customer managed
    /// permission that has the same IAM
    /// permissions as the original resource-based policy. You can associate this
    /// customer managed permission to any
    /// resource shares.
    ///
    /// Before you use PromoteResourceShareCreatedFromPolicy, you should
    /// first run this operation to ensure that you have an appropriate customer
    /// managed permission that can be
    /// associated with the promoted resource share.
    ///
    /// * The original `CREATED_FROM_POLICY` policy isn't deleted, and
    /// resource shares using that original policy aren't automatically
    /// updated.
    ///
    /// * You can't modify a `CREATED_FROM_POLICY` resource share so you can't
    /// associate the new customer managed permission by using
    /// `ReplacePermsissionAssociations`. However, if you use
    /// PromoteResourceShareCreatedFromPolicy, that operation
    /// automatically associates the fully manageable customer managed permission to
    /// the newly promoted
    /// `STANDARD` resource share.
    ///
    /// * After you promote a resource share, if the original `CREATED_FROM_POLICY`
    /// managed permission has no other associations to A resource share, then RAM
    /// automatically deletes
    /// it.
    pub fn promotePermissionCreatedFromPolicy(self: *Self, allocator: std.mem.Allocator, input: promote_permission_created_from_policy.PromotePermissionCreatedFromPolicyInput, options: promote_permission_created_from_policy.Options) !promote_permission_created_from_policy.PromotePermissionCreatedFromPolicyOutput {
        return promote_permission_created_from_policy.execute(self, allocator, input, options);
    }

    /// When you attach a resource-based policy to a resource, RAM automatically
    /// creates
    /// a resource share of `featureSet`=`CREATED_FROM_POLICY` with a managed
    /// permission that
    /// has the same IAM permissions as the original resource-based policy. However,
    /// this type
    /// of managed permission is visible to only the resource share owner, and the
    /// associated resource share can't be modified by
    /// using RAM.
    ///
    /// This operation promotes the resource share to a `STANDARD` resource share
    /// that is fully
    /// manageable in RAM. When you promote a resource share, you can then manage
    /// the resource share in RAM and
    /// it becomes visible to all of the principals you shared it with.
    ///
    /// Before you perform this operation, you should first run
    /// PromotePermissionCreatedFromPolicyto ensure that you have an
    /// appropriate customer managed permission that can be associated with this
    /// resource share after its is promoted. If
    /// this operation can't find a managed permission that exactly matches the
    /// existing
    /// `CREATED_FROM_POLICY` permission, then this operation fails.
    pub fn promoteResourceShareCreatedFromPolicy(self: *Self, allocator: std.mem.Allocator, input: promote_resource_share_created_from_policy.PromoteResourceShareCreatedFromPolicyInput, options: promote_resource_share_created_from_policy.Options) !promote_resource_share_created_from_policy.PromoteResourceShareCreatedFromPolicyOutput {
        return promote_resource_share_created_from_policy.execute(self, allocator, input, options);
    }

    /// Rejects an invitation to a resource share from another Amazon Web Services
    /// account.
    pub fn rejectResourceShareInvitation(self: *Self, allocator: std.mem.Allocator, input: reject_resource_share_invitation.RejectResourceShareInvitationInput, options: reject_resource_share_invitation.Options) !reject_resource_share_invitation.RejectResourceShareInvitationOutput {
        return reject_resource_share_invitation.execute(self, allocator, input, options);
    }

    /// Updates all resource shares that use a managed permission to a different
    /// managed
    /// permission. This operation always applies the default version of the target
    /// managed
    /// permission. You can optionally specify that the update applies to only
    /// resource shares that
    /// currently use a specified version. This enables you to update to the latest
    /// version,
    /// without changing the which managed permission is used.
    ///
    /// You can use this operation to update all of your resource shares to use the
    /// current
    /// default version of the permission by specifying the same value for the
    /// `fromPermissionArn` and `toPermissionArn` parameters.
    ///
    /// You can use the optional `fromPermissionVersion` parameter to update only
    /// those resources that use a specified version of the managed permission to
    /// the new managed
    /// permission.
    ///
    /// To successfully perform this operation, you must have permission to update
    /// the
    /// resource-based policy on all affected resource types.
    pub fn replacePermissionAssociations(self: *Self, allocator: std.mem.Allocator, input: replace_permission_associations.ReplacePermissionAssociationsInput, options: replace_permission_associations.Options) !replace_permission_associations.ReplacePermissionAssociationsOutput {
        return replace_permission_associations.execute(self, allocator, input, options);
    }

    /// Designates the specified version number as the default version for the
    /// specified
    /// customer managed permission. New resource shares automatically use this new
    /// default permission. Existing
    /// resource shares continue to use their original permission version, but you
    /// can use ReplacePermissionAssociations to update them.
    pub fn setDefaultPermissionVersion(self: *Self, allocator: std.mem.Allocator, input: set_default_permission_version.SetDefaultPermissionVersionInput, options: set_default_permission_version.Options) !set_default_permission_version.SetDefaultPermissionVersionOutput {
        return set_default_permission_version.execute(self, allocator, input, options);
    }

    /// Adds the specified tag keys and values to a resource share or managed
    /// permission. If you choose a resource share, the
    /// tags are attached to only the resource share, not to the resources that are
    /// in the resource share.
    ///
    /// The tags on a managed permission are the same for all versions of the
    /// managed permission.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: tag_resource.Options) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Removes the specified tag key and value pairs from the specified resource
    /// share or managed permission.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: untag_resource.Options) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Modifies some of the properties of the specified resource share.
    pub fn updateResourceShare(self: *Self, allocator: std.mem.Allocator, input: update_resource_share.UpdateResourceShareInput, options: update_resource_share.Options) !update_resource_share.UpdateResourceShareOutput {
        return update_resource_share.execute(self, allocator, input, options);
    }

    pub fn getResourcePoliciesPaginator(self: *Self, params: get_resource_policies.GetResourcePoliciesInput) paginator.GetResourcePoliciesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn getResourceShareAssociationsPaginator(self: *Self, params: get_resource_share_associations.GetResourceShareAssociationsInput) paginator.GetResourceShareAssociationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn getResourceShareInvitationsPaginator(self: *Self, params: get_resource_share_invitations.GetResourceShareInvitationsInput) paginator.GetResourceShareInvitationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn getResourceSharesPaginator(self: *Self, params: get_resource_shares.GetResourceSharesInput) paginator.GetResourceSharesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listPendingInvitationResourcesPaginator(self: *Self, params: list_pending_invitation_resources.ListPendingInvitationResourcesInput) paginator.ListPendingInvitationResourcesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listPermissionAssociationsPaginator(self: *Self, params: list_permission_associations.ListPermissionAssociationsInput) paginator.ListPermissionAssociationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listPermissionVersionsPaginator(self: *Self, params: list_permission_versions.ListPermissionVersionsInput) paginator.ListPermissionVersionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listPermissionsPaginator(self: *Self, params: list_permissions.ListPermissionsInput) paginator.ListPermissionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listPrincipalsPaginator(self: *Self, params: list_principals.ListPrincipalsInput) paginator.ListPrincipalsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listReplacePermissionAssociationsWorkPaginator(self: *Self, params: list_replace_permission_associations_work.ListReplacePermissionAssociationsWorkInput) paginator.ListReplacePermissionAssociationsWorkPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listResourceSharePermissionsPaginator(self: *Self, params: list_resource_share_permissions.ListResourceSharePermissionsInput) paginator.ListResourceSharePermissionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listResourceTypesPaginator(self: *Self, params: list_resource_types.ListResourceTypesInput) paginator.ListResourceTypesPaginator {
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

    pub fn listSourceAssociationsPaginator(self: *Self, params: list_source_associations.ListSourceAssociationsInput) paginator.ListSourceAssociationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};
