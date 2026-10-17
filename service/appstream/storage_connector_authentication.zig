const std = @import("std");

/// Specifies whether users' cloud storage authentication persists across
/// streaming sessions.
pub const StorageConnectorAuthentication = enum {
    force_reauthentication,
    reuse_credentials,

    pub const json_field_names = .{
        .force_reauthentication = "FORCE_REAUTHENTICATION",
        .reuse_credentials = "REUSE_CREDENTIALS",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .force_reauthentication => "FORCE_REAUTHENTICATION",
            .reuse_credentials => "REUSE_CREDENTIALS",
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
