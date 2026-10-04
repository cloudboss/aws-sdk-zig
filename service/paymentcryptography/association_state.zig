const std = @import("std");

pub const AssociationState = enum {
    active,
    update_pending,
    delete_pending,

    pub const json_field_names = .{
        .active = "ACTIVE",
        .update_pending = "UPDATE_PENDING",
        .delete_pending = "DELETE_PENDING",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .active => "ACTIVE",
            .update_pending => "UPDATE_PENDING",
            .delete_pending => "DELETE_PENDING",
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
