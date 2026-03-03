const std = @import("std");

pub const SlotTypeCategory = enum {
    custom,
    extended,
    external_grammar,
    composite,

    pub const json_field_names = .{
        .custom = "Custom",
        .extended = "Extended",
        .external_grammar = "ExternalGrammar",
        .composite = "Composite",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .custom => "Custom",
            .extended => "Extended",
            .external_grammar => "ExternalGrammar",
            .composite => "Composite",
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
