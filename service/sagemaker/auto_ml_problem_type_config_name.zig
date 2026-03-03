const std = @import("std");

pub const AutoMLProblemTypeConfigName = enum {
    image_classification,
    text_classification,
    timeseries_forecasting,
    tabular,
    text_generation,

    pub const json_field_names = .{
        .image_classification = "ImageClassification",
        .text_classification = "TextClassification",
        .timeseries_forecasting = "TimeSeriesForecasting",
        .tabular = "Tabular",
        .text_generation = "TextGeneration",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .image_classification => "ImageClassification",
            .text_classification => "TextClassification",
            .timeseries_forecasting => "TimeSeriesForecasting",
            .tabular => "Tabular",
            .text_generation => "TextGeneration",
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
