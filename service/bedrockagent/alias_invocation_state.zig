const std = @import("std");

/// Enum representing the invocation state of an agent alias
pub const AliasInvocationState = enum {
    /// Agent is actively processing requests
    accept_invocations,
    /// Agent is paused and will not accept new requests
    reject_invocations,

    pub const json_field_names = .{
        .accept_invocations = "ACCEPT_INVOCATIONS",
        .reject_invocations = "REJECT_INVOCATIONS",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .accept_invocations => "ACCEPT_INVOCATIONS",
            .reject_invocations => "REJECT_INVOCATIONS",
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
