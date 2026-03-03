const std = @import("std");

pub const ChunkingStrategy = enum {
    fixed_size,
    none,
    hierarchical,
    semantic,

    pub const json_field_names = .{
        .fixed_size = "FIXED_SIZE",
        .none = "NONE",
        .hierarchical = "HIERARCHICAL",
        .semantic = "SEMANTIC",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .fixed_size => "FIXED_SIZE",
            .none => "NONE",
            .hierarchical => "HIERARCHICAL",
            .semantic => "SEMANTIC",
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
