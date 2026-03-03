const std = @import("std");

pub const PolicyValidationMode = enum {
    fail_on_any_findings,
    ignore_all_findings,

    pub const json_field_names = .{
        .fail_on_any_findings = "FAIL_ON_ANY_FINDINGS",
        .ignore_all_findings = "IGNORE_ALL_FINDINGS",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .fail_on_any_findings => "FAIL_ON_ANY_FINDINGS",
            .ignore_all_findings => "IGNORE_ALL_FINDINGS",
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
