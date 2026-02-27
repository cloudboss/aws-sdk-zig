/// Contains any warnings returned by the `GetTemplateSummary` API action.
pub const Warnings = struct {
    /// A list of all of the unrecognized resource types. This is only returned if
    /// the
    /// `TemplateSummaryConfig` parameter has the
    /// `TreatUnrecognizedResourceTypesAsWarning` configuration set to
    /// `True`.
    unrecognized_resource_types: ?[]const []const u8,
};
