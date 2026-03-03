const std = @import("std");

pub const StandardsStatus = enum {
    pending,
    ready,
    failed,
    deleting,
    incomplete,

    pub const json_field_names = .{
        .pending = "PENDING",
        .ready = "READY",
        .failed = "FAILED",
        .deleting = "DELETING",
        .incomplete = "INCOMPLETE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .pending => "PENDING",
            .ready => "READY",
            .failed => "FAILED",
            .deleting => "DELETING",
            .incomplete => "INCOMPLETE",
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
