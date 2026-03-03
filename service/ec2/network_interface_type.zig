const std = @import("std");

pub const NetworkInterfaceType = enum {
    interface,
    nat_gateway,
    efa,
    efa_only,
    trunk,
    load_balancer,
    network_load_balancer,
    vpc_endpoint,
    branch,
    transit_gateway,
    lambda,
    quicksight,
    global_accelerator_managed,
    api_gateway_managed,
    gateway_load_balancer,
    gateway_load_balancer_endpoint,
    iot_rules_managed,
    aws_codestar_connections_managed,

    pub const json_field_names = .{
        .interface = "interface",
        .nat_gateway = "natGateway",
        .efa = "efa",
        .efa_only = "efa-only",
        .trunk = "trunk",
        .load_balancer = "load_balancer",
        .network_load_balancer = "network_load_balancer",
        .vpc_endpoint = "vpc_endpoint",
        .branch = "branch",
        .transit_gateway = "transit_gateway",
        .lambda = "lambda",
        .quicksight = "quicksight",
        .global_accelerator_managed = "global_accelerator_managed",
        .api_gateway_managed = "api_gateway_managed",
        .gateway_load_balancer = "gateway_load_balancer",
        .gateway_load_balancer_endpoint = "gateway_load_balancer_endpoint",
        .iot_rules_managed = "iot_rules_managed",
        .aws_codestar_connections_managed = "aws_codestar_connections_managed",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .interface => "interface",
            .nat_gateway => "natGateway",
            .efa => "efa",
            .efa_only => "efa-only",
            .trunk => "trunk",
            .load_balancer => "load_balancer",
            .network_load_balancer => "network_load_balancer",
            .vpc_endpoint => "vpc_endpoint",
            .branch => "branch",
            .transit_gateway => "transit_gateway",
            .lambda => "lambda",
            .quicksight => "quicksight",
            .global_accelerator_managed => "global_accelerator_managed",
            .api_gateway_managed => "api_gateway_managed",
            .gateway_load_balancer => "gateway_load_balancer",
            .gateway_load_balancer_endpoint => "gateway_load_balancer_endpoint",
            .iot_rules_managed => "iot_rules_managed",
            .aws_codestar_connections_managed => "aws_codestar_connections_managed",
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
