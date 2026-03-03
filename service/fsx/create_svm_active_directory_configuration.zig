const SelfManagedActiveDirectoryConfiguration = @import("self_managed_active_directory_configuration.zig").SelfManagedActiveDirectoryConfiguration;

/// The configuration that Amazon FSx uses to join the ONTAP storage virtual
/// machine
/// (SVM) to your self-managed (including on-premises) Microsoft Active
/// Directory directory.
pub const CreateSvmActiveDirectoryConfiguration = struct {
    /// The NetBIOS name of the Active Directory computer object that will be
    /// created for your SVM.
    net_bios_name: []const u8,

    self_managed_active_directory_configuration: ?SelfManagedActiveDirectoryConfiguration = null,

    pub const json_field_names = .{
        .net_bios_name = "NetBiosName",
        .self_managed_active_directory_configuration = "SelfManagedActiveDirectoryConfiguration",
    };
};
