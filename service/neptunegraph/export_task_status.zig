const std = @import("std");

pub const ExportTaskStatus = enum {
    initializing,
    exporting,
    succeeded,
    failed,
    cancelling,
    cancelled,
    deleted,

    pub const json_field_names = .{
        .initializing = "INITIALIZING",
        .exporting = "EXPORTING",
        .succeeded = "SUCCEEDED",
        .failed = "FAILED",
        .cancelling = "CANCELLING",
        .cancelled = "CANCELLED",
        .deleted = "DELETED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .initializing => "INITIALIZING",
            .exporting => "EXPORTING",
            .succeeded => "SUCCEEDED",
            .failed => "FAILED",
            .cancelling => "CANCELLING",
            .cancelled => "CANCELLED",
            .deleted => "DELETED",
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
