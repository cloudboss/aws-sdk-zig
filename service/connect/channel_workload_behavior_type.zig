const std = @import("std");

pub const ChannelWorkloadBehaviorType = enum {
    route_current_channel_current_workloadtype_only,
    route_current_channel_any_workloadtype_only,
    route_any_channel_any_workload_type,

    pub const json_field_names = .{
        .route_current_channel_current_workloadtype_only = "ROUTE_CURRENT_CHANNEL_CURRENT_WORKLOADTYPE_ONLY",
        .route_current_channel_any_workloadtype_only = "ROUTE_CURRENT_CHANNEL_ANY_WORKLOADTYPE_ONLY",
        .route_any_channel_any_workload_type = "ROUTE_ANY_CHANNEL_ANY_WORKLOAD_TYPE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .route_current_channel_current_workloadtype_only => "ROUTE_CURRENT_CHANNEL_CURRENT_WORKLOADTYPE_ONLY",
            .route_current_channel_any_workloadtype_only => "ROUTE_CURRENT_CHANNEL_ANY_WORKLOADTYPE_ONLY",
            .route_any_channel_any_workload_type => "ROUTE_ANY_CHANNEL_ANY_WORKLOAD_TYPE",
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
