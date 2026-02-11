pub const WitnessStatus = enum {
    creating,
    deleting,
    active,

    pub const json_field_names = .{
        .creating = "CREATING",
        .deleting = "DELETING",
        .active = "ACTIVE",
    };
};
