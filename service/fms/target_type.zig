const std = @import("std");

pub const TargetType = enum {
    gateway,
    carrier_gateway,
    instance,
    local_gateway,
    nat_gateway,
    network_interface,
    vpc_endpoint,
    vpc_peering_connection,
    egress_only_internet_gateway,
    transit_gateway,

    pub const json_field_names = .{
        .gateway = "GATEWAY",
        .carrier_gateway = "CARRIER_GATEWAY",
        .instance = "INSTANCE",
        .local_gateway = "LOCAL_GATEWAY",
        .nat_gateway = "NAT_GATEWAY",
        .network_interface = "NETWORK_INTERFACE",
        .vpc_endpoint = "VPC_ENDPOINT",
        .vpc_peering_connection = "VPC_PEERING_CONNECTION",
        .egress_only_internet_gateway = "EGRESS_ONLY_INTERNET_GATEWAY",
        .transit_gateway = "TRANSIT_GATEWAY",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .gateway => "GATEWAY",
            .carrier_gateway => "CARRIER_GATEWAY",
            .instance => "INSTANCE",
            .local_gateway => "LOCAL_GATEWAY",
            .nat_gateway => "NAT_GATEWAY",
            .network_interface => "NETWORK_INTERFACE",
            .vpc_endpoint => "VPC_ENDPOINT",
            .vpc_peering_connection => "VPC_PEERING_CONNECTION",
            .egress_only_internet_gateway => "EGRESS_ONLY_INTERNET_GATEWAY",
            .transit_gateway => "TRANSIT_GATEWAY",
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
