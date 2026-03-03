const std = @import("std");

pub const InstanceMetricName = enum {
    cpu_utilization,
    network_in,
    network_out,
    status_check_failed,
    status_check_failed_instance,
    status_check_failed_system,
    burst_capacity_time,
    burst_capacity_percentage,
    metadata_no_token,

    pub const json_field_names = .{
        .cpu_utilization = "CPUUtilization",
        .network_in = "NetworkIn",
        .network_out = "NetworkOut",
        .status_check_failed = "StatusCheckFailed",
        .status_check_failed_instance = "StatusCheckFailed_Instance",
        .status_check_failed_system = "StatusCheckFailed_System",
        .burst_capacity_time = "BurstCapacityTime",
        .burst_capacity_percentage = "BurstCapacityPercentage",
        .metadata_no_token = "MetadataNoToken",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .cpu_utilization => "CPUUtilization",
            .network_in => "NetworkIn",
            .network_out => "NetworkOut",
            .status_check_failed => "StatusCheckFailed",
            .status_check_failed_instance => "StatusCheckFailed_Instance",
            .status_check_failed_system => "StatusCheckFailed_System",
            .burst_capacity_time => "BurstCapacityTime",
            .burst_capacity_percentage => "BurstCapacityPercentage",
            .metadata_no_token => "MetadataNoToken",
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
