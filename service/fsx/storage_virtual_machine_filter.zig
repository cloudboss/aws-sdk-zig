const StorageVirtualMachineFilterName = @import("storage_virtual_machine_filter_name.zig").StorageVirtualMachineFilterName;

/// A filter used to restrict the results of describe calls for
/// Amazon FSx for NetApp ONTAP storage virtual machines (SVMs). You can use
/// multiple
/// filters to return results that meet all applied filter requirements.
pub const StorageVirtualMachineFilter = struct {
    /// The name for this filter.
    name: ?StorageVirtualMachineFilterName,

    /// The values of the filter. These are all the values for any of the applied
    /// filters.
    values: ?[]const []const u8,

    pub const json_field_names = .{
        .name = "Name",
        .values = "Values",
    };
};
