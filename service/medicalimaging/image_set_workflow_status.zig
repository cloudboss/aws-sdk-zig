const std = @import("std");

pub const ImageSetWorkflowStatus = enum {
    created,
    copied,
    copying,
    copying_with_read_only_access,
    copy_failed,
    updating,
    updated,
    update_failed,
    deleting,
    deleted,
    importing,
    imported,
    import_failed,

    pub const json_field_names = .{
        .created = "CREATED",
        .copied = "COPIED",
        .copying = "COPYING",
        .copying_with_read_only_access = "COPYING_WITH_READ_ONLY_ACCESS",
        .copy_failed = "COPY_FAILED",
        .updating = "UPDATING",
        .updated = "UPDATED",
        .update_failed = "UPDATE_FAILED",
        .deleting = "DELETING",
        .deleted = "DELETED",
        .importing = "IMPORTING",
        .imported = "IMPORTED",
        .import_failed = "IMPORT_FAILED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .created => "CREATED",
            .copied => "COPIED",
            .copying => "COPYING",
            .copying_with_read_only_access => "COPYING_WITH_READ_ONLY_ACCESS",
            .copy_failed => "COPY_FAILED",
            .updating => "UPDATING",
            .updated => "UPDATED",
            .update_failed => "UPDATE_FAILED",
            .deleting => "DELETING",
            .deleted => "DELETED",
            .importing => "IMPORTING",
            .imported => "IMPORTED",
            .import_failed => "IMPORT_FAILED",
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
