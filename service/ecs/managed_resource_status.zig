const std = @import("std");

pub const ManagedResourceStatus = enum {
    provisioning,
    active,
    deprovisioning,
    deleted,
    failed,

    pub const json_field_names = .{
        .provisioning = "PROVISIONING",
        .active = "ACTIVE",
        .deprovisioning = "DEPROVISIONING",
        .deleted = "DELETED",
        .failed = "FAILED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .provisioning => "PROVISIONING",
            .active => "ACTIVE",
            .deprovisioning => "DEPROVISIONING",
            .deleted => "DELETED",
            .failed => "FAILED",
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
