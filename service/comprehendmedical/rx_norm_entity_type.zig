const std = @import("std");

pub const RxNormEntityType = enum {
    brand_name,
    generic_name,

    pub const json_field_names = .{
        .brand_name = "BRAND_NAME",
        .generic_name = "GENERIC_NAME",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .brand_name => "BRAND_NAME",
            .generic_name => "GENERIC_NAME",
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
