const std = @import("std");

/// Classification of a pipeline execution failure.
pub const PipelineErrorCode = enum {
    validation_error,
    internal_failure,
    execution_error,
    timed_out,

    pub const json_field_names = .{
        .validation_error = "VALIDATION_ERROR",
        .internal_failure = "INTERNAL_FAILURE",
        .execution_error = "EXECUTION_ERROR",
        .timed_out = "TIMED_OUT",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .validation_error => "VALIDATION_ERROR",
            .internal_failure => "INTERNAL_FAILURE",
            .execution_error => "EXECUTION_ERROR",
            .timed_out => "TIMED_OUT",
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
