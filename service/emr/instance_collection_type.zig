pub const InstanceCollectionType = enum {
    instance_fleet,
    instance_group,

    pub const json_field_names = .{
        .instance_fleet = "INSTANCE_FLEET",
        .instance_group = "INSTANCE_GROUP",
    };
};
