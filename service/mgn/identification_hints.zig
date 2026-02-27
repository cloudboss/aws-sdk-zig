/// Identification hints.
pub const IdentificationHints = struct {
    /// AWS Instance ID identification hint.
    aws_instance_id: ?[]const u8,

    /// FQDN address identification hint.
    fqdn: ?[]const u8,

    /// Hostname identification hint.
    hostname: ?[]const u8,

    /// vCenter VM path identification hint.
    vm_path: ?[]const u8,

    /// vmWare UUID identification hint.
    vm_ware_uuid: ?[]const u8,

    pub const json_field_names = .{
        .aws_instance_id = "awsInstanceID",
        .fqdn = "fqdn",
        .hostname = "hostname",
        .vm_path = "vmPath",
        .vm_ware_uuid = "vmWareUuid",
    };
};
