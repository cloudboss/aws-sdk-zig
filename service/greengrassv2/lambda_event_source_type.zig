pub const LambdaEventSourceType = enum {
    pub_sub,
    iot_core,

    pub const json_field_names = .{
        .pub_sub = "PUB_SUB",
        .iot_core = "IOT_CORE",
    };
};
