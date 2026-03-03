const std = @import("std");

pub const EnvironmentSoftwareSetComplianceStatus = enum {
    no_registered_devices,
    compliant,
    not_compliant,

    pub const json_field_names = .{
        .no_registered_devices = "NO_REGISTERED_DEVICES",
        .compliant = "COMPLIANT",
        .not_compliant = "NOT_COMPLIANT",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .no_registered_devices => "NO_REGISTERED_DEVICES",
            .compliant => "COMPLIANT",
            .not_compliant => "NOT_COMPLIANT",
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
