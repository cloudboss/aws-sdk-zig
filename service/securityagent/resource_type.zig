const std = @import("std");

/// Type of resource.
pub const ResourceType = enum {
    code_repository,
    document,

    pub const json_field_names = .{
        .code_repository = "CODE_REPOSITORY",
        .document = "DOCUMENT",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .code_repository => "CODE_REPOSITORY",
            .document => "DOCUMENT",
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
