const SelfManagedActiveDirectoryConfigurationUpdates = @import("self_managed_active_directory_configuration_updates.zig").SelfManagedActiveDirectoryConfigurationUpdates;

/// Specifies updates to an FSx for ONTAP storage virtual machine's (SVM)
/// Microsoft Active Directory (AD) configuration.
/// Note that account credentials are not returned in the response payload.
pub const UpdateSvmActiveDirectoryConfiguration = struct {
    /// Specifies an updated NetBIOS name of the AD computer object `NetBiosName` to
    /// which an SVM is joined.
    net_bios_name: ?[]const u8 = null,

    self_managed_active_directory_configuration: ?SelfManagedActiveDirectoryConfigurationUpdates = null,

    pub const json_field_names = .{
        .net_bios_name = "NetBiosName",
        .self_managed_active_directory_configuration = "SelfManagedActiveDirectoryConfiguration",
    };
};
