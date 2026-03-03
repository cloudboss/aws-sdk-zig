const std = @import("std");

pub const PlatformDifference = enum {
    hypervisor,
    network_interface,
    storage_interface,
    instance_store_availability,
    virtualization_type,
    architecture,

    pub const json_field_names = .{
        .hypervisor = "Hypervisor",
        .network_interface = "NetworkInterface",
        .storage_interface = "StorageInterface",
        .instance_store_availability = "InstanceStoreAvailability",
        .virtualization_type = "VirtualizationType",
        .architecture = "Architecture",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .hypervisor => "Hypervisor",
            .network_interface => "NetworkInterface",
            .storage_interface => "StorageInterface",
            .instance_store_availability => "InstanceStoreAvailability",
            .virtualization_type => "VirtualizationType",
            .architecture => "Architecture",
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
