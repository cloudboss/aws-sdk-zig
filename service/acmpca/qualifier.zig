/// Defines a `PolicyInformation` qualifier. Amazon Web Services Private CA
/// supports the [certification practice statement (CPS)
/// qualifier](https://datatracker.ietf.org/doc/html/rfc5280#section-4.2.1.4)
/// defined in RFC 5280.
pub const Qualifier = struct {
    /// Contains a pointer to a certification practice statement (CPS) published by
    /// the CA.
    cps_uri: []const u8,

    pub const json_field_names = .{
        .cps_uri = "CpsUri",
    };
};
