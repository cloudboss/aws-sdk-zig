const SampleType = @import("sample_type.zig").SampleType;

/// Represents the sample size and sampling type for DataBrew to use for
/// interactive data
/// analysis.
pub const Sample = struct {
    /// The number of rows in the sample.
    size: ?i32,

    /// The way in which DataBrew obtains rows from a dataset.
    type: SampleType,

    pub const json_field_names = .{
        .size = "Size",
        .type = "Type",
    };
};
