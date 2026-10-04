/// Settings for integer-second duration normalization. When this preprocessor
/// is present, the output duration will be adjusted to an exact integer-second
/// boundary. If the input is within the trim threshold of an integer second,
/// trailing frames are dropped. If within the compression threshold and less
/// than 500ms over the previous integer second, the output is sped up slightly.
/// Otherwise, black frames are padded to the next integer second.
pub const DurationControl = struct {
    /// Required. Denominator of the maximum allowed compression ratio.
    integer_duration_maximum_compression_denominator: ?i32 = null,

    /// Required. Numerator of the maximum allowed compression ratio, defined as
    /// overrun divided by target duration. For example, numerator 5 with
    /// denominator 100 means max 5% compression. Set to 0 to disable compression
    /// entirely (only trim or pad will be used).
    integer_duration_maximum_compression_numerator: ?i32 = null,

    /// Maximum number of fractional milliseconds past an integer second that
    /// qualify for the trim path (frame dropping). Default is 0 (trimming
    /// disabled).
    integer_duration_trim_threshold_milliseconds: ?i32 = null,

    pub const json_field_names = .{
        .integer_duration_maximum_compression_denominator = "IntegerDurationMaximumCompressionDenominator",
        .integer_duration_maximum_compression_numerator = "IntegerDurationMaximumCompressionNumerator",
        .integer_duration_trim_threshold_milliseconds = "IntegerDurationTrimThresholdMilliseconds",
    };
};
