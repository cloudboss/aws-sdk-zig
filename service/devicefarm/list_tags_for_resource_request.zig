pub const ListTagsForResourceRequest = struct {
    /// The Amazon Resource Name (ARN) of the resource or resources for which to
    /// list tags. You can associate tags
    /// with the following Device Farm resources: `PROJECT`, `TESTGRID_PROJECT`,
    /// `RUN`,
    /// `NETWORK_PROFILE`, `INSTANCE_PROFILE`, `DEVICE_INSTANCE`,
    /// `SESSION`, `DEVICE_POOL`, `DEVICE`, and
    /// `VPCE_CONFIGURATION`.
    resource_arn: []const u8,

    pub const json_field_names = .{
        .resource_arn = "ResourceARN",
    };
};
