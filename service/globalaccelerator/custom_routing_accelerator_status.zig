pub const CustomRoutingAcceleratorStatus = enum {
    deployed,
    in_progress,

    pub const json_field_names = .{
        .deployed = "DEPLOYED",
        .in_progress = "IN_PROGRESS",
    };
};
