pub const UntagResourceRequest = struct {
    /// The Amazon Resource Name (ARN) of the resource or resources from which to
    /// delete tags. You can associate
    /// tags with the following Device Farm resources: `PROJECT`,
    /// `TESTGRID_PROJECT`, `RUN`,
    /// `NETWORK_PROFILE`, `INSTANCE_PROFILE`, `DEVICE_INSTANCE`,
    /// `SESSION`, `DEVICE_POOL`, `DEVICE`, and
    /// `VPCE_CONFIGURATION`.
    resource_arn: []const u8,

    /// The keys of the tags to be removed.
    tag_keys: []const []const u8,

    pub const json_field_names = .{
        .resource_arn = "ResourceARN",
        .tag_keys = "TagKeys",
    };
};
