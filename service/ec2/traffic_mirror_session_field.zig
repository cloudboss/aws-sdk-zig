const std = @import("std");

pub const TrafficMirrorSessionField = enum {
    packet_length,
    description,
    virtual_network_id,

    pub const json_field_names = .{
        .packet_length = "packet-length",
        .description = "description",
        .virtual_network_id = "virtual-network-id",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .packet_length => "packet-length",
            .description => "description",
            .virtual_network_id => "virtual-network-id",
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
