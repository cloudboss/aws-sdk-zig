const std = @import("std");

pub const LogGroupClass = enum {
    standard,
    infrequent_access,
    delivery,

    pub const json_field_names = .{
        .standard = "STANDARD",
        .infrequent_access = "INFREQUENT_ACCESS",
        .delivery = "DELIVERY",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .standard => "STANDARD",
            .infrequent_access => "INFREQUENT_ACCESS",
            .delivery => "DELIVERY",
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
