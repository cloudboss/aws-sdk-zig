const std = @import("std");

/// The status of a capacity provider. Possible values:
///
/// * `CREATING` – The service is creating the capacity provider and validating
///   its configuration.
/// * `CREATE_FAILED` – The service could not create the capacity provider. For
///   details, see `statusCode` and `statusReason`.
/// * `UPDATING` – The service is updating the capacity provider.
/// * `UPDATE_FAILED` – The service could not update the capacity provider. For
///   details, see `statusCode` and `statusReason`.
/// * `READY` – The capacity provider is available for use.
/// * `DELETING` – The service is deleting the capacity provider.
/// * `DELETE_FAILED` – The service could not delete the capacity provider. You
///   can retry the deletion.
pub const CapacityProviderStatus = enum {
    creating,
    create_failed,
    updating,
    update_failed,
    ready,
    deleting,
    delete_failed,

    pub const json_field_names = .{
        .creating = "CREATING",
        .create_failed = "CREATE_FAILED",
        .updating = "UPDATING",
        .update_failed = "UPDATE_FAILED",
        .ready = "READY",
        .deleting = "DELETING",
        .delete_failed = "DELETE_FAILED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .creating => "CREATING",
            .create_failed => "CREATE_FAILED",
            .updating => "UPDATING",
            .update_failed => "UPDATE_FAILED",
            .ready => "READY",
            .deleting => "DELETING",
            .delete_failed => "DELETE_FAILED",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        const fields = @typeInfo(@TypeOf(json_field_names)).@"struct".field_names;
        inline for (fields) |field_name| {
            if (std.mem.eql(u8, str, @field(json_field_names, field_name))) {
                return @field(@This(), field_name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
