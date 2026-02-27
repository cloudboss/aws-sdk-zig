pub const ChannelMode = enum {
    unrestricted,
    restricted,

    pub const json_field_names = .{
        .unrestricted = "UNRESTRICTED",
        .restricted = "RESTRICTED",
    };
};
