/// Properties of the cloud environment where this Source Server originated
/// from.
pub const SourceCloudProperties = struct {
    /// AWS Account ID for an EC2-originated Source Server.
    origin_account_id: ?[]const u8 = null,

    /// AWS Availability Zone for an EC2-originated Source Server.
    origin_availability_zone: ?[]const u8 = null,

    /// AWS Region for an EC2-originated Source Server.
    origin_region: ?[]const u8 = null,

    /// The ARN of the source Outpost
    source_outpost_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .origin_account_id = "originAccountID",
        .origin_availability_zone = "originAvailabilityZone",
        .origin_region = "originRegion",
        .source_outpost_arn = "sourceOutpostArn",
    };
};
