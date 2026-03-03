const std = @import("std");

/// Used in DescribeNetworkResult, DescribeNetworkSummary, UpdateNetworkResult.
pub const NetworkState = enum {
    creating,
    create_failed,
    active,
    deleting,
    idle,
    in_use,
    updating,
    delete_failed,
    deleted,

    pub const json_field_names = .{
        .creating = "CREATING",
        .create_failed = "CREATE_FAILED",
        .active = "ACTIVE",
        .deleting = "DELETING",
        .idle = "IDLE",
        .in_use = "IN_USE",
        .updating = "UPDATING",
        .delete_failed = "DELETE_FAILED",
        .deleted = "DELETED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .creating => "CREATING",
            .create_failed => "CREATE_FAILED",
            .active => "ACTIVE",
            .deleting => "DELETING",
            .idle => "IDLE",
            .in_use => "IN_USE",
            .updating => "UPDATING",
            .delete_failed => "DELETE_FAILED",
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
