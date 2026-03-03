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
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
