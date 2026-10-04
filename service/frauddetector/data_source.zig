const std = @import("std");

pub const DataSource = enum {
    event,
    model_score,
    external_model_score,

    pub const json_field_names = .{
        .event = "EVENT",
        .model_score = "MODEL_SCORE",
        .external_model_score = "EXTERNAL_MODEL_SCORE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .event => "EVENT",
            .model_score => "MODEL_SCORE",
            .external_model_score => "EXTERNAL_MODEL_SCORE",
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
