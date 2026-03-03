/// Specifies a location in Amazon Web Services.
pub const AWSLocation = struct {
    /// The Amazon Resource Name (ARN) of the subnet that the device is located in.
    subnet_arn: ?[]const u8 = null,

    /// The Zone that the device is located in. Specify the ID of an Availability
    /// Zone, Local
    /// Zone, Wavelength Zone, or an Outpost.
    zone: ?[]const u8 = null,

    pub const json_field_names = .{
        .subnet_arn = "SubnetArn",
        .zone = "Zone",
    };
};
