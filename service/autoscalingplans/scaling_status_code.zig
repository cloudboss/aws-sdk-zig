const std = @import("std");

pub const ScalingStatusCode = enum {
    inactive,
    partially_active,
    active,

    pub const json_field_names = .{
        .inactive = "Inactive",
        .partially_active = "PartiallyActive",
        .active = "Active",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .inactive => "Inactive",
            .partially_active => "PartiallyActive",
            .active => "Active",
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
