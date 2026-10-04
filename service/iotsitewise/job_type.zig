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
        const fields = @typeInfo(@TypeOf(json_field_names)).@"struct".field_names;
        inline for (fields) |field_name| {
            if (std.mem.eql(u8, str, @field(json_field_names, field_name))) {
                return @field(@This(), field_name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
