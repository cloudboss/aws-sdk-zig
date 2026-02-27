const JobManifestFieldName = @import("job_manifest_field_name.zig").JobManifestFieldName;
const JobManifestFormat = @import("job_manifest_format.zig").JobManifestFormat;

/// Describes the format of a manifest. If the manifest is in CSV format, also
/// describes the
/// columns contained within the manifest.
pub const JobManifestSpec = struct {
    /// If the specified manifest object is in the `S3BatchOperations_CSV_20180820`
    /// format, this element describes which columns contain the required data.
    fields: ?[]const JobManifestFieldName,

    /// Indicates which of the available formats the specified manifest uses.
    format: JobManifestFormat,
};
