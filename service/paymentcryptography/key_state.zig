const std = @import("std");

/// Defines the state of a key
pub const KeyState = enum {
    create_in_progress,
    create_complete,
    delete_pending,
    delete_complete,

    pub const json_field_names = .{
        .create_in_progress = "CREATE_IN_PROGRESS",
        .create_complete = "CREATE_COMPLETE",
        .delete_pending = "DELETE_PENDING",
        .delete_complete = "DELETE_COMPLETE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .create_in_progress => "CREATE_IN_PROGRESS",
            .create_complete => "CREATE_COMPLETE",
            .delete_pending => "DELETE_PENDING",
            .delete_complete => "DELETE_COMPLETE",
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
