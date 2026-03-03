/// Represents the resources that were scanned in the scan entry.
pub const ResourceDetails = struct {
    /// Instance ARN that was scanned in the scan entry.
    instance_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .instance_arn = "InstanceArn",
    };
};
