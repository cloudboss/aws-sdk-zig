const std = @import("std");

pub const LicenseRecommendationFilterName = enum {
    license_finding,
    license_finding_reason_code,
    license_name,

    pub const json_field_names = .{
        .license_finding = "Finding",
        .license_finding_reason_code = "FindingReasonCode",
        .license_name = "LicenseName",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .license_finding => "Finding",
            .license_finding_reason_code => "FindingReasonCode",
            .license_name => "LicenseName",
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
