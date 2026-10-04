const std = @import("std");

pub const RecommendationComplianceStatus = enum {
    breached_unattainable,
    breached_can_meet,
    met_can_improve,
    missing_policy,

    pub const json_field_names = .{
        .breached_unattainable = "BreachedUnattainable",
        .breached_can_meet = "BreachedCanMeet",
        .met_can_improve = "MetCanImprove",
        .missing_policy = "MissingPolicy",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .breached_unattainable => "BreachedUnattainable",
            .breached_can_meet => "BreachedCanMeet",
            .met_can_improve => "MetCanImprove",
            .missing_policy => "MissingPolicy",
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
