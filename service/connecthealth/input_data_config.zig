const FHIRServer = @import("fhir_server.zig").FHIRServer;
const S3Source = @import("s3_source.zig").S3Source;

/// Configuration details for input patient data
pub const InputDataConfig = struct {
    /// FHIR server configuration to retrieve patient data.
    fhir_server: ?FHIRServer = null,

    /// List of S3 sources containing patient data.
    s_3_sources: ?[]const S3Source = null,

    pub const json_field_names = .{
        .fhir_server = "fhirServer",
        .s_3_sources = "s3Sources",
    };
};
