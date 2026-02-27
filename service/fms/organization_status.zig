pub const OrganizationStatus = enum {
    onboarding,
    onboarding_complete,
    offboarding,
    offboarding_complete,

    pub const json_field_names = .{
        .onboarding = "Onboarding",
        .onboarding_complete = "OnboardingComplete",
        .offboarding = "Offboarding",
        .offboarding_complete = "OffboardingComplete",
    };
};
