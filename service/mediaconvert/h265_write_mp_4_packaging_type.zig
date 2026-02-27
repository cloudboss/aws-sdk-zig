/// If the location of parameter set NAL units doesn't matter in your workflow,
/// ignore this setting. Use this setting only with CMAF or DASH outputs, or
/// with standalone file outputs in an MPEG-4 container (MP4 outputs). Choose
/// HVC1 to mark your output as HVC1. This makes your output compliant with the
/// following specification: ISO IECJTC1 SC29 N13798 Text ISO/IEC FDIS 14496-15
/// 3rd Edition. For these outputs, the service stores parameter set NAL units
/// in the sample headers but not in the samples directly. For MP4 outputs, when
/// you choose HVC1, your output video might not work properly with some
/// downstream systems and video players. The service defaults to marking your
/// output as HEV1. For these outputs, the service writes parameter set NAL
/// units directly into the samples.
pub const H265WriteMp4PackagingType = enum {
    hvc1,
    hev1,

    pub const json_field_names = .{
        .hvc1 = "HVC1",
        .hev1 = "HEV1",
    };
};
