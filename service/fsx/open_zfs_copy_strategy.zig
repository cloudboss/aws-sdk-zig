const std = @import("std");

pub const OpenZFSCopyStrategy = enum {
    clone,
    full_copy,
    incremental_copy,

    pub const json_field_names = .{
        .clone = "CLONE",
        .full_copy = "FULL_COPY",
        .incremental_copy = "INCREMENTAL_COPY",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .clone => "CLONE",
            .full_copy => "FULL_COPY",
            .incremental_copy => "INCREMENTAL_COPY",
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
