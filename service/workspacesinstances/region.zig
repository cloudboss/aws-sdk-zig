/// Represents an AWS region supported by WorkSpaces Instances.
pub const Region = struct {
    /// Name of the AWS region.
    region_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .region_name = "RegionName",
    };
};
