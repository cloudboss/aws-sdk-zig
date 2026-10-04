const std = @import("std");

/// The behavior when a synchronous hook target fails.
pub const HarnessHookFailureMode = enum {
    /// Specifies that the current action continues when the hook target fails.
    allow,
    /// Specifies that the service denies the current action when the hook target
    /// fails.
    deny,

    pub const json_field_names = .{
        .allow = "allow",
        .deny = "deny",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .allow => "allow",
            .deny => "deny",
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
