const std = @import("std");

pub const FleetContextCode = enum {
    create_failed,
    update_failed,
    action_required,
    pending_deletion,
    insufficient_capacity,

    pub const json_field_names = .{
        .create_failed = "CREATE_FAILED",
        .update_failed = "UPDATE_FAILED",
        .action_required = "ACTION_REQUIRED",
        .pending_deletion = "PENDING_DELETION",
        .insufficient_capacity = "INSUFFICIENT_CAPACITY",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .create_failed => "CREATE_FAILED",
            .update_failed => "UPDATE_FAILED",
            .action_required => "ACTION_REQUIRED",
            .pending_deletion => "PENDING_DELETION",
            .insufficient_capacity => "INSUFFICIENT_CAPACITY",
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
