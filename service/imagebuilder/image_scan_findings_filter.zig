/// A name value pair that Image Builder applies to streamline results from the
/// vulnerability scan findings list action.
pub const ImageScanFindingsFilter = struct {
    /// The name of the image scan finding filter. Filter names are case-sensitive.
    name: ?[]const u8 = null,

    /// The filter values. Filter values are case-sensitive.
    values: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .name = "name",
        .values = "values",
    };
};
