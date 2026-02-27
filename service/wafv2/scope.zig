pub const Scope = enum {
    cloudfront,
    regional,

    pub const json_field_names = .{
        .cloudfront = "CLOUDFRONT",
        .regional = "REGIONAL",
    };
};
