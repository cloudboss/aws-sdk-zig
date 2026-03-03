const std = @import("std");

pub const DocumentClassifierMode = enum {
    multi_class,
    multi_label,

    pub const json_field_names = .{
        .multi_class = "MULTI_CLASS",
        .multi_label = "MULTI_LABEL",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .multi_class => "MULTI_CLASS",
            .multi_label => "MULTI_LABEL",
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
