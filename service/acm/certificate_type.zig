const std = @import("std");

pub const CertificateType = enum {
    imported,
    amazon_issued,
    private,

    pub const json_field_names = .{
        .imported = "IMPORTED",
        .amazon_issued = "AMAZON_ISSUED",
        .private = "PRIVATE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .imported => "IMPORTED",
            .amazon_issued => "AMAZON_ISSUED",
            .private => "PRIVATE",
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
