/// Options for the `GetTemplateSummary` API action.
pub const TemplateSummaryConfig = struct {
    /// If set to `True`, any unrecognized resource types generate warnings and not
    /// an
    /// error. Any unrecognized resource types are returned in the `Warnings` output
    /// parameter.
    treat_unrecognized_resource_types_as_warnings: ?bool,
};
