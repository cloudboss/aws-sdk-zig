const std = @import("std");

pub const BatchInferenceJobMode = enum {
    batch_inference,
    theme_generation,

    pub const json_field_names = .{
        .batch_inference = "BATCH_INFERENCE",
        .theme_generation = "THEME_GENERATION",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .batch_inference => "BATCH_INFERENCE",
            .theme_generation => "THEME_GENERATION",
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
