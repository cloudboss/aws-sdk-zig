pub const EngineType = enum {
    influxdb_v2,
    influxdb_v3_core,
    influxdb_v3_enterprise,

    pub const json_field_names = .{
        .influxdb_v2 = "INFLUXDB_V2",
        .influxdb_v3_core = "INFLUXDB_V3_CORE",
        .influxdb_v3_enterprise = "INFLUXDB_V3_ENTERPRISE",
    };
};
