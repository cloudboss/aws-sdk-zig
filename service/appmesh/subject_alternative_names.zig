const SubjectAlternativeNameMatchers = @import("subject_alternative_name_matchers.zig").SubjectAlternativeNameMatchers;

/// An object that represents the subject alternative names secured by the
/// certificate.
pub const SubjectAlternativeNames = struct {
    /// An object that represents the criteria for determining a SANs match.
    match: SubjectAlternativeNameMatchers,

    pub const json_field_names = .{
        .match = "match",
    };
};
