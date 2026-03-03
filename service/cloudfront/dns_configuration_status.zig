const std = @import("std");

pub const DnsConfigurationStatus = enum {
    valid,
    invalid,
    unknown,

    pub const json_field_names = .{
        .valid = "valid-configuration",
        .invalid = "invalid-configuration",
        .unknown = "unknown-configuration",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .valid => "valid-configuration",
            .invalid => "invalid-configuration",
            .unknown => "unknown-configuration",
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
