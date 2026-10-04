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
        const fields = @typeInfo(@TypeOf(json_field_names)).@"struct".field_names;
        inline for (fields) |field_name| {
            if (std.mem.eql(u8, str, @field(json_field_names, field_name))) {
                return @field(@This(), field_name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
