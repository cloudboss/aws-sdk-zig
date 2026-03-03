const std = @import("std");

pub const ProtectionGroupPattern = enum {
    all,
    arbitrary,
    by_resource_type,

    pub const json_field_names = .{
        .all = "ALL",
        .arbitrary = "ARBITRARY",
        .by_resource_type = "BY_RESOURCE_TYPE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .all => "ALL",
            .arbitrary => "ARBITRARY",
            .by_resource_type => "BY_RESOURCE_TYPE",
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
