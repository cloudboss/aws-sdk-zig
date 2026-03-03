const std = @import("std");

pub const AssociationExecutionTargetsFilterKey = enum {
    status,
    resource_id,
    resource_type,

    pub const json_field_names = .{
        .status = "Status",
        .resource_id = "ResourceId",
        .resource_type = "ResourceType",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .status => "Status",
            .resource_id => "ResourceId",
            .resource_type => "ResourceType",
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
