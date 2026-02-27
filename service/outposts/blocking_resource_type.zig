pub const BlockingResourceType = enum {
    ec2_instance,
    outpost_ram_share,
    lgw_routing_domain,
    lgw_route_table,
    lgw_virtual_interface_group,
    outpost_order_cancellable,
    outpost_order_intervention_required,

    pub const json_field_names = .{
        .ec2_instance = "EC2_INSTANCE",
        .outpost_ram_share = "OUTPOST_RAM_SHARE",
        .lgw_routing_domain = "LGW_ROUTING_DOMAIN",
        .lgw_route_table = "LGW_ROUTE_TABLE",
        .lgw_virtual_interface_group = "LGW_VIRTUAL_INTERFACE_GROUP",
        .outpost_order_cancellable = "OUTPOST_ORDER_CANCELLABLE",
        .outpost_order_intervention_required = "OUTPOST_ORDER_INTERVENTION_REQUIRED",
    };
};
