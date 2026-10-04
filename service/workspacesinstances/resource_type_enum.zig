const std = @import("std");

pub const ResourceTypeEnum = enum {
    instance,
    volume,
    spot_instances_request,
    network_interface,

    pub const json_field_names = .{
        .instance = "instance",
        .volume = "volume",
        .spot_instances_request = "spot-instances-request",
        .network_interface = "network-interface",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .instance => "instance",
            .volume => "volume",
            .spot_instances_request => "spot-instances-request",
            .network_interface => "network-interface",
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
