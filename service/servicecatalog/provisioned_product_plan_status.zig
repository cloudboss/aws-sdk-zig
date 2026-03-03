const std = @import("std");

pub const ProvisionedProductPlanStatus = enum {
    create_in_progress,
    create_success,
    create_failed,
    execute_in_progress,
    execute_success,
    execute_failed,

    pub const json_field_names = .{
        .create_in_progress = "CREATE_IN_PROGRESS",
        .create_success = "CREATE_SUCCESS",
        .create_failed = "CREATE_FAILED",
        .execute_in_progress = "EXECUTE_IN_PROGRESS",
        .execute_success = "EXECUTE_SUCCESS",
        .execute_failed = "EXECUTE_FAILED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .create_in_progress => "CREATE_IN_PROGRESS",
            .create_success => "CREATE_SUCCESS",
            .create_failed => "CREATE_FAILED",
            .execute_in_progress => "EXECUTE_IN_PROGRESS",
            .execute_success => "EXECUTE_SUCCESS",
            .execute_failed => "EXECUTE_FAILED",
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
