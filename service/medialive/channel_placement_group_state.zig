const std = @import("std");

/// Used in DescribeChannelPlacementGroupResult
pub const ChannelPlacementGroupState = enum {
    unassigned,
    assigning,
    assigned,
    deleting,
    delete_failed,
    deleted,
    unassigning,

    pub const json_field_names = .{
        .unassigned = "UNASSIGNED",
        .assigning = "ASSIGNING",
        .assigned = "ASSIGNED",
        .deleting = "DELETING",
        .delete_failed = "DELETE_FAILED",
        .deleted = "DELETED",
        .unassigning = "UNASSIGNING",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .unassigned => "UNASSIGNED",
            .assigning => "ASSIGNING",
            .assigned => "ASSIGNED",
            .deleting => "DELETING",
            .delete_failed => "DELETE_FAILED",
            .deleted => "DELETED",
            .unassigning => "UNASSIGNING",
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
