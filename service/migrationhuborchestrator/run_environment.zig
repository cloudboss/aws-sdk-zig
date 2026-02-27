pub const RunEnvironment = enum {
    aws,
    onpremise,

    pub const json_field_names = .{
        .aws = "AWS",
        .onpremise = "ONPREMISE",
    };
};
