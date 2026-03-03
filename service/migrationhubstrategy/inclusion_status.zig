const std = @import("std");

pub const InclusionStatus = enum {
    exclude_from_recommendation,
    include_in_recommendation,

    pub const json_field_names = .{
        .exclude_from_recommendation = "excludeFromAssessment",
        .include_in_recommendation = "includeInAssessment",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .exclude_from_recommendation => "excludeFromAssessment",
            .include_in_recommendation => "includeInAssessment",
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
