const std = @import("std");

pub const ValidationExceptionErrorCode = enum {
    malformed_token,
    expired_token,
    invalid_token,
    field_validation_failed,
    missing_input,
    non_india_customer_can_not_set_pan,
    gst_existence_block_set_pan,

    pub const json_field_names = .{
        .malformed_token = "MalformedToken",
        .expired_token = "ExpiredToken",
        .invalid_token = "InvalidToken",
        .field_validation_failed = "FieldValidationFailed",
        .missing_input = "MissingInput",
        .non_india_customer_can_not_set_pan = "NonIndiaCustomerCanNotSetPAN",
        .gst_existence_block_set_pan = "GSTExistenceBlockSetPAN",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .malformed_token => "MalformedToken",
            .expired_token => "ExpiredToken",
            .invalid_token => "InvalidToken",
            .field_validation_failed => "FieldValidationFailed",
            .missing_input => "MissingInput",
            .non_india_customer_can_not_set_pan => "NonIndiaCustomerCanNotSetPAN",
            .gst_existence_block_set_pan => "GSTExistenceBlockSetPAN",
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
