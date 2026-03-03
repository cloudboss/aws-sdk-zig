const std = @import("std");

/// Global Configuration Output Locking Mode
pub const GlobalConfigurationOutputLockingMode = enum {
    epoch_locking,
    pipeline_locking,
    disabled,

    pub const json_field_names = .{
        .epoch_locking = "EPOCH_LOCKING",
        .pipeline_locking = "PIPELINE_LOCKING",
        .disabled = "DISABLED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .epoch_locking => "EPOCH_LOCKING",
            .pipeline_locking => "PIPELINE_LOCKING",
            .disabled => "DISABLED",
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
