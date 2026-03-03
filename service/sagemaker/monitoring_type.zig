const std = @import("std");

pub const MonitoringType = enum {
    data_quality,
    model_quality,
    model_bias,
    model_explainability,

    pub const json_field_names = .{
        .data_quality = "DataQuality",
        .model_quality = "ModelQuality",
        .model_bias = "ModelBias",
        .model_explainability = "ModelExplainability",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .data_quality => "DataQuality",
            .model_quality => "ModelQuality",
            .model_bias => "ModelBias",
            .model_explainability => "ModelExplainability",
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
