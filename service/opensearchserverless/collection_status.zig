const std = @import("std");

pub const CollectionStatus = enum {
    /// Creating collection resource
    creating,
    /// Updating collection resource
    updating,
    /// Deleting collection resource
    deleting,
    /// Collection resource is ready to use
    active,
    /// Collection resource create or delete failed
    failed,
    /// Collection resource update failed
    update_failed,

    pub const json_field_names = .{
        .creating = "CREATING",
        .updating = "UPDATING",
        .deleting = "DELETING",
        .active = "ACTIVE",
        .failed = "FAILED",
        .update_failed = "UPDATE_FAILED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .creating => "CREATING",
            .updating => "UPDATING",
            .deleting => "DELETING",
            .active => "ACTIVE",
            .failed => "FAILED",
            .update_failed => "UPDATE_FAILED",
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
