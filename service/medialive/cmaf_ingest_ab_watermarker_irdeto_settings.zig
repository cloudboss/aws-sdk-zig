const OutputLocationRef = @import("output_location_ref.zig").OutputLocationRef;
const AbWatermarkingCustomProfile = @import("ab_watermarking_custom_profile.zig").AbWatermarkingCustomProfile;
const AbWatermarkingProfile = @import("ab_watermarking_profile.zig").AbWatermarkingProfile;
const AbWatermarkerIdLength = @import("ab_watermarker_id_length.zig").AbWatermarkerIdLength;

/// A/B Watermarker settings for CMAF Ingest output groups.
pub const CmafIngestAbWatermarkerIrdetoSettings = struct {
    /// The "B" pipeline renditions for the additional destinations.
    additional_destinations_alternate_destinations: ?[]const OutputLocationRef = null,

    /// The "B" pipeline renditions for the main destination.
    alternate_destination: OutputLocationRef,

    /// The vendor-provided custom profile values.
    custom_profile: ?AbWatermarkingCustomProfile = null,

    /// The name of the Secrets Manager secret containing the license file.
    license: ?[]const u8 = null,

    /// The vendor-provided Operator ID.
    operator_id: i32,

    /// The number of segments per watermarking bit. The total duration of the
    /// watermarking bit
    /// should be the LCM (least common multiple) of all segments sizes emitted by
    /// the downstream packager.
    poly_period: ?i32 = null,

    /// The vendor-provided profile choice.
    profile: AbWatermarkingProfile,

    /// The number of bits that compose the watermarking identifier to be embedded.
    watermark_id_length: ?AbWatermarkerIdLength = null,

    pub const json_field_names = .{
        .additional_destinations_alternate_destinations = "AdditionalDestinationsAlternateDestinations",
        .alternate_destination = "AlternateDestination",
        .custom_profile = "CustomProfile",
        .license = "License",
        .operator_id = "OperatorId",
        .poly_period = "PolyPeriod",
        .profile = "Profile",
        .watermark_id_length = "WatermarkIdLength",
    };
};
