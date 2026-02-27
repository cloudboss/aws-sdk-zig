pub const ServiceType = enum {
    data,
    credential_provider,
    jobs,

    pub const json_field_names = .{
        .data = "DATA",
        .credential_provider = "CREDENTIAL_PROVIDER",
        .jobs = "JOBS",
    };
};
