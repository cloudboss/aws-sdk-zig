const std = @import("std");

pub const OperationType = enum {
    start_deployment,
    create_service,
    pause_service,
    resume_service,
    delete_service,
    update_service,

    pub const json_field_names = .{
        .start_deployment = "START_DEPLOYMENT",
        .create_service = "CREATE_SERVICE",
        .pause_service = "PAUSE_SERVICE",
        .resume_service = "RESUME_SERVICE",
        .delete_service = "DELETE_SERVICE",
        .update_service = "UPDATE_SERVICE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .start_deployment => "START_DEPLOYMENT",
            .create_service => "CREATE_SERVICE",
            .pause_service => "PAUSE_SERVICE",
            .resume_service => "RESUME_SERVICE",
            .delete_service => "DELETE_SERVICE",
            .update_service => "UPDATE_SERVICE",
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
