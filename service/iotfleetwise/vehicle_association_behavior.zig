pub const VehicleAssociationBehavior = enum {
    create_iot_thing,
    validate_iot_thing_exists,

    pub const json_field_names = .{
        .create_iot_thing = "CREATE_IOT_THING",
        .validate_iot_thing_exists = "VALIDATE_IOT_THING_EXISTS",
    };
};
