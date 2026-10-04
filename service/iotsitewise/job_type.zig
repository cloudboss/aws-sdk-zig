const std = @import("std");

/// The type of enrichment job, derived from the job configuration union member
pub const JobType = enum {
    event_detection,

    pub const json_field_names = .{
        .event_detection = "EVENT_DETECTION",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .event_detection => "EVENT_DETECTION",
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
