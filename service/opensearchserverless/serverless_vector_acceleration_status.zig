const std = @import("std");

/// Specifies whether serverless vector acceleration is enabled for the
/// collection.
pub const ServerlessVectorAccelerationStatus = enum {
    /// Serverless vector acceleration is enabled by default
    enabled,
    /// Serverless vector acceleration is disabled
    disabled,
    /// Serverless vector acceleration is allowed but not enabled by default
    allowed,

    pub const json_field_names = .{
        .enabled = "ENABLED",
        .disabled = "DISABLED",
        .allowed = "ALLOWED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .enabled => "ENABLED",
            .disabled => "DISABLED",
            .allowed => "ALLOWED",
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
