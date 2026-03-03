const std = @import("std");

pub const ResourceGroupState = enum {
    creating,
    create_complete,
    create_failed,
    updating,
    update_complete,
    update_failed,

    pub const json_field_names = .{
        .creating = "CREATING",
        .create_complete = "CREATE_COMPLETE",
        .create_failed = "CREATE_FAILED",
        .updating = "UPDATING",
        .update_complete = "UPDATE_COMPLETE",
        .update_failed = "UPDATE_FAILED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .creating => "CREATING",
            .create_complete => "CREATE_COMPLETE",
            .create_failed => "CREATE_FAILED",
            .updating => "UPDATING",
            .update_complete => "UPDATE_COMPLETE",
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
