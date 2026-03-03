const std = @import("std");

pub const EvaluationFormItemSourceValuesComparator = enum {
    in,
    not_in,
    all_in,
    exact,

    pub const json_field_names = .{
        .in = "IN",
        .not_in = "NOT_IN",
        .all_in = "ALL_IN",
        .exact = "EXACT",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .in => "IN",
            .not_in => "NOT_IN",
            .all_in => "ALL_IN",
            .exact => "EXACT",
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
