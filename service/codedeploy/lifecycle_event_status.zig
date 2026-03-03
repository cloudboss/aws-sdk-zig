const std = @import("std");

pub const LifecycleEventStatus = enum {
    pending,
    in_progress,
    succeeded,
    failed,
    skipped,
    unknown,

    pub const json_field_names = .{
        .pending = "Pending",
        .in_progress = "InProgress",
        .succeeded = "Succeeded",
        .failed = "Failed",
        .skipped = "Skipped",
        .unknown = "Unknown",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .pending => "Pending",
            .in_progress => "InProgress",
            .succeeded => "Succeeded",
            .failed => "Failed",
            .skipped => "Skipped",
            .unknown => "Unknown",
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
