const std = @import("std");

pub const AutonomousDatabaseBackupType = enum {
    incremental,
    full,
    longterm,
    virtual_full,
    cumulative_incremental,
    roll_forward_image_copy,

    pub const json_field_names = .{
        .incremental = "INCREMENTAL",
        .full = "FULL",
        .longterm = "LONGTERM",
        .virtual_full = "VIRTUAL_FULL",
        .cumulative_incremental = "CUMULATIVE_INCREMENTAL",
        .roll_forward_image_copy = "ROLL_FORWARD_IMAGE_COPY",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .incremental => "INCREMENTAL",
            .full => "FULL",
            .longterm => "LONGTERM",
            .virtual_full => "VIRTUAL_FULL",
            .cumulative_incremental => "CUMULATIVE_INCREMENTAL",
            .roll_forward_image_copy => "ROLL_FORWARD_IMAGE_COPY",
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
