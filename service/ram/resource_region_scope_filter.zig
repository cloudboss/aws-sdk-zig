const std = @import("std");

pub const ResourceRegionScopeFilter = enum {
    all,
    regional,
    global,

    pub const json_field_names = .{
        .all = "ALL",
        .regional = "REGIONAL",
        .global = "GLOBAL",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .all => "ALL",
            .regional => "REGIONAL",
            .global => "GLOBAL",
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
