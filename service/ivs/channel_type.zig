pub const ChannelType = enum {
    basic_channel_type,
    standard_channel_type,
    advanced_sd_channel_type,
    advanced_hd_channel_type,

    pub const json_field_names = .{
        .basic_channel_type = "BasicChannelType",
        .standard_channel_type = "StandardChannelType",
        .advanced_sd_channel_type = "AdvancedSDChannelType",
        .advanced_hd_channel_type = "AdvancedHDChannelType",
    };
};
