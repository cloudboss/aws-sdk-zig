/// FHIR server configuration for input data source
pub const FHIRServer = struct {
    /// FHIR server endpoint URL for accessing patient data.
    fhir_endpoint: []const u8,

    /// OAuth token for authenticating with the FHIR server.
    oauth_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .fhir_endpoint = "fhirEndpoint",
        .oauth_token = "oauthToken",
    };
};
