const aws = @import("aws");
const std = @import("std");

const accept_account_link_invitation = @import("accept_account_link_invitation.zig");
const associate_connection_alias = @import("associate_connection_alias.zig");
const associate_ip_groups = @import("associate_ip_groups.zig");
const associate_workspace_application = @import("associate_workspace_application.zig");
const authorize_ip_rules = @import("authorize_ip_rules.zig");
const copy_workspace_image = @import("copy_workspace_image.zig");
const create_account_link_invitation = @import("create_account_link_invitation.zig");
const create_connect_client_add_in = @import("create_connect_client_add_in.zig");
const create_connection_alias = @import("create_connection_alias.zig");
const create_ip_group = @import("create_ip_group.zig");
const create_standby_workspaces = @import("create_standby_workspaces.zig");
const create_tags = @import("create_tags.zig");
const create_updated_workspace_image = @import("create_updated_workspace_image.zig");
const create_workspace_bundle = @import("create_workspace_bundle.zig");
const create_workspace_image = @import("create_workspace_image.zig");
const create_workspaces = @import("create_workspaces.zig");
const create_workspaces_pool = @import("create_workspaces_pool.zig");
const delete_account_link_invitation = @import("delete_account_link_invitation.zig");
const delete_client_branding = @import("delete_client_branding.zig");
const delete_connect_client_add_in = @import("delete_connect_client_add_in.zig");
const delete_connection_alias = @import("delete_connection_alias.zig");
const delete_ip_group = @import("delete_ip_group.zig");
const delete_tags = @import("delete_tags.zig");
const delete_workspace_bundle = @import("delete_workspace_bundle.zig");
const delete_workspace_image = @import("delete_workspace_image.zig");
const deploy_workspace_applications = @import("deploy_workspace_applications.zig");
const deregister_workspace_directory = @import("deregister_workspace_directory.zig");
const describe_account = @import("describe_account.zig");
const describe_account_modifications = @import("describe_account_modifications.zig");
const describe_application_associations = @import("describe_application_associations.zig");
const describe_applications = @import("describe_applications.zig");
const describe_bundle_associations = @import("describe_bundle_associations.zig");
const describe_client_branding = @import("describe_client_branding.zig");
const describe_client_properties = @import("describe_client_properties.zig");
const describe_connect_client_add_ins = @import("describe_connect_client_add_ins.zig");
const describe_connection_alias_permissions = @import("describe_connection_alias_permissions.zig");
const describe_connection_aliases = @import("describe_connection_aliases.zig");
const describe_custom_workspace_image_import = @import("describe_custom_workspace_image_import.zig");
const describe_image_associations = @import("describe_image_associations.zig");
const describe_ip_groups = @import("describe_ip_groups.zig");
const describe_tags = @import("describe_tags.zig");
const describe_workspace_associations = @import("describe_workspace_associations.zig");
const describe_workspace_bundles = @import("describe_workspace_bundles.zig");
const describe_workspace_directories = @import("describe_workspace_directories.zig");
const describe_workspace_image_permissions = @import("describe_workspace_image_permissions.zig");
const describe_workspace_images = @import("describe_workspace_images.zig");
const describe_workspace_snapshots = @import("describe_workspace_snapshots.zig");
const describe_workspaces = @import("describe_workspaces.zig");
const describe_workspaces_connection_status = @import("describe_workspaces_connection_status.zig");
const describe_workspaces_pool_sessions = @import("describe_workspaces_pool_sessions.zig");
const describe_workspaces_pools = @import("describe_workspaces_pools.zig");
const disassociate_connection_alias = @import("disassociate_connection_alias.zig");
const disassociate_ip_groups = @import("disassociate_ip_groups.zig");
const disassociate_workspace_application = @import("disassociate_workspace_application.zig");
const get_account_link = @import("get_account_link.zig");
const import_client_branding = @import("import_client_branding.zig");
const import_custom_workspace_image = @import("import_custom_workspace_image.zig");
const import_workspace_image = @import("import_workspace_image.zig");
const list_account_links = @import("list_account_links.zig");
const list_available_management_cidr_ranges = @import("list_available_management_cidr_ranges.zig");
const migrate_workspace = @import("migrate_workspace.zig");
const modify_account = @import("modify_account.zig");
const modify_certificate_based_auth_properties = @import("modify_certificate_based_auth_properties.zig");
const modify_client_properties = @import("modify_client_properties.zig");
const modify_endpoint_encryption_mode = @import("modify_endpoint_encryption_mode.zig");
const modify_saml_properties = @import("modify_saml_properties.zig");
const modify_selfservice_permissions = @import("modify_selfservice_permissions.zig");
const modify_streaming_properties = @import("modify_streaming_properties.zig");
const modify_workspace_access_properties = @import("modify_workspace_access_properties.zig");
const modify_workspace_creation_properties = @import("modify_workspace_creation_properties.zig");
const modify_workspace_properties = @import("modify_workspace_properties.zig");
const modify_workspace_state = @import("modify_workspace_state.zig");
const reboot_workspaces = @import("reboot_workspaces.zig");
const rebuild_workspaces = @import("rebuild_workspaces.zig");
const register_workspace_directory = @import("register_workspace_directory.zig");
const reject_account_link_invitation = @import("reject_account_link_invitation.zig");
const restore_workspace = @import("restore_workspace.zig");
const revoke_ip_rules = @import("revoke_ip_rules.zig");
const start_workspaces = @import("start_workspaces.zig");
const start_workspaces_pool = @import("start_workspaces_pool.zig");
const stop_workspaces = @import("stop_workspaces.zig");
const stop_workspaces_pool = @import("stop_workspaces_pool.zig");
const terminate_workspaces = @import("terminate_workspaces.zig");
const terminate_workspaces_pool = @import("terminate_workspaces_pool.zig");
const terminate_workspaces_pool_session = @import("terminate_workspaces_pool_session.zig");
const update_connect_client_add_in = @import("update_connect_client_add_in.zig");
const update_connection_alias_permission = @import("update_connection_alias_permission.zig");
const update_rules_of_ip_group = @import("update_rules_of_ip_group.zig");
const update_workspace_bundle = @import("update_workspace_bundle.zig");
const update_workspace_image_permission = @import("update_workspace_image_permission.zig");
const update_workspaces_pool = @import("update_workspaces_pool.zig");
const CallOptions = @import("call_options.zig").CallOptions;
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "WorkSpaces";

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

    /// Accepts the account link invitation.
    ///
    /// There's currently no unlinking capability after you accept the account
    /// linking invitation.
    pub fn acceptAccountLinkInvitation(self: *Self, allocator: std.mem.Allocator, input: accept_account_link_invitation.AcceptAccountLinkInvitationInput, options: CallOptions) !accept_account_link_invitation.AcceptAccountLinkInvitationOutput {
        return accept_account_link_invitation.execute(self, allocator, input, options);
    }

    /// Associates the specified connection alias with the specified directory to
    /// enable
    /// cross-Region redirection. For more information, see [ Cross-Region
    /// Redirection for Amazon
    /// WorkSpaces](https://docs.aws.amazon.com/workspaces/latest/adminguide/cross-region-redirection.html).
    ///
    /// Before performing this operation, call [
    /// DescribeConnectionAliases](https://docs.aws.amazon.com/workspaces/latest/api/API_DescribeConnectionAliases.html) to make sure that the current state of the
    /// connection alias is `CREATED`.
    pub fn associateConnectionAlias(self: *Self, allocator: std.mem.Allocator, input: associate_connection_alias.AssociateConnectionAliasInput, options: CallOptions) !associate_connection_alias.AssociateConnectionAliasOutput {
        return associate_connection_alias.execute(self, allocator, input, options);
    }

    /// Associates the specified IP access control group with the specified
    /// directory.
    pub fn associateIpGroups(self: *Self, allocator: std.mem.Allocator, input: associate_ip_groups.AssociateIpGroupsInput, options: CallOptions) !associate_ip_groups.AssociateIpGroupsOutput {
        return associate_ip_groups.execute(self, allocator, input, options);
    }

    /// Associates the specified application to the specified WorkSpace.
    pub fn associateWorkspaceApplication(self: *Self, allocator: std.mem.Allocator, input: associate_workspace_application.AssociateWorkspaceApplicationInput, options: CallOptions) !associate_workspace_application.AssociateWorkspaceApplicationOutput {
        return associate_workspace_application.execute(self, allocator, input, options);
    }

    /// Adds one or more rules to the specified IP access control group.
    ///
    /// This action gives users permission to access their WorkSpaces from the CIDR
    /// address
    /// ranges specified in the rules.
    pub fn authorizeIpRules(self: *Self, allocator: std.mem.Allocator, input: authorize_ip_rules.AuthorizeIpRulesInput, options: CallOptions) !authorize_ip_rules.AuthorizeIpRulesOutput {
        return authorize_ip_rules.execute(self, allocator, input, options);
    }

    /// Copies the specified image from the specified Region to the current Region.
    /// For more
    /// information about copying images, see [ Copy a Custom WorkSpaces
    /// Image](https://docs.aws.amazon.com/workspaces/latest/adminguide/copy-custom-image.html).
    ///
    /// In the China (Ningxia) Region, you can copy images only within the same
    /// Region.
    ///
    /// In Amazon Web Services GovCloud (US), to copy images to and from other
    /// Regions, contact Amazon Web Services Support.
    ///
    /// Before copying a shared image, be sure to verify that it has been shared
    /// from the
    /// correct Amazon Web Services account. To determine if an image has been
    /// shared and to see
    /// the ID of the Amazon Web Services account that owns an image, use the
    /// [DescribeWorkSpaceImages](https://docs.aws.amazon.com/workspaces/latest/api/API_DescribeWorkspaceImages.html) and [DescribeWorkspaceImagePermissions](https://docs.aws.amazon.com/workspaces/latest/api/API_DescribeWorkspaceImagePermissions.html) API operations.
    pub fn copyWorkspaceImage(self: *Self, allocator: std.mem.Allocator, input: copy_workspace_image.CopyWorkspaceImageInput, options: CallOptions) !copy_workspace_image.CopyWorkspaceImageOutput {
        return copy_workspace_image.execute(self, allocator, input, options);
    }

    /// Creates the account link invitation.
    pub fn createAccountLinkInvitation(self: *Self, allocator: std.mem.Allocator, input: create_account_link_invitation.CreateAccountLinkInvitationInput, options: CallOptions) !create_account_link_invitation.CreateAccountLinkInvitationOutput {
        return create_account_link_invitation.execute(self, allocator, input, options);
    }

    /// Creates a client-add-in for Amazon Connect within a directory. You can
    /// create only
    /// one Amazon Connect client add-in within a directory.
    ///
    /// This client add-in allows WorkSpaces users to seamlessly connect to Amazon
    /// Connect.
    pub fn createConnectClientAddIn(self: *Self, allocator: std.mem.Allocator, input: create_connect_client_add_in.CreateConnectClientAddInInput, options: CallOptions) !create_connect_client_add_in.CreateConnectClientAddInOutput {
        return create_connect_client_add_in.execute(self, allocator, input, options);
    }

    /// Creates the specified connection alias for use with cross-Region
    /// redirection. For more
    /// information, see [ Cross-Region
    /// Redirection for Amazon
    /// WorkSpaces](https://docs.aws.amazon.com/workspaces/latest/adminguide/cross-region-redirection.html).
    pub fn createConnectionAlias(self: *Self, allocator: std.mem.Allocator, input: create_connection_alias.CreateConnectionAliasInput, options: CallOptions) !create_connection_alias.CreateConnectionAliasOutput {
        return create_connection_alias.execute(self, allocator, input, options);
    }

    /// Creates an IP access control group.
    ///
    /// An IP access control group provides you with the ability to control the IP
    /// addresses
    /// from which users are allowed to access their WorkSpaces. To specify the CIDR
    /// address
    /// ranges, add rules to your IP access control group and then associate the
    /// group with your
    /// directory. You can add rules when you create the group or at any time using
    /// AuthorizeIpRules.
    ///
    /// There is a default IP access control group associated with your directory.
    /// If you don't
    /// associate an IP access control group with your directory, the default group
    /// is used. The
    /// default group includes a default rule that allows users to access their
    /// WorkSpaces from
    /// anywhere. You cannot modify the default IP access control group for your
    /// directory.
    pub fn createIpGroup(self: *Self, allocator: std.mem.Allocator, input: create_ip_group.CreateIpGroupInput, options: CallOptions) !create_ip_group.CreateIpGroupOutput {
        return create_ip_group.execute(self, allocator, input, options);
    }

    /// Creates a standby WorkSpace in a secondary Region.
    pub fn createStandbyWorkspaces(self: *Self, allocator: std.mem.Allocator, input: create_standby_workspaces.CreateStandbyWorkspacesInput, options: CallOptions) !create_standby_workspaces.CreateStandbyWorkspacesOutput {
        return create_standby_workspaces.execute(self, allocator, input, options);
    }

    /// Creates the specified tags for the specified WorkSpaces resource.
    pub fn createTags(self: *Self, allocator: std.mem.Allocator, input: create_tags.CreateTagsInput, options: CallOptions) !create_tags.CreateTagsOutput {
        return create_tags.execute(self, allocator, input, options);
    }

    /// Creates a new updated WorkSpace image based on the specified source image.
    /// The new
    /// updated WorkSpace image has the latest drivers and other updates required by
    /// the
    /// Amazon WorkSpaces components.
    ///
    /// To determine which WorkSpace images need to be updated with the latest
    /// Amazon WorkSpaces
    /// requirements, use [
    /// DescribeWorkspaceImages](https://docs.aws.amazon.com/workspaces/latest/api/API_DescribeWorkspaceImages.html).
    ///
    /// * Only Windows 10, Windows Server 2016, and Windows Server 2019 WorkSpace
    ///   images
    /// can be programmatically updated at this time.
    ///
    /// * Microsoft Windows updates and other application updates are not included
    ///   in the
    /// update process.
    ///
    /// * The source WorkSpace image is not deleted. You can delete the source image
    /// after you've verified your new updated image and created a new bundle.
    pub fn createUpdatedWorkspaceImage(self: *Self, allocator: std.mem.Allocator, input: create_updated_workspace_image.CreateUpdatedWorkspaceImageInput, options: CallOptions) !create_updated_workspace_image.CreateUpdatedWorkspaceImageOutput {
        return create_updated_workspace_image.execute(self, allocator, input, options);
    }

    /// Creates the specified WorkSpace bundle. For more information about creating
    /// WorkSpace bundles, see
    /// [
    /// Create a Custom WorkSpaces Image and
    /// Bundle](https://docs.aws.amazon.com/workspaces/latest/adminguide/create-custom-bundle.html).
    pub fn createWorkspaceBundle(self: *Self, allocator: std.mem.Allocator, input: create_workspace_bundle.CreateWorkspaceBundleInput, options: CallOptions) !create_workspace_bundle.CreateWorkspaceBundleOutput {
        return create_workspace_bundle.execute(self, allocator, input, options);
    }

    /// Creates a new WorkSpace image from an existing WorkSpace.
    pub fn createWorkspaceImage(self: *Self, allocator: std.mem.Allocator, input: create_workspace_image.CreateWorkspaceImageInput, options: CallOptions) !create_workspace_image.CreateWorkspaceImageOutput {
        return create_workspace_image.execute(self, allocator, input, options);
    }

    /// Creates one or more WorkSpaces.
    ///
    /// This operation is asynchronous and returns before the WorkSpaces are
    /// created.
    ///
    /// * The `MANUAL` running mode value is only supported by Amazon WorkSpaces
    /// Core. Contact your account team to be allow-listed to use this value. For
    /// more
    /// information, see [Amazon WorkSpaces
    /// Core](http://aws.amazon.com/workspaces/core/).
    ///
    /// * You don't need to specify the `PCOIP` protocol for Linux bundles
    /// because `DCV` (formerly WSP) is the default protocol for those bundles.
    ///
    /// * User-decoupled WorkSpaces are only supported by Amazon WorkSpaces
    /// Core.
    ///
    /// * Review your running mode to ensure you are using one that is optimal for
    ///   your needs and budget.
    /// For more information on switching running modes, see
    /// [
    /// Can I switch between hourly and monthly
    /// billing?](http://aws.amazon.com/workspaces-family/workspaces/faqs/#:~:text=Can%20I%20switch%20between%20hourly%20and%20monthly%20billing%20on%20WorkSpaces%20Personal%3F)
    pub fn createWorkspaces(self: *Self, allocator: std.mem.Allocator, input: create_workspaces.CreateWorkspacesInput, options: CallOptions) !create_workspaces.CreateWorkspacesOutput {
        return create_workspaces.execute(self, allocator, input, options);
    }

    /// Creates a pool of WorkSpaces.
    pub fn createWorkspacesPool(self: *Self, allocator: std.mem.Allocator, input: create_workspaces_pool.CreateWorkspacesPoolInput, options: CallOptions) !create_workspaces_pool.CreateWorkspacesPoolOutput {
        return create_workspaces_pool.execute(self, allocator, input, options);
    }

    /// Deletes the account link invitation.
    pub fn deleteAccountLinkInvitation(self: *Self, allocator: std.mem.Allocator, input: delete_account_link_invitation.DeleteAccountLinkInvitationInput, options: CallOptions) !delete_account_link_invitation.DeleteAccountLinkInvitationOutput {
        return delete_account_link_invitation.execute(self, allocator, input, options);
    }

    /// Deletes customized client branding. Client branding allows you to customize
    /// your
    /// WorkSpace's client login portal. You can tailor your login portal company
    /// logo, the support
    /// email address, support link, link to reset password, and a custom message
    /// for users trying
    /// to sign in.
    ///
    /// After you delete your customized client branding, your login portal reverts
    /// to the
    /// default client branding.
    pub fn deleteClientBranding(self: *Self, allocator: std.mem.Allocator, input: delete_client_branding.DeleteClientBrandingInput, options: CallOptions) !delete_client_branding.DeleteClientBrandingOutput {
        return delete_client_branding.execute(self, allocator, input, options);
    }

    /// Deletes a client-add-in for Amazon Connect that is configured within a
    /// directory.
    pub fn deleteConnectClientAddIn(self: *Self, allocator: std.mem.Allocator, input: delete_connect_client_add_in.DeleteConnectClientAddInInput, options: CallOptions) !delete_connect_client_add_in.DeleteConnectClientAddInOutput {
        return delete_connect_client_add_in.execute(self, allocator, input, options);
    }

    /// Deletes the specified connection alias. For more information, see [
    /// Cross-Region Redirection for Amazon
    /// WorkSpaces](https://docs.aws.amazon.com/workspaces/latest/adminguide/cross-region-redirection.html).
    ///
    /// **If you will no longer be using a fully qualified domain name
    /// (FQDN) as the registration code for your WorkSpaces users, you must take
    /// certain
    /// precautions to prevent potential security issues.** For more information,
    /// see [ Security Considerations if You Stop Using Cross-Region
    /// Redirection](https://docs.aws.amazon.com/workspaces/latest/adminguide/cross-region-redirection.html#cross-region-redirection-security-considerations).
    ///
    /// To delete a connection alias that has been shared, the shared account must
    /// first
    /// disassociate the connection alias from any directories it has been
    /// associated with. Then
    /// you must unshare the connection alias from the account it has been shared
    /// with. You can
    /// delete a connection alias only after it is no longer shared with any
    /// accounts or
    /// associated with any directories.
    pub fn deleteConnectionAlias(self: *Self, allocator: std.mem.Allocator, input: delete_connection_alias.DeleteConnectionAliasInput, options: CallOptions) !delete_connection_alias.DeleteConnectionAliasOutput {
        return delete_connection_alias.execute(self, allocator, input, options);
    }

    /// Deletes the specified IP access control group.
    ///
    /// You cannot delete an IP access control group that is associated with a
    /// directory.
    pub fn deleteIpGroup(self: *Self, allocator: std.mem.Allocator, input: delete_ip_group.DeleteIpGroupInput, options: CallOptions) !delete_ip_group.DeleteIpGroupOutput {
        return delete_ip_group.execute(self, allocator, input, options);
    }

    /// Deletes the specified tags from the specified WorkSpaces resource.
    pub fn deleteTags(self: *Self, allocator: std.mem.Allocator, input: delete_tags.DeleteTagsInput, options: CallOptions) !delete_tags.DeleteTagsOutput {
        return delete_tags.execute(self, allocator, input, options);
    }

    /// Deletes the specified WorkSpace bundle. For more information about deleting
    /// WorkSpace bundles, see
    /// [
    /// Delete a Custom WorkSpaces Bundle or
    /// Image](https://docs.aws.amazon.com/workspaces/latest/adminguide/delete_bundle.html).
    pub fn deleteWorkspaceBundle(self: *Self, allocator: std.mem.Allocator, input: delete_workspace_bundle.DeleteWorkspaceBundleInput, options: CallOptions) !delete_workspace_bundle.DeleteWorkspaceBundleOutput {
        return delete_workspace_bundle.execute(self, allocator, input, options);
    }

    /// Deletes the specified image from your account. To delete an image, you must
    /// first delete
    /// any bundles that are associated with the image and unshare the image if it
    /// is shared with
    /// other accounts.
    pub fn deleteWorkspaceImage(self: *Self, allocator: std.mem.Allocator, input: delete_workspace_image.DeleteWorkspaceImageInput, options: CallOptions) !delete_workspace_image.DeleteWorkspaceImageOutput {
        return delete_workspace_image.execute(self, allocator, input, options);
    }

    /// Deploys associated applications to the specified WorkSpace
    pub fn deployWorkspaceApplications(self: *Self, allocator: std.mem.Allocator, input: deploy_workspace_applications.DeployWorkspaceApplicationsInput, options: CallOptions) !deploy_workspace_applications.DeployWorkspaceApplicationsOutput {
        return deploy_workspace_applications.execute(self, allocator, input, options);
    }

    /// Deregisters the specified directory. This operation is asynchronous and
    /// returns before
    /// the WorkSpace directory is deregistered. If any WorkSpaces are registered to
    /// this
    /// directory, you must remove them before you can deregister the directory.
    ///
    /// Simple AD and AD Connector are made available to you free of charge to use
    /// with
    /// WorkSpaces. If there are no WorkSpaces being used with your Simple AD or AD
    /// Connector
    /// directory for 30 consecutive days, this directory will be automatically
    /// deregistered for
    /// use with Amazon WorkSpaces, and you will be charged for this directory as
    /// per the [Directory Service pricing
    /// terms](http://aws.amazon.com/directoryservice/pricing/).
    ///
    /// To delete empty directories, see [ Delete the
    /// Directory for Your
    /// WorkSpaces](https://docs.aws.amazon.com/workspaces/latest/adminguide/delete-workspaces-directory.html). If you delete your Simple AD or AD Connector
    /// directory, you can always create a new one when you want to start using
    /// WorkSpaces
    /// again.
    pub fn deregisterWorkspaceDirectory(self: *Self, allocator: std.mem.Allocator, input: deregister_workspace_directory.DeregisterWorkspaceDirectoryInput, options: CallOptions) !deregister_workspace_directory.DeregisterWorkspaceDirectoryOutput {
        return deregister_workspace_directory.execute(self, allocator, input, options);
    }

    /// Retrieves a list that describes the configuration of Bring Your Own License
    /// (BYOL) for
    /// the specified account.
    pub fn describeAccount(self: *Self, allocator: std.mem.Allocator, input: describe_account.DescribeAccountInput, options: CallOptions) !describe_account.DescribeAccountOutput {
        return describe_account.execute(self, allocator, input, options);
    }

    /// Retrieves a list that describes modifications to the configuration of Bring
    /// Your Own
    /// License (BYOL) for the specified account.
    pub fn describeAccountModifications(self: *Self, allocator: std.mem.Allocator, input: describe_account_modifications.DescribeAccountModificationsInput, options: CallOptions) !describe_account_modifications.DescribeAccountModificationsOutput {
        return describe_account_modifications.execute(self, allocator, input, options);
    }

    /// Describes the associations between the application and the specified
    /// associated resources.
    pub fn describeApplicationAssociations(self: *Self, allocator: std.mem.Allocator, input: describe_application_associations.DescribeApplicationAssociationsInput, options: CallOptions) !describe_application_associations.DescribeApplicationAssociationsOutput {
        return describe_application_associations.execute(self, allocator, input, options);
    }

    /// Describes the specified applications by filtering based on their compute
    /// types, license availability, operating systems, and owners.
    pub fn describeApplications(self: *Self, allocator: std.mem.Allocator, input: describe_applications.DescribeApplicationsInput, options: CallOptions) !describe_applications.DescribeApplicationsOutput {
        return describe_applications.execute(self, allocator, input, options);
    }

    /// Describes the associations between the applications and the specified
    /// bundle.
    pub fn describeBundleAssociations(self: *Self, allocator: std.mem.Allocator, input: describe_bundle_associations.DescribeBundleAssociationsInput, options: CallOptions) !describe_bundle_associations.DescribeBundleAssociationsOutput {
        return describe_bundle_associations.execute(self, allocator, input, options);
    }

    /// Describes the specified client branding. Client branding allows you to
    /// customize the log
    /// in page of various device types for your users. You can add your company
    /// logo, the support
    /// email address, support link, link to reset password, and a custom message
    /// for users trying
    /// to sign in.
    ///
    /// Only device types that have branding information configured will be shown in
    /// the
    /// response.
    pub fn describeClientBranding(self: *Self, allocator: std.mem.Allocator, input: describe_client_branding.DescribeClientBrandingInput, options: CallOptions) !describe_client_branding.DescribeClientBrandingOutput {
        return describe_client_branding.execute(self, allocator, input, options);
    }

    /// Retrieves a list that describes one or more specified Amazon WorkSpaces
    /// clients.
    pub fn describeClientProperties(self: *Self, allocator: std.mem.Allocator, input: describe_client_properties.DescribeClientPropertiesInput, options: CallOptions) !describe_client_properties.DescribeClientPropertiesOutput {
        return describe_client_properties.execute(self, allocator, input, options);
    }

    /// Retrieves a list of Amazon Connect client add-ins that have been created.
    pub fn describeConnectClientAddIns(self: *Self, allocator: std.mem.Allocator, input: describe_connect_client_add_ins.DescribeConnectClientAddInsInput, options: CallOptions) !describe_connect_client_add_ins.DescribeConnectClientAddInsOutput {
        return describe_connect_client_add_ins.execute(self, allocator, input, options);
    }

    /// Describes the permissions that the owner of a connection alias has granted
    /// to another
    /// Amazon Web Services account for the specified connection alias. For more
    /// information, see
    /// [ Cross-Region
    /// Redirection for Amazon
    /// WorkSpaces](https://docs.aws.amazon.com/workspaces/latest/adminguide/cross-region-redirection.html).
    pub fn describeConnectionAliasPermissions(self: *Self, allocator: std.mem.Allocator, input: describe_connection_alias_permissions.DescribeConnectionAliasPermissionsInput, options: CallOptions) !describe_connection_alias_permissions.DescribeConnectionAliasPermissionsOutput {
        return describe_connection_alias_permissions.execute(self, allocator, input, options);
    }

    /// Retrieves a list that describes the connection aliases used for cross-Region
    /// redirection. For more information, see [ Cross-Region
    /// Redirection for Amazon
    /// WorkSpaces](https://docs.aws.amazon.com/workspaces/latest/adminguide/cross-region-redirection.html).
    pub fn describeConnectionAliases(self: *Self, allocator: std.mem.Allocator, input: describe_connection_aliases.DescribeConnectionAliasesInput, options: CallOptions) !describe_connection_aliases.DescribeConnectionAliasesOutput {
        return describe_connection_aliases.execute(self, allocator, input, options);
    }

    /// Retrieves information about a WorkSpace BYOL image being imported via
    /// ImportCustomWorkspaceImage.
    pub fn describeCustomWorkspaceImageImport(self: *Self, allocator: std.mem.Allocator, input: describe_custom_workspace_image_import.DescribeCustomWorkspaceImageImportInput, options: CallOptions) !describe_custom_workspace_image_import.DescribeCustomWorkspaceImageImportOutput {
        return describe_custom_workspace_image_import.execute(self, allocator, input, options);
    }

    /// Describes the associations between the applications and the specified image.
    pub fn describeImageAssociations(self: *Self, allocator: std.mem.Allocator, input: describe_image_associations.DescribeImageAssociationsInput, options: CallOptions) !describe_image_associations.DescribeImageAssociationsOutput {
        return describe_image_associations.execute(self, allocator, input, options);
    }

    /// Describes one or more of your IP access control groups.
    pub fn describeIpGroups(self: *Self, allocator: std.mem.Allocator, input: describe_ip_groups.DescribeIpGroupsInput, options: CallOptions) !describe_ip_groups.DescribeIpGroupsOutput {
        return describe_ip_groups.execute(self, allocator, input, options);
    }

    /// Describes the specified tags for the specified WorkSpaces resource.
    pub fn describeTags(self: *Self, allocator: std.mem.Allocator, input: describe_tags.DescribeTagsInput, options: CallOptions) !describe_tags.DescribeTagsOutput {
        return describe_tags.execute(self, allocator, input, options);
    }

    /// Describes the associations betweens applications and the specified
    /// WorkSpace.
    pub fn describeWorkspaceAssociations(self: *Self, allocator: std.mem.Allocator, input: describe_workspace_associations.DescribeWorkspaceAssociationsInput, options: CallOptions) !describe_workspace_associations.DescribeWorkspaceAssociationsOutput {
        return describe_workspace_associations.execute(self, allocator, input, options);
    }

    /// Retrieves a list that describes the available WorkSpace bundles.
    ///
    /// You can filter the results using either bundle ID or owner, but not both.
    pub fn describeWorkspaceBundles(self: *Self, allocator: std.mem.Allocator, input: describe_workspace_bundles.DescribeWorkspaceBundlesInput, options: CallOptions) !describe_workspace_bundles.DescribeWorkspaceBundlesOutput {
        return describe_workspace_bundles.execute(self, allocator, input, options);
    }

    /// Describes the available directories that are registered with Amazon
    /// WorkSpaces.
    pub fn describeWorkspaceDirectories(self: *Self, allocator: std.mem.Allocator, input: describe_workspace_directories.DescribeWorkspaceDirectoriesInput, options: CallOptions) !describe_workspace_directories.DescribeWorkspaceDirectoriesOutput {
        return describe_workspace_directories.execute(self, allocator, input, options);
    }

    /// Describes the permissions that the owner of an image has granted to other
    /// Amazon Web Services accounts for an image.
    pub fn describeWorkspaceImagePermissions(self: *Self, allocator: std.mem.Allocator, input: describe_workspace_image_permissions.DescribeWorkspaceImagePermissionsInput, options: CallOptions) !describe_workspace_image_permissions.DescribeWorkspaceImagePermissionsOutput {
        return describe_workspace_image_permissions.execute(self, allocator, input, options);
    }

    /// Retrieves a list that describes one or more specified images, if the image
    /// identifiers
    /// are provided. Otherwise, all images in the account are described.
    pub fn describeWorkspaceImages(self: *Self, allocator: std.mem.Allocator, input: describe_workspace_images.DescribeWorkspaceImagesInput, options: CallOptions) !describe_workspace_images.DescribeWorkspaceImagesOutput {
        return describe_workspace_images.execute(self, allocator, input, options);
    }

    /// Describes the snapshots for the specified WorkSpace.
    pub fn describeWorkspaceSnapshots(self: *Self, allocator: std.mem.Allocator, input: describe_workspace_snapshots.DescribeWorkspaceSnapshotsInput, options: CallOptions) !describe_workspace_snapshots.DescribeWorkspaceSnapshotsOutput {
        return describe_workspace_snapshots.execute(self, allocator, input, options);
    }

    /// Describes the specified WorkSpaces.
    ///
    /// You can filter the results by using the bundle identifier, directory
    /// identifier, or
    /// owner, but you can specify only one filter at a time.
    pub fn describeWorkspaces(self: *Self, allocator: std.mem.Allocator, input: describe_workspaces.DescribeWorkspacesInput, options: CallOptions) !describe_workspaces.DescribeWorkspacesOutput {
        return describe_workspaces.execute(self, allocator, input, options);
    }

    /// Describes the connection status of the specified WorkSpaces.
    pub fn describeWorkspacesConnectionStatus(self: *Self, allocator: std.mem.Allocator, input: describe_workspaces_connection_status.DescribeWorkspacesConnectionStatusInput, options: CallOptions) !describe_workspaces_connection_status.DescribeWorkspacesConnectionStatusOutput {
        return describe_workspaces_connection_status.execute(self, allocator, input, options);
    }

    /// Retrieves a list that describes the streaming sessions for a specified pool.
    pub fn describeWorkspacesPoolSessions(self: *Self, allocator: std.mem.Allocator, input: describe_workspaces_pool_sessions.DescribeWorkspacesPoolSessionsInput, options: CallOptions) !describe_workspaces_pool_sessions.DescribeWorkspacesPoolSessionsOutput {
        return describe_workspaces_pool_sessions.execute(self, allocator, input, options);
    }

    /// Describes the specified WorkSpaces Pools.
    pub fn describeWorkspacesPools(self: *Self, allocator: std.mem.Allocator, input: describe_workspaces_pools.DescribeWorkspacesPoolsInput, options: CallOptions) !describe_workspaces_pools.DescribeWorkspacesPoolsOutput {
        return describe_workspaces_pools.execute(self, allocator, input, options);
    }

    /// Disassociates a connection alias from a directory. Disassociating a
    /// connection alias
    /// disables cross-Region redirection between two directories in different
    /// Regions. For more
    /// information, see [ Cross-Region
    /// Redirection for Amazon
    /// WorkSpaces](https://docs.aws.amazon.com/workspaces/latest/adminguide/cross-region-redirection.html).
    ///
    /// Before performing this operation, call [
    /// DescribeConnectionAliases](https://docs.aws.amazon.com/workspaces/latest/api/API_DescribeConnectionAliases.html) to make sure that the current state of the
    /// connection alias is `CREATED`.
    pub fn disassociateConnectionAlias(self: *Self, allocator: std.mem.Allocator, input: disassociate_connection_alias.DisassociateConnectionAliasInput, options: CallOptions) !disassociate_connection_alias.DisassociateConnectionAliasOutput {
        return disassociate_connection_alias.execute(self, allocator, input, options);
    }

    /// Disassociates the specified IP access control group from the specified
    /// directory.
    pub fn disassociateIpGroups(self: *Self, allocator: std.mem.Allocator, input: disassociate_ip_groups.DisassociateIpGroupsInput, options: CallOptions) !disassociate_ip_groups.DisassociateIpGroupsOutput {
        return disassociate_ip_groups.execute(self, allocator, input, options);
    }

    /// Disassociates the specified application from a WorkSpace.
    pub fn disassociateWorkspaceApplication(self: *Self, allocator: std.mem.Allocator, input: disassociate_workspace_application.DisassociateWorkspaceApplicationInput, options: CallOptions) !disassociate_workspace_application.DisassociateWorkspaceApplicationOutput {
        return disassociate_workspace_application.execute(self, allocator, input, options);
    }

    /// Retrieves account link information.
    pub fn getAccountLink(self: *Self, allocator: std.mem.Allocator, input: get_account_link.GetAccountLinkInput, options: CallOptions) !get_account_link.GetAccountLinkOutput {
        return get_account_link.execute(self, allocator, input, options);
    }

    /// Imports client branding. Client branding allows you to customize your
    /// WorkSpace's client
    /// login portal. You can tailor your login portal company logo, the support
    /// email address,
    /// support link, link to reset password, and a custom message for users trying
    /// to sign
    /// in.
    ///
    /// After you import client branding, the default branding experience for the
    /// specified
    /// platform type is replaced with the imported experience
    ///
    /// * You must specify at least one platform type when importing client
    /// branding.
    ///
    /// * You can import up to 6 MB of data with each request. If your request
    ///   exceeds
    /// this limit, you can import client branding for different platform types
    /// using
    /// separate requests.
    ///
    /// * In each platform type, the `SupportEmail` and
    /// `SupportLink` parameters are mutually exclusive. You can specify
    /// only one parameter for each platform type, but not both.
    ///
    /// * Imported data can take up to a minute to appear in the WorkSpaces
    /// client.
    pub fn importClientBranding(self: *Self, allocator: std.mem.Allocator, input: import_client_branding.ImportClientBrandingInput, options: CallOptions) !import_client_branding.ImportClientBrandingOutput {
        return import_client_branding.execute(self, allocator, input, options);
    }

    /// Imports the specified Windows 10 or 11 Bring Your Own License (BYOL)
    /// image into Amazon WorkSpaces using EC2 Image Builder. The image must be an
    /// already licensed image that is
    /// in your Amazon Web Services account, and you must own the image. For more
    /// information about
    /// creating BYOL images, see [ Bring Your Own Windows
    /// Desktop
    /// Licenses](https://docs.aws.amazon.com/workspaces/latest/adminguide/byol-windows-images.html).
    pub fn importCustomWorkspaceImage(self: *Self, allocator: std.mem.Allocator, input: import_custom_workspace_image.ImportCustomWorkspaceImageInput, options: CallOptions) !import_custom_workspace_image.ImportCustomWorkspaceImageOutput {
        return import_custom_workspace_image.execute(self, allocator, input, options);
    }

    /// Imports the specified Windows 10 or 11 Bring Your Own License (BYOL)
    /// image into Amazon WorkSpaces. The image must be an already licensed Amazon
    /// EC2 image that is
    /// in your Amazon Web Services account, and you must own the image. For more
    /// information about
    /// creating BYOL images, see [ Bring Your Own Windows
    /// Desktop
    /// Licenses](https://docs.aws.amazon.com/workspaces/latest/adminguide/byol-windows-images.html).
    pub fn importWorkspaceImage(self: *Self, allocator: std.mem.Allocator, input: import_workspace_image.ImportWorkspaceImageInput, options: CallOptions) !import_workspace_image.ImportWorkspaceImageOutput {
        return import_workspace_image.execute(self, allocator, input, options);
    }

    /// Lists all account links.
    pub fn listAccountLinks(self: *Self, allocator: std.mem.Allocator, input: list_account_links.ListAccountLinksInput, options: CallOptions) !list_account_links.ListAccountLinksOutput {
        return list_account_links.execute(self, allocator, input, options);
    }

    /// Retrieves a list of IP address ranges, specified as IPv4 CIDR blocks, that
    /// you can use
    /// for the network management interface when you enable Bring Your Own License
    /// (BYOL).
    ///
    /// This operation can be run only by Amazon Web Services accounts that are
    /// enabled for BYOL.
    /// If your account isn't enabled for BYOL, you'll receive an
    /// `AccessDeniedException` error.
    ///
    /// The management network interface is connected to a secure Amazon WorkSpaces
    /// management
    /// network. It is used for interactive streaming of the WorkSpace desktop to
    /// Amazon WorkSpaces
    /// clients, and to allow Amazon WorkSpaces to manage the WorkSpace.
    pub fn listAvailableManagementCidrRanges(self: *Self, allocator: std.mem.Allocator, input: list_available_management_cidr_ranges.ListAvailableManagementCidrRangesInput, options: CallOptions) !list_available_management_cidr_ranges.ListAvailableManagementCidrRangesOutput {
        return list_available_management_cidr_ranges.execute(self, allocator, input, options);
    }

    /// Migrates a WorkSpace from one operating system or bundle type to another,
    /// while
    /// retaining the data on the user volume.
    ///
    /// The migration process recreates the WorkSpace by using a new root volume
    /// from the target
    /// bundle image and the user volume from the last available snapshot of the
    /// original
    /// WorkSpace. During migration, the original `D:\Users\%USERNAME%` user profile
    /// folder is renamed to `D:\Users\%USERNAME%MMddyyTHHmmss%.NotMigrated`. A new
    /// `D:\Users\%USERNAME%\` folder is generated by the new OS. Certain files in
    /// the old user profile are moved to the new user profile.
    ///
    /// For available migration scenarios, details about what happens during
    /// migration, and best
    /// practices, see [Migrate a
    /// WorkSpace](https://docs.aws.amazon.com/workspaces/latest/adminguide/migrate-workspaces.html).
    pub fn migrateWorkspace(self: *Self, allocator: std.mem.Allocator, input: migrate_workspace.MigrateWorkspaceInput, options: CallOptions) !migrate_workspace.MigrateWorkspaceOutput {
        return migrate_workspace.execute(self, allocator, input, options);
    }

    /// Modifies the configuration of Bring Your Own License (BYOL) for the
    /// specified
    /// account.
    pub fn modifyAccount(self: *Self, allocator: std.mem.Allocator, input: modify_account.ModifyAccountInput, options: CallOptions) !modify_account.ModifyAccountOutput {
        return modify_account.execute(self, allocator, input, options);
    }

    /// Modifies the properties of the certificate-based authentication you want
    /// to use with your WorkSpaces.
    pub fn modifyCertificateBasedAuthProperties(self: *Self, allocator: std.mem.Allocator, input: modify_certificate_based_auth_properties.ModifyCertificateBasedAuthPropertiesInput, options: CallOptions) !modify_certificate_based_auth_properties.ModifyCertificateBasedAuthPropertiesOutput {
        return modify_certificate_based_auth_properties.execute(self, allocator, input, options);
    }

    /// Modifies the properties of the specified Amazon WorkSpaces clients.
    pub fn modifyClientProperties(self: *Self, allocator: std.mem.Allocator, input: modify_client_properties.ModifyClientPropertiesInput, options: CallOptions) !modify_client_properties.ModifyClientPropertiesOutput {
        return modify_client_properties.execute(self, allocator, input, options);
    }

    /// Modifies the endpoint encryption mode that allows you to configure the
    /// specified
    /// directory between Standard TLS and FIPS 140-2 validated mode.
    pub fn modifyEndpointEncryptionMode(self: *Self, allocator: std.mem.Allocator, input: modify_endpoint_encryption_mode.ModifyEndpointEncryptionModeInput, options: CallOptions) !modify_endpoint_encryption_mode.ModifyEndpointEncryptionModeOutput {
        return modify_endpoint_encryption_mode.execute(self, allocator, input, options);
    }

    /// Modifies multiple properties related to SAML 2.0 authentication, including
    /// the enablement status,
    /// user access URL, and relay state parameter name that are used for
    /// configuring federation with an
    /// SAML 2.0 identity provider.
    pub fn modifySamlProperties(self: *Self, allocator: std.mem.Allocator, input: modify_saml_properties.ModifySamlPropertiesInput, options: CallOptions) !modify_saml_properties.ModifySamlPropertiesOutput {
        return modify_saml_properties.execute(self, allocator, input, options);
    }

    /// Modifies the self-service WorkSpace management capabilities for your users.
    /// For more
    /// information, see [Enable Self-Service WorkSpace Management Capabilities for
    /// Your
    /// Users](https://docs.aws.amazon.com/workspaces/latest/adminguide/enable-user-self-service-workspace-management.html).
    pub fn modifySelfservicePermissions(self: *Self, allocator: std.mem.Allocator, input: modify_selfservice_permissions.ModifySelfservicePermissionsInput, options: CallOptions) !modify_selfservice_permissions.ModifySelfservicePermissionsOutput {
        return modify_selfservice_permissions.execute(self, allocator, input, options);
    }

    /// Modifies the specified streaming properties.
    pub fn modifyStreamingProperties(self: *Self, allocator: std.mem.Allocator, input: modify_streaming_properties.ModifyStreamingPropertiesInput, options: CallOptions) !modify_streaming_properties.ModifyStreamingPropertiesOutput {
        return modify_streaming_properties.execute(self, allocator, input, options);
    }

    /// Specifies which devices and operating systems users can use to access their
    /// WorkSpaces.
    /// For more information, see [
    /// Control Device
    /// Access](https://docs.aws.amazon.com/workspaces/latest/adminguide/update-directory-details.html#control-device-access).
    pub fn modifyWorkspaceAccessProperties(self: *Self, allocator: std.mem.Allocator, input: modify_workspace_access_properties.ModifyWorkspaceAccessPropertiesInput, options: CallOptions) !modify_workspace_access_properties.ModifyWorkspaceAccessPropertiesOutput {
        return modify_workspace_access_properties.execute(self, allocator, input, options);
    }

    /// Modify the default properties used to create WorkSpaces.
    pub fn modifyWorkspaceCreationProperties(self: *Self, allocator: std.mem.Allocator, input: modify_workspace_creation_properties.ModifyWorkspaceCreationPropertiesInput, options: CallOptions) !modify_workspace_creation_properties.ModifyWorkspaceCreationPropertiesOutput {
        return modify_workspace_creation_properties.execute(self, allocator, input, options);
    }

    /// Modifies the specified WorkSpace properties. For important information about
    /// how to
    /// modify the size of the root and user volumes, see [ Modify a
    /// WorkSpace](https://docs.aws.amazon.com/workspaces/latest/adminguide/modify-workspaces.html).
    ///
    /// The `MANUAL` running mode value is only supported by Amazon WorkSpaces
    /// Core. Contact your account team to be allow-listed to use this value. For
    /// more
    /// information, see [Amazon WorkSpaces
    /// Core](http://aws.amazon.com/workspaces/core/).
    pub fn modifyWorkspaceProperties(self: *Self, allocator: std.mem.Allocator, input: modify_workspace_properties.ModifyWorkspacePropertiesInput, options: CallOptions) !modify_workspace_properties.ModifyWorkspacePropertiesOutput {
        return modify_workspace_properties.execute(self, allocator, input, options);
    }

    /// Sets the state of the specified WorkSpace.
    ///
    /// To maintain a WorkSpace without being interrupted, set the WorkSpace state
    /// to
    /// `ADMIN_MAINTENANCE`. WorkSpaces in this state do not respond to requests to
    /// reboot, stop, start, rebuild, or restore. An AutoStop WorkSpace in this
    /// state is not
    /// stopped. Users cannot log into a WorkSpace in the `ADMIN_MAINTENANCE`
    /// state.
    pub fn modifyWorkspaceState(self: *Self, allocator: std.mem.Allocator, input: modify_workspace_state.ModifyWorkspaceStateInput, options: CallOptions) !modify_workspace_state.ModifyWorkspaceStateOutput {
        return modify_workspace_state.execute(self, allocator, input, options);
    }

    /// Reboots the specified WorkSpaces.
    ///
    /// You cannot reboot a WorkSpace unless its state is `AVAILABLE`,
    /// `UNHEALTHY`, or `REBOOTING`. Reboot a WorkSpace in the `REBOOTING`
    /// state only if your WorkSpace has been stuck in the `REBOOTING` state for
    /// over 20 minutes.
    ///
    /// This operation is asynchronous and returns before the WorkSpaces have
    /// rebooted.
    pub fn rebootWorkspaces(self: *Self, allocator: std.mem.Allocator, input: reboot_workspaces.RebootWorkspacesInput, options: CallOptions) !reboot_workspaces.RebootWorkspacesOutput {
        return reboot_workspaces.execute(self, allocator, input, options);
    }

    /// Rebuilds the specified WorkSpace.
    ///
    /// You cannot rebuild a WorkSpace unless its state is `AVAILABLE`,
    /// `ERROR`, `UNHEALTHY`, `STOPPED`, or
    /// `REBOOTING`.
    ///
    /// Rebuilding a WorkSpace is a potentially destructive action that can result
    /// in the loss
    /// of data. For more information, see [Rebuild a
    /// WorkSpace](https://docs.aws.amazon.com/workspaces/latest/adminguide/reset-workspace.html).
    ///
    /// This operation is asynchronous and returns before the WorkSpaces have been
    /// completely
    /// rebuilt.
    pub fn rebuildWorkspaces(self: *Self, allocator: std.mem.Allocator, input: rebuild_workspaces.RebuildWorkspacesInput, options: CallOptions) !rebuild_workspaces.RebuildWorkspacesOutput {
        return rebuild_workspaces.execute(self, allocator, input, options);
    }

    /// Registers the specified directory. This operation is asynchronous and
    /// returns before the
    /// WorkSpace directory is registered. If this is the first time you are
    /// registering a
    /// directory, you will need to create the workspaces_DefaultRole role before
    /// you can register
    /// a directory. For more information, see [
    /// Creating the workspaces_DefaultRole
    /// Role](https://docs.aws.amazon.com/workspaces/latest/adminguide/workspaces-access-control.html#create-default-role).
    pub fn registerWorkspaceDirectory(self: *Self, allocator: std.mem.Allocator, input: register_workspace_directory.RegisterWorkspaceDirectoryInput, options: CallOptions) !register_workspace_directory.RegisterWorkspaceDirectoryOutput {
        return register_workspace_directory.execute(self, allocator, input, options);
    }

    /// Rejects the account link invitation.
    pub fn rejectAccountLinkInvitation(self: *Self, allocator: std.mem.Allocator, input: reject_account_link_invitation.RejectAccountLinkInvitationInput, options: CallOptions) !reject_account_link_invitation.RejectAccountLinkInvitationOutput {
        return reject_account_link_invitation.execute(self, allocator, input, options);
    }

    /// Restores the specified WorkSpace to its last known healthy state.
    ///
    /// You cannot restore a WorkSpace unless its state is ` AVAILABLE`,
    /// `ERROR`, `UNHEALTHY`, or `STOPPED`.
    ///
    /// Restoring a WorkSpace is a potentially destructive action that can result in
    /// the loss of
    /// data. For more information, see [Restore a
    /// WorkSpace](https://docs.aws.amazon.com/workspaces/latest/adminguide/restore-workspace.html).
    ///
    /// This operation is asynchronous and returns before the WorkSpace is
    /// completely
    /// restored.
    pub fn restoreWorkspace(self: *Self, allocator: std.mem.Allocator, input: restore_workspace.RestoreWorkspaceInput, options: CallOptions) !restore_workspace.RestoreWorkspaceOutput {
        return restore_workspace.execute(self, allocator, input, options);
    }

    /// Removes one or more rules from the specified IP access control group.
    pub fn revokeIpRules(self: *Self, allocator: std.mem.Allocator, input: revoke_ip_rules.RevokeIpRulesInput, options: CallOptions) !revoke_ip_rules.RevokeIpRulesOutput {
        return revoke_ip_rules.execute(self, allocator, input, options);
    }

    /// Starts the specified WorkSpaces.
    ///
    /// You cannot start a WorkSpace unless it has a running mode of `AutoStop` or
    /// `Manual` and a state of `STOPPED`.
    pub fn startWorkspaces(self: *Self, allocator: std.mem.Allocator, input: start_workspaces.StartWorkspacesInput, options: CallOptions) !start_workspaces.StartWorkspacesOutput {
        return start_workspaces.execute(self, allocator, input, options);
    }

    /// Starts the specified pool.
    ///
    /// You cannot start a pool unless it has a running mode of
    /// `AutoStop` and a state of `STOPPED`.
    pub fn startWorkspacesPool(self: *Self, allocator: std.mem.Allocator, input: start_workspaces_pool.StartWorkspacesPoolInput, options: CallOptions) !start_workspaces_pool.StartWorkspacesPoolOutput {
        return start_workspaces_pool.execute(self, allocator, input, options);
    }

    /// Stops the specified WorkSpaces.
    ///
    /// You cannot stop a WorkSpace unless it has a running mode of `AutoStop` or
    /// `Manual` and a state of `AVAILABLE`, `IMPAIRED`,
    /// `UNHEALTHY`, or `ERROR`.
    pub fn stopWorkspaces(self: *Self, allocator: std.mem.Allocator, input: stop_workspaces.StopWorkspacesInput, options: CallOptions) !stop_workspaces.StopWorkspacesOutput {
        return stop_workspaces.execute(self, allocator, input, options);
    }

    /// Stops the specified pool.
    ///
    /// You cannot stop a WorkSpace pool unless it has a running mode of `AutoStop`
    /// and a state of `AVAILABLE`, `IMPAIRED`, `UNHEALTHY`, or `ERROR`.
    pub fn stopWorkspacesPool(self: *Self, allocator: std.mem.Allocator, input: stop_workspaces_pool.StopWorkspacesPoolInput, options: CallOptions) !stop_workspaces_pool.StopWorkspacesPoolOutput {
        return stop_workspaces_pool.execute(self, allocator, input, options);
    }

    /// Terminates the specified WorkSpaces.
    ///
    /// Terminating a WorkSpace is a permanent action and cannot be undone. The
    /// user's data
    /// is destroyed. If you need to archive any user data, contact Amazon Web
    /// Services Support before
    /// terminating the WorkSpace.
    ///
    /// You can terminate a WorkSpace that is in any state except `SUSPENDED`.
    ///
    /// This operation is asynchronous and returns before the WorkSpaces have been
    /// completely
    /// terminated. After a WorkSpace is terminated, the `TERMINATED` state is
    /// returned
    /// only briefly before the WorkSpace directory metadata is cleaned up, so this
    /// state is rarely
    /// returned. To confirm that a WorkSpace is terminated, check for the WorkSpace
    /// ID by using
    /// [
    /// DescribeWorkSpaces](https://docs.aws.amazon.com/workspaces/latest/api/API_DescribeWorkspaces.html). If the WorkSpace ID isn't returned, then the WorkSpace has
    /// been successfully terminated.
    ///
    /// Simple AD and AD Connector are made available to you free of charge to use
    /// with
    /// WorkSpaces. If there are no WorkSpaces being used with your Simple AD or AD
    /// Connector
    /// directory for 30 consecutive days, this directory will be automatically
    /// deregistered for
    /// use with Amazon WorkSpaces, and you will be charged for this directory as
    /// per the [Directory Service pricing
    /// terms](http://aws.amazon.com/directoryservice/pricing/).
    ///
    /// To delete empty directories, see [ Delete the
    /// Directory for Your
    /// WorkSpaces](https://docs.aws.amazon.com/workspaces/latest/adminguide/delete-workspaces-directory.html). If you delete your Simple AD or AD Connector
    /// directory, you can always create a new one when you want to start using
    /// WorkSpaces
    /// again.
    pub fn terminateWorkspaces(self: *Self, allocator: std.mem.Allocator, input: terminate_workspaces.TerminateWorkspacesInput, options: CallOptions) !terminate_workspaces.TerminateWorkspacesOutput {
        return terminate_workspaces.execute(self, allocator, input, options);
    }

    /// Terminates the specified pool.
    pub fn terminateWorkspacesPool(self: *Self, allocator: std.mem.Allocator, input: terminate_workspaces_pool.TerminateWorkspacesPoolInput, options: CallOptions) !terminate_workspaces_pool.TerminateWorkspacesPoolOutput {
        return terminate_workspaces_pool.execute(self, allocator, input, options);
    }

    /// Terminates the pool session.
    pub fn terminateWorkspacesPoolSession(self: *Self, allocator: std.mem.Allocator, input: terminate_workspaces_pool_session.TerminateWorkspacesPoolSessionInput, options: CallOptions) !terminate_workspaces_pool_session.TerminateWorkspacesPoolSessionOutput {
        return terminate_workspaces_pool_session.execute(self, allocator, input, options);
    }

    /// Updates a Amazon Connect client add-in. Use this action to update the name
    /// and
    /// endpoint URL of a Amazon Connect client add-in.
    pub fn updateConnectClientAddIn(self: *Self, allocator: std.mem.Allocator, input: update_connect_client_add_in.UpdateConnectClientAddInInput, options: CallOptions) !update_connect_client_add_in.UpdateConnectClientAddInOutput {
        return update_connect_client_add_in.execute(self, allocator, input, options);
    }

    /// Shares or unshares a connection alias with one account by specifying whether
    /// that
    /// account has permission to associate the connection alias with a directory.
    /// If the
    /// association permission is granted, the connection alias is shared with that
    /// account. If the
    /// association permission is revoked, the connection alias is unshared with the
    /// account. For
    /// more information, see [ Cross-Region
    /// Redirection for Amazon
    /// WorkSpaces](https://docs.aws.amazon.com/workspaces/latest/adminguide/cross-region-redirection.html).
    ///
    /// * Before performing this operation, call [
    /// DescribeConnectionAliases](https://docs.aws.amazon.com/workspaces/latest/api/API_DescribeConnectionAliases.html) to make sure that the current state of the
    /// connection alias is `CREATED`.
    ///
    /// * To delete a connection alias that has been shared, the shared account must
    /// first disassociate the connection alias from any directories it has been
    /// associated with. Then you must unshare the connection alias from the account
    /// it
    /// has been shared with. You can delete a connection alias only after it is no
    /// longer
    /// shared with any accounts or associated with any directories.
    pub fn updateConnectionAliasPermission(self: *Self, allocator: std.mem.Allocator, input: update_connection_alias_permission.UpdateConnectionAliasPermissionInput, options: CallOptions) !update_connection_alias_permission.UpdateConnectionAliasPermissionOutput {
        return update_connection_alias_permission.execute(self, allocator, input, options);
    }

    /// Replaces the current rules of the specified IP access control group with the
    /// specified
    /// rules.
    pub fn updateRulesOfIpGroup(self: *Self, allocator: std.mem.Allocator, input: update_rules_of_ip_group.UpdateRulesOfIpGroupInput, options: CallOptions) !update_rules_of_ip_group.UpdateRulesOfIpGroupOutput {
        return update_rules_of_ip_group.execute(self, allocator, input, options);
    }

    /// Updates a WorkSpace bundle with a new image. For more information about
    /// updating WorkSpace bundles, see
    /// [
    /// Update a Custom WorkSpaces
    /// Bundle](https://docs.aws.amazon.com/workspaces/latest/adminguide/update-custom-bundle.html).
    ///
    /// Existing WorkSpaces aren't automatically updated when you update the bundle
    /// that they're
    /// based on. To update existing WorkSpaces that are based on a bundle that
    /// you've updated, you
    /// must either rebuild the WorkSpaces or delete and recreate them.
    pub fn updateWorkspaceBundle(self: *Self, allocator: std.mem.Allocator, input: update_workspace_bundle.UpdateWorkspaceBundleInput, options: CallOptions) !update_workspace_bundle.UpdateWorkspaceBundleOutput {
        return update_workspace_bundle.execute(self, allocator, input, options);
    }

    /// Shares or unshares an image with one account in the same Amazon Web Services
    /// Region by
    /// specifying whether that account has permission to copy the image. If the
    /// copy image
    /// permission is granted, the image is shared with that account. If the copy
    /// image permission
    /// is revoked, the image is unshared with the account.
    ///
    /// After an image has been shared, the recipient account can copy the image to
    /// other
    /// Regions as needed.
    ///
    /// In the China (Ningxia) Region, you can copy images only within the same
    /// Region.
    ///
    /// In Amazon Web Services GovCloud (US), to copy images to and from other
    /// Regions, contact Amazon Web Services Support.
    ///
    /// For more information about sharing images, see [ Share or Unshare a Custom
    /// WorkSpaces
    /// Image](https://docs.aws.amazon.com/workspaces/latest/adminguide/share-custom-image.html).
    ///
    /// * To delete an image that has been shared, you must unshare the image before
    ///   you
    /// delete it.
    ///
    /// * Sharing Bring Your Own License (BYOL) images across Amazon Web Services
    ///   accounts
    /// isn't supported at this time in Amazon Web Services GovCloud (US). To share
    /// BYOL images
    /// across accounts in Amazon Web Services GovCloud (US), contact Amazon Web
    /// Services Support.
    pub fn updateWorkspaceImagePermission(self: *Self, allocator: std.mem.Allocator, input: update_workspace_image_permission.UpdateWorkspaceImagePermissionInput, options: CallOptions) !update_workspace_image_permission.UpdateWorkspaceImagePermissionOutput {
        return update_workspace_image_permission.execute(self, allocator, input, options);
    }

    /// Updates the specified pool.
    pub fn updateWorkspacesPool(self: *Self, allocator: std.mem.Allocator, input: update_workspaces_pool.UpdateWorkspacesPoolInput, options: CallOptions) !update_workspaces_pool.UpdateWorkspacesPoolOutput {
        return update_workspaces_pool.execute(self, allocator, input, options);
    }

    pub fn describeApplicationAssociationsPaginator(self: *Self, params: describe_application_associations.DescribeApplicationAssociationsInput) paginator.DescribeApplicationAssociationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeApplicationsPaginator(self: *Self, params: describe_applications.DescribeApplicationsInput) paginator.DescribeApplicationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeWorkspaceBundlesPaginator(self: *Self, params: describe_workspace_bundles.DescribeWorkspaceBundlesInput) paginator.DescribeWorkspaceBundlesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeWorkspaceDirectoriesPaginator(self: *Self, params: describe_workspace_directories.DescribeWorkspaceDirectoriesInput) paginator.DescribeWorkspaceDirectoriesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeWorkspacesPaginator(self: *Self, params: describe_workspaces.DescribeWorkspacesInput) paginator.DescribeWorkspacesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listAccountLinksPaginator(self: *Self, params: list_account_links.ListAccountLinksInput) paginator.ListAccountLinksPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};
