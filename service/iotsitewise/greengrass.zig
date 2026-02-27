/// Contains details for a gateway that runs on IoT Greengrass. To create a
/// gateway that runs on IoT Greengrass,
/// you must add the IoT SiteWise connector to a Greengrass group and deploy it.
/// Your Greengrass
/// group must also have permissions to upload data to IoT SiteWise. For more
/// information, see [Ingesting data using a
/// gateway](https://docs.aws.amazon.com/iot-sitewise/latest/userguide/gateway-connector.html) in the *IoT SiteWise User Guide*.
pub const Greengrass = struct {
    /// The
    /// [ARN](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html) of the Greengrass group. For more information about how to find a group's
    /// ARN, see
    /// [ListGroups](https://docs.aws.amazon.com/greengrass/v1/apireference/listgroups-get.html) and [GetGroup](https://docs.aws.amazon.com/greengrass/v1/apireference/getgroup-get.html) in the *IoT Greengrass V1
    /// API Reference*.
    group_arn: []const u8,

    pub const json_field_names = .{
        .group_arn = "groupArn",
    };
};
