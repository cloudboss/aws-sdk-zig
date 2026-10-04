const std = @import("std");

pub const ImageTagMutability = enum {
    mutable,
    immutable,
    immutable_with_exclusion,
    mutable_with_exclusion,

    pub const json_field_names = .{
        .mutable = "MUTABLE",
        .immutable = "IMMUTABLE",
        .immutable_with_exclusion = "IMMUTABLE_WITH_EXCLUSION",
        .mutable_with_exclusion = "MUTABLE_WITH_EXCLUSION",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .mutable => "MUTABLE",
            .immutable => "IMMUTABLE",
            .immutable_with_exclusion => "IMMUTABLE_WITH_EXCLUSION",
            .mutable_with_exclusion => "MUTABLE_WITH_EXCLUSION",
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
