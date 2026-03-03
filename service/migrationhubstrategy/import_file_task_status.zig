const std = @import("std");

pub const ImportFileTaskStatus = enum {
    import_in_progress,
    import_failed,
    import_partial_success,
    import_success,
    delete_in_progress,
    delete_failed,
    delete_partial_success,
    delete_success,

    pub const json_field_names = .{
        .import_in_progress = "ImportInProgress",
        .import_failed = "ImportFailed",
        .import_partial_success = "ImportPartialSuccess",
        .import_success = "ImportSuccess",
        .delete_in_progress = "DeleteInProgress",
        .delete_failed = "DeleteFailed",
        .delete_partial_success = "DeletePartialSuccess",
        .delete_success = "DeleteSuccess",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .import_in_progress => "ImportInProgress",
            .import_failed => "ImportFailed",
            .import_partial_success => "ImportPartialSuccess",
            .import_success => "ImportSuccess",
            .delete_in_progress => "DeleteInProgress",
            .delete_failed => "DeleteFailed",
            .delete_partial_success => "DeletePartialSuccess",
            .delete_success => "DeleteSuccess",
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
