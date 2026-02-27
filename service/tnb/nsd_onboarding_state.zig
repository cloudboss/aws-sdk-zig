pub const NsdOnboardingState = enum {
    created,
    onboarded,
    @"error",

    pub const json_field_names = .{
        .created = "CREATED",
        .onboarded = "ONBOARDED",
        .@"error" = "ERROR",
    };
};
