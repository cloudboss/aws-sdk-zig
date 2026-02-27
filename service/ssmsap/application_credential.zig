const CredentialType = @import("credential_type.zig").CredentialType;

/// The credentials of your SAP application.
pub const ApplicationCredential = struct {
    /// The type of the application credentials.
    credential_type: CredentialType,

    /// The name of the SAP HANA database.
    database_name: []const u8,

    /// The secret ID created in AWS Secrets Manager to store the credentials of the
    /// SAP application.
    secret_id: []const u8,

    pub const json_field_names = .{
        .credential_type = "CredentialType",
        .database_name = "DatabaseName",
        .secret_id = "SecretId",
    };
};
