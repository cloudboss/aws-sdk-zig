const std = @import("std");

pub const PackageStatus = enum {
    copying,
    copy_failed,
    validating,
    validation_failed,
    available,
    deleting,
    deleted,
    delete_failed,

    pub const json_field_names = .{
        .copying = "COPYING",
        .copy_failed = "COPY_FAILED",
        .validating = "VALIDATING",
        .validation_failed = "VALIDATION_FAILED",
        .available = "AVAILABLE",
        .deleting = "DELETING",
        .deleted = "DELETED",
        .delete_failed = "DELETE_FAILED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .copying => "COPYING",
            .copy_failed => "COPY_FAILED",
            .validating => "VALIDATING",
            .validation_failed => "VALIDATION_FAILED",
            .available => "AVAILABLE",
            .deleting => "DELETING",
            .deleted => "DELETED",
            .delete_failed => "DELETE_FAILED",
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
