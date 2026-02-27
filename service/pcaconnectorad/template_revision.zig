/// The revision version of the template. Template updates will increment the
/// minor
/// revision. Re-enrolling all certificate holders will increment the major
/// revision.
pub const TemplateRevision = struct {
    /// The revision version of the template. Re-enrolling all certificate holders
    /// will
    /// increment the major revision.
    major_revision: i32,

    /// The revision version of the template. Re-enrolling all certificate holders
    /// will
    /// increment the major revision.
    minor_revision: i32,

    pub const json_field_names = .{
        .major_revision = "MajorRevision",
        .minor_revision = "MinorRevision",
    };
};
