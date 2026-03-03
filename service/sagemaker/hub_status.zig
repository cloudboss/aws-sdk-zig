const std = @import("std");

pub const HubStatus = enum {
    in_service,
    creating,
    updating,
    deleting,
    create_failed,
    update_failed,
    delete_failed,

    pub const json_field_names = .{
        .in_service = "InService",
        .creating = "Creating",
        .updating = "Updating",
        .deleting = "Deleting",
        .create_failed = "CreateFailed",
        .update_failed = "UpdateFailed",
        .delete_failed = "DeleteFailed",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .in_service => "InService",
            .creating => "Creating",
            .updating => "Updating",
            .deleting => "Deleting",
            .create_failed => "CreateFailed",
            .update_failed => "UpdateFailed",
            .delete_failed => "DeleteFailed",
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
