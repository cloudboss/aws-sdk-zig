const std = @import("std");

pub const DocumentStatus = enum {
    received,
    processing,
    indexed,
    updated,
    failed,
    deleting,
    deleted,
    document_failed_to_index,

    pub const json_field_names = .{
        .received = "RECEIVED",
        .processing = "PROCESSING",
        .indexed = "INDEXED",
        .updated = "UPDATED",
        .failed = "FAILED",
        .deleting = "DELETING",
        .deleted = "DELETED",
        .document_failed_to_index = "DOCUMENT_FAILED_TO_INDEX",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .received => "RECEIVED",
            .processing => "PROCESSING",
            .indexed => "INDEXED",
            .updated => "UPDATED",
            .failed => "FAILED",
            .deleting => "DELETING",
            .deleted => "DELETED",
            .document_failed_to_index => "DOCUMENT_FAILED_TO_INDEX",
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
