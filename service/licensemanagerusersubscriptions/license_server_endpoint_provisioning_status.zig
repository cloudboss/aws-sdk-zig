const std = @import("std");

pub const LicenseServerEndpointProvisioningStatus = enum {
    provisioning,
    provisioning_failed,
    provisioned,
    deleting,
    deletion_failed,
    deleted,

    pub const json_field_names = .{
        .provisioning = "PROVISIONING",
        .provisioning_failed = "PROVISIONING_FAILED",
        .provisioned = "PROVISIONED",
        .deleting = "DELETING",
        .deletion_failed = "DELETION_FAILED",
        .deleted = "DELETED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .provisioning => "PROVISIONING",
            .provisioning_failed => "PROVISIONING_FAILED",
            .provisioned => "PROVISIONED",
            .deleting => "DELETING",
            .deletion_failed => "DELETION_FAILED",
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
