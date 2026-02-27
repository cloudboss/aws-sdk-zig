const SigV4Authorization = @import("sig_v4_authorization.zig").SigV4Authorization;

/// The authorization method used to send messages.
pub const HttpAuthorization = struct {
    /// Use Sig V4 authorization. For more information, see [Signature
    /// Version 4 Signing
    /// Process](https://docs.aws.amazon.com/general/latest/gr/signature-version-4.html).
    sigv_4: ?SigV4Authorization,

    pub const json_field_names = .{
        .sigv_4 = "sigv4",
    };
};
