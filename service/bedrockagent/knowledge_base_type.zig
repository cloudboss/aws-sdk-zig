const std = @import("std");

/// The type of a knowledge base.
pub const KnowledgeBaseType = enum {
    vector,
    kendra,
    sql,
    managed,

    pub const json_field_names = .{
        .vector = "VECTOR",
        .kendra = "KENDRA",
        .sql = "SQL",
        .managed = "MANAGED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .vector => "VECTOR",
            .kendra => "KENDRA",
            .sql => "SQL",
            .managed => "MANAGED",
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
