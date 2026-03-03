const std = @import("std");

pub const assignmentStatusType = enum {
    assigned,
    unassigned,
    any,

    pub const json_field_names = .{
        .assigned = "Assigned",
        .unassigned = "Unassigned",
        .any = "Any",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .assigned => "Assigned",
            .unassigned => "Unassigned",
            .any => "Any",
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
