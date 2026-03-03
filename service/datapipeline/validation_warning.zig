/// Defines a validation warning. Validation warnings do not prevent pipeline
/// activation. The set of validation warnings that can be returned are defined
/// by AWS Data Pipeline.
pub const ValidationWarning = struct {
    /// The identifier of the object that contains the validation warning.
    id: ?[]const u8 = null,

    /// A description of the validation warning.
    warnings: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .id = "id",
        .warnings = "warnings",
    };
};
