const CmkSecretConfig = @import("cmk_secret_config.zig").CmkSecretConfig;
const CustomSecretConfig = @import("custom_secret_config.zig").CustomSecretConfig;
const ManagedSecretConfig = @import("managed_secret_config.zig").ManagedSecretConfig;
const SmbMountOptions = @import("smb_mount_options.zig").SmbMountOptions;

/// Specifies the Server Message Block (SMB) protocol configuration that
/// DataSync uses to access your Amazon FSx for NetApp ONTAP file system's
/// storage virtual machine
/// (SVM). For more information, see [Providing DataSync access to FSx for ONTAP
/// file
/// systems](https://docs.aws.amazon.com/datasync/latest/userguide/create-ontap-location.html#create-ontap-location-access).
pub const FsxProtocolSmb = struct {
    /// Specifies configuration information for a DataSync-managed secret, which
    /// includes the password that DataSync uses to access a specific FSx for ONTAP
    /// storage location (using SMB), with a customer-managed KMS key.
    ///
    /// When you include this parameter as part of a `CreateLocationFsxOntap`
    /// request,
    /// you provide only the KMS key ARN. DataSync uses this KMS key together with
    /// the `Password` you specify for
    /// to create a DataSync-managed secret to store the location access
    /// credentials.
    ///
    /// Make sure that DataSync has permission to access the KMS key that
    /// you specify. For more information, see [
    /// Using a service-managed secret encrypted with a custom KMS
    /// key](https://docs.aws.amazon.com/datasync/latest/userguide/location-credentials.html#service-secret-custom-key).
    ///
    /// You can use either `CmkSecretConfig` (with `Password`) or
    /// `CustomSecretConfig` (without `Password`) to provide
    /// credentials for a `CreateLocationFsxOntap` request. Do not provide both
    /// parameters for the same request.
    cmk_secret_config: ?CmkSecretConfig = null,

    /// Specifies configuration information for a customer-managed Secrets Manager
    /// secret where
    /// the password for an FSx for ONTAP storage location (using SMB) is stored in
    /// plain text,
    /// in Secrets Manager. This configuration includes the secret ARN, and the ARN
    /// for
    /// an IAM role that provides access to the secret. For more information, see [
    /// Using a secret that you
    /// manage](https://docs.aws.amazon.com/datasync/latest/userguide/location-credentials.html#custom-secret-custom-key).
    ///
    /// You can use either `CmkSecretConfig` (with `Password`) or
    /// `CustomSecretConfig` (without `Password`) to provide
    /// credentials for a `CreateLocationFsxOntap` request. Do not provide both
    /// parameters for the same request.
    custom_secret_config: ?CustomSecretConfig = null,

    /// Specifies the name of the Windows domain that your storage virtual machine
    /// (SVM) belongs
    /// to.
    ///
    /// If you have multiple domains in your environment, configuring this setting
    /// makes sure that
    /// DataSync connects to the right SVM.
    ///
    /// If you have multiple Active Directory domains in your environment,
    /// configuring this
    /// parameter makes sure that DataSync connects to the right SVM.
    domain: ?[]const u8 = null,

    /// Describes configuration information for a DataSync-managed secret, such as a
    /// `Password` that DataSync uses to access
    /// a specific storage location. DataSync uses the default Amazon Web
    /// Services-managed
    /// KMS key to encrypt this secret in Secrets Manager.
    ///
    /// Do not provide this for a `CreateLocation` request. `ManagedSecretConfig`
    /// is a ReadOnly property and is only be populated in the `DescribeLocation`
    /// response.
    managed_secret_config: ?ManagedSecretConfig = null,

    mount_options: ?SmbMountOptions = null,

    /// Specifies the password of a user who has permission to access your SVM.
    password: []const u8 = "",

    /// Specifies a user that can mount and access the files, folders, and metadata
    /// in your
    /// SVM.
    ///
    /// For information about choosing a user with the right level of access for
    /// your transfer,
    /// see [Using
    /// the SMB
    /// protocol](https://docs.aws.amazon.com/datasync/latest/userguide/create-ontap-location.html#create-ontap-location-smb).
    user: []const u8,

    pub const json_field_names = .{
        .cmk_secret_config = "CmkSecretConfig",
        .custom_secret_config = "CustomSecretConfig",
        .domain = "Domain",
        .managed_secret_config = "ManagedSecretConfig",
        .mount_options = "MountOptions",
        .password = "Password",
        .user = "User",
    };
};
