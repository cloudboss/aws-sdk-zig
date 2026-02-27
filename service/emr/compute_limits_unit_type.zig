pub const ComputeLimitsUnitType = enum {
    instance_fleet_units,
    instances,
    vcpu,

    pub const json_field_names = .{
        .instance_fleet_units = "InstanceFleetUnits",
        .instances = "Instances",
        .vcpu = "VCPU",
    };
};
