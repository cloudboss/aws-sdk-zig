const std = @import("std");

/// Smooth Group Event Id Mode
pub const SmoothGroupEventIdMode = enum {
    no_event_id,
    use_configured,
    use_timestamp,

    pub const json_field_names = .{
        .no_event_id = "NO_EVENT_ID",
        .use_configured = "USE_CONFIGURED",
        .use_timestamp = "USE_TIMESTAMP",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .no_event_id => "NO_EVENT_ID",
            .use_configured => "USE_CONFIGURED",
            .use_timestamp => "USE_TIMESTAMP",
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
