const std = @import("std");

pub const OcsfBooleanField = enum {
    compliance_assessments_meets_criteria,
    vulnerabilities_is_exploit_available,
    vulnerabilities_is_fix_available,

    pub const json_field_names = .{
        .compliance_assessments_meets_criteria = "compliance.assessments.meets_criteria",
        .vulnerabilities_is_exploit_available = "vulnerabilities.is_exploit_available",
        .vulnerabilities_is_fix_available = "vulnerabilities.is_fix_available",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .compliance_assessments_meets_criteria => "compliance.assessments.meets_criteria",
            .vulnerabilities_is_exploit_available => "vulnerabilities.is_exploit_available",
            .vulnerabilities_is_fix_available => "vulnerabilities.is_fix_available",
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
