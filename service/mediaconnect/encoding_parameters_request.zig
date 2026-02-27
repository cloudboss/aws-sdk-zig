const EncoderProfile = @import("encoder_profile.zig").EncoderProfile;

/// A collection of parameters that determine how MediaConnect will convert the
/// content. These fields only apply to outputs on flows that have a CDI source.
pub const EncodingParametersRequest = struct {
    /// A value that is used to calculate compression for an output. The bitrate of
    /// the output is calculated as follows: Output bitrate = (1 /
    /// compressionFactor) * (source bitrate) This property only applies to outputs
    /// that use the ST 2110 JPEG XS protocol, with a flow source that uses the CDI
    /// protocol. Valid values are floating point numbers in the range of 3.0 to
    /// 10.0, inclusive.
    compression_factor: f64,

    /// A setting on the encoder that drives compression settings. This property
    /// only applies to video media streams associated with outputs that use the ST
    /// 2110 JPEG XS protocol, if at least one source on the flow uses the CDI
    /// protocol.
    encoder_profile: EncoderProfile,

    pub const json_field_names = .{
        .compression_factor = "CompressionFactor",
        .encoder_profile = "EncoderProfile",
    };
};
