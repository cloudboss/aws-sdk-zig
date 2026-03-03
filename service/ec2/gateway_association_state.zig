const std = @import("std");

pub const GatewayAssociationState = enum {
    associated,
    not_associated,
    associating,
    disassociating,

    pub const json_field_names = .{
        .associated = "associated",
        .not_associated = "not-associated",
        .associating = "associating",
        .disassociating = "disassociating",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .associated => "associated",
            .not_associated => "not-associated",
            .associating => "associating",
            .disassociating => "disassociating",
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
