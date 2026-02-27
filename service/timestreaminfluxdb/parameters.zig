const InfluxDBv2Parameters = @import("influx_d_bv_2_parameters.zig").InfluxDBv2Parameters;
const InfluxDBv3CoreParameters = @import("influx_d_bv_3_core_parameters.zig").InfluxDBv3CoreParameters;
const InfluxDBv3EnterpriseParameters = @import("influx_d_bv_3_enterprise_parameters.zig").InfluxDBv3EnterpriseParameters;

/// The parameters that comprise the parameter group.
pub const Parameters = union(enum) {
    /// All the customer-modifiable InfluxDB v2 parameters in Timestream for
    /// InfluxDB.
    influx_d_bv_2: ?InfluxDBv2Parameters,
    /// All the customer-modifiable InfluxDB v3 Core parameters in Timestream for
    /// InfluxDB.
    influx_d_bv_3_core: ?InfluxDBv3CoreParameters,
    /// All the customer-modifiable InfluxDB v3 Enterprise parameters in Timestream
    /// for InfluxDB.
    influx_d_bv_3_enterprise: ?InfluxDBv3EnterpriseParameters,

    pub const json_field_names = .{
        .influx_d_bv_2 = "InfluxDBv2",
        .influx_d_bv_3_core = "InfluxDBv3Core",
        .influx_d_bv_3_enterprise = "InfluxDBv3Enterprise",
    };
};
