pub const DetectionSource = enum {
    amazon,
    bitdefender,

    pub const json_field_names = .{
        .amazon = "AMAZON",
        .bitdefender = "BITDEFENDER",
    };
};
