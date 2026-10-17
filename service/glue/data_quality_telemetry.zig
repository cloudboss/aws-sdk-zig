const aws = @import("aws");

const DataQualityEngine = @import("data_quality_engine.zig").DataQualityEngine;

pub const DataQualityTelemetry = struct {
    engine: ?DataQualityEngine = null,

    flags_enabled: ?[]const aws.map.StringMapEntry = null,

    host_runtime_version: ?[]const u8 = null,

    library_version: ?[]const u8 = null,

    spark_version: ?[]const u8 = null,

    vcpu_hours: ?f64 = null,

    pub const json_field_names = .{
        .engine = "Engine",
        .flags_enabled = "FlagsEnabled",
        .host_runtime_version = "HostRuntimeVersion",
        .library_version = "LibraryVersion",
        .spark_version = "SparkVersion",
        .vcpu_hours = "VcpuHours",
    };
};
