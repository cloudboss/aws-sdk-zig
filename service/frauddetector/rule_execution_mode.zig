const std = @import("std");

pub const RuleExecutionMode = enum {
    all_matched,
    first_matched,

    pub const json_field_names = .{
        .all_matched = "ALL_MATCHED",
        .first_matched = "FIRST_MATCHED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .all_matched => "ALL_MATCHED",
            .first_matched => "FIRST_MATCHED",
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
