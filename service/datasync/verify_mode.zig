const std = @import("std");

pub const VerifyMode = enum {
    point_in_time_consistent,
    only_files_transferred,
    none,

    pub const json_field_names = .{
        .point_in_time_consistent = "POINT_IN_TIME_CONSISTENT",
        .only_files_transferred = "ONLY_FILES_TRANSFERRED",
        .none = "NONE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .point_in_time_consistent => "POINT_IN_TIME_CONSISTENT",
            .only_files_transferred => "ONLY_FILES_TRANSFERRED",
            .none => "NONE",
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
