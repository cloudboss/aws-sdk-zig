const CmkSecretConfig = @import("cmk_secret_config.zig").CmkSecretConfig;
const CustomSecretConfig = @import("custom_secret_config.zig").CustomSecretConfig;
const SmbMountOptions = @import("smb_mount_options.zig").SmbMountOptions;

/// Specifies the Server Message Block (SMB) protocol configuration that
/// DataSync uses to access your Amazon FSx for NetApp ONTAP file system's
/// storage virtual machine
/// (SVM). For more information, see [Providing DataSync access to FSx for ONTAP
/// file
/// systems](https://docs.aws.amazon.com/datasync/latest/userguide/create-ontap-location.html#create-ontap-location-access).
pub const FsxUpdateProtocolSmb = struct {
    /// Specifies configuration information for a DataSync-managed secret, such as a
    /// `Password` or set of credentials that DataSync uses to access a
    /// specific transfer location, and a customer-managed KMS key.
    cmk_secret_config: ?CmkSecretConfig = null,

    /// Specifies configuration information for a customer-managed secret, such as a
    /// `Password` or set of credentials that DataSync uses to access a
    /// specific transfer location. This configuration includes the secret ARN, and
    /// the ARN
    /// for an IAM role that provides access to the secret.
    custom_secret_config: ?CustomSecretConfig = null,

    /// Specifies the name of the Windows domain that your storage virtual machine
    /// (SVM) belongs
    /// to.
    ///
    /// If you have multiple Active Directory domains in your environment,
    /// configuring this
    /// parameter makes sure that DataSync connects to the right SVM.
    domain: ?[]const u8 = null,

    mount_options: ?SmbMountOptions = null,

    /// Specifies the password of a user who has permission to access your SVM.
    password: ?[]const u8 = null,

    /// Specifies a user that can mount and access the files, folders, and metadata
    /// in your
    /// SVM.
    ///
    /// For information about choosing a user with the right level of access for
    /// your transfer,
    /// see [Using
    /// the SMB
    /// protocol](https://docs.aws.amazon.com/datasync/latest/userguide/create-ontap-location.html#create-ontap-location-smb).
    user: ?[]const u8 = null,

    pub const json_field_names = .{
        .cmk_secret_config = "CmkSecretConfig",
        .custom_secret_config = "CustomSecretConfig",
        .domain = "Domain",
        .mount_options = "MountOptions",
        .password = "Password",
        .user = "User",
    };
};
