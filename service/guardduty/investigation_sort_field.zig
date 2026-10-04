const std = @import("std");

pub const InvestigationSortField = enum {
    start_time,
    end_time,
    status,
    risk_level,
    confidence,

    pub const json_field_names = .{
        .start_time = "START_TIME",
        .end_time = "END_TIME",
        .status = "STATUS",
        .risk_level = "RISK_LEVEL",
        .confidence = "CONFIDENCE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .start_time => "START_TIME",
            .end_time => "END_TIME",
            .status => "STATUS",
            .risk_level => "RISK_LEVEL",
            .confidence => "CONFIDENCE",
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
