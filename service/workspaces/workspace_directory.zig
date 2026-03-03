const ActiveDirectoryConfig = @import("active_directory_config.zig").ActiveDirectoryConfig;
const CertificateBasedAuthProperties = @import("certificate_based_auth_properties.zig").CertificateBasedAuthProperties;
const WorkspaceDirectoryType = @import("workspace_directory_type.zig").WorkspaceDirectoryType;
const EndpointEncryptionMode = @import("endpoint_encryption_mode.zig").EndpointEncryptionMode;
const IDCConfig = @import("idc_config.zig").IDCConfig;
const MicrosoftEntraConfig = @import("microsoft_entra_config.zig").MicrosoftEntraConfig;
const SamlProperties = @import("saml_properties.zig").SamlProperties;
const SelfservicePermissions = @import("selfservice_permissions.zig").SelfservicePermissions;
const WorkspaceDirectoryState = @import("workspace_directory_state.zig").WorkspaceDirectoryState;
const StreamingProperties = @import("streaming_properties.zig").StreamingProperties;
const Tenancy = @import("tenancy.zig").Tenancy;
const UserIdentityType = @import("user_identity_type.zig").UserIdentityType;
const WorkspaceAccessProperties = @import("workspace_access_properties.zig").WorkspaceAccessProperties;
const DefaultWorkspaceCreationProperties = @import("default_workspace_creation_properties.zig").DefaultWorkspaceCreationProperties;
const WorkspaceType = @import("workspace_type.zig").WorkspaceType;

/// Describes a directory that is used with Amazon WorkSpaces.
pub const WorkspaceDirectory = struct {
    /// Information about the Active Directory config.
    active_directory_config: ?ActiveDirectoryConfig = null,

    /// The directory alias.
    alias: ?[]const u8 = null,

    /// The certificate-based authentication properties used to authenticate SAML
    /// 2.0 Identity Provider (IdP)
    /// user identities to Active Directory for WorkSpaces login.
    certificate_based_auth_properties: ?CertificateBasedAuthProperties = null,

    /// The user name for the service account.
    customer_user_name: ?[]const u8 = null,

    /// The directory identifier.
    directory_id: ?[]const u8 = null,

    /// The name of the directory.
    directory_name: ?[]const u8 = null,

    /// The directory type.
    directory_type: ?WorkspaceDirectoryType = null,

    /// The IP addresses of the DNS servers for the directory.
    dns_ip_addresses: ?[]const []const u8 = null,

    /// The IPv6 addresses of the DNS servers for the directory.
    dns_ipv_6_addresses: ?[]const []const u8 = null,

    /// Endpoint encryption mode that allows you to configure the specified
    /// directory between
    /// Standard TLS and FIPS 140-2 validated mode.
    endpoint_encryption_mode: ?EndpointEncryptionMode = null,

    /// The error message returned.
    error_message: ?[]const u8 = null,

    /// The identifier of the IAM role. This is the role that allows Amazon
    /// WorkSpaces to make
    /// calls to other services, such as Amazon EC2, on your behalf.
    iam_role_id: ?[]const u8 = null,

    /// Specifies details about identity center configurations.
    idc_config: ?IDCConfig = null,

    /// The identifiers of the IP access control groups associated with the
    /// directory.
    ip_group_ids: ?[]const []const u8 = null,

    /// Specifies details about Microsoft Entra configurations.
    microsoft_entra_config: ?MicrosoftEntraConfig = null,

    /// The registration code for the directory. This is the code that users enter
    /// in their
    /// Amazon WorkSpaces client application to connect to the directory.
    registration_code: ?[]const u8 = null,

    /// Describes the enablement status, user access URL, and relay state parameter
    /// name that are used for configuring
    /// federation with an SAML 2.0 identity provider.
    saml_properties: ?SamlProperties = null,

    /// The default self-service permissions for WorkSpaces in the directory.
    selfservice_permissions: ?SelfservicePermissions = null,

    /// The state of the directory's registration with Amazon WorkSpaces. After a
    /// directory is
    /// deregistered, the `DEREGISTERED` state is returned very briefly before the
    /// directory metadata is cleaned up, so this state is rarely returned. To
    /// confirm that a
    /// directory is deregistered, check for the directory ID by using [
    /// DescribeWorkspaceDirectories](https://docs.aws.amazon.com/workspaces/latest/api/API_DescribeWorkspaceDirectories.html). If the directory ID isn't returned, then the
    /// directory has been successfully deregistered.
    state: ?WorkspaceDirectoryState = null,

    /// The streaming properties to configure.
    streaming_properties: ?StreamingProperties = null,

    /// The identifiers of the subnets used with the directory.
    subnet_ids: ?[]const []const u8 = null,

    /// Specifies whether the directory is dedicated or shared. To use Bring Your
    /// Own License
    /// (BYOL), this value must be set to `DEDICATED`. For more information, see
    /// [Bring
    /// Your Own Windows Desktop
    /// Images](https://docs.aws.amazon.com/workspaces/latest/adminguide/byol-windows-images.html).
    tenancy: ?Tenancy = null,

    /// Indicates the identity type of the specifired user.
    user_identity_type: ?UserIdentityType = null,

    /// The devices and operating systems that users can use to access WorkSpaces.
    workspace_access_properties: ?WorkspaceAccessProperties = null,

    /// The default creation properties for all WorkSpaces in the directory.
    workspace_creation_properties: ?DefaultWorkspaceCreationProperties = null,

    /// The description of the WorkSpace directory
    workspace_directory_description: ?[]const u8 = null,

    /// The name fo the WorkSpace directory.
    workspace_directory_name: ?[]const u8 = null,

    /// The identifier of the security group that is assigned to new WorkSpaces.
    workspace_security_group_id: ?[]const u8 = null,

    /// Indicates whether the directory's WorkSpace type is personal or pools.
    workspace_type: ?WorkspaceType = null,

    pub const json_field_names = .{
        .active_directory_config = "ActiveDirectoryConfig",
        .alias = "Alias",
        .certificate_based_auth_properties = "CertificateBasedAuthProperties",
        .customer_user_name = "CustomerUserName",
        .directory_id = "DirectoryId",
        .directory_name = "DirectoryName",
        .directory_type = "DirectoryType",
        .dns_ip_addresses = "DnsIpAddresses",
        .dns_ipv_6_addresses = "DnsIpv6Addresses",
        .endpoint_encryption_mode = "EndpointEncryptionMode",
        .error_message = "ErrorMessage",
        .iam_role_id = "IamRoleId",
        .idc_config = "IDCConfig",
        .ip_group_ids = "ipGroupIds",
        .microsoft_entra_config = "MicrosoftEntraConfig",
        .registration_code = "RegistrationCode",
        .saml_properties = "SamlProperties",
        .selfservice_permissions = "SelfservicePermissions",
        .state = "State",
        .streaming_properties = "StreamingProperties",
        .subnet_ids = "SubnetIds",
        .tenancy = "Tenancy",
        .user_identity_type = "UserIdentityType",
        .workspace_access_properties = "WorkspaceAccessProperties",
        .workspace_creation_properties = "WorkspaceCreationProperties",
        .workspace_directory_description = "WorkspaceDirectoryDescription",
        .workspace_directory_name = "WorkspaceDirectoryName",
        .workspace_security_group_id = "WorkspaceSecurityGroupId",
        .workspace_type = "WorkspaceType",
    };
};
