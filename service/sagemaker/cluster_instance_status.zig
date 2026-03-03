const std = @import("std");

pub const ClusterInstanceStatus = enum {
    running,
    failure,
    pending,
    shutting_down,
    system_updating,
    deep_health_check_in_progress,
    not_found,

    pub const json_field_names = .{
        .running = "Running",
        .failure = "Failure",
        .pending = "Pending",
        .shutting_down = "ShuttingDown",
        .system_updating = "SystemUpdating",
        .deep_health_check_in_progress = "DeepHealthCheckInProgress",
        .not_found = "NotFound",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .running => "Running",
            .failure => "Failure",
            .pending => "Pending",
            .shutting_down => "ShuttingDown",
            .system_updating => "SystemUpdating",
            .deep_health_check_in_progress => "DeepHealthCheckInProgress",
            .not_found => "NotFound",
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
