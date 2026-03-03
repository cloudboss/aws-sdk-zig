const std = @import("std");

pub const PerformanceMode = enum {
    general_purpose,
    max_io,

    pub const json_field_names = .{
        .general_purpose = "generalPurpose",
        .max_io = "maxIO",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .general_purpose => "generalPurpose",
            .max_io => "maxIO",
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
