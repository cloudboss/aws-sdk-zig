const std = @import("std");

pub const ArrayJobDependency = enum {
    n_to_n,
    sequential,

    pub const json_field_names = .{
        .n_to_n = "N_TO_N",
        .sequential = "SEQUENTIAL",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .n_to_n => "N_TO_N",
            .sequential => "SEQUENTIAL",
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
