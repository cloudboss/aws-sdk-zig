const std = @import("std");

pub const InsightsCategory = enum {
    cross_region,
    new_dependency,
    third_party,
    uneven_usage,
    aws_service,

    pub const json_field_names = .{
        .cross_region = "CROSS_REGION",
        .new_dependency = "NEW_DEPENDENCY",
        .third_party = "THIRD_PARTY",
        .uneven_usage = "UNEVEN_USAGE",
        .aws_service = "AWS_SERVICE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .cross_region => "CROSS_REGION",
            .new_dependency => "NEW_DEPENDENCY",
            .third_party => "THIRD_PARTY",
            .uneven_usage => "UNEVEN_USAGE",
            .aws_service => "AWS_SERVICE",
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
