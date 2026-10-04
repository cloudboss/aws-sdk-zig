const std = @import("std");

/// Specifies whether the agent-generated answer is written back to a short-term
/// memory session.
pub const AgenticRetrieveMemoryPersistenceMode = enum {
    /// Specifies that the question and the agent-generated answer are persisted to
    /// the session. This is the default when persistenceMode is omitted.
    default,
    /// Specifies that the session is left unchanged.
    none,

    pub const json_field_names = .{
        .default = "DEFAULT",
        .none = "NONE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .default => "DEFAULT",
            .none => "NONE",
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
