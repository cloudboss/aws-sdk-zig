const SmbMountOptions = @import("smb_mount_options.zig").SmbMountOptions;

/// Specifies the Server Message Block (SMB) protocol configuration that
/// DataSync uses to access your Amazon FSx for NetApp ONTAP file system's
/// storage virtual machine
/// (SVM). For more information, see [Providing DataSync access to FSx for ONTAP
/// file
/// systems](https://docs.aws.amazon.com/datasync/latest/userguide/create-ontap-location.html#create-ontap-location-access).
pub const FsxProtocolSmb = struct {
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

    mount_options: ?SmbMountOptions = null,

    /// Specifies the password of a user who has permission to access your SVM.
    password: []const u8,

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
        .domain = "Domain",
        .mount_options = "MountOptions",
        .password = "Password",
        .user = "User",
    };
};
