const std = @import("std");

pub const AttachmentStatus = enum {
    upload_in_progress,
    upload_complete,
    upload_failed,
    deleted,

    pub const json_field_names = .{
        .upload_in_progress = "UPLOAD_IN_PROGRESS",
        .upload_complete = "UPLOAD_COMPLETE",
        .upload_failed = "UPLOAD_FAILED",
        .deleted = "DELETED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .upload_in_progress => "UPLOAD_IN_PROGRESS",
            .upload_complete => "UPLOAD_COMPLETE",
            .upload_failed => "UPLOAD_FAILED",
            .deleted => "DELETED",
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
