const std = @import("std");

pub const CapacityProviderSessionStatus = enum {
    provisioning,
    deprovisioning,
    active,
    deleting,
    deleted,
    stopped,

    pub const json_field_names = .{
        .provisioning = "Provisioning",
        .deprovisioning = "Deprovisioning",
        .active = "Active",
        .deleting = "Deleting",
        .deleted = "Deleted",
        .stopped = "Stopped",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .provisioning => "Provisioning",
            .deprovisioning => "Deprovisioning",
            .active => "Active",
            .deleting => "Deleting",
            .deleted => "Deleted",
            .stopped => "Stopped",
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
