const std = @import("std");

pub const ProvisioningStatus = enum {
    latest_permission_set_provisioned,
    latest_permission_set_not_provisioned,

    pub const json_field_names = .{
        .latest_permission_set_provisioned = "LATEST_PERMISSION_SET_PROVISIONED",
        .latest_permission_set_not_provisioned = "LATEST_PERMISSION_SET_NOT_PROVISIONED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .latest_permission_set_provisioned => "LATEST_PERMISSION_SET_PROVISIONED",
            .latest_permission_set_not_provisioned => "LATEST_PERMISSION_SET_NOT_PROVISIONED",
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
