const std = @import("std");

pub const ValidationExceptionReason = enum {
    unsupported_operation,
    field_validation_failed,
    other,
    invalid_inbound_event,

    pub const json_field_names = .{
        .unsupported_operation = "unsupportedOperation",
        .field_validation_failed = "fieldValidationFailed",
        .other = "other",
        .invalid_inbound_event = "invalidInboundEvent",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .unsupported_operation => "unsupportedOperation",
            .field_validation_failed => "fieldValidationFailed",
            .other => "other",
            .invalid_inbound_event => "invalidInboundEvent",
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
