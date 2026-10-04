const std = @import("std");

pub const SortByType = enum {
    created_date,
    last_accessed_date,
    last_changed_date,
    name,

    pub const json_field_names = .{
        .created_date = "created-date",
        .last_accessed_date = "last-accessed-date",
        .last_changed_date = "last-changed-date",
        .name = "name",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .created_date => "created-date",
            .last_accessed_date => "last-accessed-date",
            .last_changed_date => "last-changed-date",
            .name => "name",
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
