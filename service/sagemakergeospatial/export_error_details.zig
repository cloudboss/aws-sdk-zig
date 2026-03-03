const ExportErrorDetailsOutput = @import("export_error_details_output.zig").ExportErrorDetailsOutput;

/// The structure for returning the export error details in a
/// GetEarthObservationJob.
pub const ExportErrorDetails = struct {
    /// The structure for returning the export error details while exporting results
    /// of an Earth Observation job.
    export_results: ?ExportErrorDetailsOutput = null,

    /// The structure for returning the export error details
    /// while exporting the source images of an Earth Observation job.
    export_source_images: ?ExportErrorDetailsOutput = null,

    pub const json_field_names = .{
        .export_results = "ExportResults",
        .export_source_images = "ExportSourceImages",
    };
};
