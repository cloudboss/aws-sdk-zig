const std = @import("std");

pub const ProblemType = enum {
    binary_classification,
    multiclass_classification,
    regression,

    pub const json_field_names = .{
        .binary_classification = "BinaryClassification",
        .multiclass_classification = "MulticlassClassification",
        .regression = "Regression",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .binary_classification => "BinaryClassification",
            .multiclass_classification => "MulticlassClassification",
            .regression => "Regression",
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
