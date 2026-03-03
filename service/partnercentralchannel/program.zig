const std = @import("std");

pub const Program = enum {
    solution_provider,
    distribution,
    distribution_seller,

    pub const json_field_names = .{
        .solution_provider = "SOLUTION_PROVIDER",
        .distribution = "DISTRIBUTION",
        .distribution_seller = "DISTRIBUTION_SELLER",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .solution_provider => "SOLUTION_PROVIDER",
            .distribution => "DISTRIBUTION",
            .distribution_seller => "DISTRIBUTION_SELLER",
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
