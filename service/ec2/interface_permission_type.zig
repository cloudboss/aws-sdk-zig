const std = @import("std");

pub const InterfacePermissionType = enum {
    instance_attach,
    eip_associate,

    pub const json_field_names = .{
        .instance_attach = "INSTANCE-ATTACH",
        .eip_associate = "EIP-ASSOCIATE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .instance_attach => "INSTANCE-ATTACH",
            .eip_associate => "EIP-ASSOCIATE",
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
