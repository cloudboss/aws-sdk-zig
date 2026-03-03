const std = @import("std");

pub const RetryTrigger = enum {
    automated_stage_retry,
    manual_stage_retry,

    pub const json_field_names = .{
        .automated_stage_retry = "AutomatedStageRetry",
        .manual_stage_retry = "ManualStageRetry",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .automated_stage_retry => "AutomatedStageRetry",
            .manual_stage_retry => "ManualStageRetry",
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
