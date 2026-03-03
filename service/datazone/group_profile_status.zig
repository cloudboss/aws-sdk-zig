const std = @import("std");

pub const GroupProfileStatus = enum {
    assigned,
    not_assigned,

    pub const json_field_names = .{
        .assigned = "ASSIGNED",
        .not_assigned = "NOT_ASSIGNED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .assigned => "ASSIGNED",
            .not_assigned => "NOT_ASSIGNED",
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
