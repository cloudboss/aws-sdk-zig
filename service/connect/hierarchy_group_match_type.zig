const std = @import("std");

pub const HierarchyGroupMatchType = enum {
    exact,
    with_child_groups,

    pub const json_field_names = .{
        .exact = "EXACT",
        .with_child_groups = "WITH_CHILD_GROUPS",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .exact => "EXACT",
            .with_child_groups => "WITH_CHILD_GROUPS",
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
