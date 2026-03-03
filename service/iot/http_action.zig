const HttpAuthorization = @import("http_authorization.zig").HttpAuthorization;
const BatchConfig = @import("batch_config.zig").BatchConfig;
const HttpActionHeader = @import("http_action_header.zig").HttpActionHeader;

/// Send data to an HTTPS endpoint.
pub const HttpAction = struct {
    /// The authentication method to use when sending data to an HTTPS endpoint.
    auth: ?HttpAuthorization = null,

    /// The configuration settings for batching. For more information, see [
    /// Batching HTTP action
    /// messages](https://docs.aws.amazon.com/iot/latest/developerguide/http_batching.html).
    batch_config: ?BatchConfig = null,

    /// The URL to which IoT sends a confirmation message. The value of the
    /// confirmation URL
    /// must be a prefix of the endpoint URL. If you do not specify a confirmation
    /// URL IoT uses
    /// the endpoint URL as the confirmation URL. If you use substitution templates
    /// in the
    /// confirmationUrl, you must create and enable topic rule destinations that
    /// match each
    /// possible value of the substitution template before traffic is allowed to
    /// your endpoint
    /// URL.
    confirmation_url: ?[]const u8 = null,

    /// Whether to process the HTTP action messages into a single request. Value can
    /// be true or false.
    enable_batching: ?bool = null,

    /// The HTTP headers to send with the message data.
    headers: ?[]const HttpActionHeader = null,

    /// The endpoint URL. If substitution templates are used in the URL, you must
    /// also specify a
    /// `confirmationUrl`. If this is a new destination, a new
    /// `TopicRuleDestination` is created if possible.
    url: []const u8,

    pub const json_field_names = .{
        .auth = "auth",
        .batch_config = "batchConfig",
        .confirmation_url = "confirmationUrl",
        .enable_batching = "enableBatching",
        .headers = "headers",
        .url = "url",
    };
};
