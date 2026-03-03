const std = @import("std");

pub const TargetStatus = enum {
    creating,
    updating,
    update_unsuccessful,
    deleting,
    ready,
    failed,
    synchronizing,
    synchronize_unsuccessful,

    pub const json_field_names = .{
        .creating = "CREATING",
        .updating = "UPDATING",
        .update_unsuccessful = "UPDATE_UNSUCCESSFUL",
        .deleting = "DELETING",
        .ready = "READY",
        .failed = "FAILED",
        .synchronizing = "SYNCHRONIZING",
        .synchronize_unsuccessful = "SYNCHRONIZE_UNSUCCESSFUL",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .creating => "CREATING",
            .updating => "UPDATING",
            .update_unsuccessful => "UPDATE_UNSUCCESSFUL",
            .deleting => "DELETING",
            .ready => "READY",
            .failed => "FAILED",
            .synchronizing => "SYNCHRONIZING",
            .synchronize_unsuccessful => "SYNCHRONIZE_UNSUCCESSFUL",
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
