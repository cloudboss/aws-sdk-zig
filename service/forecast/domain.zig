const std = @import("std");

pub const Domain = enum {
    retail,
    custom,
    inventory_planning,
    ec2_capacity,
    work_force,
    web_traffic,
    metrics,

    pub const json_field_names = .{
        .retail = "RETAIL",
        .custom = "CUSTOM",
        .inventory_planning = "INVENTORY_PLANNING",
        .ec2_capacity = "EC2_CAPACITY",
        .work_force = "WORK_FORCE",
        .web_traffic = "WEB_TRAFFIC",
        .metrics = "METRICS",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .retail => "RETAIL",
            .custom => "CUSTOM",
            .inventory_planning => "INVENTORY_PLANNING",
            .ec2_capacity => "EC2_CAPACITY",
            .work_force => "WORK_FORCE",
            .web_traffic => "WEB_TRAFFIC",
            .metrics => "METRICS",
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
