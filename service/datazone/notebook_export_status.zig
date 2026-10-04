const std = @import("std");

/// The status of a notebook export in Amazon SageMaker Unified Studio.
pub const NotebookExportStatus = enum {
    /// The notebook export is in progress.
    in_progress,
    /// The notebook export succeeded.
    succeeded,
    /// The notebook export failed.
    failed,

    pub const json_field_names = .{
        .in_progress = "IN_PROGRESS",
        .succeeded = "SUCCEEDED",
        .failed = "FAILED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .in_progress => "IN_PROGRESS",
            .succeeded => "SUCCEEDED",
            .failed => "FAILED",
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
