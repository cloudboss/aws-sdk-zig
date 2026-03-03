const std = @import("std");

pub const Day = enum {
    sun,
    mon,
    tue,
    wed,
    thu,
    fri,
    sat,

    pub const json_field_names = .{
        .sun = "SUN",
        .mon = "MON",
        .tue = "TUE",
        .wed = "WED",
        .thu = "THU",
        .fri = "FRI",
        .sat = "SAT",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .sun => "SUN",
            .mon => "MON",
            .tue => "TUE",
            .wed => "WED",
            .thu => "THU",
            .fri => "FRI",
            .sat => "SAT",
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
