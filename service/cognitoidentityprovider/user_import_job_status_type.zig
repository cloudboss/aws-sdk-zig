const std = @import("std");

pub const UserImportJobStatusType = enum {
    created,
    pending,
    in_progress,
    stopping,
    expired,
    stopped,
    failed,
    succeeded,

    pub const json_field_names = .{
        .created = "Created",
        .pending = "Pending",
        .in_progress = "InProgress",
        .stopping = "Stopping",
        .expired = "Expired",
        .stopped = "Stopped",
        .failed = "Failed",
        .succeeded = "Succeeded",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .created => "Created",
            .pending => "Pending",
            .in_progress => "InProgress",
            .stopping => "Stopping",
            .expired => "Expired",
            .stopped => "Stopped",
            .failed => "Failed",
            .succeeded => "Succeeded",
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
