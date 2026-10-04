const std = @import("std");

pub const ResourceType = enum {
    file_system,
    volume,

    pub const json_field_names = .{
        .file_system = "FILE_SYSTEM",
        .volume = "VOLUME",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .file_system => "FILE_SYSTEM",
            .volume => "VOLUME",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        const fields = @typeInfo(@TypeOf(json_field_names)).@"struct".field_names;
        inline for (fields) |field_name| {
            if (std.mem.eql(u8, str, @field(json_field_names, field_name))) {
                return @field(@This(), field_name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
