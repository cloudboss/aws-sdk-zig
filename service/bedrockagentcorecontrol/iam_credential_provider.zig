/// An IAM credential provider for gateway authentication. This structure
/// contains the configuration for authenticating with the target endpoint using
/// IAM credentials and SigV4 signing.
pub const IamCredentialProvider = struct {
    /// The Amazon Web Services Region used for SigV4 signing. If not specified,
    /// defaults to the gateway's Region.
    region: ?[]const u8 = null,

    /// The target Amazon Web Services service name used for SigV4 signing. This
    /// value identifies the service that the gateway authenticates with when making
    /// requests to the target endpoint.
    service: []const u8,

    pub const json_field_names = .{
        .region = "region",
        .service = "service",
    };
};
