/// Provides the configuration information to connect to websites that require
/// basic user
/// authentication.
pub const BasicAuthenticationConfiguration = struct {
    /// The Amazon Resource Name (ARN) of an Secrets Manager secret. You create a
    /// secret to store your credentials in [Secrets
    /// Manager](https://docs.aws.amazon.com/secretsmanager/latest/userguide/intro.html)
    ///
    /// You use a secret if basic authentication credentials are required to connect
    /// to a
    /// website. The secret stores your credentials of user name and password.
    credentials: []const u8,

    /// The name of the website host you want to connect to using authentication
    /// credentials.
    ///
    /// For example, the host name of https://a.example.com/page1.html is
    /// "a.example.com".
    host: []const u8,

    /// The port number of the website host you want to connect to using
    /// authentication
    /// credentials.
    ///
    /// For example, the port for https://a.example.com/page1.html is 443, the
    /// standard port
    /// for HTTPS.
    port: i32,

    pub const json_field_names = .{
        .credentials = "Credentials",
        .host = "Host",
        .port = "Port",
    };
};
