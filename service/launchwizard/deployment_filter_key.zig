const std = @import("std");

pub const DeploymentFilterKey = enum {
    workload_name,
    deployment_status,

    pub const json_field_names = .{
        .workload_name = "WORKLOAD_NAME",
        .deployment_status = "DEPLOYMENT_STATUS",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .workload_name => "WORKLOAD_NAME",
            .deployment_status => "DEPLOYMENT_STATUS",
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
