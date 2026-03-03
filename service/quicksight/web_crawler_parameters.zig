const WebCrawlerAuthType = @import("web_crawler_auth_type.zig").WebCrawlerAuthType;

/// The parameters for a web crawler data source.
pub const WebCrawlerParameters = struct {
    /// The URL of the login page for the web crawler to authenticate.
    login_page_url: ?[]const u8 = null,

    /// The XPath expression for locating the password submit button on the login
    /// page.
    password_button_xpath: ?[]const u8 = null,

    /// The XPath expression for locating the password field on the login page.
    password_field_xpath: ?[]const u8 = null,

    /// The XPath expression for locating the username submit button on the login
    /// page.
    username_button_xpath: ?[]const u8 = null,

    /// The XPath expression for locating the username field on the login page.
    username_field_xpath: ?[]const u8 = null,

    /// The authentication type for the web crawler. The type can be one of the
    /// following:
    ///
    /// * `NO_AUTH`: No authentication required.
    ///
    /// * `BASIC_AUTH`: Basic authentication using username and password.
    ///
    /// * `SAML`: SAML-based authentication.
    ///
    /// * `FORM`: Form-based authentication.
    web_crawler_auth_type: WebCrawlerAuthType,

    /// The hostname of the web proxy server for the web crawler.
    web_proxy_host_name: ?[]const u8 = null,

    /// The port number of the web proxy server for the web crawler.
    web_proxy_port_number: i32 = 0,

    pub const json_field_names = .{
        .login_page_url = "LoginPageUrl",
        .password_button_xpath = "PasswordButtonXpath",
        .password_field_xpath = "PasswordFieldXpath",
        .username_button_xpath = "UsernameButtonXpath",
        .username_field_xpath = "UsernameFieldXpath",
        .web_crawler_auth_type = "WebCrawlerAuthType",
        .web_proxy_host_name = "WebProxyHostName",
        .web_proxy_port_number = "WebProxyPortNumber",
    };
};
