const CredentialsProvider = @import("credentials_provider.zig").CredentialsProvider;

/// Server settings that are specific to a Remote Desktop Services (RDS) license
/// server.
pub const RdsSalSettings = struct {
    /// The `CredentialsProvider` resource contains a reference to the credentials
    /// provider that's used for RDS license server user administration.
    rds_sal_credentials_provider: CredentialsProvider,

    pub const json_field_names = .{
        .rds_sal_credentials_provider = "RdsSalCredentialsProvider",
    };
};
