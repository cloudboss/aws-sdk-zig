/// A list of filters to apply to the conformance pack compliance score result
/// set.
pub const ConformancePackComplianceScoresFilters = struct {
    /// The names of the conformance packs whose compliance scores you want to
    /// include in the conformance pack compliance score result set.
    /// You can include up to 25 conformance packs in the `ConformancePackNames`
    /// array of strings, each with a character limit of 256 characters for the
    /// conformance pack name.
    conformance_pack_names: []const []const u8,

    pub const json_field_names = .{
        .conformance_pack_names = "ConformancePackNames",
    };
};
