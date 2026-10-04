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
        const fields = @typeInfo(@TypeOf(json_field_names)).@"struct".field_names;
        inline for (fields) |field_name| {
            if (std.mem.eql(u8, str, @field(json_field_names, field_name))) {
                return @field(@This(), field_name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
