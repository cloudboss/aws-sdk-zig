const std = @import("std");

pub const KnowledgeBaseSortByField = enum {
    knowledge_base_size_bytes,
    created_at,

    pub const json_field_names = .{
        .knowledge_base_size_bytes = "KNOWLEDGE_BASE_SIZE_BYTES",
        .created_at = "CREATED_AT",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .knowledge_base_size_bytes => "KNOWLEDGE_BASE_SIZE_BYTES",
            .created_at => "CREATED_AT",
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
