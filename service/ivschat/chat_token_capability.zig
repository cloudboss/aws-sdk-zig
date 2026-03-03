const std = @import("std");

pub const ChatTokenCapability = enum {
    send_message,
    disconnect_user,
    delete_message,

    pub const json_field_names = .{
        .send_message = "SEND_MESSAGE",
        .disconnect_user = "DISCONNECT_USER",
        .delete_message = "DELETE_MESSAGE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .send_message => "SEND_MESSAGE",
            .disconnect_user => "DISCONNECT_USER",
            .delete_message => "DELETE_MESSAGE",
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
