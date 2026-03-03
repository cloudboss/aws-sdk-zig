const std = @import("std");

pub const PolicyGenerationStatus = enum {
    generating,
    generated,
    generate_failed,
    delete_failed,

    pub const json_field_names = .{
        .generating = "GENERATING",
        .generated = "GENERATED",
        .generate_failed = "GENERATE_FAILED",
        .delete_failed = "DELETE_FAILED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .generating => "GENERATING",
            .generated => "GENERATED",
            .generate_failed => "GENERATE_FAILED",
            .delete_failed => "DELETE_FAILED",
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
