const std = @import("std");

pub const PlatformDifference = enum {
    hypervisor,
    network_interface,
    storage_interface,
    instance_store_availability,
    virtualization_type,

    pub const json_field_names = .{
        .hypervisor = "HYPERVISOR",
        .network_interface = "NETWORK_INTERFACE",
        .storage_interface = "STORAGE_INTERFACE",
        .instance_store_availability = "INSTANCE_STORE_AVAILABILITY",
        .virtualization_type = "VIRTUALIZATION_TYPE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .hypervisor => "HYPERVISOR",
            .network_interface => "NETWORK_INTERFACE",
            .storage_interface => "STORAGE_INTERFACE",
            .instance_store_availability => "INSTANCE_STORE_AVAILABILITY",
            .virtualization_type => "VIRTUALIZATION_TYPE",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        const fields = @typeInfo(@TypeOf(json_field_names)).@"struct".field_names;
        inline for (fields) |field_name| {
            if (std.mem.eql(u8, str, @field(json_field_names, field_name))) {
                return @field(@This(), field_name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
