/// The connector metadata specific to Snowflake.
pub const SnowflakeMetadata = struct {
    /// Specifies the supported Amazon Web Services Regions when using Snowflake.
    supported_regions: ?[]const []const u8,

    pub const json_field_names = .{
        .supported_regions = "supportedRegions",
    };
};
