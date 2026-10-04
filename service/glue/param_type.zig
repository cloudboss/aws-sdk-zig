const std = @import("std");

pub const ParamType = enum {
    str,
    int,
    float,
    complex,
    bool,
    list,
    null,

    pub const json_field_names = .{
        .str = "str",
        .int = "int",
        .float = "float",
        .complex = "complex",
        .bool = "bool",
        .list = "list",
        .null = "null",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .str => "str",
            .int => "int",
            .float => "float",
            .complex => "complex",
            .bool => "bool",
            .list => "list",
            .null => "null",
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
