const std = @import("std");

pub const ComplianceType = enum {
    compliant,
    non_compliant,
    not_applicable,
    insufficient_data,

    pub const json_field_names = .{
        .compliant = "COMPLIANT",
        .non_compliant = "NON_COMPLIANT",
        .not_applicable = "NOT_APPLICABLE",
        .insufficient_data = "INSUFFICIENT_DATA",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .compliant => "COMPLIANT",
            .non_compliant => "NON_COMPLIANT",
            .not_applicable => "NOT_APPLICABLE",
            .insufficient_data => "INSUFFICIENT_DATA",
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
