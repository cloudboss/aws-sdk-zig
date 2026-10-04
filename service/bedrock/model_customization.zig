const std = @import("std");

pub const ModelCustomization = enum {
    fine_tuning,
    continued_pre_training,
    distillation,

    pub const json_field_names = .{
        .fine_tuning = "FINE_TUNING",
        .continued_pre_training = "CONTINUED_PRE_TRAINING",
        .distillation = "DISTILLATION",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .fine_tuning => "FINE_TUNING",
            .continued_pre_training => "CONTINUED_PRE_TRAINING",
            .distillation => "DISTILLATION",
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
