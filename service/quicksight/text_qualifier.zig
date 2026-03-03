const std = @import("std");

pub const TextQualifier = enum {
    double_quote,
    single_quote,

    pub const json_field_names = .{
        .double_quote = "DOUBLE_QUOTE",
        .single_quote = "SINGLE_QUOTE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .double_quote => "DOUBLE_QUOTE",
            .single_quote => "SINGLE_QUOTE",
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
