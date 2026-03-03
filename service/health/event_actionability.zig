const std = @import("std");

pub const EventActionability = enum {
    action_required,
    action_may_be_required,
    informational,

    pub const json_field_names = .{
        .action_required = "ACTION_REQUIRED",
        .action_may_be_required = "ACTION_MAY_BE_REQUIRED",
        .informational = "INFORMATIONAL",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .action_required => "ACTION_REQUIRED",
            .action_may_be_required => "ACTION_MAY_BE_REQUIRED",
            .informational => "INFORMATIONAL",
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
