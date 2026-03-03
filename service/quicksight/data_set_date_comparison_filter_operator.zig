const std = @import("std");

pub const DataSetDateComparisonFilterOperator = enum {
    before,
    before_or_equals_to,
    after,
    after_or_equals_to,

    pub const json_field_names = .{
        .before = "BEFORE",
        .before_or_equals_to = "BEFORE_OR_EQUALS_TO",
        .after = "AFTER",
        .after_or_equals_to = "AFTER_OR_EQUALS_TO",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .before => "BEFORE",
            .before_or_equals_to => "BEFORE_OR_EQUALS_TO",
            .after => "AFTER",
            .after_or_equals_to => "AFTER_OR_EQUALS_TO",
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
