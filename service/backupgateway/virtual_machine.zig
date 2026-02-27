/// A virtual machine that is on a hypervisor.
pub const VirtualMachine = struct {
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

    pub const json_field_names = .{
        .host_name = "HostName",
        .hypervisor_id = "HypervisorId",
        .last_backup_date = "LastBackupDate",
        .name = "Name",
        .path = "Path",
        .resource_arn = "ResourceArn",
    };
};
