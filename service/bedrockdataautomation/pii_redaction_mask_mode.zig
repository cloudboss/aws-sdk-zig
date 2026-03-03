const std = @import("std");

/// Mode for redacting detected PII
pub const PIIRedactionMaskMode = enum {
    /// Replace with generic PII marker [PII]
    pii,
    /// Replace with specific entity type marker, e.g. [NAME]/[SSN] etc.
    entity_type,

    pub const json_field_names = .{
        .pii = "PII",
        .entity_type = "ENTITY_TYPE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .pii => "PII",
            .entity_type => "ENTITY_TYPE",
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
