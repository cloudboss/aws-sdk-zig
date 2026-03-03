const std = @import("std");

pub const DirectConnectGatewayAttachmentType = enum {
    transit_virtual_interface,
    private_virtual_interface,

    pub const json_field_names = .{
        .transit_virtual_interface = "TransitVirtualInterface",
        .private_virtual_interface = "PrivateVirtualInterface",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .transit_virtual_interface => "TransitVirtualInterface",
            .private_virtual_interface => "PrivateVirtualInterface",
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
