const std = @import("std");

pub const VoiceRecordingTrack = enum {
    from_agent,
    to_agent,
    all,

    pub const json_field_names = .{
        .from_agent = "FROM_AGENT",
        .to_agent = "TO_AGENT",
        .all = "ALL",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .from_agent => "FROM_AGENT",
            .to_agent => "TO_AGENT",
            .all => "ALL",
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
