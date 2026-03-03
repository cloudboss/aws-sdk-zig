const std = @import("std");

pub const BaselineOperationType = enum {
    enable_baseline,
    disable_baseline,
    update_enabled_baseline,
    reset_enabled_baseline,

    pub const json_field_names = .{
        .enable_baseline = "ENABLE_BASELINE",
        .disable_baseline = "DISABLE_BASELINE",
        .update_enabled_baseline = "UPDATE_ENABLED_BASELINE",
        .reset_enabled_baseline = "RESET_ENABLED_BASELINE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .enable_baseline => "ENABLE_BASELINE",
            .disable_baseline => "DISABLE_BASELINE",
            .update_enabled_baseline => "UPDATE_ENABLED_BASELINE",
            .reset_enabled_baseline => "RESET_ENABLED_BASELINE",
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
