/// A name value pair that Image Builder applies to streamline results from the
/// vulnerability scan findings list action.
pub const ImageScanFindingsFilter = struct {
    /// The name of the image scan finding filter. Filter names are case-sensitive.
    /// Valid filter names are:
    ///
    /// * `imageBuildVersionArn` – Filters findings by the
    /// image build version that was scanned.
    ///
    /// * `imagePipelineArn` – Filters findings by the
    /// pipeline that created the scanned image.
    ///
    /// * `vulnerabilityId` – Filters findings by
    /// vulnerability ID, for example a CVE ID.
    ///
    /// * `severity` – Filters findings by severity
    /// level.
    name: ?[]const u8 = null,

    /// The filter values. Filter values are case-sensitive.
    values: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .name = "name",
        .values = "values",
    };
};
