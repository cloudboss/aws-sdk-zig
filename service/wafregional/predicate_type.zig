const std = @import("std");

pub const PredicateType = enum {
    ip_match,
    byte_match,
    sql_injection_match,
    geo_match,
    size_constraint,
    xss_match,
    regex_match,

    pub const json_field_names = .{
        .ip_match = "IPMatch",
        .byte_match = "ByteMatch",
        .sql_injection_match = "SqlInjectionMatch",
        .geo_match = "GeoMatch",
        .size_constraint = "SizeConstraint",
        .xss_match = "XssMatch",
        .regex_match = "RegexMatch",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .ip_match => "IPMatch",
            .byte_match => "ByteMatch",
            .sql_injection_match => "SqlInjectionMatch",
            .geo_match => "GeoMatch",
            .size_constraint => "SizeConstraint",
            .xss_match => "XssMatch",
            .regex_match => "RegexMatch",
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
