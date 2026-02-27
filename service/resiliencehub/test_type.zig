pub const TestType = enum {
    software,
    hardware,
    az,
    region,

    pub const json_field_names = .{
        .software = "SOFTWARE",
        .hardware = "HARDWARE",
        .az = "AZ",
        .region = "REGION",
    };
};
