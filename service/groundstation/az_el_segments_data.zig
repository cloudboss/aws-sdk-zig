const AzElSegments = @import("az_el_segments.zig").AzElSegments;
const S3Object = @import("s3_object.zig").S3Object;

/// Container for azimuth elevation segment data.
///
/// Specify either AzElSegmentsData$s3Object to reference data in Amazon S3, or
/// AzElSegmentsData$azElData to provide data inline.
pub const AzElSegmentsData = union(enum) {
    /// Azimuth elevation segment data provided directly in the request.
    ///
    /// Use this option for smaller datasets or when Amazon S3 access is not
    /// available.
    az_el_data: ?AzElSegments,
    /// The Amazon S3 object containing azimuth elevation segment data.
    ///
    /// The Amazon S3 object must contain JSON-formatted azimuth elevation data
    /// matching the AzElSegments structure.
    s_3_object: ?S3Object,

    pub const json_field_names = .{
        .az_el_data = "azElData",
        .s_3_object = "s3Object",
    };
};
