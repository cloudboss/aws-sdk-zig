const PipeEnrichmentHttpParameters = @import("pipe_enrichment_http_parameters.zig").PipeEnrichmentHttpParameters;

/// The parameters required to set up enrichment on your pipe.
pub const PipeEnrichmentParameters = struct {
    /// Contains the HTTP parameters to use when the target is a API Gateway REST
    /// endpoint or EventBridge ApiDestination.
    ///
    /// If you specify an API Gateway REST API or EventBridge ApiDestination as a
    /// target, you can use this parameter to specify headers, path parameters, and
    /// query string
    /// keys/values as part of your target invoking request. If you're using
    /// ApiDestinations, the
    /// corresponding Connection can also have these values configured. In case of
    /// any conflicting
    /// keys, values from the Connection take precedence.
    http_parameters: ?PipeEnrichmentHttpParameters = null,

    /// Valid JSON text passed to the enrichment. In this case, nothing from the
    /// event itself is
    /// passed to the enrichment. For more information, see [The JavaScript Object
    /// Notation (JSON)
    /// Data Interchange Format](http://www.rfc-editor.org/rfc/rfc7159.txt).
    ///
    /// To remove an input template, specify an empty string.
    input_template: ?[]const u8 = null,

    pub const json_field_names = .{
        .http_parameters = "HttpParameters",
        .input_template = "InputTemplate",
    };
};
