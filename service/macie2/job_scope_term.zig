const SimpleScopeTerm = @import("simple_scope_term.zig").SimpleScopeTerm;
const TagScopeTerm = @import("tag_scope_term.zig").TagScopeTerm;

/// Specifies a property- or tag-based condition that defines criteria for
/// including or excluding S3 objects from a classification job. A JobScopeTerm
/// object can contain only one simpleScopeTerm object or one tagScopeTerm
/// object.
pub const JobScopeTerm = struct {
    /// A property-based condition that defines a property, operator, and one or
    /// more values for including or excluding objects from the job.
    simple_scope_term: ?SimpleScopeTerm = null,

    /// A tag-based condition that defines the operator and tag keys or tag key and
    /// value pairs for including or excluding objects from the job.
    tag_scope_term: ?TagScopeTerm = null,

    pub const json_field_names = .{
        .simple_scope_term = "simpleScopeTerm",
        .tag_scope_term = "tagScopeTerm",
    };
};
