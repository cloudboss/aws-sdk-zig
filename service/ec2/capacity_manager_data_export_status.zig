const std = @import("std");

pub const CapacityManagerDataExportStatus = enum {
    pending,
    in_progress,
    delivered,
    failed,

    pub const json_field_names = .{
        .pending = "pending",
        .in_progress = "in-progress",
        .delivered = "delivered",
        .failed = "failed",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .pending => "pending",
            .in_progress => "in-progress",
            .delivered => "delivered",
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
