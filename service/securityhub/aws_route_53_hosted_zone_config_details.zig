/// An object that contains an optional comment about your Amazon Route 53
/// hosted zone.
pub const AwsRoute53HostedZoneConfigDetails = struct {
    /// Any comments that you include about the hosted zone.
    comment: ?[]const u8,

    pub const json_field_names = .{
        .comment = "Comment",
    };
};
