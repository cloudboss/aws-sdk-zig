/// An object that represents the methods by which a subject alternative name on
/// a peer
/// Transport Layer Security (TLS) certificate can be matched.
pub const SubjectAlternativeNameMatchers = struct {
    /// The values sent must match the specified values exactly.
    exact: []const []const u8,

    pub const json_field_names = .{
        .exact = "exact",
    };
};
