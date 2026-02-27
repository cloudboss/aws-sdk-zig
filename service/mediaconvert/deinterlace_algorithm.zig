/// Only applies when you set Deinterlace mode to Deinterlace or Adaptive.
/// Interpolate produces sharper pictures, while blend produces smoother motion.
/// If your source file includes a ticker, such as a scrolling headline at the
/// bottom of the frame: Choose Interpolate ticker or Blend ticker. To apply
/// field doubling: Choose Linear interpolation. Note that Linear interpolation
/// may introduce video artifacts into your output.
pub const DeinterlaceAlgorithm = enum {
    interpolate,
    interpolate_ticker,
    blend,
    blend_ticker,
    linear_interpolation,

    pub const json_field_names = .{
        .interpolate = "INTERPOLATE",
        .interpolate_ticker = "INTERPOLATE_TICKER",
        .blend = "BLEND",
        .blend_ticker = "BLEND_TICKER",
        .linear_interpolation = "LINEAR_INTERPOLATION",
    };
};
