const std = @import("std");

/// The reason why applying an instrumentation configuration failed.
///
/// * `FILE_NOT_FOUND` - The specified file or file location could not be
///   located.
/// * `METHOD_NOT_FOUND` - The specified method or function does not exist.
/// * `LINE_NOT_EXECUTABLE` - The specified line does not contain executable
///   code.
/// * `OVERLOADED_METHODS` - Multiple overloaded methods were found; provide a
///   line number to disambiguate.
/// * `LANGUAGE_MISMATCH` - The language specified in the configuration does not
///   match the service.
/// * `RUNTIME_ERROR` - A runtime error occurred while applying the
///   instrumentation.
pub const InstrumentationErrorCause = enum {
    file_not_found,
    method_not_found,
    line_not_executable,
    overloaded_methods,
    language_mismatch,
    runtime_error,

    pub const json_field_names = .{
        .file_not_found = "FILE_NOT_FOUND",
        .method_not_found = "METHOD_NOT_FOUND",
        .line_not_executable = "LINE_NOT_EXECUTABLE",
        .overloaded_methods = "OVERLOADED_METHODS",
        .language_mismatch = "LANGUAGE_MISMATCH",
        .runtime_error = "RUNTIME_ERROR",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .file_not_found => "FILE_NOT_FOUND",
            .method_not_found => "METHOD_NOT_FOUND",
            .line_not_executable => "LINE_NOT_EXECUTABLE",
            .overloaded_methods => "OVERLOADED_METHODS",
            .language_mismatch => "LANGUAGE_MISMATCH",
            .runtime_error => "RUNTIME_ERROR",
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
