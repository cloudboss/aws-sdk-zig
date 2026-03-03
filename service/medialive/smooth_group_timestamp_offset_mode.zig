const std = @import("std");

/// Smooth Group Timestamp Offset Mode
pub const SmoothGroupTimestampOffsetMode = enum {
    use_configured_offset,
    use_event_start_date,

    pub const json_field_names = .{
        .use_configured_offset = "USE_CONFIGURED_OFFSET",
        .use_event_start_date = "USE_EVENT_START_DATE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .use_configured_offset => "USE_CONFIGURED_OFFSET",
            .use_event_start_date => "USE_EVENT_START_DATE",
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
