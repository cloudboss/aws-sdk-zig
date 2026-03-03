const std = @import("std");

/// H265 Treeblock Size
pub const H265TreeblockSize = enum {
    auto,
    tree_size_32_x32,

    pub const json_field_names = .{
        .auto = "AUTO",
        .tree_size_32_x32 = "TREE_SIZE_32X32",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .auto => "AUTO",
            .tree_size_32_x32 => "TREE_SIZE_32X32",
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
