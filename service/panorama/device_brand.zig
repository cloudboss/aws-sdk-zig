pub const DeviceBrand = enum {
    aws_panorama,
    lenovo,

    pub const json_field_names = .{
        .aws_panorama = "AWS_PANORAMA",
        .lenovo = "LENOVO",
    };
};
