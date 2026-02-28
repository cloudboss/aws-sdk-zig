/// Details related activities associated with a potential security event. Lists
/// all distinct categories of evidence that are connected to the resource or
/// the finding group.
pub const RelatedFindingDetail = struct {
    /// The Amazon Resource Name (ARN) of the related finding.
    arn: ?[]const u8,

    /// The IP address of the finding.
    ip_address: ?[]const u8,

    /// The type of finding.
    @"type": ?[]const u8,

    pub const json_field_names = .{
        .arn = "Arn",
        .ip_address = "IpAddress",
        .@"type" = "Type",
    };
};
