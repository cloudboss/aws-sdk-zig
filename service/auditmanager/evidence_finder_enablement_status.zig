const std = @import("std");

pub const EvidenceFinderEnablementStatus = enum {
    enabled,
    disabled,
    enable_in_progress,
    disable_in_progress,

    pub const json_field_names = .{
        .enabled = "ENABLED",
        .disabled = "DISABLED",
        .enable_in_progress = "ENABLE_IN_PROGRESS",
        .disable_in_progress = "DISABLE_IN_PROGRESS",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .enabled => "ENABLED",
            .disabled => "DISABLED",
            .enable_in_progress => "ENABLE_IN_PROGRESS",
            .disable_in_progress => "DISABLE_IN_PROGRESS",
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
