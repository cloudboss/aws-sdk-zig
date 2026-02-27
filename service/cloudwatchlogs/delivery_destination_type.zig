pub const DeliveryDestinationType = enum {
    s3,
    cwl,
    fh,
    xray,

    pub const json_field_names = .{
        .s3 = "S3",
        .cwl = "CWL",
        .fh = "FH",
        .xray = "XRAY",
    };
};
