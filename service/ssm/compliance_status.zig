const std = @import("std");

pub const ComplianceStatus = enum {
    compliant,
    non_compliant,

    pub const json_field_names = .{
        .compliant = "COMPLIANT",
        .non_compliant = "NON_COMPLIANT",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .compliant => "COMPLIANT",
            .non_compliant => "NON_COMPLIANT",
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
