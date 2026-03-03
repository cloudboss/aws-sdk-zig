const std = @import("std");

pub const MetadataGenerationRunType = enum {
    business_descriptions,
    business_names,
    business_glossary_associations,

    pub const json_field_names = .{
        .business_descriptions = "BUSINESS_DESCRIPTIONS",
        .business_names = "BUSINESS_NAMES",
        .business_glossary_associations = "BUSINESS_GLOSSARY_ASSOCIATIONS",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .business_descriptions => "BUSINESS_DESCRIPTIONS",
            .business_names => "BUSINESS_NAMES",
            .business_glossary_associations => "BUSINESS_GLOSSARY_ASSOCIATIONS",
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
