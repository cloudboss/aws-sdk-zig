pub const ExecutionResultCode = enum {
    parsing_failed,
    vpc_endpoint_setup_failed,

    pub const json_field_names = .{
        .parsing_failed = "PARSING_FAILED",
        .vpc_endpoint_setup_failed = "VPC_ENDPOINT_SETUP_FAILED",
    };
};
