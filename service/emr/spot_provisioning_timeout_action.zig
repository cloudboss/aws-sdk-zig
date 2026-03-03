const std = @import("std");

pub const SpotProvisioningTimeoutAction = enum {
    switch_to_on_demand,
    terminate_cluster,

    pub const json_field_names = .{
        .switch_to_on_demand = "SWITCH_TO_ON_DEMAND",
        .terminate_cluster = "TERMINATE_CLUSTER",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .switch_to_on_demand => "SWITCH_TO_ON_DEMAND",
            .terminate_cluster => "TERMINATE_CLUSTER",
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
