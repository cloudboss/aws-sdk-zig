/// The type of campaign communication limits config.
pub const CommunicationLimitsConfigType = enum {
    all_channel_subtypes,

    pub const json_field_names = .{
        .all_channel_subtypes = "ALL_CHANNEL_SUBTYPES",
    };
};
