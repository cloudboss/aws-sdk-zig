const std = @import("std");

pub const AZStatus = enum {
    single_az,
    multi_az,

    pub const json_field_names = .{
        .single_az = "singleaz",
        .multi_az = "multiaz",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .single_az => "singleaz",
            .multi_az => "multiaz",
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
