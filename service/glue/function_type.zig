const std = @import("std");

pub const FunctionType = enum {
    regular_function,
    aggregate_function,
    stored_procedure,

    pub const json_field_names = .{
        .regular_function = "REGULAR_FUNCTION",
        .aggregate_function = "AGGREGATE_FUNCTION",
        .stored_procedure = "STORED_PROCEDURE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .regular_function => "REGULAR_FUNCTION",
            .aggregate_function => "AGGREGATE_FUNCTION",
            .stored_procedure => "STORED_PROCEDURE",
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
