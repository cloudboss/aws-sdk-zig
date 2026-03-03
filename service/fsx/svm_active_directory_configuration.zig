const SelfManagedActiveDirectoryAttributes = @import("self_managed_active_directory_attributes.zig").SelfManagedActiveDirectoryAttributes;

/// Describes the Microsoft Active Directory (AD) directory configuration to
/// which the FSx for ONTAP storage virtual machine (SVM) is joined.
/// Note that account credentials are not returned in the response payload.
pub const SvmActiveDirectoryConfiguration = struct {
    /// The NetBIOS name of the AD computer object to which the SVM is joined.
    net_bios_name: ?[]const u8 = null,

    self_managed_active_directory_configuration: ?SelfManagedActiveDirectoryAttributes = null,

    pub const json_field_names = .{
        .net_bios_name = "NetBiosName",
        .self_managed_active_directory_configuration = "SelfManagedActiveDirectoryConfiguration",
    };
};
