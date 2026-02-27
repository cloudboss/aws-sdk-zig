/// The definition for the `ContributionAnalysisFactor`.
pub const ContributionAnalysisFactor = struct {
    /// The field name of the `ContributionAnalysisFactor`.
    field_name: ?[]const u8,

    pub const json_field_names = .{
        .field_name = "FieldName",
    };
};
