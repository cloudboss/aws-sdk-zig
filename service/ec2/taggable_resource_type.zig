const std = @import("std");

pub const TaggableResourceType = enum {
    network_interface,
    instance,
    auto_scaling_group,

    pub const json_field_names = .{
        .network_interface = "network-interface",
        .instance = "instance",
        .auto_scaling_group = "auto-scaling-group",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .network_interface => "network-interface",
            .instance => "instance",
            .auto_scaling_group => "auto-scaling-group",
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
