const std = @import("std");

pub const ExcludeRecommendationReason = enum {
    already_implemented,
    not_relevant,
    complexity_of_implementation,

    pub const json_field_names = .{
        .already_implemented = "AlreadyImplemented",
        .not_relevant = "NotRelevant",
        .complexity_of_implementation = "ComplexityOfImplementation",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .already_implemented => "AlreadyImplemented",
            .not_relevant => "NotRelevant",
            .complexity_of_implementation => "ComplexityOfImplementation",
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
