const std = @import("std");

/// The type of a function, which determines what the function can do at
/// runtime. For more information, see [Function types and
/// composition](https://docs.aws.amazon.com/mediatailor/latest/ug/monetization-functions-types.html) in the *MediaTailor User Guide*.
pub const FunctionType = enum {
    http_request,
    aws_service_request,
    custom_output,
    concurrent_executor,
    sequential_executor,
    vast_request,

    pub const json_field_names = .{
        .http_request = "HTTP_REQUEST",
        .aws_service_request = "AWS_SERVICE_REQUEST",
        .custom_output = "CUSTOM_OUTPUT",
        .concurrent_executor = "CONCURRENT_EXECUTOR",
        .sequential_executor = "SEQUENTIAL_EXECUTOR",
        .vast_request = "VAST_REQUEST",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .http_request => "HTTP_REQUEST",
            .aws_service_request => "AWS_SERVICE_REQUEST",
            .custom_output => "CUSTOM_OUTPUT",
            .concurrent_executor => "CONCURRENT_EXECUTOR",
            .sequential_executor => "SEQUENTIAL_EXECUTOR",
            .vast_request => "VAST_REQUEST",
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
