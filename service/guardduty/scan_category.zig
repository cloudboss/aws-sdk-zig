const std = @import("std");

pub const ScanCategory = enum {
    full_scan,
    incremental_scan,

    pub const json_field_names = .{
        .full_scan = "FULL_SCAN",
        .incremental_scan = "INCREMENTAL_SCAN",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .full_scan => "FULL_SCAN",
            .incremental_scan => "INCREMENTAL_SCAN",
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
