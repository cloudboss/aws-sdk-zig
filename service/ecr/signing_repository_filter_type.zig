const std = @import("std");

/// The type of filter to use when determining which repositories
/// should have their images automatically signed.
pub const SigningRepositoryFilterType = enum {
    wildcard_match,

    pub const json_field_names = .{
        .wildcard_match = "WILDCARD_MATCH",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .wildcard_match => "WILDCARD_MATCH",
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
