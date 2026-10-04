const std = @import("std");

pub const RuleType = enum {
    metadata_form_enforcement,
    glossary_term_enforcement,

    pub const json_field_names = .{
        .metadata_form_enforcement = "METADATA_FORM_ENFORCEMENT",
        .glossary_term_enforcement = "GLOSSARY_TERM_ENFORCEMENT",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .metadata_form_enforcement => "METADATA_FORM_ENFORCEMENT",
            .glossary_term_enforcement => "GLOSSARY_TERM_ENFORCEMENT",
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
