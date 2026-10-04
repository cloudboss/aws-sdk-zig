/// Opportunity quality score and trend.
pub const OpportunityQuality = struct {
    /// Deal quality score based on opportunity content completeness and sales
    /// methodology criteria. Values range from 0 to 100.
    score: ?i32 = null,

    /// Direction of score change since last scoring iteration. Known values:
    /// `Improving`, `Declining`, `No Change`.
    trend: ?[]const u8 = null,

    pub const json_field_names = .{
        .score = "Score",
        .trend = "Trend",
    };
};
