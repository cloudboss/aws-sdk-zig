/// Describes a cross-origin resource sharing (CORS) rule for a Lightsail
/// bucket. CORS rules specify which origins are allowed to access the bucket,
/// which HTTP methods are allowed, and other access control information. For
/// more information, see [Configuring cross-origin resource sharing
/// (CORS)](https://docs.aws.amazon.com/lightsail/latest/userguide/configure-cors.html).
pub const BucketCorsRule = struct {
    /// Headers that are specified in the `Access-Control-Request-Headers` header.
    /// These headers are allowed in a preflight `OPTIONS` request. In response to
    /// any preflight `OPTIONS` request, Amazon S3 returns any requested headers
    /// that are allowed.
    allowed_headers: ?[]const []const u8,

    /// The HTTP methods that are allowed when accessing the bucket from the
    /// specified origin. Each CORS rule must identify at least one origin and one
    /// method.
    ///
    /// You can use the following HTTP methods:
    ///
    /// * `GET` - Retrieves data from the server, such as downloading files or
    ///   viewing content.
    ///
    /// * `PUT` - Uploads or replaces data on the server, such as uploading new
    ///   files.
    ///
    /// * `POST` - Sends data to the server for processing, such as submitting forms
    ///   or creating new resources.
    ///
    /// * `DELETE` - Removes data from the server, such as deleting files or
    ///   resources.
    ///
    /// * `HEAD` - Retrieves only the headers from the server without the actual
    ///   content, useful for checking if a resource exists.
    allowed_methods: []const []const u8,

    /// One or more origins you want customers to be able to access the bucket from.
    /// Each CORS rule must identify at least one origin and one method.
    allowed_origins: []const []const u8,

    /// One or more headers in the response that you want customers to be able to
    /// access from their applications (for example, from a JavaScript
    /// `XMLHttpRequest` object).
    expose_headers: ?[]const []const u8,

    /// A unique identifier for the CORS rule. The ID value can be up to 255
    /// characters long. The IDs help you find a rule in the configuration.
    id: ?[]const u8,

    /// The time in seconds that your browser is to cache the preflight response for
    /// the specified resource. A CORS rule can have only one `maxAgeSeconds`
    /// element.
    max_age_seconds: ?i32,

    pub const json_field_names = .{
        .allowed_headers = "allowedHeaders",
        .allowed_methods = "allowedMethods",
        .allowed_origins = "allowedOrigins",
        .expose_headers = "exposeHeaders",
        .id = "id",
        .max_age_seconds = "maxAgeSeconds",
    };
};
