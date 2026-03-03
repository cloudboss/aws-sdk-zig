const std = @import("std");

pub const AnalyticsIntentStageField = enum {
    intent_stage_name,
    switched_to_intent,

    pub const json_field_names = .{
        .intent_stage_name = "IntentStageName",
        .switched_to_intent = "SwitchedToIntent",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .intent_stage_name => "IntentStageName",
            .switched_to_intent => "SwitchedToIntent",
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
