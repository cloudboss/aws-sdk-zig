const std = @import("std");

pub const ValidationExceptionReason = enum {
    field_validation_failed,
    invalid_configuration,
    invalid_query,
    iam_synchronization_delay,

    pub const json_field_names = .{
        .field_validation_failed = "FIELD_VALIDATION_FAILED",
        .invalid_configuration = "INVALID_CONFIGURATION",
        .invalid_query = "INVALID_QUERY",
        .iam_synchronization_delay = "IAM_SYNCHRONIZATION_DELAY",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .field_validation_failed => "FIELD_VALIDATION_FAILED",
            .invalid_configuration => "INVALID_CONFIGURATION",
            .invalid_query => "INVALID_QUERY",
            .iam_synchronization_delay => "IAM_SYNCHRONIZATION_DELAY",
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
