const std = @import("std");

/// The type of resource that a limit applies to.
pub const ResourceType = enum {
    index_storage,
    agent_hours,

    pub const json_field_names = .{
        .index_storage = "INDEX_STORAGE",
        .agent_hours = "AGENT_HOURS",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .index_storage => "INDEX_STORAGE",
            .agent_hours => "AGENT_HOURS",
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
