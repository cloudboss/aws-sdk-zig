const std = @import("std");

pub const ScheduleLambdaFunctionFailedCause = enum {
    id_already_in_use,
    open_lambda_functions_limit_exceeded,
    lambda_function_creation_rate_exceeded,
    lambda_service_not_available_in_region,

    pub const json_field_names = .{
        .id_already_in_use = "ID_ALREADY_IN_USE",
        .open_lambda_functions_limit_exceeded = "OPEN_LAMBDA_FUNCTIONS_LIMIT_EXCEEDED",
        .lambda_function_creation_rate_exceeded = "LAMBDA_FUNCTION_CREATION_RATE_EXCEEDED",
        .lambda_service_not_available_in_region = "LAMBDA_SERVICE_NOT_AVAILABLE_IN_REGION",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .id_already_in_use => "ID_ALREADY_IN_USE",
            .open_lambda_functions_limit_exceeded => "OPEN_LAMBDA_FUNCTIONS_LIMIT_EXCEEDED",
            .lambda_function_creation_rate_exceeded => "LAMBDA_FUNCTION_CREATION_RATE_EXCEEDED",
            .lambda_service_not_available_in_region => "LAMBDA_SERVICE_NOT_AVAILABLE_IN_REGION",
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
