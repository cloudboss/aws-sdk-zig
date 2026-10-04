const std = @import("std");

pub const InstancesHealthAttribute = enum {
    health_status,
    color,
    causes,
    application_metrics,
    refreshed_at,
    launched_at,
    system,
    deployment,
    availability_zone,
    instance_type,
    all,

    pub const json_field_names = .{
        .health_status = "HealthStatus",
        .color = "Color",
        .causes = "Causes",
        .application_metrics = "ApplicationMetrics",
        .refreshed_at = "RefreshedAt",
        .launched_at = "LaunchedAt",
        .system = "System",
        .deployment = "Deployment",
        .availability_zone = "AvailabilityZone",
        .instance_type = "InstanceType",
        .all = "All",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .health_status => "HealthStatus",
            .color => "Color",
            .causes => "Causes",
            .application_metrics => "ApplicationMetrics",
            .refreshed_at => "RefreshedAt",
            .launched_at => "LaunchedAt",
            .system => "System",
            .deployment => "Deployment",
            .availability_zone => "AvailabilityZone",
            .instance_type => "InstanceType",
            .all => "All",
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
