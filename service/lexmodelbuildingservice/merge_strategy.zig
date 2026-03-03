const std = @import("std");

pub const MergeStrategy = enum {
    overwrite_latest,
    fail_on_conflict,

    pub const json_field_names = .{
        .overwrite_latest = "OVERWRITE_LATEST",
        .fail_on_conflict = "FAIL_ON_CONFLICT",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .overwrite_latest => "OVERWRITE_LATEST",
            .fail_on_conflict => "FAIL_ON_CONFLICT",
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
