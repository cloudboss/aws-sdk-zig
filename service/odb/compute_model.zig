pub const ComputeModel = enum {
    ecpu,
    ocpu,

    pub const json_field_names = .{
        .ecpu = "ECPU",
        .ocpu = "OCPU",
    };
};
