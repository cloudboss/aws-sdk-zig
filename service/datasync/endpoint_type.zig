pub const EndpointType = enum {
    public,
    private_link,
    fips,
    fips_private_link,

    pub const json_field_names = .{
        .public = "PUBLIC",
        .private_link = "PRIVATE_LINK",
        .fips = "FIPS",
        .fips_private_link = "FIPS_PRIVATE_LINK",
    };
};
