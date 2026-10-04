const std = @import("std");

/// Dataset lifecycle and operation status.
pub const DatasetStatus = enum {
    /// CreateDataset async ingestion in progress. All writes are blocked.
    creating,
    /// An async example mutation or CreateDatasetVersion is in progress. All writes
    /// are blocked.
    updating,
    /// Full or version-specific delete is in progress. Read operations are still
    /// allowed.
    deleting,
    /// Dataset is stable. All operations are allowed per operation-specific guards.
    active,
    /// Initial ingestion failed. DRAFT record exists but contains no examples.
    create_failed,
    /// Last example mutation or CreateDatasetVersion failed. DRAFT may be partially
    /// modified.
    update_failed,
    /// Delete failed after retries. Dataset record may be in an inconsistent state.
    delete_failed,

    pub const json_field_names = .{
        .creating = "CREATING",
        .updating = "UPDATING",
        .deleting = "DELETING",
        .active = "ACTIVE",
        .create_failed = "CREATE_FAILED",
        .update_failed = "UPDATE_FAILED",
        .delete_failed = "DELETE_FAILED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .creating => "CREATING",
            .updating => "UPDATING",
            .deleting => "DELETING",
            .active => "ACTIVE",
            .create_failed => "CREATE_FAILED",
            .update_failed => "UPDATE_FAILED",
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
