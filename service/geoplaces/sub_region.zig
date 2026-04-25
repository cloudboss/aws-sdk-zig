/// The sub-region.
pub const SubRegion = struct {
    /// Abbreviated code for the county or sub-region. Not available in
    /// `ap-southeast-1` and `ap-southeast-5` regions for
    /// [GrabMaps](https://docs.aws.amazon.com/location/latest/developerguide/GrabMaps.html) customers.
    code: ?[]const u8 = null,

    /// Name for the county or sub-region.
    name: ?[]const u8 = null,

    pub const json_field_names = .{
        .code = "Code",
        .name = "Name",
    };
};
