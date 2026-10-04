const std = @import("std");

pub const Dimension = enum {
    service,
    operation,
    usage_type,
    region,
    free_tier_type,
    description,
    usage_percentage,

    pub const json_field_names = .{
        .service = "SERVICE",
        .operation = "OPERATION",
        .usage_type = "USAGE_TYPE",
        .region = "REGION",
        .free_tier_type = "FREE_TIER_TYPE",
        .description = "DESCRIPTION",
        .usage_percentage = "USAGE_PERCENTAGE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .service => "SERVICE",
            .operation => "OPERATION",
            .usage_type => "USAGE_TYPE",
            .region => "REGION",
            .free_tier_type => "FREE_TIER_TYPE",
            .description => "DESCRIPTION",
            .usage_percentage => "USAGE_PERCENTAGE",
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
