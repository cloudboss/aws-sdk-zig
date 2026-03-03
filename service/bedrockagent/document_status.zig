const std = @import("std");

pub const DocumentStatus = enum {
    indexed,
    partially_indexed,
    pending,
    failed,
    metadata_partially_indexed,
    metadata_update_failed,
    ignored,
    not_found,
    starting,
    in_progress,
    deleting,
    delete_in_progress,

    pub const json_field_names = .{
        .indexed = "INDEXED",
        .partially_indexed = "PARTIALLY_INDEXED",
        .pending = "PENDING",
        .failed = "FAILED",
        .metadata_partially_indexed = "METADATA_PARTIALLY_INDEXED",
        .metadata_update_failed = "METADATA_UPDATE_FAILED",
        .ignored = "IGNORED",
        .not_found = "NOT_FOUND",
        .starting = "STARTING",
        .in_progress = "IN_PROGRESS",
        .deleting = "DELETING",
        .delete_in_progress = "DELETE_IN_PROGRESS",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .indexed => "INDEXED",
            .partially_indexed => "PARTIALLY_INDEXED",
            .pending => "PENDING",
            .failed => "FAILED",
            .metadata_partially_indexed => "METADATA_PARTIALLY_INDEXED",
            .metadata_update_failed => "METADATA_UPDATE_FAILED",
            .ignored => "IGNORED",
            .not_found => "NOT_FOUND",
            .starting => "STARTING",
            .in_progress => "IN_PROGRESS",
            .deleting => "DELETING",
            .delete_in_progress => "DELETE_IN_PROGRESS",
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
