const std = @import("std");

pub const SessionStatus = enum {
    pending,
    cancelled,
    approved,
    failed,
    creating,

    pub const json_field_names = .{
        .pending = "PENDING",
        .cancelled = "CANCELLED",
        .approved = "APPROVED",
        .failed = "FAILED",
        .creating = "CREATING",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .pending => "PENDING",
            .cancelled => "CANCELLED",
            .approved => "APPROVED",
            .failed => "FAILED",
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
