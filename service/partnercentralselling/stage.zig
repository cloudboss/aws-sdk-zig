const std = @import("std");

pub const Stage = enum {
    prospect,
    qualified,
    technical_validation,
    business_validation,
    committed,
    launched,
    closed_lost,

    pub const json_field_names = .{
        .prospect = "Prospect",
        .qualified = "Qualified",
        .technical_validation = "Technical Validation",
        .business_validation = "Business Validation",
        .committed = "Committed",
        .launched = "Launched",
        .closed_lost = "Closed Lost",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .prospect => "Prospect",
            .qualified => "Qualified",
            .technical_validation => "Technical Validation",
            .business_validation => "Business Validation",
            .committed => "Committed",
            .launched => "Launched",
            .closed_lost => "Closed Lost",
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
