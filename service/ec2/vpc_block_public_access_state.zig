const std = @import("std");

pub const VpcBlockPublicAccessState = enum {
    default_state,
    update_in_progress,
    update_complete,

    pub const json_field_names = .{
        .default_state = "default-state",
        .update_in_progress = "update-in-progress",
        .update_complete = "update-complete",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .default_state => "default-state",
            .update_in_progress => "update-in-progress",
            .update_complete => "update-complete",
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
