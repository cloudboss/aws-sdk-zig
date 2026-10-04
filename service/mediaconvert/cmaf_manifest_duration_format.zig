const std = @import("std");

/// Indicates whether the output manifest should use floating point values for
/// segment duration.
pub const CmafManifestDurationFormat = enum {
    floating_point,
    integer,

    pub const json_field_names = .{
        .floating_point = "FLOATING_POINT",
        .integer = "INTEGER",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .floating_point => "FLOATING_POINT",
            .integer => "INTEGER",
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
