/// Required. Specify whether your source content already contains Nielsen
/// non-linear watermarks. When you set this value to Watermarked, the service
/// fails the job. Nielsen requires that you add non-linear watermarking to only
/// clean content that doesn't already have non-linear Nielsen watermarks.
pub const NielsenSourceWatermarkStatusType = enum {
    clean,
    watermarked,

    pub const json_field_names = .{
        .clean = "CLEAN",
        .watermarked = "WATERMARKED",
    };
};
