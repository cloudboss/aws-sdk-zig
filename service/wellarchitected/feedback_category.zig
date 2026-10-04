const std = @import("std");

pub const FeedbackCategory = enum {
    other,
    recommendation_not_relevant,
    resource_not_important,
    resource_type_not_important,
    recommendation_incorrect,

    pub const json_field_names = .{
        .other = "OTHER",
        .recommendation_not_relevant = "RECOMMENDATION_NOT_RELEVANT",
        .resource_not_important = "RESOURCE_NOT_IMPORTANT",
        .resource_type_not_important = "RESOURCE_TYPE_NOT_IMPORTANT",
        .recommendation_incorrect = "RECOMMENDATION_INCORRECT",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .other => "OTHER",
            .recommendation_not_relevant => "RECOMMENDATION_NOT_RELEVANT",
            .resource_not_important => "RESOURCE_NOT_IMPORTANT",
            .resource_type_not_important => "RESOURCE_TYPE_NOT_IMPORTANT",
            .recommendation_incorrect => "RECOMMENDATION_INCORRECT",
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
