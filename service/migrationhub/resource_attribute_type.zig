const std = @import("std");

pub const ResourceAttributeType = enum {
    ipv4_address,
    ipv6_address,
    mac_address,
    fqdn,
    vm_manager_id,
    vm_managed_object_reference,
    vm_name,
    vm_path,
    bios_id,
    motherboard_serial_number,

    pub const json_field_names = .{
        .ipv4_address = "IPV4_ADDRESS",
        .ipv6_address = "IPV6_ADDRESS",
        .mac_address = "MAC_ADDRESS",
        .fqdn = "FQDN",
        .vm_manager_id = "VM_MANAGER_ID",
        .vm_managed_object_reference = "VM_MANAGED_OBJECT_REFERENCE",
        .vm_name = "VM_NAME",
        .vm_path = "VM_PATH",
        .bios_id = "BIOS_ID",
        .motherboard_serial_number = "MOTHERBOARD_SERIAL_NUMBER",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .ipv4_address => "IPV4_ADDRESS",
            .ipv6_address => "IPV6_ADDRESS",
            .mac_address => "MAC_ADDRESS",
            .fqdn => "FQDN",
            .vm_manager_id => "VM_MANAGER_ID",
            .vm_managed_object_reference => "VM_MANAGED_OBJECT_REFERENCE",
            .vm_name => "VM_NAME",
            .vm_path => "VM_PATH",
            .bios_id => "BIOS_ID",
            .motherboard_serial_number => "MOTHERBOARD_SERIAL_NUMBER",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
