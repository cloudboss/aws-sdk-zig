const SftpAuthenticationMethods = @import("sftp_authentication_methods.zig").SftpAuthenticationMethods;

/// Returns information related to the type of user authentication that is in
/// use for a file transfer protocol-enabled server's users. A server can have
/// only one method of authentication.
pub const IdentityProviderDetails = struct {
    /// The identifier of the Directory Service directory that you want to use as
    /// your identity provider.
    directory_id: ?[]const u8 = null,

    /// The ARN for a Lambda function to use for the Identity provider.
    function: ?[]const u8 = null,

    /// This parameter is only applicable if your `IdentityProviderType` is
    /// `API_GATEWAY`. Provides the type of `InvocationRole` used to authenticate
    /// the user account.
    invocation_role: ?[]const u8 = null,

    /// For SFTP-enabled servers, and for custom identity providers *only*, you can
    /// specify whether to authenticate using a password, SSH key pair, or both.
    ///
    /// * `PASSWORD` - users must provide their password to connect.
    /// * `PUBLIC_KEY` - users must provide their private key to connect.
    /// * `PUBLIC_KEY_OR_PASSWORD` - users can authenticate with either their
    ///   password or their key. This is the default value.
    /// * `PUBLIC_KEY_AND_PASSWORD` - users must provide both their private key and
    ///   their password to connect. The server checks the key first, and then if
    ///   the key is valid, the system prompts for a password. If the private key
    ///   provided does not match the public key that is stored, authentication
    ///   fails.
    sftp_authentication_methods: ?SftpAuthenticationMethods = null,

    /// Provides the location of the service endpoint used to authenticate users.
    url: ?[]const u8 = null,

    pub const json_field_names = .{
        .directory_id = "DirectoryId",
        .function = "Function",
        .invocation_role = "InvocationRole",
        .sftp_authentication_methods = "SftpAuthenticationMethods",
        .url = "Url",
    };
};
