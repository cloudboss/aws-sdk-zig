/// Provides the configuration information for a web proxy to connect to website
/// hosts.
pub const ProxyConfiguration = struct {
    /// The Amazon Resource Name (ARN) of an Secrets Manager secret. You create a
    /// secret to store your credentials in [Secrets
    /// Manager](https://docs.aws.amazon.com/secretsmanager/latest/userguide/intro.html)
    ///
    /// The credentials are optional. You use a secret if web proxy credentials are
    /// required
    /// to connect to a website host. Amazon Kendra currently support basic
    /// authentication
    /// to connect to a web proxy server. The secret stores your credentials.
    credentials: ?[]const u8 = null,

    /// The name of the website host you want to connect to via a web proxy server.
    ///
    /// For example, the host name of https://a.example.com/page1.html is
    /// "a.example.com".
    host: []const u8,

    /// The port number of the website host you want to connect to via a web proxy
    /// server.
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
