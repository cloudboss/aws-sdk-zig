const std = @import("std");

/// Strategy for merging registration data into brand profile attributes.
pub const OnAttributeConflict = enum {
    /// New registration value replaces the existing attribute value (default).
    replace,
    /// Existing attribute value is kept; the registration value is ignored.
    preserve,

    pub const json_field_names = .{
        .replace = "REPLACE",
        .preserve = "PRESERVE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .replace => "REPLACE",
            .preserve => "PRESERVE",
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
