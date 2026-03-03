const std = @import("std");

pub const tgwStatus = enum {
    none,
    update_requested,
    updating,
    failed_update,
    successfully_updated,

    pub const json_field_names = .{
        .none = "NONE",
        .update_requested = "UPDATE_REQUESTED",
        .updating = "UPDATING",
        .failed_update = "FAILED_UPDATE",
        .successfully_updated = "SUCCESSFULLY_UPDATED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .none => "NONE",
            .update_requested => "UPDATE_REQUESTED",
            .updating => "UPDATING",
            .failed_update => "FAILED_UPDATE",
            .successfully_updated => "SUCCESSFULLY_UPDATED",
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
