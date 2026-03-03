const std = @import("std");

pub const EventType = enum {
    system,
    create_action,
    delete_action,
    update_action,
    execute_action,

    pub const json_field_names = .{
        .system = "SYSTEM",
        .create_action = "CREATE_ACTION",
        .delete_action = "DELETE_ACTION",
        .update_action = "UPDATE_ACTION",
        .execute_action = "EXECUTE_ACTION",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .system => "SYSTEM",
            .create_action => "CREATE_ACTION",
            .delete_action => "DELETE_ACTION",
            .update_action => "UPDATE_ACTION",
            .execute_action => "EXECUTE_ACTION",
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
