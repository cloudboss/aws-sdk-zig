const std = @import("std");

pub const RestoreTestingRecoveryPointSelectionAlgorithm = enum {
    latest_within_window,
    random_within_window,

    pub const json_field_names = .{
        .latest_within_window = "LATEST_WITHIN_WINDOW",
        .random_within_window = "RANDOM_WITHIN_WINDOW",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .latest_within_window => "LATEST_WITHIN_WINDOW",
            .random_within_window => "RANDOM_WITHIN_WINDOW",
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
