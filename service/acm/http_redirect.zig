/// Contains information for HTTP-based domain validation of certificates
/// requested through Amazon CloudFront and issued by ACM. This field exists
/// only when the certificate type is `AMAZON_ISSUED` and the validation method
/// is `HTTP`.
pub const HttpRedirect = struct {
    /// The URL including the domain to be validated. The certificate authority
    /// sends `GET` requests here during validation.
    redirect_from: ?[]const u8 = null,

    /// The URL hosting the validation token. `RedirectFrom` must return this
    /// content or redirect here.
    redirect_to: ?[]const u8 = null,

    pub const json_field_names = .{
        .redirect_from = "RedirectFrom",
        .redirect_to = "RedirectTo",
    };
};
