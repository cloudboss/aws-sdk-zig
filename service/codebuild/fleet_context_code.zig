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
        const fields = @typeInfo(@TypeOf(json_field_names)).@"struct".field_names;
        inline for (fields) |field_name| {
            if (std.mem.eql(u8, str, @field(json_field_names, field_name))) {
                return @field(@This(), field_name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
