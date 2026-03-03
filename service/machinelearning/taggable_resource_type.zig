const std = @import("std");

pub const TaggableResourceType = enum {
    batch_prediction,
    datasource,
    evaluation,
    ml_model,

    pub const json_field_names = .{
        .batch_prediction = "BatchPrediction",
        .datasource = "DataSource",
        .evaluation = "Evaluation",
        .ml_model = "MLModel",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .batch_prediction => "BatchPrediction",
            .datasource => "DataSource",
            .evaluation => "Evaluation",
            .ml_model => "MLModel",
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
