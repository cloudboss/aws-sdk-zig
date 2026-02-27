pub const AccountLimitName = enum {
    phone_numbers,
    pools,
    configuration_sets,
    opt_out_lists,
    sender_ids,
    registrations,
    registration_attachments,
    verified_destination_numbers,

    pub const json_field_names = .{
        .phone_numbers = "PHONE_NUMBERS",
        .pools = "POOLS",
        .configuration_sets = "CONFIGURATION_SETS",
        .opt_out_lists = "OPT_OUT_LISTS",
        .sender_ids = "SENDER_IDS",
        .registrations = "REGISTRATIONS",
        .registration_attachments = "REGISTRATION_ATTACHMENTS",
        .verified_destination_numbers = "VERIFIED_DESTINATION_NUMBERS",
    };
};
