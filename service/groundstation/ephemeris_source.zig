const std = @import("std");

pub const EphemerisSource = enum {
    customer_provided,
    space_track,

    pub const json_field_names = .{
        .customer_provided = "CUSTOMER_PROVIDED",
        .space_track = "SPACE_TRACK",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .customer_provided => "CUSTOMER_PROVIDED",
            .space_track => "SPACE_TRACK",
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
