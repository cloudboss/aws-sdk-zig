const std = @import("std");

pub const FineGrainedAction = enum {
    describe_dimension_keys,
    get_dimension_key_details,
    get_resource_metrics,

    pub const json_field_names = .{
        .describe_dimension_keys = "DescribeDimensionKeys",
        .get_dimension_key_details = "GetDimensionKeyDetails",
        .get_resource_metrics = "GetResourceMetrics",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .describe_dimension_keys => "DescribeDimensionKeys",
            .get_dimension_key_details => "GetDimensionKeyDetails",
            .get_resource_metrics => "GetResourceMetrics",
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
