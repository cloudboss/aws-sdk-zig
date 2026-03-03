const std = @import("std");

pub const AggregationTypeName = enum {
    statistics,
    percentiles,
    cardinality,

    pub const json_field_names = .{
        .statistics = "Statistics",
        .percentiles = "Percentiles",
        .cardinality = "Cardinality",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .statistics => "Statistics",
            .percentiles => "Percentiles",
            .cardinality => "Cardinality",
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
