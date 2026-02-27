pub const RxNormAttributeType = enum {
    dosage,
    duration,
    form,
    frequency,
    rate,
    route_or_mode,
    strength,

    pub const json_field_names = .{
        .dosage = "DOSAGE",
        .duration = "DURATION",
        .form = "FORM",
        .frequency = "FREQUENCY",
        .rate = "RATE",
        .route_or_mode = "ROUTE_OR_MODE",
        .strength = "STRENGTH",
    };
};
