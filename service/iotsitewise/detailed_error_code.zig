pub const DetailedErrorCode = enum {
    incompatible_compute_location,
    incompatible_forwarding_configuration,

    pub const json_field_names = .{
        .incompatible_compute_location = "INCOMPATIBLE_COMPUTE_LOCATION",
        .incompatible_forwarding_configuration = "INCOMPATIBLE_FORWARDING_CONFIGURATION",
    };
};
