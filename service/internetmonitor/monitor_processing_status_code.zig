pub const MonitorProcessingStatusCode = enum {
    ok,
    inactive,
    collecting_data,
    insufficient_data,
    fault_service,
    fault_access_cloudwatch,

    pub const json_field_names = .{
        .ok = "OK",
        .inactive = "INACTIVE",
        .collecting_data = "COLLECTING_DATA",
        .insufficient_data = "INSUFFICIENT_DATA",
        .fault_service = "FAULT_SERVICE",
        .fault_access_cloudwatch = "FAULT_ACCESS_CLOUDWATCH",
    };
};
