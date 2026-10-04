const std = @import("std");

/// The enforcement mode for a policy. Run this policy in `LOG_ONLY` mode to
/// collect data on how it affects your application. Once you are satisfied with
/// the data gathered, switch the policy to `ACTIVE`.
pub const EnforcementMode = enum {
    active,
    log_only,

    pub const json_field_names = .{
        .active = "ACTIVE",
        .log_only = "LOG_ONLY",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .active => "ACTIVE",
            .log_only => "LOG_ONLY",
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
