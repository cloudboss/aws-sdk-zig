const std = @import("std");

/// The scope type for a document access control list (ACL) membership
/// condition. Valid values: `KNOWLEDGE_BASE` – The entry applies at the
/// knowledge base level. `DATA_SOURCE` – The entry applies at the data source
/// level.
pub const DocumentAclMembershipType = enum {
    knowledge_base,
    data_source,

    pub const json_field_names = .{
        .knowledge_base = "KNOWLEDGE_BASE",
        .data_source = "DATA_SOURCE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .knowledge_base => "KNOWLEDGE_BASE",
            .data_source => "DATA_SOURCE",
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
