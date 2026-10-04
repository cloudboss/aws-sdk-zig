const std = @import("std");

/// The lifecycle status of a VPC configuration. Valid values:
///
/// * `CREATING` – The configuration is being created.
/// * `CREATED` – The configuration is ready to use.
/// * `DELETING` – The configuration is being deleted.
/// * `CREATE_FAILED` – Creation failed. See `statusMessage` for the cause.
/// * `DELETE_FAILED` – Deletion failed. See `statusMessage` for the cause.
pub const VpcConfigurationStatus = enum {
    creating,
    created,
    deleting,
    create_failed,
    delete_failed,

    pub const json_field_names = .{
        .creating = "CREATING",
        .created = "CREATED",
        .deleting = "DELETING",
        .create_failed = "CREATE_FAILED",
        .delete_failed = "DELETE_FAILED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .creating => "CREATING",
            .created => "CREATED",
            .deleting => "DELETING",
            .create_failed => "CREATE_FAILED",
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
