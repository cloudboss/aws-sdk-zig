const std = @import("std");

pub const DataRepositoryTaskLifecycle = enum {
    pending,
    executing,
    failed,
    succeeded,
    canceled,
    canceling,

    pub const json_field_names = .{
        .pending = "PENDING",
        .executing = "EXECUTING",
        .failed = "FAILED",
        .succeeded = "SUCCEEDED",
        .canceled = "CANCELED",
        .canceling = "CANCELING",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .pending => "PENDING",
            .executing => "EXECUTING",
            .failed => "FAILED",
            .succeeded => "SUCCEEDED",
            .canceled => "CANCELED",
            .canceling => "CANCELING",
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
