const std = @import("std");

/// Controls whether query parameters are included in Service Connect access
/// logs. Consider security and privacy implications when enabling this feature.
/// By default, this parameter is `DISABLED`.
pub const ServiceConnectIncludeQueryParameters = enum {
    disabled,
    enabled,

    pub const json_field_names = .{
        .disabled = "DISABLED",
        .enabled = "ENABLED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .disabled => "DISABLED",
            .enabled => "ENABLED",
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
