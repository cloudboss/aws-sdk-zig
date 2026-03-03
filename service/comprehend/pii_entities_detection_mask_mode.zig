const std = @import("std");

pub const PiiEntitiesDetectionMaskMode = enum {
    mask,
    replace_with_pii_entity_type,

    pub const json_field_names = .{
        .mask = "MASK",
        .replace_with_pii_entity_type = "REPLACE_WITH_PII_ENTITY_TYPE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .mask => "MASK",
            .replace_with_pii_entity_type => "REPLACE_WITH_PII_ENTITY_TYPE",
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
