const std = @import("std");

pub const CustomModelDeploymentUpdateStatus = enum {
    updating,
    update_completed,
    update_failed,

    pub const json_field_names = .{
        .updating = "Updating",
        .update_completed = "UpdateCompleted",
        .update_failed = "UpdateFailed",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .updating => "Updating",
            .update_completed => "UpdateCompleted",
            .update_failed => "UpdateFailed",
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
