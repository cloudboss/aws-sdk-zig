pub const GetPlaceAdditionalFeature = enum {
    time_zone,
    phonemes,
    access,
    contact,
    secondary_addresses,

    pub const json_field_names = .{
        .time_zone = "TIME_ZONE",
        .phonemes = "PHONEMES",
        .access = "ACCESS",
        .contact = "CONTACT",
        .secondary_addresses = "SECONDARY_ADDRESSES",
    };
};
