const std = @import("std");

pub const InitiatedBy = enum {
    start_recovery,
    start_drill,
    failback,
    diagnostic,
    terminate_recovery_instances,
    target_account,
    create_network_recovery,
    update_network_recovery,
    associate_network_recovery,

    pub const json_field_names = .{
        .start_recovery = "START_RECOVERY",
        .start_drill = "START_DRILL",
        .failback = "FAILBACK",
        .diagnostic = "DIAGNOSTIC",
        .terminate_recovery_instances = "TERMINATE_RECOVERY_INSTANCES",
        .target_account = "TARGET_ACCOUNT",
        .create_network_recovery = "CREATE_NETWORK_RECOVERY",
        .update_network_recovery = "UPDATE_NETWORK_RECOVERY",
        .associate_network_recovery = "ASSOCIATE_NETWORK_RECOVERY",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .start_recovery => "START_RECOVERY",
            .start_drill => "START_DRILL",
            .failback => "FAILBACK",
            .diagnostic => "DIAGNOSTIC",
            .terminate_recovery_instances => "TERMINATE_RECOVERY_INSTANCES",
            .target_account => "TARGET_ACCOUNT",
            .create_network_recovery => "CREATE_NETWORK_RECOVERY",
            .update_network_recovery => "UPDATE_NETWORK_RECOVERY",
            .associate_network_recovery => "ASSOCIATE_NETWORK_RECOVERY",
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
