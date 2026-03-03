const std = @import("std");

pub const EnvironmentStatus = enum {
    create_requested,
    creating,
    created,
    delete_requested,
    deleting,
    deleted,
    failed_creation,
    retry_deletion,
    failed_deletion,
    update_network_requested,
    updating_network,
    failed_updating_network,
    suspended,

    pub const json_field_names = .{
        .create_requested = "CREATE_REQUESTED",
        .creating = "CREATING",
        .created = "CREATED",
        .delete_requested = "DELETE_REQUESTED",
        .deleting = "DELETING",
        .deleted = "DELETED",
        .failed_creation = "FAILED_CREATION",
        .retry_deletion = "RETRY_DELETION",
        .failed_deletion = "FAILED_DELETION",
        .update_network_requested = "UPDATE_NETWORK_REQUESTED",
        .updating_network = "UPDATING_NETWORK",
        .failed_updating_network = "FAILED_UPDATING_NETWORK",
        .suspended = "SUSPENDED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .create_requested => "CREATE_REQUESTED",
            .creating => "CREATING",
            .created => "CREATED",
            .delete_requested => "DELETE_REQUESTED",
            .deleting => "DELETING",
            .deleted => "DELETED",
            .failed_creation => "FAILED_CREATION",
            .retry_deletion => "RETRY_DELETION",
            .failed_deletion => "FAILED_DELETION",
            .update_network_requested => "UPDATE_NETWORK_REQUESTED",
            .updating_network => "UPDATING_NETWORK",
            .failed_updating_network => "FAILED_UPDATING_NETWORK",
            .suspended => "SUSPENDED",
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
