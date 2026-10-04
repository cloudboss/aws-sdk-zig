const std = @import("std");

pub const ModelVersionStatus = enum {
    in_progress,
    success,
    failed,
    import_in_progress,
    canceled,

    pub const json_field_names = .{
        .in_progress = "IN_PROGRESS",
        .success = "SUCCESS",
        .failed = "FAILED",
        .import_in_progress = "IMPORT_IN_PROGRESS",
        .canceled = "CANCELED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .in_progress => "IN_PROGRESS",
            .success => "SUCCESS",
            .failed => "FAILED",
            .import_in_progress => "IMPORT_IN_PROGRESS",
            .canceled => "CANCELED",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        const fields = @typeInfo(@TypeOf(json_field_names)).@"struct".field_names;
        inline for (fields) |field_name| {
            if (std.mem.eql(u8, str, @field(json_field_names, field_name))) {
                return @field(@This(), field_name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
