const std = @import("std");

pub const OverrideType = enum {
    semantic_override,
    summary_override,
    user_preference_override,
    self_managed,
    episodic_override,

    pub const json_field_names = .{
        .semantic_override = "SEMANTIC_OVERRIDE",
        .summary_override = "SUMMARY_OVERRIDE",
        .user_preference_override = "USER_PREFERENCE_OVERRIDE",
        .self_managed = "SELF_MANAGED",
        .episodic_override = "EPISODIC_OVERRIDE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .semantic_override => "SEMANTIC_OVERRIDE",
            .summary_override => "SUMMARY_OVERRIDE",
            .user_preference_override => "USER_PREFERENCE_OVERRIDE",
            .self_managed => "SELF_MANAGED",
            .episodic_override => "EPISODIC_OVERRIDE",
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
