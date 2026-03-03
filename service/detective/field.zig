const std = @import("std");

pub const Field = enum {
    severity,
    status,
    created_time,

    pub const json_field_names = .{
        .severity = "SEVERITY",
        .status = "STATUS",
        .created_time = "CREATED_TIME",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .severity => "SEVERITY",
            .status => "STATUS",
            .created_time => "CREATED_TIME",
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
