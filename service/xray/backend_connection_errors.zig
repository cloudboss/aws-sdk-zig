pub const BackendConnectionErrors = struct {
    connection_refused_count: ?i32 = null,

    http_code_4_xx_count: ?i32 = null,

    http_code_5_xx_count: ?i32 = null,

    other_count: ?i32 = null,

    timeout_count: ?i32 = null,

    unknown_host_count: ?i32 = null,

    pub const json_field_names = .{
        .connection_refused_count = "ConnectionRefusedCount",
        .http_code_4_xx_count = "HTTPCode4XXCount",
        .http_code_5_xx_count = "HTTPCode5XXCount",
        .other_count = "OtherCount",
        .timeout_count = "TimeoutCount",
        .unknown_host_count = "UnknownHostCount",
    };
};
