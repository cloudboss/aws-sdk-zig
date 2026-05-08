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
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
