const std = @import("std");

/// Specifies the Auto-Tune state for the Elasticsearch domain. For valid states
/// see the [Developer
/// Guide](https://docs.aws.amazon.com/elasticsearch-service/latest/developerguide/auto-tune.html).
pub const AutoTuneState = enum {
    enabled,
    disabled,
    enable_in_progress,
    disable_in_progress,
    disabled_and_rollback_scheduled,
    disabled_and_rollback_in_progress,
    disabled_and_rollback_complete,
    disabled_and_rollback_error,
    @"error",

    pub const json_field_names = .{
        .enabled = "ENABLED",
        .disabled = "DISABLED",
        .enable_in_progress = "ENABLE_IN_PROGRESS",
        .disable_in_progress = "DISABLE_IN_PROGRESS",
        .disabled_and_rollback_scheduled = "DISABLED_AND_ROLLBACK_SCHEDULED",
        .disabled_and_rollback_in_progress = "DISABLED_AND_ROLLBACK_IN_PROGRESS",
        .disabled_and_rollback_complete = "DISABLED_AND_ROLLBACK_COMPLETE",
        .disabled_and_rollback_error = "DISABLED_AND_ROLLBACK_ERROR",
        .@"error" = "ERROR",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .enabled => "ENABLED",
            .disabled => "DISABLED",
            .enable_in_progress => "ENABLE_IN_PROGRESS",
            .disable_in_progress => "DISABLE_IN_PROGRESS",
            .disabled_and_rollback_scheduled => "DISABLED_AND_ROLLBACK_SCHEDULED",
            .disabled_and_rollback_in_progress => "DISABLED_AND_ROLLBACK_IN_PROGRESS",
            .disabled_and_rollback_complete => "DISABLED_AND_ROLLBACK_COMPLETE",
            .disabled_and_rollback_error => "DISABLED_AND_ROLLBACK_ERROR",
            .@"error" => "ERROR",
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
