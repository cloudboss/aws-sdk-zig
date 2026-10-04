/// Contains details about a VM instance involved in a finding.
pub const Vm = struct {
    /// The execution role of the VM instance.
    execution_role: ?[]const u8 = null,

    /// The IPv4 addresses of the VM instance.
    ip_v4_addresses: ?[]const []const u8 = null,

    /// The IPv6 addresses of the VM instance.
    ip_v6_addresses: ?[]const []const u8 = null,

    /// The key name associated with the VM instance.
    key_name: ?[]const u8 = null,

    /// The date and time the VM instance was launched.
    launched_at: ?i64 = null,

    /// The network ID associated with the VM instance.
    network_id: ?[]const u8 = null,

    /// The platform of the VM instance.
    platform: ?[]const u8 = null,

    /// The security group IDs associated with the VM instance.
    security_group_ids: ?[]const []const u8 = null,

    /// The subnet IDs of the VM instance.
    subnet_ids: ?[]const []const u8 = null,

    /// The type of the VM instance.
    @"type": ?[]const u8 = null,

    /// The image reference of the VM instance.
    vm_image_reference: ?[]const u8 = null,

    /// The name of the VM instance.
    vm_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .execution_role = "executionRole",
        .ip_v4_addresses = "ipV4Addresses",
        .ip_v6_addresses = "ipV6Addresses",
        .key_name = "keyName",
        .launched_at = "launchedAt",
        .network_id = "networkId",
        .platform = "platform",
        .security_group_ids = "securityGroupIds",
        .subnet_ids = "subnetIds",
        .@"type" = "type",
        .vm_image_reference = "vmImageReference",
        .vm_name = "vmName",
    };
};
