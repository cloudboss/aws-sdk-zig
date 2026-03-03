/// Hints used to uniquely identify a machine.
pub const IdentificationHints = struct {
    /// AWS Instance ID identification hint.
    aws_instance_id: ?[]const u8 = null,

    /// Fully Qualified Domain Name identification hint.
    fqdn: ?[]const u8 = null,

    /// Hostname identification hint.
    hostname: ?[]const u8 = null,

    /// vCenter VM path identification hint.
    vm_ware_uuid: ?[]const u8 = null,

    pub const json_field_names = .{
        .aws_instance_id = "awsInstanceID",
        .fqdn = "fqdn",
        .hostname = "hostname",
        .vm_ware_uuid = "vmWareUuid",
    };
};
