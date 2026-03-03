const std = @import("std");

pub const RecoveryPointStatus = enum {
    completed,
    partial,
    deleting,
    expired,
    available,
    stopped,
    creating,

    pub const json_field_names = .{
        .completed = "COMPLETED",
        .partial = "PARTIAL",
        .deleting = "DELETING",
        .expired = "EXPIRED",
        .available = "AVAILABLE",
        .stopped = "STOPPED",
        .creating = "CREATING",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .completed => "COMPLETED",
            .partial => "PARTIAL",
            .deleting => "DELETING",
            .expired => "EXPIRED",
            .available => "AVAILABLE",
            .stopped => "STOPPED",
            .creating => "CREATING",
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
