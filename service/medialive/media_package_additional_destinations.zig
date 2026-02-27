const OutputLocationRef = @import("output_location_ref.zig").OutputLocationRef;

/// Additional output destinations for a CMAF Ingest output group
pub const MediaPackageAdditionalDestinations = struct {
    /// The destination location
    destination: OutputLocationRef,

    pub const json_field_names = .{
        .destination = "Destination",
    };
};
