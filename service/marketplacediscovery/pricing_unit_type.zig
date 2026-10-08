const std = @import("std");

pub const PricingUnitType = enum {
    users,
    hosts,
    bandwidth,
    data,
    tiers,
    requests,
    units,

    pub const json_field_names = .{
        .users = "USERS",
        .hosts = "HOSTS",
        .bandwidth = "BANDWIDTH",
        .data = "DATA",
        .tiers = "TIERS",
        .requests = "REQUESTS",
        .units = "UNITS",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .users => "USERS",
            .hosts => "HOSTS",
            .bandwidth => "BANDWIDTH",
            .data => "DATA",
            .tiers => "TIERS",
            .requests => "REQUESTS",
            .units => "UNITS",
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
