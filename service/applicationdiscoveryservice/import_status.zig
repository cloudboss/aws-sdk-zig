const std = @import("std");

pub const ImportStatus = enum {
    import_in_progress,
    import_complete,
    import_complete_with_errors,
    import_failed,
    import_failed_server_limit_exceeded,
    import_failed_record_limit_exceeded,
    import_failed_unsupported_file_type,
    delete_in_progress,
    delete_complete,
    delete_failed,
    delete_failed_limit_exceeded,
    internal_error,

    pub const json_field_names = .{
        .import_in_progress = "IMPORT_IN_PROGRESS",
        .import_complete = "IMPORT_COMPLETE",
        .import_complete_with_errors = "IMPORT_COMPLETE_WITH_ERRORS",
        .import_failed = "IMPORT_FAILED",
        .import_failed_server_limit_exceeded = "IMPORT_FAILED_SERVER_LIMIT_EXCEEDED",
        .import_failed_record_limit_exceeded = "IMPORT_FAILED_RECORD_LIMIT_EXCEEDED",
        .import_failed_unsupported_file_type = "IMPORT_FAILED_UNSUPPORTED_FILE_TYPE",
        .delete_in_progress = "DELETE_IN_PROGRESS",
        .delete_complete = "DELETE_COMPLETE",
        .delete_failed = "DELETE_FAILED",
        .delete_failed_limit_exceeded = "DELETE_FAILED_LIMIT_EXCEEDED",
        .internal_error = "INTERNAL_ERROR",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .import_in_progress => "IMPORT_IN_PROGRESS",
            .import_complete => "IMPORT_COMPLETE",
            .import_complete_with_errors => "IMPORT_COMPLETE_WITH_ERRORS",
            .import_failed => "IMPORT_FAILED",
            .import_failed_server_limit_exceeded => "IMPORT_FAILED_SERVER_LIMIT_EXCEEDED",
            .import_failed_record_limit_exceeded => "IMPORT_FAILED_RECORD_LIMIT_EXCEEDED",
            .import_failed_unsupported_file_type => "IMPORT_FAILED_UNSUPPORTED_FILE_TYPE",
            .delete_in_progress => "DELETE_IN_PROGRESS",
            .delete_complete => "DELETE_COMPLETE",
            .delete_failed => "DELETE_FAILED",
            .delete_failed_limit_exceeded => "DELETE_FAILED_LIMIT_EXCEEDED",
            .internal_error => "INTERNAL_ERROR",
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
