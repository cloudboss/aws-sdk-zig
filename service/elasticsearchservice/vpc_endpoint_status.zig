const std = @import("std");

/// Specifies the current status of the VPC endpoint:
///
/// * CREATING: Indicates that the VPC endpoint is currently being created.
///
/// * CREATE_FAILED: Indicates that the VPC endpoint creation failed.
///
/// * ACTIVE: Indicates that the VPC endpoint is currently active.
///
/// * UPDATING: Indicates that the VPC endpoint is currently being updated.
///
/// * UPDATE_FAILED: Indicates that the VPC endpoint update failed.
///
/// * DELETING: Indicates that the VPC endpoint is currently being deleted.
///
/// * DELETE_FAILED: Indicates that the VPC endpoint deletion failed.
pub const VpcEndpointStatus = enum {
    creating,
    create_failed,
    active,
    updating,
    update_failed,
    deleting,
    delete_failed,

    pub const json_field_names = .{
        .creating = "CREATING",
        .create_failed = "CREATE_FAILED",
        .active = "ACTIVE",
        .updating = "UPDATING",
        .update_failed = "UPDATE_FAILED",
        .deleting = "DELETING",
        .delete_failed = "DELETE_FAILED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .creating => "CREATING",
            .create_failed => "CREATE_FAILED",
            .active => "ACTIVE",
            .updating => "UPDATING",
            .update_failed => "UPDATE_FAILED",
            .deleting => "DELETING",
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
