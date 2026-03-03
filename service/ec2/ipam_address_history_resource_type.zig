const std = @import("std");

pub const IpamAddressHistoryResourceType = enum {
    eip,
    vpc,
    subnet,
    network_interface,
    instance,

    pub const json_field_names = .{
        .eip = "eip",
        .vpc = "vpc",
        .subnet = "subnet",
        .network_interface = "network-interface",
        .instance = "instance",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .eip => "eip",
            .vpc => "vpc",
            .subnet => "subnet",
            .network_interface => "network-interface",
            .instance => "instance",
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
