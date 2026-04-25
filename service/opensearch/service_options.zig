/// Options for the service, such as the supported Regions.
pub const ServiceOptions = struct {
    /// The list of supported Regions for the service.
    supported_regions: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .supported_regions = "SupportedRegions",
    };
};
