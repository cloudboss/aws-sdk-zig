pub const ThirdPartyFirewallAssociationStatus = enum {
    onboarding,
    onboard_complete,
    offboarding,
    offboard_complete,
    not_exist,

    pub const json_field_names = .{
        .onboarding = "ONBOARDING",
        .onboard_complete = "ONBOARD_COMPLETE",
        .offboarding = "OFFBOARDING",
        .offboard_complete = "OFFBOARD_COMPLETE",
        .not_exist = "NOT_EXIST",
    };
};
