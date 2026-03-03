const std = @import("std");

pub const ReadSetStatus = enum {
    archived,
    activating,
    active,
    deleting,
    deleted,
    processing_upload,
    upload_failed,

    pub const json_field_names = .{
        .archived = "ARCHIVED",
        .activating = "ACTIVATING",
        .active = "ACTIVE",
        .deleting = "DELETING",
        .deleted = "DELETED",
        .processing_upload = "PROCESSING_UPLOAD",
        .upload_failed = "UPLOAD_FAILED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .archived => "ARCHIVED",
            .activating => "ACTIVATING",
            .active => "ACTIVE",
            .deleting => "DELETING",
            .deleted => "DELETED",
            .processing_upload => "PROCESSING_UPLOAD",
            .upload_failed => "UPLOAD_FAILED",
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
