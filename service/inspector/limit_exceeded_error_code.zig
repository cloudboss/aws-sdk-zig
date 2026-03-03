const std = @import("std");

pub const LimitExceededErrorCode = enum {
    assessment_target_limit_exceeded,
    assessment_template_limit_exceeded,
    assessment_run_limit_exceeded,
    resource_group_limit_exceeded,
    event_subscription_limit_exceeded,

    pub const json_field_names = .{
        .assessment_target_limit_exceeded = "ASSESSMENT_TARGET_LIMIT_EXCEEDED",
        .assessment_template_limit_exceeded = "ASSESSMENT_TEMPLATE_LIMIT_EXCEEDED",
        .assessment_run_limit_exceeded = "ASSESSMENT_RUN_LIMIT_EXCEEDED",
        .resource_group_limit_exceeded = "RESOURCE_GROUP_LIMIT_EXCEEDED",
        .event_subscription_limit_exceeded = "EVENT_SUBSCRIPTION_LIMIT_EXCEEDED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .assessment_target_limit_exceeded => "ASSESSMENT_TARGET_LIMIT_EXCEEDED",
            .assessment_template_limit_exceeded => "ASSESSMENT_TEMPLATE_LIMIT_EXCEEDED",
            .assessment_run_limit_exceeded => "ASSESSMENT_RUN_LIMIT_EXCEEDED",
            .resource_group_limit_exceeded => "RESOURCE_GROUP_LIMIT_EXCEEDED",
            .event_subscription_limit_exceeded => "EVENT_SUBSCRIPTION_LIMIT_EXCEEDED",
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
