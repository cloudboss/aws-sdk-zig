pub const AvailabilityProviderType = enum {
    ews,
    lambda,

    pub const json_field_names = .{
        .ews = "EWS",
        .lambda = "LAMBDA",
    };
};
