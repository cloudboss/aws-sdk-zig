const std = @import("std");

pub const UserProfileStatus = enum {
    deleting,
    failed,
    in_service,
    pending,
    updating,
    update_failed,
    delete_failed,

    pub const json_field_names = .{
        .deleting = "Deleting",
        .failed = "Failed",
        .in_service = "InService",
        .pending = "Pending",
        .updating = "Updating",
        .update_failed = "Update_Failed",
        .delete_failed = "Delete_Failed",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .deleting => "Deleting",
            .failed => "Failed",
            .in_service => "InService",
            .pending => "Pending",
            .updating => "Updating",
            .update_failed => "Update_Failed",
            .delete_failed => "Delete_Failed",
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
