const std = @import("std");

/// Where evaluation results are written: dedicated results log group (default)
/// or the source log group.
pub const ResultDestination = enum {
    dedicated_log_group,
    source_log_group,

    pub const json_field_names = .{
        .dedicated_log_group = "DEDICATED_LOG_GROUP",
        .source_log_group = "SOURCE_LOG_GROUP",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .dedicated_log_group => "DEDICATED_LOG_GROUP",
            .source_log_group => "SOURCE_LOG_GROUP",
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
