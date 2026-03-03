/// Represents a gateway's local disk.
pub const Disk = struct {
    /// The iSCSI qualified name (IQN) that is defined for a disk. This field is not
    /// included in
    /// the response if the local disk is not defined as an iSCSI target. The format
    /// of this field
    /// is *targetIqn::LUNNumber::region-volumeId*.
    disk_allocation_resource: ?[]const u8 = null,

    disk_allocation_type: ?[]const u8 = null,

    disk_attribute_list: ?[]const []const u8 = null,

    /// The unique device ID or other distinguishing data that identifies a local
    /// disk.
    disk_id: ?[]const u8 = null,

    /// The device node of a local disk as assigned by the virtualization
    /// environment.
    disk_node: ?[]const u8 = null,

    /// The path of a local disk in the gateway virtual machine (VM).
    disk_path: ?[]const u8 = null,

    /// The local disk size in bytes.
    disk_size_in_bytes: i64 = 0,

    /// A value that represents the status of a local disk.
    disk_status: ?[]const u8 = null,

    pub const json_field_names = .{
        .disk_allocation_resource = "DiskAllocationResource",
        .disk_allocation_type = "DiskAllocationType",
        .disk_attribute_list = "DiskAttributeList",
        .disk_id = "DiskId",
        .disk_node = "DiskNode",
        .disk_path = "DiskPath",
        .disk_size_in_bytes = "DiskSizeInBytes",
        .disk_status = "DiskStatus",
    };
};
