const std = @import("std");

pub const EventTypeActionability = enum {
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
        const fields = @typeInfo(@TypeOf(json_field_names)).@"struct".field_names;
        inline for (fields) |field_name| {
            if (std.mem.eql(u8, str, @field(json_field_names, field_name))) {
                return @field(@This(), field_name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
