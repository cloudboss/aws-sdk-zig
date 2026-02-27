const ArchiveBooleanEmailAttribute = @import("archive_boolean_email_attribute.zig").ArchiveBooleanEmailAttribute;

/// The attribute to evaluate in a boolean expression.
pub const ArchiveBooleanToEvaluate = union(enum) {
    /// The name of the email attribute to evaluate.
    attribute: ?ArchiveBooleanEmailAttribute,

    pub const json_field_names = .{
        .attribute = "Attribute",
    };
};
