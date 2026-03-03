const aws = @import("aws");

const SignatureValidityPeriod = @import("signature_validity_period.zig").SignatureValidityPeriod;
const SigningMaterial = @import("signing_material.zig").SigningMaterial;
const SigningProfileStatus = @import("signing_profile_status.zig").SigningProfileStatus;

/// Contains information about the ACM certificates and signing configuration
/// parameters that
/// can be used by a given code signing user.
pub const SigningProfile = struct {
    /// The Amazon Resource Name (ARN) for the signing profile.
    arn: ?[]const u8 = null,

    /// The name of the signing platform.
    platform_display_name: ?[]const u8 = null,

    /// The ID of a platform that is available for use by a signing profile.
    platform_id: ?[]const u8 = null,

    /// The name of the signing profile.
    profile_name: ?[]const u8 = null,

    /// The version of a signing profile.
    profile_version: ?[]const u8 = null,

    /// The ARN of a signing profile, including the profile version.
    profile_version_arn: ?[]const u8 = null,

    /// The validity period for a signing job created using this signing profile.
    signature_validity_period: ?SignatureValidityPeriod = null,

    /// The ACM certificate that is available for use by a signing profile.
    signing_material: ?SigningMaterial = null,

    /// The parameters that are available for use by a Signer user.
    signing_parameters: ?[]const aws.map.StringMapEntry = null,

    /// The status of a signing profile.
    status: ?SigningProfileStatus = null,

    /// A list of tags associated with the signing profile.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .arn = "arn",
        .platform_display_name = "platformDisplayName",
        .platform_id = "platformId",
        .profile_name = "profileName",
        .profile_version = "profileVersion",
        .profile_version_arn = "profileVersionArn",
        .signature_validity_period = "signatureValidityPeriod",
        .signing_material = "signingMaterial",
        .signing_parameters = "signingParameters",
        .status = "status",
        .tags = "tags",
    };
};
