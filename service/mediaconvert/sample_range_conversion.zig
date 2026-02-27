/// Specify how MediaConvert limits the color sample range for this output. To
/// create a limited range output from a full range input: Choose Limited range
/// squeeze. For full range inputs, MediaConvert performs a linear offset to
/// color samples equally across all pixels and frames. Color samples in 10-bit
/// outputs are limited to 64 through 940, and 8-bit outputs are limited to 16
/// through 235. Note: For limited range inputs, values for color samples are
/// passed through to your output unchanged. MediaConvert does not limit the
/// sample range. To correct pixels in your input that are out of range or out
/// of gamut: Choose Limited range clip. Use for broadcast applications.
/// MediaConvert conforms any pixels outside of the values that you specify
/// under Minimum YUV and Maximum YUV to limited range bounds. MediaConvert also
/// corrects any YUV values that, when converted to RGB, would be outside the
/// bounds you specify under Minimum RGB tolerance and Maximum RGB tolerance.
/// With either limited range conversion, MediaConvert writes the sample range
/// metadata in the output.
pub const SampleRangeConversion = enum {
    limited_range_squeeze,
    none,
    limited_range_clip,

    pub const json_field_names = .{
        .limited_range_squeeze = "LIMITED_RANGE_SQUEEZE",
        .none = "NONE",
        .limited_range_clip = "LIMITED_RANGE_CLIP",
    };
};
