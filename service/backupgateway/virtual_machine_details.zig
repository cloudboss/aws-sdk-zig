const VmwareTag = @import("vmware_tag.zig").VmwareTag;

/// Your `VirtualMachine` objects, ordered by their Amazon Resource Names
/// (ARNs).
pub const VirtualMachineDetails = struct {
    /// The host name of the virtual machine.
    host_name: ?[]const u8,

    /// The ID of the virtual machine's hypervisor.
    hypervisor_id: ?[]const u8,

    /// The most recent date a virtual machine was backed up, in Unix format and UTC
    /// time.
    last_backup_date: ?i64,

    /// The name of the virtual machine.
    name: ?[]const u8,

    /// The path of the virtual machine.
    path: ?[]const u8,

    /// The Amazon Resource Name (ARN) of the virtual machine. For example,
    /// `arn:aws:backup-gateway:us-west-1:0000000000000:vm/vm-0000ABCDEFGIJKL`.
    resource_arn: ?[]const u8,

    /// These are the details of the VMware tags associated with the specified
    /// virtual machine.
    vmware_tags: ?[]const VmwareTag,

    pub const json_field_names = .{
        .host_name = "HostName",
        .hypervisor_id = "HypervisorId",
        .last_backup_date = "LastBackupDate",
        .name = "Name",
        .path = "Path",
        .resource_arn = "ResourceArn",
        .vmware_tags = "VmwareTags",
    };
};
