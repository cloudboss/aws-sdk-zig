const std = @import("std");

pub const CustomizationType = enum {
    fine_tuning,
    continued_pre_training,
    distillation,
    reinforcement_fine_tuning,
    imported,

    pub const json_field_names = .{
        .fine_tuning = "FINE_TUNING",
        .continued_pre_training = "CONTINUED_PRE_TRAINING",
        .distillation = "DISTILLATION",
        .reinforcement_fine_tuning = "REINFORCEMENT_FINE_TUNING",
        .imported = "IMPORTED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .fine_tuning => "FINE_TUNING",
            .continued_pre_training => "CONTINUED_PRE_TRAINING",
            .distillation => "DISTILLATION",
            .reinforcement_fine_tuning => "REINFORCEMENT_FINE_TUNING",
            .imported => "IMPORTED",
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
