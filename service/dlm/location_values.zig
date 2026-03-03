const std = @import("std");

pub const LocationValues = enum {
    cloud,
    outpost_local,
    local_zone,

    pub const json_field_names = .{
        .cloud = "CLOUD",
        .outpost_local = "OUTPOST_LOCAL",
        .local_zone = "LOCAL_ZONE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .cloud => "CLOUD",
            .outpost_local => "OUTPOST_LOCAL",
            .local_zone => "LOCAL_ZONE",
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
