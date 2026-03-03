const std = @import("std");

/// Object status with the following possible values:
///
/// * `PENDING`
///
/// * `INPROGRESS`
///
/// * `FAILED`
///
/// * `COMPLETED`
///
/// * `DELETED`
pub const EntityStatus = enum {
    pending,
    inprogress,
    failed,
    completed,
    deleted,

    pub const json_field_names = .{
        .pending = "PENDING",
        .inprogress = "INPROGRESS",
        .failed = "FAILED",
        .completed = "COMPLETED",
        .deleted = "DELETED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .pending => "PENDING",
            .inprogress => "INPROGRESS",
            .failed => "FAILED",
            .completed => "COMPLETED",
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
