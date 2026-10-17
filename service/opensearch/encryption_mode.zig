const std = @import("std");

/// The type of encryption at rest applied to a domain's data: `DISK` for
/// volume-level encryption or `NATIVE` for engine-native, index-level
/// encryption.
pub const EncryptionMode = enum {
    disk,
    native,

    pub const json_field_names = .{
        .disk = "DISK",
        .native = "NATIVE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .disk => "DISK",
            .native => "NATIVE",
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
