const std = @import("std");

pub const SchemaValueType = enum {
    /// LONG type
    long,
    /// INT type
    int,
    /// STRING type
    string,
    /// FLOAT type
    float,
    /// DOUBLE type
    double,
    /// BOOLEAN type
    boolean,

    pub const json_field_names = .{
        .long = "LONG",
        .int = "INT",
        .string = "STRING",
        .float = "FLOAT",
        .double = "DOUBLE",
        .boolean = "BOOLEAN",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .long => "LONG",
            .int => "INT",
            .string => "STRING",
            .float => "FLOAT",
            .double => "DOUBLE",
            .boolean => "BOOLEAN",
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
