const std = @import("std");

pub const ArchiveState = enum {
    enabled,
    disabled,
    creating,
    updating,
    create_failed,
    update_failed,

    pub const json_field_names = .{
        .enabled = "ENABLED",
        .disabled = "DISABLED",
        .creating = "CREATING",
        .updating = "UPDATING",
        .create_failed = "CREATE_FAILED",
        .update_failed = "UPDATE_FAILED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .enabled => "ENABLED",
            .disabled => "DISABLED",
            .creating => "CREATING",
            .updating => "UPDATING",
            .create_failed => "CREATE_FAILED",
            .update_failed => "UPDATE_FAILED",
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
