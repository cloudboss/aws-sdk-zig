pub const CommandNamespace = enum {
    aws_io_t,
    aws_io_t_fleet_wise,

    pub const json_field_names = .{
        .aws_io_t = "AWSIoT",
        .aws_io_t_fleet_wise = "AWSIoTFleetWise",
    };
};
