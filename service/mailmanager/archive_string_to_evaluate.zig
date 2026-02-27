const ArchiveStringEmailAttribute = @import("archive_string_email_attribute.zig").ArchiveStringEmailAttribute;

/// Specifies the email attribute to evaluate in a string expression.
pub const ArchiveStringToEvaluate = union(enum) {
    /// The name of the email attribute to evaluate.
    attribute: ?ArchiveStringEmailAttribute,

    pub const json_field_names = .{
        .attribute = "Attribute",
    };
};
