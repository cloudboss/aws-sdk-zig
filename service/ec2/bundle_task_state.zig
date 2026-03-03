const std = @import("std");

pub const BundleTaskState = enum {
    pending,
    waiting_for_shutdown,
    bundling,
    storing,
    cancelling,
    complete,
    failed,

    pub const json_field_names = .{
        .pending = "pending",
        .waiting_for_shutdown = "waiting-for-shutdown",
        .bundling = "bundling",
        .storing = "storing",
        .cancelling = "cancelling",
        .complete = "complete",
        .failed = "failed",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .pending => "pending",
            .waiting_for_shutdown => "waiting-for-shutdown",
            .bundling => "bundling",
            .storing => "storing",
            .cancelling => "cancelling",
            .complete => "complete",
            .failed => "failed",
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
