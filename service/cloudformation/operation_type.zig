const std = @import("std");

pub const OperationType = enum {
    create_stack,
    update_stack,
    delete_stack,
    continue_rollback,
    rollback,
    create_changeset,

    pub const json_field_names = .{
        .create_stack = "CREATE_STACK",
        .update_stack = "UPDATE_STACK",
        .delete_stack = "DELETE_STACK",
        .continue_rollback = "CONTINUE_ROLLBACK",
        .rollback = "ROLLBACK",
        .create_changeset = "CREATE_CHANGESET",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .create_stack => "CREATE_STACK",
            .update_stack => "UPDATE_STACK",
            .delete_stack => "DELETE_STACK",
            .continue_rollback => "CONTINUE_ROLLBACK",
            .rollback => "ROLLBACK",
            .create_changeset => "CREATE_CHANGESET",
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
