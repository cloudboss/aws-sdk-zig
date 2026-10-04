const ValidationMethod = @import("validation_method.zig").ValidationMethod;

/// Contains information about a domain validation method migration, including
/// the previous validation method and the target validation method.
pub const DomainValidationMethodUpdateSummary = struct {
    /// The validation method that the certificate was using before the update.
    from: ?ValidationMethod = null,

    /// The target validation method for the update.
    to: ?ValidationMethod = null,

    pub const json_field_names = .{
        .from = "From",
        .to = "To",
    };
};
