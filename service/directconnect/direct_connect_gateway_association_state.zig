const std = @import("std");

pub const DirectConnectGatewayAssociationState = enum {
    associating,
    associated,
    disassociating,
    disassociated,
    updating,

    pub const json_field_names = .{
        .associating = "associating",
        .associated = "associated",
        .disassociating = "disassociating",
        .disassociated = "disassociated",
        .updating = "updating",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .associating => "associating",
            .associated => "associated",
            .disassociating => "disassociating",
            .disassociated => "disassociated",
            .updating => "updating",
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
