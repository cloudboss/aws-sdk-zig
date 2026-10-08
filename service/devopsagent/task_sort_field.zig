const std = @import("std");

/// Fields available for sorting tasks
pub const TaskSortField = enum {
    /// Sort by task creation timestamp
    created_at,
    /// Sort by task priority level
    priority,

    pub const json_field_names = .{
        .created_at = "CREATED_AT",
        .priority = "PRIORITY",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .created_at => "CREATED_AT",
            .priority => "PRIORITY",
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
