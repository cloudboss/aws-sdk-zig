const std = @import("std");

/// Indicates whether a registry record's custom metadata conforms to the
/// registry's current schema. `COMPLIANT` means all required fields are present
/// and all values match their declared types. `NON_COMPLIANT` means the
/// metadata does not satisfy the current schema, for example because the schema
/// was updated after the record was last modified.
pub const CustomMetadataSchemaComplianceStatus = enum {
    compliant,
    non_compliant,

    pub const json_field_names = .{
        .compliant = "COMPLIANT",
        .non_compliant = "NON_COMPLIANT",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .compliant => "COMPLIANT",
            .non_compliant => "NON_COMPLIANT",
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
