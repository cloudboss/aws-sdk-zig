const std = @import("std");

pub const ColumnOrderingType = enum {
    greater_is_better,
    lesser_is_better,
    specified,

    pub const json_field_names = .{
        .greater_is_better = "GREATER_IS_BETTER",
        .lesser_is_better = "LESSER_IS_BETTER",
        .specified = "SPECIFIED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .greater_is_better => "GREATER_IS_BETTER",
            .lesser_is_better => "LESSER_IS_BETTER",
            .specified => "SPECIFIED",
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
