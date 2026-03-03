const std = @import("std");

pub const BatchRebootClusterNodesErrorCode = enum {
    instance_id_not_found,
    invalid_instance_status,
    instance_id_in_use,
    internal_server_error,

    pub const json_field_names = .{
        .instance_id_not_found = "InstanceIdNotFound",
        .invalid_instance_status = "InvalidInstanceStatus",
        .instance_id_in_use = "InstanceIdInUse",
        .internal_server_error = "InternalServerError",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .instance_id_not_found => "InstanceIdNotFound",
            .invalid_instance_status => "InvalidInstanceStatus",
            .instance_id_in_use => "InstanceIdInUse",
            .internal_server_error => "InternalServerError",
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
