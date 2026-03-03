const std = @import("std");

pub const AssociationFilterKey = enum {
    instance_id,
    name,
    association_id,
    status,
    last_executed_before,
    last_executed_after,
    association_name,
    resource_group_name,

    pub const json_field_names = .{
        .instance_id = "InstanceId",
        .name = "Name",
        .association_id = "AssociationId",
        .status = "AssociationStatusName",
        .last_executed_before = "LastExecutedBefore",
        .last_executed_after = "LastExecutedAfter",
        .association_name = "AssociationName",
        .resource_group_name = "ResourceGroupName",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .instance_id => "InstanceId",
            .name => "Name",
            .association_id => "AssociationId",
            .status => "AssociationStatusName",
            .last_executed_before => "LastExecutedBefore",
            .last_executed_after => "LastExecutedAfter",
            .association_name => "AssociationName",
            .resource_group_name => "ResourceGroupName",
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
