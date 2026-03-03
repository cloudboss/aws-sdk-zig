/// Specify YUV limits and RGB tolerances when you set Sample range conversion
/// to Limited range clip.
pub const ClipLimits = struct {
    /// Specify the Maximum RGB color sample range tolerance for your output.
    /// MediaConvert corrects any YUV values that, when converted to RGB, would be
    /// outside the upper tolerance that you specify. Enter an integer from 90 to
    /// 105 as an offset percentage to the maximum possible value. Leave blank to
    /// use the default value 100. When you specify a value for Maximum RGB
    /// tolerance, you must set Sample range conversion to Limited range clip.
    maximum_rgb_tolerance: ?i32 = null,

    /// Specify the Maximum YUV color sample limit. MediaConvert conforms any pixels
    /// in your input above the value that you specify to typical limited range
    /// bounds. Enter an integer from 920 to 1023. Leave blank to use the default
    /// value 940. The value that you enter applies to 10-bit ranges. For 8-bit
    /// ranges, MediaConvert automatically scales this value down. When you specify
    /// a value for Maximum YUV, you must set Sample range conversion to Limited
    /// range clip.
    maximum_yuv: ?i32 = null,

    /// Specify the Minimum RGB color sample range tolerance for your output.
    /// MediaConvert corrects any YUV values that, when converted to RGB, would be
    /// outside the lower tolerance that you specify. Enter an integer from -5 to 10
    /// as an offset percentage to the minimum possible value. Leave blank to use
    /// the default value 0. When you specify a value for Minimum RGB tolerance, you
    /// must set Sample range conversion to Limited range clip.
    minimum_rgb_tolerance: ?i32 = null,

    /// Specify the Minimum YUV color sample limit. MediaConvert conforms any pixels
    /// in your input below the value that you specify to typical limited range
    /// bounds. Enter an integer from 0 to 128. Leave blank to use the default value
    /// 64. The value that you enter applies to 10-bit ranges. For 8-bit ranges,
    /// MediaConvert automatically scales this value down. When you specify a value
    /// for Minumum YUV, you must set Sample range conversion to Limited range clip.
    minimum_yuv: ?i32 = null,

    pub const json_field_names = .{
        .maximum_rgb_tolerance = "MaximumRGBTolerance",
        .maximum_yuv = "MaximumYUV",
        .minimum_rgb_tolerance = "MinimumRGBTolerance",
        .minimum_yuv = "MinimumYUV",
    };
};
