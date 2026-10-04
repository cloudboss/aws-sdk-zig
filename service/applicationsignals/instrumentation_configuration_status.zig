const std = @import("std");

/// The status of an instrumentation configuration on a host.
///
/// * `READY` - The configuration has been applied but has not been hit yet.
/// * `ERROR` - Applying the configuration failed; see the error cause.
/// * `ACTIVE` - The configuration has been hit and is capturing data.
/// * `DISABLED` - The configuration was disabled, for example because a limit
///   was reached.
pub const InstrumentationConfigurationStatus = enum {
    ready,
    @"error",
    active,
    disabled,

    pub const json_field_names = .{
        .ready = "READY",
        .@"error" = "ERROR",
        .active = "ACTIVE",
        .disabled = "DISABLED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .ready => "READY",
            .@"error" => "ERROR",
            .active => "ACTIVE",
            .disabled => "DISABLED",
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
