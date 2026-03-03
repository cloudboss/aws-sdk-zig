const std = @import("std");

pub const Status = enum {
    initializing,
    deploying,
    succeeded,
    deleting,
    stopping,
    failed,
    stopped,
    delete_failed,
    stop_failed,
    none,

    pub const json_field_names = .{
        .initializing = "INITIALIZING",
        .deploying = "DEPLOYING",
        .succeeded = "SUCCEEDED",
        .deleting = "DELETING",
        .stopping = "STOPPING",
        .failed = "FAILED",
        .stopped = "STOPPED",
        .delete_failed = "DELETE_FAILED",
        .stop_failed = "STOP_FAILED",
        .none = "NONE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .initializing => "INITIALIZING",
            .deploying => "DEPLOYING",
            .succeeded => "SUCCEEDED",
            .deleting => "DELETING",
            .stopping => "STOPPING",
            .failed => "FAILED",
            .stopped => "STOPPED",
            .delete_failed => "DELETE_FAILED",
            .stop_failed => "STOP_FAILED",
            .none => "NONE",
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
