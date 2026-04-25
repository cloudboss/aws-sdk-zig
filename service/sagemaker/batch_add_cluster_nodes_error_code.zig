const std = @import("std");

pub const BatchAddClusterNodesErrorCode = enum {
    instance_group_not_found,
    invalid_instance_group_status,
    incompatible_availability_zones,
    incompatible_instance_types,

    pub const json_field_names = .{
        .instance_group_not_found = "InstanceGroupNotFound",
        .invalid_instance_group_status = "InvalidInstanceGroupStatus",
        .incompatible_availability_zones = "IncompatibleAvailabilityZones",
        .incompatible_instance_types = "IncompatibleInstanceTypes",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .instance_group_not_found => "InstanceGroupNotFound",
            .invalid_instance_group_status => "InvalidInstanceGroupStatus",
            .incompatible_availability_zones => "IncompatibleAvailabilityZones",
            .incompatible_instance_types => "IncompatibleInstanceTypes",
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
